local PLUGIN = PLUGIN;

Clockwork.kernel:SetSharedVar("thermalsActive", NWTYPE_BOOL, true);

Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");