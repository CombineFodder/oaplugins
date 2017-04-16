local ITEM = Clockwork.item:New("furniture_base");

ITEM.name = "Red Couch";
ITEM.model = "models/props_junk/wood_crate002a.mdl";
ITEM.weight = 0.5;
ITEM.access = "1";
ITEM.business = true;
ITEM.description = "A big red couch made of the finest Union Synthesized Cotton.";

-- Called when a player uses the item.
function ITEM:GetEntityName()
	return "cw_furniture_red_couch"
end;

ITEM:Register();