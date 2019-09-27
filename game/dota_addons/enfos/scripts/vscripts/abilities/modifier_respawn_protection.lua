modifier_respawn_protection = class({})

function modifier_respawn_protection:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
	return funcs
end

function modifier_respawn_protection:GetTexture()
	return "omniknight_guardian_angel"
end

function modifier_respawn_protection:GetEffectName()
	return "particles/items_fx/glyph_creeps.vpcf"
end

function modifier_respawn_protection:IsPurgable()
	return false
end

function modifier_respawn_protection:GetAbsoluteNoDamagePhysical(params) return true end
function modifier_respawn_protection:GetAbsoluteNoDamageMagical(params) return true end
function modifier_respawn_protection:GetAbsoluteNoDamagePure(params) return true end

function modifier_respawn_protection:CheckState()
	local state = {}
	if IsServer() then
		state[MODIFIER_STATE_ATTACK_IMMUNE] = true;
		state[MODIFIER_STATE_MAGIC_IMMUNE] = true;
		state[MODIFIER_STATE_NO_HEALTH_BAR] = true;
	end
	return state
end