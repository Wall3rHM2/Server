AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")
local Preco=5
function ENT:Initialize()
		self:SetModel("models/props_interiors/VendingMachineSoda01a.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:GetPhysicsObject():Wake()
		self:Activate()
		
		util.AddNetworkString( "SodaCor" )
		 local Cor=Color(0,255,0,255)
		 net.Start( "SodaCor" )
		 net.WriteColor( Cor )
		 net.Broadcast()
		 
		 self:SetNWInt("CanSpawnRefri",1)
		 self:SetNWInt("CantRefri",1)
		 


	end
	
		function ENT:Use( activator, caller )

 self:GetNWInt("CantRefri",1)

	
	if IsValid(caller) and caller:IsPlayer() then
		 util.AddNetworkString( "SodaEnt" )
		 net.Start( "SodaEnt" )
		 net.WriteEntity( self )
		 net.Broadcast()
		 

if self:GetNWInt("CanSpawnRefri",1)==1 and activator:GetMoeda()>=Preco then
self:EmitSound(Sound("buttons/blip1.wav"))
self:SetNWInt("CanSpawnRefri",0)
timer.Simple(1,function()
activator:TakeMoeda(Preco)
activator:SaveMoeda()
self:SetNWString("CorSprite","255 0 0 255")
--[[
		 net.Start( "SodaCor" )
		 net.WriteColor( Cor )
		 net.Broadcast()--]]

		 local ent = ents.Create( "AlgoGenerico2" )
		 activator:EmitSound( Sound( "ambient/levels/labs/coinslot1.wav" ) )
		ent:SetPos( self:GetPos() + ( self:GetForward() * 30 ) + ( self:GetUp() * -30 ) )
		ent:CPPISetOwner(activator)
		ent:SetAngles( self:GetAngles() + Angle( 0, 0, 90 ) )
		ent:Spawn()
		ent:Activate()
		ent:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 150 )

timer.Simple(3,function()
self:SetNWString("CorSprite","0 255 0 255")
self:SetNWInt("CanSpawnRefri",1)
	--[[	 local Cor=Color(R,G,0,255)
		 net.Start( "SodaCor" )
		 net.WriteColor( Cor )
		 net.WriteEntity(self)
		 net.Broadcast()--]]

end)
		 
end)
		 
		
		elseif self:GetNWInt("CantRefri",1)==1  and activator:GetMoeda()<Preco then
		self:SetNWInt("CantRefri",0)
	activator:ChatPrint("Você não possui dinheiro suficiente.")
	timer.Simple(3,function()
	self:SetNWInt("CantRefri",1) end)
		end
	end
	end



	function ENT:Think()
	end
	