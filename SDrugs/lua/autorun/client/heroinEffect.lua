net.Receive( "HeroinmeuStart", function()
	local Lply=LocalPlayer()
	
	


hook.Add("RenderScreenspaceEffects","RenderHeroin",function()

	DrawMaterialOverlay( "effects/water_warp", 0.4 )	
	DrawTexturize(1,Material("pp/texturize/rainbow.png"))

end)
timer.Simple(260,function()
hook.Remove("RenderScreenspaceEffects","RenderHeroin") end)
end)

