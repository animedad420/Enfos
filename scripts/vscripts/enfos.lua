if Enfos == nil then
  Enfos = class({})
  Enfos.__index = Enfos
end

function Enfos:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

Enfos.moonbeamActive = {} -- value for the moonbeam
Enfos.appliers = {}
-- we have to populate these tables with the player ID values. if we don't, we'll get an indexing error when we try to use them for the first time.
for i=0,9 do
  Enfos.appliers[i] = ""
end
-- a function that makes dealing damage slightly faster.
function DealDamage(source, target, damage, dType, flags)
  local dTable = {
    victim = target,
    attacker = source,
    damage = damage,
    damage_type = dType,
    damage_flags = flags,
    ability = nil
  }
  ApplyDamage(dTable)
end
-- a function to quickly create an appropriate dummy
function FastDummy(target, team) 
  local dummy = CreateUnitByName("npc_dummy_unit", target, false, nil, nil, team)
  dummy:SetAbsOrigin(target) -- CreateUnitByName uses only the x and y coordinates so we have to move it with SetAbsOrigin()
  dummy:GetAbilityByIndex(0):SetLevel(1)
  dummy:AddNewModifier(dummy, nil, "modifier_phased", { duration = 9999})
  dummy:AddNewModifier(dummy, nil, "modifier_invulnerable", { duration = 9999})
  return dummy
end
-- quickly destroy a unit
function DelayDestroy(unit, delayAmount)
  Timers:CreateTimer(DoUniqueString("delay"), {
    endTime = delayAmount or 0.03,
    callback = function()
      unit:Destroy()
    end
  })
end
-- some fast math functions
function AdjustX(vec, xAdj) -- return the vector with x added
  return Vector(vec.x + xAdj, vec.y, vec.z)
end

function AdjustY(vec, yAdj) -- return the vector with y added
  return Vector(vec.x, vec.y + yAdj, vec.z)
end

function AdjustZ(vec, zAdj) -- return the vector with z added
  return Vector(vec.x, vec.y, vec.z + zAdj)
end

function GetMidPoint(vector1, vector2) -- can also pass in units
  if type(vector1) == "table" then
    vector1 = vector1:GetAbsOrigin()
  end
  if type(vector2) == "table" then
    vector2 = vector2:GetAbsOrigin()
  end
  return (vector1 + vector2)/2
end

  
