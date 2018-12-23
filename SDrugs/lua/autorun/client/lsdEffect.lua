net.Receive( "LSDmeuStart", function()
	local Lply=LocalPlayer()
	


hook.Add("RenderScreenspaceEffects","SDrugs_LSDEffect",function()

	DrawMaterialOverlay( "effects/water_warp", 0.4 )
	if not LocalPlayer():Alive() then hook.Remove("RenderScreenspaceEffects","SDrugs_LSDEffect") end

end)
timer.Simple(260,function()
hook.Remove("RenderScreenspaceEffects","SDrugs_LSDEffect") end)
end)

print("LSDClient inicializado")