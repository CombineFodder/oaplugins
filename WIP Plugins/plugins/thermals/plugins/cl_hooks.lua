local PLUGIN = PLUGIN;

-- Called when screen space effects should be rendered.
function PLUGIN:RenderScreenspaceEffects()
	local thermalsActive = Clockwork.Client:GetSharedVar("thermals");
	local modulation = {1, 1, 1};
	
	if (thermalsActive) then
		modulation = {0.5, 0.5, 0.5};
		
		local colorModify = {};
			colorModify["$pp_colour_brightness"] = 0.1;
			colorModify["$pp_colour_contrast"] = 0.2;
			colorModify["$pp_colour_colour"] = 0;
			colorModify["$pp_colour_addr"] = 0;
			colorModify["$pp_colour_addg"] = 0;
			colorModify["$pp_colour_addb"] = 0;
			colorModify["$pp_colour_mulr"] = 0;
			colorModify["$pp_colour_mulg"] = 0;
			colorModify["$pp_colour_mulb"] = 0;
		DrawColorModify(colorModify);
	end;
	
	cam.Start3D( EyePos(), EyeAngles() );
		for k, v in ipairs( _player.GetAll() ) do
			if (v:Alive() and !v:IsRagdolled()) then
				if (v:HasInitialized()) then
					if (thermalsActive) then
						render.SuppressEngineLighting(true);
						render.SetColorModulation( unpack(modulation) );
						
						render.MaterialOverride(material);
							v:DrawModel();
						render.MaterialOverride(false)
						
						render.SetColorModulation(1, 1, 1);
						render.SuppressEngineLighting(false);
					end;
				end;
			end;
		end;
		
		for k, v in ipairs( ents.FindByClass("npc_*") ) do
			if (thermalsActive) then
				local material = PLUGIN.heatwaveMaterial;
				
				if (thermalImplant) then
					material = PLUGIN.shinyMaterial;
				end;
				
				render.SuppressEngineLighting(true);
				render.SetColorModulation( unpack(modulation) );
				
				render.MaterialOverride(material);
					v:DrawModel();
				render.MaterialOverride(false)
				
				render.SetColorModulation(1, 1, 1);
				render.SuppressEngineLighting(false);
			end;
		end;
	cam.End3D();
end;