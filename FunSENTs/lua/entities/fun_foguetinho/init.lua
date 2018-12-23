AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName )
if ( !tr.Hit ) then return end
local ent = ents.Create( ClassName )
ent:SetPos( tr.HitPos + tr.HitNormal + Vector(0, 0, 30) )
ent:Spawn()
ent:Activate()
return ent
end

function ENT:Initialize()
if ( CLIENT ) then return end
self:SetModel( "models/props_c17/canister02a.mdl" )
self:SetColor(color_white)
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetSolid(SOLID_VPHYSICS)
self:SetUseType(SIMPLE_USE)	
self:GetPhysicsObject():Wake()
self:SetNWBool("FoguetinhoOn",false)
end


local function Explodir(ent) 
	if CLIENT then return end
   if ent:IsValid() then
    ent:GetPhysicsObject():EnableGravity(true)
    ent:StopLoopingSound(ent:GetNWInt("SomIDFoguetinho"))
   end
   local explode = ents.Create( "env_explosion" )
   explode:SetPos( ent:GetPos() )
   explode:CPPISetOwner( ent:CPPIGetOwner() )
   explode:Spawn() //this actually spawns the explosion
   explode:SetKeyValue( "iMagnitude", "220" ) //the magnitude
   explode:Fire( "Explode", 0, 0 )
   explode:EmitSound( "weapon_AWP.Single", 400, 400 )
   local ExplodirI=0.1
   local FoguetinhoOwner=ent:CPPIGetOwner()
   --ACF_HE( self:GetPos() , self:GetUp() , 1650, 37 , self:CPPIGetOwner(),{self})
   for k,v in pairs(ents.FindInSphere( ent:GetPos(), 300 )) do
   	if v:GetClass()=="prop_physics" then
   	 timer.Simple(ExplodirI,function()
   	  if not v:IsValid() then return end
   	  ACF_HE( v:GetPos() , v:GetPos() , 90,90 , FoguetinhoOwner )
   	 end)
   	 ExplodirI=ExplodirI+0.1
   	 //ACF_Damage(v,{Kinetic = 2500,Momentum = 100,Penetration = 300},200,200,self:CPPIGetOwner())
   	end
   end
   ent:Remove()
  end --fim da funcao explodir

function ENT:Use(activator,caller)
 if ( CLIENT ) then return end
 if self:GetNWBool("FoguetinhoOn")==false then
  --funcao explodir
  local Tempo=6	
  self:SetNWInt("SomIDFoguetinho",self:StartLoopingSound("ambient/gas/cannister_loop.wav"))
  
  
  
  self:SetNWBool("FoguetinhoOn",true)
  self:GetPhysicsObject():EnableGravity(false)
  
  timer.Create("Foguetinho"..self:EntIndex(),0.1,Tempo*10,function()
   if self:IsValid() then
    self:GetPhysicsObject():SetVelocity(self:GetUp()*1500)
   end
  end)
  timer.Simple(Tempo,function()
   if self:IsValid() then
    Explodir(self)
   end
  end)
 end
end

function ENT:PhysicsCollide(colData,entity)
  if CLIENT then return end
  if ( colData.Speed > 50 ) and self:GetNWBool("FoguetinhoOn") then Explodir(self) end
end