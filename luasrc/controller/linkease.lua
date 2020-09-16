module("luci.controller.linkease", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/linkease") then
		return
	end
	
	entry({"admin", "nas", "linkease"}, cbi("linkease"), _("Linkease"), 20).dependent = true
end

