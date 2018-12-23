--script feito por Wall3r STEAM_0:0:137939593 & Jason STEAM_0:0:125421770
if SERVER then
 util.AddNetworkString("hideNick")
 net.Receive("hideNick",function()
  local Valor=net.ReadInt(32)
  local ply=net.ReadEntity()
  ply:SetNWInt("HideNick",Valor)
 end)
end
if CLIENT then 
 local function HideMyNick(convarname,oldvalue,newvalue)
  net.Start("hideNick")
  net.WriteInt(tonumber(newvalue),32)
  net.WriteEntity(LocalPlayer())
  net.SendToServer()
 end    
 CreateClientConVar("colornicks_enabled","1",true,false,"Ativa/desativa o script de ColorNicks.")
 CreateClientConVar("colornicks_hidemynick","0",true,true,"Esconde seu color nick a voce e aos outros players, util pra pvp.")
 cvars.AddChangeCallback( "colornicks_hidemynick", HideMyNick,"HideMyNick" )
 surface.CreateFont( "NicksOverHeadFont", {
  font = "Tahoma",
  extended = false, 
  size = 153,
  weight = 500,
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
  outline = false,
 } )
  surface.CreateFont( "NicksOverHeadFontBlur", {
  font = "Tahoma",
  extended = false, 
  size = 153,
  weight = 500,
  blursize = 14,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false, 
  outline = false,
 } )
 local CNDefaultColor=Color(180,180,180)
 TableColorNicks={
   --Cores do Metastruct pra ajudar os maluco que ja tem nome formado pelas cores de la
  Color(0, 0, 0),Color(128, 128, 128),Color(192, 192, 192),
  Color(255, 255, 255),Color(0, 0, 128),Color(0, 0, 255),Color(0, 128, 128),
  Color(0, 255, 255),Color(0, 128, 0),Color(0, 255, 0),Color(128, 128, 0),
  Color(255, 255, 0),Color(128, 0, 0),Color(255, 0, 0),Color(128, 0, 128),
  Color(255, 0, 255),
  --Agora minhas cores kk
  Color(180,180,180),Color(33,255,0),Color(128,0,0),Color(184,134,11),
  Color(189,183,107),Color(124,252,0),Color(210,105,30),Color(139,69,19),
  Color(0,191,255)
  
         }
 local function SortColorNicks(x)
  if x==nil then error("Valor de SortColorNicks nao pode ser nil!") end
  local I=x
  if I<1 then I=1 end
  if I>#TableColorNicks then I=#TableColorNicks end
  return TableColorNicks[x]
 end  
 function DrawOverHeadNicks()
  if GetConVar("colornicks_enabled"):GetInt()==0 then return end
  local offset = Vector(0,0,19+5)
  for k,ply in pairs(player.GetAll()) do
   local ang = LocalPlayer():EyeAngles()
   if ply:LookupBone("ValveBiped.Bip01_Head1") != nil then
    pos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1")) + offset 
   else 
    pos = ply:GetPos()+ Vector(0,0,70+5)
   end 
   ang:RotateAroundAxis( ang:Forward(), 90 )
   ang:RotateAroundAxis( ang:Right(), 90 )
   cam.Start3D2D( pos,Angle(0,ang.y,90), 0.03 )
    local text=ply:GetNWString("NWCNNick","")
    local texte = string.Explode("", text)  
    surface.SetFont("NicksOverHeadFont")
    local chars_x = 0
    local x, y = 0, 200
    local col=CNDefaultColor
    for i = 1, #texte do
     if ply:GetNWBool("tintainvisivel",false)==false and ply:GetNWInt("HideNick",0)==0 then
      if (ply!=LocalPlayer() or GetConVar("ctp_enabled"):GetInt()==1
      or LocalPlayer():InVehicle() and LocalPlayer():GetVehicle():GetCameraDistance()>0)
      and LocalPlayer():GetPos():Distance(ply:GetPos())<880 then
       local char = texte[i]
       local textw, texth = surface.GetTextSize(string.gsub(   string.gsub(text,"%^%d%d","")    ,"%^%d",""))
       local charw, charh = surface.GetTextSize(char)
       if tonumber(char)!=nil and tonumber(texte[i-1])!=nil and texte[i-2]=="^" then col=SortColorNicks(tonumber(texte[i-1]..char)+1)
       elseif tonumber(char)!=nil  and texte[i-1]=="^"  then col=SortColorNicks(tonumber(char)+1) end
       if ((char!="^" and tonumber(char)==nil) or (char=="^" and tonumber(texte[i+1])==nil) 
       or (tonumber(char)!=nil and texte[i-1]!="^")) and (tonumber(char)!=nil and tonumber(texte[i-1])!=nil and texte[i-2]=="^")==false  then
        draw.SimpleText(char, "NicksOverHeadFont", (x + chars_x)-(textw/2), 200, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(char, "NicksOverHeadFontBlur", (x + chars_x)-(textw/2), 200, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        chars_x = chars_x + charw
       else
       end
      end
     end
    end
   cam.End3D2D()
  end
 end
 hook.Add("PostDrawOpaqueRenderables","nseikkk",DrawOverHeadNicks)
end

if SERVER then
 hook.Add("PlayerInitialSpawn","CNDefaultNick",function(ply)
  if ply:IsValid() then
   if ply:GetPData("CNNick",nil)==nil then ply:SetPData("CNNick",ply:Nick()) end
   ply:SetNWString("NWCNNick",ply:GetPData("CNNick","Sem Nome"))
   ply:SetNWInt("HideNick",tonumber(  ply:GetInfoNum( "colornicks_hidemynick","0"))  )
  end
 end)
 util.AddNetworkString("tablecolorsInit")
 hook.Add("PlayerInitialSpawn","tablecolorsNet",function(ply)
  net.Start("tablecolorsInit")
  net.Send(ply)
 end)
end

if CLIENT then
 net.Receive("tablecolorsInit",function()
  aowl.AddCommand("tablecolor|tablecolors", function(ply)
  if CLIENT and ply == LocalPlayer() then
      chat.AddText(Color(255,255,255),"============= Lista de Cores =============")
    for i=1,table.Count(TableColorNicks) do
      chat.AddText("Coloque ^".. tostring(i-1).. " para essa cor:", TableColorNicks[i], "███",Color(255,255,255))
    end
   end
  end)
 end)
end
if SERVER then
  aowl.AddCommand("tablecolor|tablecolors",function(ply) end)
end