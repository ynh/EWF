note
	description: "Summary description for {GOOGLE_AUTOCOMPLETION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GOOGLE_AUTOCOMPLETION

inherit

	WSF_AUTOCOMPLETION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize
		do
			template := "{{=value}}";
		end

feature -- Implementation

	autocompletion (input: STRING_32): JSON_ARRAY
			-- Implementation
		local
			cl: LIBCURL_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			l_json: detachable READABLE_STRING_8
			o: JSON_OBJECT
			json_parser: JSON_PARSER
			query_str: STRING_32
		do
			query_str := input
			query_str.replace_substring_all (" ", "+")
			create cl.make
			sess := cl.new_session ("http://google.com")
			if attached sess.get ("/complete/search?client=chrome&q=" + query_str, Void) as resp and then not resp.error_occurred then
				l_json := resp.body
			end
			create Result.make_array
			if l_json /= Void and then not l_json.is_empty then
				create json_parser.make_parser (l_json)
				if attached {JSON_ARRAY} json_parser.parse_json as data and then attached {JSON_ARRAY} data.i_th (2) as list then
					across
						1 |..| list.count as c
					loop
						if attached {JSON_STRING} list.i_th (c.item) as row then
							create o.make
							o.put (create {JSON_STRING}.make_json (row.unescaped_STRING_32), "value")
							Result.add (o)
						end
					end
				end
			end
		end

end
