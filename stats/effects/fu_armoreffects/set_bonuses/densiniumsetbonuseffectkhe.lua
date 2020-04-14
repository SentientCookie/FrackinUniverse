require "/stats/effects/fu_armoreffects/setbonuses_common.lua"
--require "/scripts/status.lua"

setName="fu_densiniumsetkhe"

weaponBonus={
  {stat = "critChance", amount = 4},
  {stat = "powerMultiplier", effectiveMultiplier = 1.25}
}

armorBonus={
	{stat = "breathProtection", amount = 1},
	{stat = "pressureProtection", amount = 1},
	{stat = "poisonStatusImmunity", amount = 1},
	{stat = "biomeheatImmunity", amount = 1},
	{stat = "biomeradiationImmunity", amount = 1},
	{stat = "biomecoldImmunity", amount = 1},	
	{stat = "ffextremeheatImmunity", amount = 1},
	{stat = "ffextremeradiationImmunity", amount = 1},
	{stat = "ffextremecoldImmunity", amount = 1},
	{stat = "fallDamageMultiplier", effectiveMultiplier = 0.25},
	{stat = "grit", amount=0.75}
}

function init()
	setSEBonusInit(setName)
	effectHandlerList.specialHandler=effect.addStatModifierGroup({})
	effectHandlerList.weaponBonusHandle=effect.addStatModifierGroup({})
	checkWeapons()

	effectHandlerList.armorBonusHandle=effect.addStatModifierGroup(armorBonus)
end

function update(dt)
	if not checkSetWorn(self.setBonusCheck) then
		effect.expire()
	else
		self.damageListener:update()
		effect.setStatModifierGroup(effectHandlerList.armorBonusHandle,armorBonus)

		checkWeapons()
	end
end

function checkWeapons()
	local weapons=weaponCheck({"densinium","sniper","chainsword"})
	if weapons["either"] then
		effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,weaponBonus)
	else
		effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,{})
	end
end