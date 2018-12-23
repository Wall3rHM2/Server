include("shared.lua")
local CanSpawn=1
function ENT:Draw()
	local LocalSodaEnt=self 
--[[local R=0
local G=255

net.Receive("SodaEnt",function()
local ReceiveEnt=net.ReadEntity()
if LocalSodaEnt == ReceiveEnt then
CanSpawn=0
R=255
G=0
timer.Simple(3,function()
R=0 G=255 end)
--]]

	
	

 







if self==nil then return end
self:DrawModel()

local MaquinaSodaPos = self:LocalToWorld(Vector(17.6,24.2,5.4))



 local material = Material( "sprites/light_glow02_add" )
 
 		net.Receive("SodaCor",function()
		 colorSoda=net.ReadColor()
		
		end)
	


	cam.Start3D() -- Start the 3D function so we can draw onto the screen.
	cam.IgnoreZ(false)
		render.SetMaterial( material ) -- Tell render what material we want, in this case the flash from the gravgun

		render.DrawSprite( MaquinaSodaPos, 8, 8,
		string.ToColor(self:GetNWString("CorSprite","0 255 0 255"))) 

		
	cam.End3D()




end