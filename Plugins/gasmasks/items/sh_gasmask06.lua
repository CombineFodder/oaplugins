ITEM = openAura.item:New();
ITEM.name = "Gas Mask 6";
ITEM.model = "models/maver1k_XVII/stsoc_helm_gasmask_02.mdl";
ITEM.weight = 0.25;
ITEM.batch = 1;
ITEM.business = true;
ITEM.category = "Clothing";
ITEM.description = "A gas mask that keeps you breathing.";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Head1";
ITEM.attachmentOffsetAngles = Angle(-90, 169.29, 0);
ITEM.attachmentOffsetVector = Vector(0, 1.75, 1.92);
ITEM.access = "y";
ITEM.cost = 1;

-- Called when the attachment offset info should be adjusted.
function ITEM:AdjustAttachmentOffsetInfo(player, entity, info)
	if ( string.find(player:GetModel(), "female") ) then
		info.offsetVector = Vector(0, 0, 0);
	end;
end;

-- A function to get whether the attachment is visible.
function ITEM:GetAttachmentVisible(player, entity)
	if ( player:GetSharedVar("gasmask6") ) then
		return true;
	end;
end;

-- Called when the item's local amount is needed.
function ITEM:GetLocalAmount(amount)
	if ( openAura.Client:GetSharedVar("gasmask6") ) then
		return amount - 1;
	else
		return amount;
	end;
end;

-- Called to get whether a player has the item equipped.
function ITEM:HasPlayerEquipped(player, arguments)
	return player:GetSharedVar("gasmask6");
end;

-- Called when a player has unequipped the item.
function ITEM:OnPlayerUnequipped(player, arguments)
	local skullMaskGear = openAura.player:GetGear(player, "gasmask6");
	
	if ( player:GetSharedVar("gasmask6") and IsValid(skullMaskGear) ) then
		player:SetCharacterData("gasmask6", nil);
		player:SetSharedVar("gasmask6", false);
		
		if ( IsValid(gasmask6Gear) ) then
			gasmask6Gear:Remove();
		end;
	end;
	
	player:UpdateInventory(self.uniqueID);
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position)
	if (player:GetSharedVar("gasmask6") and player:HasItem(self.uniqueID) == 1) then
		openAura.player:Notify(player, "You cannot drop this while you are wearing it!");
		
		return false;
	end;
end;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if ( player:Alive() and !player:IsRagdolled() ) then
		openAura.player:CreateGear(player, "gasmask6", self);
		
		player:SetCharacterData("gasmask6", true);
		player:SetSharedVar("gasmask6", true);
		player:UpdateInventory(self.uniqueID);
		
		if (itemEntity) then
			return true;
		end;
	else
		openAura.player:Notify(player, "You don't have permission to do this right now!");
	end;
	
	return false;
end;

openAura.item:Register(ITEM);