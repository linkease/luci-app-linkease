--wulishui <wulishui@gmail.com> ,20200911

require("luci.model.ipkg")
local fs  = require "nixio.fs"
require("nixio.fs")

local uci = require "luci.model.uci".cursor()
local port = uci:get_first("linkease", "setting", "port") or 8897
local m, s
local running=(luci.sys.call("[ `busybox ps -w | grep link-ease| grep -v grep | awk '{print $1}' | wc -l` -gt 0 ] > /dev/null") == 0)
local button = ""
local state_msg = ""

if running then
        state_msg = "<b><font color=\"green\">" .. translate("Running") .. "</font></b>"
else
        state_msg = "<b><font color=\"red\">" .. translate("Not running") .. "</font></b>"
end

if running  then
	button = "<br/><br/>---<input class=\"cbi-button cbi-button-apply\" type=\"submit\" value=\" "..translate("Click to open linkease").." \" onclick=\"window.open('http://'+window.location.hostname+':"..port.."')\"/>---"
end

m = Map("linkease", translate("Linkease"))
m.description = translate("Linkease is an efficient data transfer tool.".. button .. "<br/><br/>" .. translate("Running state").. " : "  .. state_msg .. "<br />")

s = m:section(TypedSection, "setting", translate(""))
s.anonymous = true

s:option(Flag, "enabled", translate("Enable"))

e = luci.http.formvalue("cbi.apply")
if e then
  io.popen("/etc/init.d/linkease start")
end

return m


