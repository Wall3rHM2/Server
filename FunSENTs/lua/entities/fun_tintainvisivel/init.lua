AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName )
if ( !tr.Hit ) then return end
local ent = ents.Create( ClassName )
ent:SetPos( tr.HitPos + tr.HitNormal + Vector(0, 0, 10) )
ent:Spawn()
ent:Activate()
return ent
end

function ENT:Initialize()
if ( CLIENT ) then return end
self:SetModel( "models/props_junk/metal_paintcan001a.mdl" )
self:SetColor(color_white)
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetSolid(SOLID_VPHYSICS)
self:SetUseType(SIMPLE_USE)
self:GetPhysicsObject():Wake()
end

function ENT:Use(activator,caller)
if CLIENT then return end
 self:Remove()
if caller:GetNWBool("tintainvisivel") then return end
 caller:SetNoDraw(true)
 caller:ChatPrint("Você está agora invisível.")
 caller:SetNWBool("tintainvisivel",true)
 timer.Simple(35,function()
  caller:SetNWBool("tintainvisivel",false)
  caller:ChatPrint("Você está agora visível.")
  caller:SetNoDraw(false)
 end)
end
if SERVER then
 hook.Add("PlayerSpawn","SpawnTintaInvisivel",function(ply)
  if ply:GetNWBool("tintainvisivel") then ply:SetNoDraw(true) end
 end)
end