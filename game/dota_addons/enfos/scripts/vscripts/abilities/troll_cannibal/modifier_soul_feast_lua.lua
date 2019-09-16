modifier_soul_feast_lua = class({})
function modifier_soul_feast_lua:DeclareFunctions()
    local funcs = {
		--MODIFIER_EVENT_ON_HERO_KILLED,
		--MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED
    }
	return funcs
end

function modifier_soul_feast_lua:IsPurgable() return false end
function modifier_soul_feast_lua:RemoveOnDeath() return false end

function modifier_soul_feast_lua:OnCreated(keys)
	local caster = self:GetParent()
	--[[Timers:CreateTimer(DoUniqueString("removeSoulFeastUlt"), {
		endTime = 3,
		callback = function()
			if caster:FindAbilityByName("troll_cannibal_soul_feast") ~= nil then
				local ammoLevel = caster:FindAbilityByName("troll_cannibal_soul_feast"):GetLevel()
				caster:RemoveAbility("troll_cannibal_soul_feast")
				caster:AddAbility("sniper_fire_ammo_2")
				caster:FindAbilityByName("sniper_fire_ammo_2"):SetLevel(ammoLevel)
			end
		end
	})]]
end

--[[function modifier_soul_feast_lua:OnDeath(keys)
	if not IsServer() then
		return nil
	end
	
	local caster = self:GetParent()
	--PrintTable(keys.unit)
	if caster == keys.unit then
		self:ResetTrollUlt()
	end
end

function modifier_soul_feast_lua:OnHeroKilled(keys) NONE OF THIS WORKS! HOORAY!!!
	print("henlo")
	if not IsServer() then return nil end
	
	local caster = self:GetParent()
	local target = keys.target
	local name = target:GetUnitName()
	if name == "npc_dota_hero_troll_warlord" then return nil end
	if not target:IsRealHero() then return nil end
	if caster:IsIllusion() then return nil end
	if target:IsIllusion() then return nil end
	
	self:TrollUltSteal(target)
end]]

function modifier_soul_feast_lua:OnAbilityExecuted(keys)
	if not IsServer() then return nil end
	
	if keys.unit == self:GetParent() then
		if keys.ability:GetAbilityIndex() == 3 then
			self:ResetTrollUlt(false)
		end
	end
end

function modifier_soul_feast_lua:TrollUltSteal(victim)
	if not IsServer() then return nil end
	
	local caster = self:GetParent()
	local target = victim
	local name = target:GetUnitName()
	
	local spell = target:GetAbilityByIndex(3)
	if name == "npc_dota_hero_juggernaut" or name == "npc_dota_hero_terrorblade" 
	or name == "npc_dota_hero_beastmaster" or name == "npc_dota_hero_spirit_breaker" then spell = target:GetAbilityByIndex(2) end
	if name == "npc_dota_hero_silencer" then spell = target:GetAbilityByIndex(0) end
	local spellLevel = caster:FindAbilityByName("troll_cannibal_soul_feast"):GetLevel()
	caster:RemoveAbility("troll_cannibal_soul_feast")
	caster:AddAbility(spell:GetAbilityName())
	caster:FindAbilityByName(spell:GetAbilityName()):SetLevel(spellLevel)
	if name == "npc_dota_hero_luna" or name == "npc_dota_hero_silencer" then
		caster:RemoveAbility("troll_cannibal_soul_drain")
		caster:AddAbility("generic_focus_moonbeam")
		caster:FindAbilityByName("generic_focus_moonbeam"):SetLevel(1)
	end
	if name == "npc_dota_hero_sniper" or name == "npc_dota_hero_antimage" then
		caster:AddNewModifier(caster,self:GetAbility(),"modifier_soul_feast_passive_timer",{duration = 20})
	end
end

function modifier_soul_feast_lua:ResetTrollUlt(forcereset)
	if not IsServer() then return nil end
	
	local caster = self:GetParent()
	local spell = caster:GetAbilityByIndex(3)
	local spellLevel = spell:GetLevel()
	if spell:GetChannelTime() > 0 then
		if not forcereset then return nil end
	end
	caster:RemoveAbility(spell:GetAbilityName())
	caster:AddAbility("troll_cannibal_soul_feast")
	caster:FindAbilityByName("troll_cannibal_soul_feast"):SetLevel(spellLevel)
	if caster:FindAbilityByName("generic_focus_moonbeam") ~= nil then
		caster:RemoveAbility("generic_focus_moonbeam")
		caster:AddAbility("troll_cannibal_soul_drain")
		caster:FindAbilityByName("troll_cannibal_soul_drain"):SetLevel(1)
	end
end

function modifier_soul_feast_lua:TrollUltStealTest(name)
	if not IsServer() then return nil end
	
	local caster = self:GetParent()
	local target = victim
	
	local ammoLevel = caster:FindAbilityByName("troll_cannibal_soul_feast"):GetLevel()
	caster:RemoveAbility("troll_cannibal_soul_feast")
	caster:AddAbility(name)
	caster:FindAbilityByName(name:SetLevel(ammoLevel))
	if name == "npc_dota_hero_luna" or name == "npc_dota_hero_silencer" then
		caster:RemoveAbility("troll_cannibal_soul_drain")
		caster:AddAbility("generic_focus_moonbeam")
	end
	if name == "npc_dota_hero_sniper" or name == "npc_dota_hero_antimage" then
		caster:AddNewModifier(caster,self:GetAbility(),"modifier_soul_feast_passive_timer",{duration = 20})
	end
end