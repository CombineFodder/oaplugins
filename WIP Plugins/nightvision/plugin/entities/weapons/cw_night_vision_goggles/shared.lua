if (SERVER) then
	AddCSLuaFile("shared.lua");
end;

if (CLIENT) then
	SWEP.Slot = 1;
	SWEP.SlotPos = 5;
	SWEP.DrawAmmo = false;
	SWEP.PrintName = "Night Vision Goggles";
	SWEP.DrawCrosshair = true;
end

SWEP.Instructions = "Primary Fire: Toggle.";
SWEP.Purpose = "Allows you to see in the dark.";
SWEP.Contact = "";
SWEP.Author	= "RJ";

SWEP.WorldModel = "models/weapons/w_fists_t.mdl";
SWEP.ViewModel = "models/weapons/v_punch.mdl";
SWEP.HoldType = "fist";

SWEP.Primary.DefaultClip = 0;
SWEP.Primary.Automatic = false;
SWEP.Primary.ClipSize = -1;
SWEP.Primary.Ammo = "";

SWEP.Secondary.DefaultClip = 0;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.Ammo	= "";

SWEP.NoIronSightFovChange = true;
SWEP.NoIronSightAttack = true;
SWEP.LoweredAngles = Angle(60, 60, 60);
SWEP.IronSightPos = Vector(0, 0, 0);
SWEP.IronSightAng = Vector(0, 0, 0);
SWEP.NeverRaised = true;

function SWEP:Initialize()
end;

-- A function to set whether the SWEP is activated.
function SWEP:SetActivated(bActivated)
	self.Activated = bActivated;
end;

-- A function to get whether the SWEP is activated.
function SWEP:IsActivated()
	return self.Activated;
end;

-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack()
	if (SERVER) then
		local previouslyActivated = self.Activated;
		local ent = ents.Create("cw_nvlight");
		
		if (!self.Activated) then
			self.Owner:EmitSound("items/nvg_on.wav");
			self.Activated = true;
			
			ent:SetOwner(self.Owner);
			ent:SetParent(self.Owner);
			ent:SetPos(self.Owner:GetPos());
			ent:SetOwnerVariable(self.Owner);
		else
			self.Owner:EmitSound("items/nvg_off.wav");
			self.Activated = false;
			ent:RemoveLight(self.Owner);
		end;
		
		if (self.Activated != previouslyActivated) then
			self.Owner:HandleImplants();
		end;
	end;
	
	self:SetNextPrimaryFire(CurTime() + 2);
	
	return false;
end;

-- Called when the player attempts to secondary fire.
function SWEP:SecondaryAttack() end;