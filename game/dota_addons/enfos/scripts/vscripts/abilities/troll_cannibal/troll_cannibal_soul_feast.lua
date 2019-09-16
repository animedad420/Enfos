troll_cannibal_soul_feast = class({})
LinkLuaModifier( "modifier_soul_feast_lua", "abilities/troll_cannibal/modifier_soul_feast_lua.lua" ,LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_soul_feast_passive_timer", "abilities/troll_cannibal/modifier_soul_feast_passive_timer.lua" ,LUA_MODIFIER_MOTION_NONE )

function troll_cannibal_soul_feast:OnUpgrade()
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_soul_feast_lua", nil )
end