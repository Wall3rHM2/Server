timer.Simple(120,function()
// script feito por Wall3r, copia não comédia.
//var

local N=1
local Max=70
local Min=1
local volume=1
local VMin=0
local VMax=1
local Delay=0.01
local Pitch=100
local PitchMin=1
local PitchMax=200
local posx=0		
local posy=0

if game.GetMap()=="gm_blueshills_test3" then
 wposx=792.438
 wposy=-710.292
 wposz=355.577	
 Ax=0
 Ay=90
 Az=90
 
 sposx=792.281
 sposy=-683.323
 sposz=331.318
elseif game.GetMap()=="gm_flatgrass" then
 wposx=1018
 wposy=123
 wposz=-12210
 Ax=0
 Ay=-90
 Az=90
 
 sposx=wposx
 sposy=wposy
 sposz=wposz
else 
 wposx=0
 wposy=0
 wposz=0
 Ax=0
 Ay=0
 Az=0
 
 sposx=0
 sposy=0
 sposz=0
 end
//
//table

local t={
	"ambient/music/bongo.wav",
"ambient/music/country_rock_am_radio_loop.wav",
"ambient/music/cubanmusic1.wav",
"ambient/music/dustmusic1.wav",
"ambient/music/dustmusic2.wav",
"ambient/music/dustmusic3.wav",
"ambient/music/flamenco.wav",
"ambient/music/latin.wav",
"ambient/music/looping_radio_mix.wav",
"ambient/music/mirame_radio_thru_wall.wav",
"ambient/music/piano1.wav",
"ambient/music/piano2.wav",
"music/misfortune_teller.wav",
"ui/gamestartup1.mp3",
"ui/gamestartup2.mp3",
"ui/gamestartup3.mp3",
"ui/gamestartup4.mp3",
"ui/gamestartup5.mp3",
"ui/gamestartup6.mp3",
"ui/gamestartup7.mp3",
"ui/gamestartup8.mp3",
"ui/gamestartup9.mp3",
"ui/gamestartup10.mp3",
"ui/gamestartup11.mp3",
"ui/gamestartup12.mp3",
"ui/gamestartup13.mp3",
"ui/gamestartup14.mp3",
"ui/gamestartup15.mp3",
"ui/gamestartup16.mp3",
"ui/gamestartup17.mp3",
"ui/gamestartup18.mp3",
"ui/gamestartup19.mp3",
"ui/gamestartup20.mp3",
"ui/gamestartup21.mp3",
"ui/gamestartup22.mp3",
"ui/gamestartup23.mp3",
"ui/gamestartup24.mp3",
"ui/gamestartup25.mp3",
"ui/gamestartup26.mp3",
"music/hl2_intro.mp3",
"music/hl2_song0.mp3",
"music/hl2_song1.mp3",
"music/hl2_song2.mp3",
"music/hl2_song3.mp3",
"music/hl2_song4.mp3",
"music/hl2_song6.mp3",
"music/hl2_song7.mp3",
"music/hl2_song8.mp3",
"music/hl2_song10.mp3",
"music/hl2_song11.mp3",
"music/hl2_song12_long.mp3",
"music/hl2_song13.mp3",
"music/hl2_song14.mp3",
"music/hl2_song15.mp3",
"music/hl2_song16.mp3",
"music/hl2_song17.mp3",
"music/hl2_song19.mp3",
"music/hl2_song20_submix0.mp3",
"music/hl2_song20_submix4.mp3",
"music/hl2_song23_suitsong3.mp3",
"music/hl2_song25_teleporter.mp3",
"music/hl2_song26.mp3",
"music/hl2_song26_trainstation1.mp3",
"music/hl2_song27_trainstation2.mp3",
"music/hl2_song28.mp3",
"music/hl2_song28.mp3",
"music/hl2_song30.mp3",
"music/hl2_song31.mp3",
"music/hl2_song32.mp3",
"music/hl2_song33.mp3"
}



//fim da criação da table


//Fonte

surface.CreateFont( "Fonte", {
	font = "seinao", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 39,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

surface.CreateFont( "FonteP", {
	font = "seinao", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 19,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )


//Fim da criação de fonte



//Frame principal+texto
local frame = vgui.Create( "DFrame" )
frame:SetTitle("")
frame:SetSize( 275, 250 )
frame:SetPaintedManually( true )
frame:ShowCloseButton(false)
frame.Paint = function()
	surface.SetDrawColor( Color(20, 20, 20, 180 ))
	surface.DrawRect( posx+0,posy+ 0, frame:GetWide(), frame:GetTall() )
	surface.SetDrawColor(Color( 255, 255, 255, 255 ))
		surface.SetFont("Fonte")
	surface.SetTextColor(Color(55,55,55,200))

	surface.SetTextPos(posx+50,posy+15)
	--pos.map

	surface.DrawText("Música nº "..N)
	//display de volume
	surface.SetFont("FonteP")
	surface.SetTextPos(posx+100,posy+190)
	surface.DrawText("Volume "..volume)
	
	//display de Pitch
	surface.SetFont("FonteP")
	surface.SetTextPos(posx+100,posy+220)
	surface.DrawText("Pitch "..Pitch)

	//display menor de música
	surface.SetFont("FonteP")
	surface.SetTextPos(posx+100,posy+160)
	surface.DrawText("Música "..N)
	
end
// Botao de avançar música
local botaoavan = vgui.Create( "DColorButton", frame )
botaoavan:SetPos( posx+180, posy+160 )
botaoavan:SetSize( 20, 20 )
botaoavan:Paint(20,20)
botaoavan:SetText( "  >" )
botaoavan:SetColor(Color(25,25,25))
botaoavan.DoClick = function()
	LocalPlayer():ConCommand("stopsound")
	timer.Create( "sstimer1", Delay, 1, function()
	sound.Play( t[N], Vector(sposx,sposy,sposz),75,Pitch,volume)
	end)
	if N<Max then
	N=N+1
else
	N=Min
end
end
//Botao de voltar música
local botaovolt = vgui.Create( "DColorButton", frame )
botaovolt:SetPos( posx+70, posy+160 )
botaovolt:SetSize( 20, 20 )
botaovolt:Paint(20,20)
botaovolt:SetText( "  <" )
botaovolt:SetColor(Color(25,25,25))
botaovolt.DoClick = function()
	LocalPlayer():ConCommand("stopsound")
	timer.Create( "sstimer2", Delay, 1, function()
	sound.Play( t[N], Vector(sposx,spoxsy,sposz),75,Pitch,volume)
	end)
	if N>Min then
	N=N-1
else
	N=Max
end
end




	// Botao de aumentar volume
local voluMais = vgui.Create( "DColorButton", frame )
voluMais:SetPos( posx+180, posy+190 )
voluMais:SetSize( 20, 20 )
voluMais:Paint(20,20)
voluMais:SetText( "  >" )
voluMais:SetColor(Color(25,25,25))
voluMais.DoClick = function()
	LocalPlayer():ConCommand("stopsound")
	timer.Create( "sstimer3", Delay, 1, function()
	sound.Play( t[N], Vector(sposx,sposy, sposz),75,Pitch,volume)
	end)


	if volume<VMax then
	volume=volume+0.01
else
	volume=VMin
end
end

	// Botao de diminuir volume
local voluMais = vgui.Create( "DColorButton", frame )
voluMais:SetPos( posx+70, posy+190 )
voluMais:SetSize( 20, 20 )
voluMais:Paint(20,20)
voluMais:SetText( "  <" )
voluMais:SetColor(Color(25,25,25))
voluMais.DoClick = function()
	LocalPlayer():ConCommand("stopsound")
	timer.Create( "sstimer4", Delay, 1, function()
	sound.Play( t[N], Vector(sposx,sposy,sposz),75,Pitch,volume)
	end)
	
	if volume>VMin then
	volume=volume-0.01
else
	volume=VMax
end
end
	// Botao de aumentar pitch
local PitchMais = vgui.Create( "DColorButton", frame )
PitchMais:SetPos( posx+180, posy+220 )
PitchMais:SetSize( 20, 20 )
PitchMais:Paint(20,20)
PitchMais:SetText( "  >" )
PitchMais:SetColor(Color(25,25,25))
PitchMais.DoClick = function()
	LocalPlayer():ConCommand("stopsound")
	timer.Create( "sstimer5", Delay, 1, function()
	sound.Play( t[N], Vector(sposx,sposy, sposz),75,Pitch,volume)
	end)


	if Pitch<PitchMax then
	Pitch=Pitch+1
else
 	Pitch=PitchMin
end
end
	// Botao de diminuir pitch
local PitchMais = vgui.Create( "DColorButton", frame )
PitchMais:SetPos( posx+70, posy+220 )
PitchMais:SetSize( 20, 20 )
PitchMais:Paint(20,20)
PitchMais:SetText( "  <" )
PitchMais:SetColor(Color(25,25,25))
PitchMais.DoClick = function()
	LocalPlayer():ConCommand("stopsound")
	timer.Create( "sstimer6", Delay, 1, function()
	sound.Play( t[N], Vector(sposx,sposy, sposz),75,Pitch,volume)
	end)
	
	if volume>VMin then
	Pitch=Pitch-1
else
	Pitch=PitchMax
end
end


//Hook do draw 3d2d
hook.Add( "PostDrawTranslucentRenderables", "Hook?", function()
	if IsValid( frame ) then


		vgui.Start3D2D(Vector(wposx, wposy, wposz), Angle( Ax,Ay,Az), 0.2 )
		frame:Paint3D2D()
				
			frame:Paint3D2D()
		
		vgui.End3D2D()
			end
	end)
end)
