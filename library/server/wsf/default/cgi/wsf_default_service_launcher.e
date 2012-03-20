note
	description: "Summary description for {WSF_DEFAULT_SERVICE_LAUNCHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_DEFAULT_SERVICE_LAUNCHER

inherit
	WSF_CGI_SERVICE_LAUNCHER

create
	make,
	make_and_launch,
	make_callback,
	make_callback_and_launch,
	make_and_launch_with_options -- obsolete

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end