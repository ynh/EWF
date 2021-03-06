note
	description: "Cross-Origin Resource Sharing filter."
	author: "Olivier Ligot"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Cross-Origin Resource Sharing", "src=http://www.w3.org/TR/cors/", "tag=W3C"

class
	WSF_CORS_FILTER

inherit
	WSF_FILTER

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			l_header: HTTP_HEADER
		do
			create l_header.make
			l_header.put_access_control_allow_all_origin
			res.put_header_text (l_header.string)
			execute_next (req, res)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
