modifier_soul_feast_passive_timer = class({})
function modifier_soul_feast_passive_timer:DeclareFunctions()
    local funcs = {}
	return funcs
end

function modifier_soul_feast_passive_timer:GetTexture()
	return "rubick_spell_steal"
end

function modifier_soul_feast_passive_timer:OnDestroy()
	local fuck = self:GetParent()
	local shit = fuck:FindModifierByName("modifier_soul_feast_lua")
	shit:ResetTrollUlt(false)
end