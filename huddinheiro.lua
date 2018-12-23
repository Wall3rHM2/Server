timer.Simple(1,function()
CreateClientConVar("moeda_painel","1",true,	false, "Selecione 1 para aparecer o painel e 0 para não aparecer.")	
surface.CreateFont( "FonteNSei", {
	font = "Roboto",
	extended = false,
	size = 46, --ScrW()*ScrH()/47600
	weight = 300,
	blursize = 0,	
	scanlines = 0,		
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )
hook.Add("Think","Think_HUDMoeda", function() --antes o nome era hookrun
local w = ScrW()
local h = ScrH()/500
if GetConVar("moeda_painel"):GetInt()==1	 then stringm=LocalPlayer():GetMoeda()  sufix="$"
	else stringm=""  sufix="" end
hook.Add( "HUDPaint", "HUDMoeda", function()
	draw.DrawText( stringm..sufix,"FonteNSei",w, h,Color( 0, 255, 0, 255 ), TEXT_ALIGN_RIGHT)
end)// fim da hook de draw hud
end)// fim da hook think	
end)// fim do timer.Simple