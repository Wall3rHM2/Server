AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")
util.AddNetworkString( "WeedmeuStart" )
function ENT:Initialize()
		self:SetModel("models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:GetPhysicsObject():Wake()
		self:Activate()


	end
	
		function ENT:Use( activator, caller )
	
	if IsValid(caller) and caller:IsPlayer()  then
	net.Start("WeedmeuStart")
	net.Send(caller)
	self:Remove()
		end
		end

	
	function ENT:Think()
	end