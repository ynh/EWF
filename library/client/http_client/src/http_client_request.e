note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	HTTP_CLIENT_REQUEST

inherit
	REFACTORING_HELPER

feature {NONE} -- Initialization

	make (a_url: READABLE_STRING_8; a_session: like session; ctx: like context)
			-- Initialize `Current'.
		do
			session := a_session
			url := a_url
			headers := session.headers.twin
			if ctx /= Void then
				context := ctx
				import (ctx)
			end
		ensure
			context_set: context = ctx
			ctx_header_set: ctx /= Void implies across ctx.headers as ctx_h all attached headers.item (ctx_h.key) as v and then v.same_string (ctx_h.item) end
		end

	session: HTTP_CLIENT_SESSION

	context: detachable HTTP_CLIENT_REQUEST_CONTEXT

feature -- Access

	request_method: READABLE_STRING_8
		deferred
		end

	url: READABLE_STRING_8

	headers: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]

feature {HTTP_CLIENT_SESSION} -- Execution

	import (ctx: HTTP_CLIENT_REQUEST_CONTEXT)
		local
			l_headers: like headers
		do
			l_headers := headers
			across
				ctx.headers as ctx_headers
			loop
					--| fill header from `ctx'
					--| and use `force' to overwrite the "session" value if any
				l_headers.force (ctx_headers.item, ctx_headers.key)
			end
		end

	execute: HTTP_CLIENT_RESPONSE
		deferred
		end

feature -- Authentication

	auth_type: STRING
    		-- Set the authentication type for the request.
			-- Types: "basic", "digest", "any"
		do
			Result := session.auth_type
		end

	auth_type_id: INTEGER
    		-- Set the authentication type for the request.
			-- Types: "basic", "digest", "any"
		do
			Result := session.auth_type_id
		end

	username: detachable READABLE_STRING_32
		do
			Result := session.username
		end

	password: detachable READABLE_STRING_32
		do
			Result := session.password
		end

	credentials: detachable READABLE_STRING_32
		do
			Result := session.credentials
		end

feature -- Settings

	timeout: INTEGER
			-- HTTP transaction timeout in seconds.
		do
			Result := session.timeout
		end

	connect_timeout: INTEGER
			-- HTTP connection timeout in seconds.
		do
			Result := session.connect_timeout
		end

	max_redirects: INTEGER
    		-- Maximum number of times to follow redirects.
		do
			Result := session.max_redirects
		end

	ignore_content_length: BOOLEAN
			-- Does this session ignore Content-Size headers?
		do
			Result := session.ignore_content_length
		end

	buffer_size: NATURAL
			-- Set the buffer size for request. This option will
			-- only be set if buffer_size is positive
		do
			Result := session.buffer_size
		end

	default_response_charset: detachable READABLE_STRING_8
			-- Default encoding of responses. Used if no charset is provided by the host.
		do
			Result := session.default_response_charset
		end

feature {NONE} -- Utilities

	append_parameters_to_url (a_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]])
			-- Append parameters `a_parameters' to `a_url'
		require
			a_url_attached: a_url /= Void
		local
			i: INTEGER
			l_first_param: BOOLEAN
		do
			if a_parameters /= Void and then a_parameters.count > 0 then
				if a_url.index_of ('?', 1) > 0 then
					l_first_param := False
				elseif a_url.index_of ('&', 1) > 0 then
					l_first_param := False
				else
					l_first_param := True
				end
				from
					i := a_parameters.lower
				until
					i > a_parameters.upper
				loop
					if attached a_parameters[i] as a_param then
						if l_first_param then
							a_url.append_character ('?')
						else
							a_url.append_character ('&')
						end
						a_url.append_string (a_param.name)
						a_url.append_character ('=')
						a_url.append_string (a_param.value)
						l_first_param := False
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Utilities: encoding

	url_encoder: URL_ENCODER
		once
			create Result
		end

	urlencode (s: READABLE_STRING_32): READABLE_STRING_8
			-- URL encode `s'
		do
			Result := url_encoder.encoded_string (s)
		end

	urldecode (s: READABLE_STRING_8): READABLE_STRING_32
			-- URL decode `s'
		do
			Result := url_encoder.decoded_string (s)
		end

	stripslashes (s: STRING): STRING
		do
			Result := s.string
			Result.replace_substring_all ("\%"", "%"")
			Result.replace_substring_all ("\'", "'")
			Result.replace_substring_all ("\/", "/")
			Result.replace_substring_all ("\\", "\")
		end

end