note
	description: "Summary description for {WSF_AGENT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_AGENT_HANDLER 

inherit
	WSF_HANDLER

feature -- Change

	set_action (a_action: like action)
		do
			action := a_action
		end

feature -- Access	

	action: PROCEDURE [ANY, TUPLE [request: WSF_REQUEST; response: WSF_RESPONSE]]

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			action.call ([req, res])
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
