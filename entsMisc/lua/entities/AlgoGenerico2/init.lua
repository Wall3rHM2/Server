AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")
function ENT:Initialize()
		self:SetModel("models/props_junk/PopCan01a.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:GetPhysicsObject():Wake()
		self:Activate()
		self:SetSkin( math.random(1,3) )
	end
	
		function ENT:Use( activator, caller )
		
	local buffhealth = math.random(20,60)
	local maxhealth = activator:GetMaxHealth()
	local walkspeed = activator:GetWalkSpeed()
	local runspeed = activator:GetRunSpeed()
	local health = activator:Health()
	
	if IsValid(caller) and caller:IsPlayer() then
	self:Remove()
	activator:EmitSound( Sound( "entities/drink_soda.wav" ) )
	activator:SetHealth(health+buffhealth)
	if runspeed==400 then
	activator:SetWalkSpeed(walkspeed+200)
	activator:SetRunSpeed(runspeed+300)
	timer.Simple(240,function() 	
	activator:SetWalkSpeed(walkspeed)
	activator:SetRunSpeed(runspeed) 
	end)
	end
	
		end
	end
	
	function ENT:Think()
	end