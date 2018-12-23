
local WeedI=0
local WeedIMax=2
local WeedIMin=0
local WeedSMax=16
local WeedSMin=0
local WeedS=0
local TimeWeed=1
local WeedRate=0.1
local WeedEnable=false
local WeedRateMax=4
local WHit=1
 local function IncreaseEffect1()
   if WeedI<WeedIMax then 
    WeedI=WeedI+0.25 
   end
 end
 local function DecreaseEffect1()
   if WeedI>WeedIMin then 
    WeedI=WeedI-0.25 
   end
 end
 local function IncreaseEffect2()
   if WeedS<WeedSMax then 
    WeedS=WeedS+1 if WeedEnable then LocalPlayer():SetDSP(WeedS) end
   end
 end
 local function DecreaseEffect2()
   if WeedS>WeedSMin then 
    WeedS=WeedS-1 if WeedEnable then LocalPlayer():SetDSP(WeedS) end
   end
 end
net.Receive( "WeedmeuStart", function()


 timer.Create("weedEffectTimer",228,1,function()
  hook.Remove("RenderScreenspaceEffects","SDrugs_WeedEffect")
  timer.Remove("Effect1")
  LocalPlayer():SetDSP(0)
  WeedEnable=false
  --print("Timer Over")
 end)

 timer.Simple(0.1,function()
  WeedEnable=true
  timer.Create("Effect1",9,0,function()
   for i=1,40 do
    timer.Simple(i/10,IncreaseEffect1)
   end
   for i=40,80 do
    timer.Simple(i/10,DecreaseEffect1)
   end
  end)
   for i=1,16 do
    timer.Simple(i/5,IncreaseEffect2)
   end
   for i=207,223 do
    timer.Simple(i,DecreaseEffect2)
   end
 end)
 hook.Add("RenderScreenspaceEffects","SDrugs_WeedEffect",function()
  if not WeedEnable then return end
  --print("RenderWeeed")

  DrawToyTown( WeedI, ScrH() )
 end)

end)

net.Receive("SDrugsDeath",function()
 local plySDDeath=net.ReadEntity()
 if not plySDDeath==LocalPlayer() then return end
 hook.Remove("RenderScreenspaceEffects","SDrugs_WeedEffect")
 timer.Remove("Effect1")
 WeedEnable=false
 LocalPlayer():SetDSP(0)
 timer.Remove("weedEffectTimer")
end)
print("InitWeedClient")