--[[
	Slidefuse LLC Made This. http://slidefuse.com
	Have fun with your crap openAura
--]]

local PLUGIN = PLUGIN

-- This just adds a nice tag so the developer (me, Spencer) can see if you're using the script, I like to see who uses my stuff. All it does is add a tag to the server.
function PLUGIN:Initialize()
	if (!string.find(GetConVarString('sv_tags'), ",sf_plguin")) then
		RunConsoleCommand('sv_tags', GetConVarString('sv_tags')..",sf_plguin");
	end
	
	if (!string.find(GetConVarString('sv_tags'), "sf_clockworkdoors")) then
		RunConsoleCommand('sv_tags', GetConVarString('sv_tags')..",sf_clockworkdoors");
	end
end