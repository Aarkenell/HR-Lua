require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

--[[
To make indiv cards perform summonings:
* Create buff for each player (p1 & p2 versions) onStartGame - this is what each card will look for to determine which Ritual pool to add/deduct points to/from.
* Create local ef_ effects for multiple cards to reference. eg. ef_1 performs Lesser rituals ?? will this work?
* conditions... how to set condition that checks 

Card Effect = ifElse(check for buff_p1, yes = ef_A, no = ef_B

ef_A = ifElse(p1 ritual pool.gte(X), yes = reduce pool + summon/do ritual, no = text effect; Not enough Ritual points - click undo & take the Ritual points)

ef_B = as above but check p2 ritual pool

]]

    local setup_p1_ritual_buff = createGlobalBuff({
        id="setup_p1_ritual_buff",
        name = "Necros Rituals",
        abilities = {
            createAbility({
                id="setup_p1_ritual_buff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "Necros Ritual Points",
							art = "icons/the_summoning",
							frame = "frames/necros_action_cardframe",
							text=format("<size=150%>{0}", { getCounter("p1_ritual")})
					})
    })
	
	    local setup_p2_ritual_buff = createGlobalBuff({
        id="setup_p2_ritual_buff",
        name = "Necros Rituals",
        abilities = {
            createAbility({
                id="setup_p2_ritual_buff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "Necros Ritual Points",
							art = "icons/the_summoning",
							frame = "frames/necros_action_cardframe",
							text=format("<size=150%>{0}", { getCounter("p2_ritual")})})
    })

local slot = createSlot({
        id = "VeilOfVoid",
        expiresArray = { neverExpiry }
    })

function startOfGameBuffDef()

    return createGlobalBuff({
        id="startOfGameBuff",
        name = "Replace a faction",
        abilities = {
            createAbility({
                id="SoG_effect",
                trigger = startOfGameTrigger,
                effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
				.seq(sacrificeTarget().apply(selectLoc(tradeDeckLoc).where(isCardFaction(necrosFaction))))
				
						.seq(createCardEffect(acs_fanaticist_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_fanaticist_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_acolyte_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_acolyte_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_knight_of_karamight_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_demonic_linguist_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_servant_of_the_shade_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_occultist_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_coven_priestess_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_the_chosen_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_infernal_speech_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_rite_of_the_coven_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_rite_of_the_coven_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_ceremonial_altar_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_ceremonial_altar_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_blood_ritual_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_summoning_circle_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_sinister_propaganda_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_demonic_runes_carddef(), loc(nil, nullPloc)))
						.seq(createCardEffect(acs_dark_mass_carddef(), loc(nil, nullPloc)))
						.seq(moveTarget(tradeDeckLoc).apply(selectLoc(loc(nil, nullPloc))))


				.seq(shuffleTradeDeckEffect()).seq(shuffleTradeDeckEffect())
				.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
				
	--create buffs
				.seq(createCardEffect(setup_p1_ritual_buff, loc(currentPid, buffsPloc)))
				.seq(createCardEffect(setup_p2_ritual_buff, loc(oppPid, buffsPloc)))
				
			})
        }   
	})
end


--Summoned tokens

function acs_void_guard_carddef()
    return createChampionDef(
        {
            id = "acs_void_guard",
            name = "Void Guard",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "void_guard_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1)
						
                    }
                ),
			--self-sac ability
                createAbility(
                    {
                        id = "fel_hound_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                ),
            },
            layout = createLayout(
                {
                    name = "Void Guard",
                    art = "art/t_midnight_knight",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{combat_1}
&lt;size=40%&gt;You can't a-void him."
fontsize="50" flexiblewidth="12" fontstyle="italic" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="If this token would leave play," fontsize="19" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]],
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end

function acs_fel_hound_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "acs_fel_hound",
            name = "Fel Hound",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "fel_hound_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2)
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "fel_hound_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Fel hound",
                    art = "art/epicart/demon_token",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <icon text="{combat_2}" fontsize="60"/>
</box>
</hlayout>
   <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 1,
                    isGuard = false
                }
            )
        }
    )
end

function acs_demonic_leech_carddef()
    return createChampionDef(
        {
            id = "acs_demonic_leech",
            name = "Demonic Leech",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 0,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "demonic_leech_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitOpponentEffect(1)
								.seq((grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow")).apply(selectSource()))
                    }
                ),
				createAbility(
                    {
                        id = "demonic_leech_explode",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = ifElseEffect(selectLoc(currentInPlayLoc).where(isCardSelf().And(getCardHealth().gte(5))).count().gte(1), 
							hitOpponentEffect(5).seq(sacrificeTarget().apply(selectSource())),
							nullEffect()), 
                    }),
					
				createAbility(
                    {
                        id = "demonic_leech_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Demonic Leech",
                    art = "art/t_wurm",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					xmlText = [[
<vlayout>
    <hlayout flexibleheight="0.5">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Deal 1 damage to opponent.
+1{shield} until this leaves play." fontsize="18"/>
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="0.7">
        <box flexiblewidth="7">
            <tmpro text="Explode: If this has 6{shield} at the start of a turn, immediately deal 5 damage to opponent and sacrifice this card. " fontsize="16"/>
</box>
</hlayout>
<divider/>

    <hlayout flexibleheight="0.5">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout>
</vlayout>
					]],
					health = 0,
                    isGuard = false
                }
            )
        }
    )
end

function acs_lesser_devourer_carddef()
    return createChampionDef(
        {
            id = "acs_lesser_devourer",
            name = "Lesser Devourer",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "lesser_devourer_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitSelfEffect(1).seq(grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow").apply(selectSource())),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Lesser Devourer",
                    art = "art/t_demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText = [[
<vlayout>
<hlayout flexibleheight="0.5">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{health_-1}" fontsize="38" alignment="Center" flexibleheight="1"/>
                                <tmpro text="Gain +1{shield} permanently." fontsize="22" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>
    </hlayout>
<divider/>
    <hlayout flexibleheight="0.5">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end

function acs_devourer_carddef()
    return createChampionDef(
        {
            id = "acs_devourer",
            name = "Devourer",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 3,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "devourer_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1).seq(hitSelfEffect(1).seq(grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow").apply(selectSource()))),
                    }
                ),
	--Below ability from original Custom multi script - removed for this script
				--[[createAbility(
                    {
                        id = "devourer_leaveplay",
                        trigger = onLeavePlayTrigger,
						cost= noCost,
                        activations = singleActivations,
                        effect = gainHealthEffect(2),
                    }
                )]]
            },
            layout = createLayout(
                {
                    name = "Devourer",
                    art = "art/epicart/thrasher_demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{health_-1} {combat_1}
Devourer gains +1{shield} until it leaves play." fontsize="21" flexiblewidth="10" />
    </hlayout>
    <divider/>
<hlayout flexibleheight="2">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
					]],
                    health = 3,
                    isGuard = true
                }
            )
        }
    )
end

function acs_shadow_feeder_carddef()
    return createChampionDef(
        {
            id = "acs_shadow_feeder",
            name = "Shadow Feeder",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "shadow_feeder_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = ifElseEffect(selectLoc(currentInPlayLoc).where(isCardType(demonType)).count().gte(2),gainCombatEffect(4),gainCombatEffect(2))
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Shadow Feeder",
                    art = "art/epicart/deathbringer",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="38" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{combat_2}" fontsize="38" alignment="Center" flexibleheight="1"/>
                                <tmpro text="+{combat_2}  if you have another Demon in play." fontsize="22" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>
    </hlayout>
<divider/>
    <hlayout flexibleheight="0.5">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function acs_phase_demon_carddef()
    return createChampionDef(
        {
            id = "acs_phase_demon",
            name = "Phase Demon",
			types = {minionType, championType, demonType, nostealType, tokenType},
			factions = {necrosFaction},
            health = 4,
            isGuard = true,
            abilities = {
				createAbility(
                    {
                        id = "phase_demon_onleave",
                        trigger = onLeavePlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = createCardEffect(acs_phased_demon_carddef(), loc(ownerPid, inPlayPloc))
						.seq(sacrificeSelf())
						,
					}	  
                ),
            },
            layout = createLayout(
                {
                    name = "Phase Demon",
                    art = "art/epicart/spawning_demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
   <hlayout flexibleheight="3">
            <tmpro text="When stunned, put a
Phased Demon in play.
(It has 2{shield} and {combat_1}.)" fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
<hlayout flexibleheight="1.2">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
					]],
                    health = 4,
                    isGuard = true
                }
            )
        }
    )
end

function acs_phased_demon_carddef()
    return createChampionDef(
        {
            id = "acs_phased_demon",
            name = "Phased Demon",
			types = {minionType, championType, demonType, nostealType, tokenType},
			factions = {necrosFaction},
            health = 2,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "phased_demon_combat",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1)
						,
					}	  
                ),
				
				createAbility(
                    {
                        id = "phased_demon_onleave",
                        trigger = onLeavePlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeSelf()
						,
					}	  
                ),
            },
            layout = createLayout(
                {
                    name = "Phased Demon",
                    art = "art/epicart/spawning_demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
 <hlayout flexibleheight="5">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_1}" fontsize="40"/>
</box>
</hlayout>
    <divider/>
<hlayout flexibleheight="3">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function acs_strange_thing_carddef()
    return createChampionDef(
        {
            id = "acs_strange_thing",
            name = "A Strange Thing",
			types = {minionType, championType, demonType, nostealType, tokenType},
            health = 4,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "strange_thing_combat",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2)
						,
					}	  
                ),
				
				createAbility(
                    {
                        id = "strange_thing_transform",
                        trigger = endOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = transformTarget("acs_stranger_thing").apply(selectSource()),
						check = selectLoc(loc(oppPid, discardPloc)).where(isCardStunned()).count().gte(2)
						,
					}	  
                ),
				
				createAbility(
                    {
                        id = "strange_thing_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "A Strange Thing",
                    art = "art/epicart/elder_greatwurm",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
 <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_2}" fontsize="30"/>
</box>
</hlayout>
    <divider/>
<hlayout flexibleheight="1.5">
        <box flexiblewidth="7">
            <tmpro text="If you stun 2+ champions this turn, transform into a Stranger Thing
at end of turn." fontsize="16"/>
        </box>
    </hlayout> 
    <divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
					]],
                    health = 4,
                    isGuard = false
                }
            )
        }
    )
end

function acs_stranger_thing_carddef()
    return createChampionDef(
        {
            id = "acs_stranger_thing",
            name = "A Stranger Thing",
			types = {minionType, championType, demonType, nostealType, tokenType},
            health = 6,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "stranger_thing_combat",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitOpponentEffect(4)
						,
					}	  
                ),
				createAbility(
                    {
                        id = "stranger_thing_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "A Stranger Thing",
                    art = "art/epicart/reaper",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
 <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="6">
            <icon text="Deal 4 damage to your opponent." fontsize="24"/>
</box>
</hlayout>
    <divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
					]],
                    health = 6,
                    isGuard = false
                }
            )
        }
    )
end

function acs_incubus_carddef()
    return createChampionDef(
        {
            id = "acs_incubus",
            name = "Incubus",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 4,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "acs_incubus_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(getCounter("incubus"))
                    }
                ),
				
				createAbility(
                    {
                        id = "acs_incubus_main",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = incrementCounterEffect("incubus", 1)
                    }
                ),
			
			createAbility(
                    {
                        id = "acs_incubus_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleeActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
			--changed from layout to cardLayout
            cardLayout = createLayout({
            name = "Incubus",
            art = "art/epicart/guilt_demon",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = format ([[
			<vlayout>
    <hlayout flexibleheight="1.5">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{0}{combat}" fontsize="40" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1.5">
            <tmpro text="Gains {combat_1} (permanently)
at the start of each turn." fontsize="20" flexiblewidth="10" />
    </hlayout> 
    <divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
]],
		{ getCounter("incubus") }),
					health = 4,
                    isGuard = false
        })
        }
    )
end

function acs_laughing_shade_carddef()
    return createChampionDef(
        {
            id = "acs_laughing_shade",
            name = "Laughing Shade",
			types = {championType, demonType, minionType, nostealType,},
            acquireCost = 0,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "acs_laughing_shade_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(4)
						.seq(pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = pushTargetedEffect({
												desc = "Sacrifice a Action from the market. <sprite name=\"combat_1\">",
												validTargets = selectLoc(centerRowLoc).where(isCardType(actionType)),
												min = 1,
												max = 1,
												targetEffect = sacrificeTarget().seq(gainCombatEffect(1)),
												}),
                                            layout = layoutCard(
                                                {
                                                    title = "Laughing Shade",
													art = "art/epicart/dark_prince",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="6">
            <tmpro text="&lt;size=70%&gt;Sacrifice an Action from the market. 
&lt;size=100%&gt;{combat_1}" fontsize="40" flexiblewidth="10" />
    </hlayout> 
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = pushTargetedEffect({
												desc = "Sacrifice a Champion from the market. <sprite name=\"health_3\">",
												validTargets = selectLoc(centerRowLoc).where(isCardType(championType)),
												min = 1,
												max = 1,
												targetEffect = sacrificeTarget().seq(gainHealthEffect(3)),
												}),
                                            layout = layoutCard(
                                                {
                                                    title = "Laughing Shade",
													art = "art/epicart/dark_prince",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="6">
            <tmpro text="&lt;size=70%&gt;Sacrifice a Champion from the market. 
&lt;size=100%&gt;{health_3}" fontsize="40" flexiblewidth="10" />
    </hlayout> 
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )),
					
                    }
                ),
				
			createAbility(
                    {
                        id = "acs_laughing_shade_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = multipleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout({
            name = "Laughing Shade",
            art = "art/epicart/dark_prince",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
			<vlayout>
 <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_4}" fontsize="30"/>
</box>
</hlayout>
    <divider/>
<hlayout flexibleheight="2">
        <box flexiblewidth="7">
            <tmpro text="Sacrifice a card in the market.
If it is an Action, +{combat_1} this turn.
If it is a Champion, +{health_3}." fontsize="20"/>
        </box>
    </hlayout> 
    <divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
]],
					health = 5,
                    isGuard = false
        })
        }
    )
end

function acs_karamight_carddef()
    return createChampionDef(
        {
            id = "acs_karamight",
            name = "Karamight",
			types = {championType, demonType, minionType, nostealType},
            acquireCost = 0,
            health = 5,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "acs_karamight_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(6),
                    }
                ),
				
			
			createAbility(
                    {
                        id = "acs_karamight_stun",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = grantHealthTarget(2, { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "Karamight").apply(selectSource())
						.seq(pushTargetedEffect({
                    desc = "Stun a demon minion you own to gain +2 <sprite name=\"guard\"> until your next turn.",
                    validTargets = selectLoc(currentInPlayLoc).where(isCardType(minionType).And(isCardName("Karamight").invert())),
                    min = 1,
                    max = 1,
                    targetEffect = stunTarget(),
					
            })),
			check = selectLoc(currentInPlayLoc).where(isCardType(minionType)).count().gte(2)
                    }
                ),
				
			createAbility(
                    {
                        id = "acs_karamight_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = multipleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout({
            name = "Karamight",
            art = "art/epicart/raxxa_s_enforcer",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
<vlayout>
 <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_6}" fontsize="40"/>
</box>
</hlayout>
    <divider/>
<hlayout flexibleheight="3">
        <box flexiblewidth="7">
            <tmpro text="You may stun a demon token you own to gain +2{guard} until next turn." fontsize="20"/>
        </box>
    </hlayout> 
    <divider/>
<hlayout flexibleheight="1.5">
        <box flexiblewidth="7">
            <tmpro text="If this token would leave play,
put it back in the token pile." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
]],
					health = 5,
                    isGuard = true
        })
        }
    )
end


--Perform Rituals
local lesser_rituals = pushChoiceEffectWithTitle(

{
					upperTitle = "Cost is paid in Ritual points (not Gold).",
					lowerTitle = "All demons summoned are tokens, and are sacrificed when they leave play.",
choices = {
-- Choice 1a: Always available - 1 cost
			{
				effect = pushTargetedEffect({
												desc = "Give a champion +2 <sprite name=\"shield\"> until your next turn.",
												validTargets = selectLoc(currentInPlayLoc),
												min = 0,
												max = 1,
												targetEffect = grantHealthTarget(2, { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "shadow")
											})
						.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -1), incrementCounterEffect("p2_ritual", -1)))
						,

				cost = 1,
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(1),

				layout = createLayout({
					name = "Infernal Strength",
					art = "art/epicart/dark_leader",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 1,
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Give a champion +2{shield} until your next turn." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},

-- Choice 1b: Always available - 1 cost

			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -1), incrementCounterEffect("p2_ritual", -1))
				.seq(createCardEffect(acs_demonic_leech_carddef(), currentInPlayLoc)),
            condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(1),
			layout = createLayout(
                {
                    name = "Summon Demonic Leech",
                    art = "art/t_wurm",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 1,
					xmlText = [[
<vlayout>
    <hlayout flexibleheight="0.5">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Deal 1 damage to opponent.
+1{shield} until this leaves play." fontsize="18"/>
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="0.7">
        <box flexiblewidth="7">
            <tmpro text="Explode: If this has 5{shield} at the start of a turn, immediately deal 5 damage to opponent and sacrifice this card. " fontsize="20"/>
</box>
</hlayout>
</vlayout>
					]],
					health = 0,
                    isGuard = false
                }
            ),
				
				tags = {}
			},			
-- Choice 1c: Always available - 2 cost									
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -2), incrementCounterEffect("p2_ritual", -2))
				.seq(createCardEffect(acs_void_guard_carddef(), currentInPlayLoc)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(2),
				layout = createLayout({
                    name = "Summon Void Guard",
                    art = "art/t_midnight_knight",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 2,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="50" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="You can't a-void him." fontsize="20" fontstyle="italic" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]],
                    health = 2,
                    isGuard = true
									}),
				
				tags = {}
			},	

-- Choice 1d- Always available - 2 cost
													{
				effect = gainMaxHealthEffect(currentPid, 1).seq(gainHealthEffect(4))
							.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -2), incrementCounterEffect("p2_ritual", -2))),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(2),
				layout = createLayout({
					name = "Embrace Darkness",
					art = "art/epicart/dark_offering",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 2,
					
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Increase your
max Health by 1.

&lt;size=150%&gt;{health_4}" fontsize="24"/>
	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			}									
}
}
)

local common_rituals = pushChoiceEffectWithTitle(

{
					upperTitle = "Cost is paid in Ritual points (not Gold). You must have a Necros card in play to perform these Rituals.",
					lowerTitle = "All demons summoned are tokens, and are sacrificed when they leave play.",
choices = {
-- Choice 2a: Always available - 3 cost
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -3), incrementCounterEffect("p2_ritual", -3))
				.seq(createCardEffect(acs_shadow_feeder_carddef(), currentInPlayLoc)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(3),
				layout = createLayout(
                {
                    name = "Summon Shadow Feeder",
                    art = "art/epicart/deathbringer",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 3,
					
					xmlText = [[
<vlayout>
<hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="38" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <tmpro text="{combat_2}
&lt;size=70%&gt;+{combat_2}  if you have another Demon
in play." fontsize="38" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>
    </hlayout>
</vlayout>
					]],
					health = 2,
                    isGuard = false
                }
            ),
				
				tags = {}
			},

-- Choice 2b: Require 1 of 2 - 3 Costs
--Should some require specific cards in play to Summon? E.g This needs Linguist/Acolyte
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -3), incrementCounterEffect("p2_ritual", -3))
				.seq(createCardEffect(acs_devourer_carddef(), currentInPlayLoc)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(3),
				layout = createLayout({
					name = "Summon Devourer",
					art = "art/epicart/thrasher_demon",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 3,
					
					health = 3,
                    isGuard = true,
					xmlText=[[<vlayout> 
   <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="30" flexiblewidth="2"/>
            <tmpro text="{health_-1} {combat_1}
&lt;size=70%&gt;Devourer gains +1{shield} until it leaves play." fontsize="32" flexiblewidth="10" />
    </hlayout>
</vlayout>
					]]
									}),
				
				tags = {}
			},
			
-- Choice 2c: Always available - 4 cost									
			{
			
			
				effect = pushTargetedEffect({
												desc = "Give a champion +1 <sprite name=\"shield\"> until it leaves play. It cannot be attacked (and loses guard) until your next turn.",
												validTargets = selectLoc(loc(currentPid, inPlayPloc)).where(isCardWithSlotString("VeilOfVoid").invert()),
												min = 0,
												max = 1,
												targetEffect = grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow")
												.seq(addSlotToTarget(createNoAttackSlot({ startOfOwnerTurnExpiry, startOfTurnExpiry })))
												.seq(addSlotToTarget(createGuardSwitchSlot(false, { startOfOwnerTurnExpiry })))
												.seq(addSlotToTarget(slot))
											})
				.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -4), incrementCounterEffect("p2_ritual", -4))),
condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(4),
				layout = createLayout({
                     name = "Veil of the Void",
                    art = "art/t_dark_energy",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 4,
					
                    xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="Give a champion +1{shield} until it leaves play. It cannot be attacked (and loses guard) until your next turn. 
&lt;size=75%&gt;
(Each champion can only be the target of this Ritual once per game.)" fontsize="22"/>	</hlayout>	</vlayout>
					]],
									}),
				
				tags = {}
			},	

-- Choice 2d- Require X- 4 cost
													{
				effect = pushTargetedEffect({
												desc = "Expend a champion.",
												validTargets = oppStunnableSelector(),
												min = 0,
												max = 1,
												targetEffect = expendTarget()
											})
							.seq(hitSelfEffect(2))
							.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -4), incrementCounterEffect("p2_ritual", -4))),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(4),
				layout = createLayout({
					name = "Bend Will",
					art = "art/epicart/scara_s_will",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 4,
					
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="-{health_2}
&lt;size=80%&gt;Expend a champion." fontsize="32"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			}									
}
}
)

local greater_rituals = pushChoiceEffectWithTitle(

{
					upperTitle = "Cost is paid in Ritual points (not Gold). You must have a Necros card in play to perform these Rituals.",
					lowerTitle = "All demons summoned are tokens, and are sacrificed when they leave play.",
choices = {
-- Choice 3a: Always available - 5 cost
			{
				effect = hitOpponentEffect(4).seq(gainMaxHealthEffect(oppPid, -2))
							.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -5), incrementCounterEffect("p2_ritual", -5))),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(5),
				layout = createLayout({
					name = "Soul Tap",
					art = "art/t_life_drain",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 5,
					
					xmlText=[[<vlayout> 
<hlayout flexiblewidth="1">
<text text="Deal 4 damage 
to your opponent.
Reduce their
max health by 2." fontsize="22"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},

-- Choice 3b: Require 1 of 2 - 5 Costs
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -5), incrementCounterEffect("p2_ritual", -5))
				.seq(createCardEffect(acs_phase_demon_carddef(), currentInPlayLoc)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(5),
				layout = createLayout({
					name = "Summon Phase Demon",
					art = "art/epicart/spawning_demon",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					health = 4,
                    isGuard = true,
					cost = 5,
					
					xmlText=[[<vlayout>
   <hlayout flexibleheight="3">
            <tmpro text="When stunned, put a
Phased Demon in play.
(It has 2{shield} and {combat_1}.)" fontsize="24" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
									}),
				
				tags = {}
			},
			
-- Choice 3c: Always available - 4 cost									
			{
				effect = drawCardsEffect(1)
				.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -6), incrementCounterEffect("p2_ritual", -6))),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(6),
				layout = createLayout({
                     name = "Invoke",
                    art = "art/epicart/time_walker",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 6,
					
                    xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="Draw 1" fontsize="32"/>	</hlayout>	</vlayout>
					]],
									}),
				
				tags = {}
			},	

-- Choice 3d- Require X- 4 cost
													{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -6), incrementCounterEffect("p2_ritual", -6))
				.seq(createCardEffect(acs_strange_thing_carddef(), currentInPlayLoc)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(6),
				layout = createLayout({
					name = "Summon a Strange Thing",
					art = "art/epicart/elder_greatwurm", --reaper, spore_beast
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					health = 4,
                    isGuard = false,
					cost = 6,
					
					xmlText=[[<vlayout>
 <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_2}" fontsize="30"/>
</box>
</hlayout>
    <divider/>
<hlayout flexibleheight="2">
        <box flexiblewidth="7">
            <tmpro text="If you stun 2+ champions this turn, transform into a Stranger Thing." fontsize="20"/>
        </box>
    </hlayout> 
</vlayout>
					]]
									}),
				
				tags = {}
			}									
}
}
)

local infernal_rituals = pushChoiceEffectWithTitle(

{
					upperTitle = "Cost is paid in Ritual points (not Gold). You must have a Necros card in play to perform these Rituals.",
					lowerTitle = "All demons summoned are tokens, and are sacrificed when they leave play.",
choices = {
-- Choice 4a: Always available - 7 cost
{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -7), incrementCounterEffect("p2_ritual", -7))
				.seq(createCardEffect(acs_incubus_carddef(), currentInPlayLoc))
				.seq(incrementCounterEffect("incubus", 3)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(7),
				layout = createLayout({
					name = "Summon Incubus",
					art = "art/epicart/guilt_demon",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					health = 4,
                    isGuard = false,
					cost = 7,
					
					xmlText=[[<vlayout>
    <hlayout flexibleheight="0.5">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <icon text="{combat_3}" fontsize="40" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="3">
            <tmpro text="Gains {combat_1} (permanently)
at the start of each turn." fontsize="24" flexiblewidth="10" />
    </hlayout>
</vlayout>
					]]
									}),
				
				tags = {}
			},

-- Choice 4b: 7 Cost
--Should some require specific cards in play to Summon? E.g This needs Linguist/Acolyte
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -7), incrementCounterEffect("p2_ritual", -7))
				.seq(hitOpponentEffect(selectLoc(loc(currentPid, handPloc)).sum(getCardCost())))
				.seq(hitSelfEffect(divide(selectLoc(loc(currentPid, handPloc)).sum(getCardCost()), 2)))
				.seq(addEffect(endTurnEffect())),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(7),
				layout = createLayout({
					name = "Crazed Chaos",
					art = "art/epicart/divine_judgment",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 7,
					
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Add the cost of
all cards in your hand.
Hit your opponent for damage equal to that amount.
Hit yourself for half that amount (rounded down).
End your turn immediately." fontsize="18"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},
			
-- Choice 4c: Always available - 8 cost									
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -8), incrementCounterEffect("p2_ritual", -8))
				.seq(createCardEffect(acs_laughing_shade_carddef(), currentInPlayLoc)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(8),
				layout = createLayout({
                     name = "Summon Laughing Shade",
                    art = "art/epicart/dark_prince",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 8,
					
					health = 5,
					isGuard = false,
                    xmlText=[[
<vlayout>
 <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_4}" fontsize="30"/>
</box>
</hlayout>
    <divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Sacrifice a card in the market.
If it is an Action, +{combat_1} this turn.
If it is a Champion, +{health_3}." fontsize="16"/>
        </box>
    </hlayout> 
</vlayout>
					]],
									}),
				
				tags = {}
			},	

-- Choice 4d- Require X- 8 cost
													{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -8), incrementCounterEffect("p2_ritual", -8))
				.seq(createCardEffect(acs_karamight_carddef(), currentInPlayLoc)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(8),
				layout = createLayout({
					name = "Summon Karamight",
					art = "art/epicart/raxxa_s_enforcer",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					health = 5,
                    isGuard = true,
					cost = 8,
			
					xmlText=[[<vlayout>
 <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_6}" fontsize="30"/>
</box>
</hlayout>
    <divider/>
<hlayout flexibleheight="1.5">
        <box flexiblewidth="7">
            <tmpro text="You may stun a demon token you own to gain +2{guard} until next turn." fontsize="20"/>
        </box>
    </hlayout> 
</vlayout>
					]]
									}),
				
				tags = {}
			}									
}
}
)

local ef_ritual_1 = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Lesser Rituals
			{
				effect = lesser_rituals,

				layout = createLayout({
					name = "Lesser Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 1-2 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},
			
}
}
)

local ef_ritual_2 = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Lesser Rituals
			{
				effect = lesser_rituals,

				layout = createLayout({
					name = "Lesser Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 1-2 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},

-- Choice 2: Common Rituals
			{
				effect = common_rituals,

				layout = createLayout({
					name = "Devout Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 3-4 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},
			
}
}
)

local ef_ritual_3 = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Lesser Rituals
			{
				effect = lesser_rituals,

				layout = createLayout({
					name = "Lesser Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 1-2 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},

-- Choice 2: Common Rituals
			{
				effect = common_rituals,

				layout = createLayout({
					name = "Devout Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 3-4 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},
			
-- Choice 3: Greater Rituals									
			{
				effect = greater_rituals,

				layout = createLayout({
					name = "Greater Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 5-6 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},	
										
}
}
)

local ef_ritual_4 = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Lesser Rituals
			{
				effect = lesser_rituals,

				layout = createLayout({
					name = "Lesser Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 1-2 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},

-- Choice 2: Common Rituals
			{
				effect = common_rituals,

				layout = createLayout({
					name = "Devout Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 3-4 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},
			
-- Choice 3: Greater Rituals									
			{
				effect = greater_rituals,

				layout = createLayout({
					name = "Greater Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 5-6 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},	

-- Choice 4- Infernal Rituals
			{
				effect = infernal_rituals,

				layout = createLayout({
					name = "Infernal Rituals",
					art = "icons/the_summoning",
					frame = "frames/necros_action_cardframe",
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Cost 7-8 Ritual points." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},										
}
}
)
			


--Champions

function acs_acolyte_carddef()
    return createChampionDef(
        {
            id = "acs_acolyte",
            name = "Acolyte",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 3,
            health = 3,
            isGuard = true,
            abilities = {
				createAbility(
                    {
                        id = "acolyte_combat",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2)
					}	  
                ),
				createAbility(
                    {
                        id = "acolyte_leavePlay",
                        trigger = onLeavePlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 1), incrementCounterEffect("p2_ritual", 1))
					
					}	  
                ),
				createAbility(
                    {
                        id = "acolyte_ally",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain Ritual
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 2), incrementCounterEffect("p2_ritual", 2)),
				layout = createLayout({
									name = "Acolyte",
									art = "art/epicart/corpse_taker",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="2 Ritual" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2: Perform Ritual							
			{
				effect = ef_ritual_1,
				layout = createLayout({
							name = "Acolyte",
							art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Perform a
level 1 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
),
						promptType = showPrompt,
						layout = createLayout({
							name = "Acolyte",
							art = "art/epicart/corpse_taker",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="2 Ritual
or
Perform a
level 1 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                })
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Acolyte",
                    art = "art/epicart/corpse_taker",
                    frame = "frames/necros_champion_cardframe",
					cost = 3,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_2}" fontsize="40" flexiblewidth="12" />
    </hlayout>

<divider/>
    <hlayout flexibleheight="1">
            <tmpro text="{necro}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="2 Ritual" fontsize="24" flexiblewidth="12" />
    </hlayout>
<divider/>
    <hlayout flexibleheight="0.5">
        <box flexiblewidth="7">
            <tmpro text="When this leaves play: 1 Ritual" fontsize="16"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 3,
                    isGuard = true
                }
            )
        }
    )
end

function acs_demonic_linguist_carddef()
    return createChampionDef(
        {
            id = "acs_demonic_linguist",
            name = "Demonic Linguist",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 4,
            health = 5,
            isGuard = false,
            abilities = {
			
				createAbility(
                    {
                        id = "demonic_linguist_healthbuff",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = singleActivations,
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain Ritual
			{
				effect = gainGoldEffect(2)
				.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 1), incrementCounterEffect("p2_ritual", 1))),
				layout = createLayout({
									name = "Demonic Linguist",
									art = "art/epicart/abyss_summoner",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{gold_2}
&lt;size=75%&gt;1 Ritual" fontsize="36" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2: Perform Ritual							
			{
				effect = gainGoldEffect(2).seq(ef_ritual_2),
				layout = createLayout({
							name = "Demonic Linguist",
							art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{gold_2}
&lt;size=75%&gt;Perform a
level 1-2 Ritual." fontsize="36" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
)
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Demonic Linguist",
                    art = "art/epicart/abyss_summoner",
                    frame = "frames/necros_champion_cardframe",
					cost = 4,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{gold_2}
 &lt;size=65%&gt;and 1 Ritual or Perform a 
level 1-2 Ritual" fontsize="40" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end

function acs_servant_of_the_shade_carddef()
    return createChampionDef(
        {
            id = "acs_servant_of_the_shade",
            name = "Servant of the Shade",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 5,
            health = 6,
            isGuard = true,
            abilities = {
				createAbility(
                    {
                        id = "servant_of_the_shade_combat",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain Ritual
			{
				effect = gainCombatEffect(3),
				layout = createLayout({
									name = "Servant of the Shade",
									art = "art/epicart/zealous_necromancer",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{combat_2}" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2: Perform Ritual							
			{
				effect = ef_ritual_3,
				layout = createLayout({
							name = "Servant of the Shade",
							art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Perform a
level 1-3 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
),
					}	  
                ),
				createAbility(
                    {
                        id = "servant_of_the_shade_ally",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = grantHealthTarget(2, { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "shadow").apply(selectSource())
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Servant of the Shade",
                    art = "art/epicart/zealous_necromancer",
                    frame = "frames/necros_champion_cardframe",
					cost = 5,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_3}
&lt;size=50%&gt;or Perform
a level 1-3 Ritual" fontsize="40" flexiblewidth="12" />
    </hlayout>

<divider/>
    <hlayout flexibleheight="1">
            <tmpro text="{necro}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="+2{shield} until your next turn." fontsize="24" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 6,
                    isGuard = true
                }
            )
        }
    )
end

function acs_fanaticist_carddef()
    return createChampionDef(
        {
            id = "acs_fanaticist",
            name = "Fanaticist",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 2,
            health = 4,
            isGuard = true,
            abilities = {
				createAbility(
                    {
                        id = "fanaticist_combat",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitSelfEffect(2).seq(gainGoldEffect(2)),
						check = getPlayerHealth(currentPid).gte(3),
					}	  
                ),
				createAbility(
                    {
                        id = "fanaticist_ally",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = hitSelfEffect(2).seq(gainGoldEffect(2)),
						check = getPlayerHealth(currentPid).gte(3),
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Fanaticist",
                    art = "art/epicart/zealous_necromancer",
                    frame = "frames/necros_champion_cardframe",
					cost = 2,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="-{health_2} {gold_2}" fontsize="40" flexiblewidth="12" />
    </hlayout>

<divider/>
    <hlayout flexibleheight="1">
            <tmpro text="{necro}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="-{health_2} {gold_2}" fontsize="40" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 4,
                    isGuard = true
                }
            )
        }
    )
end

function acs_coven_priestess_carddef()
    return createChampionDef(
        {
            id = "acs_coven_priestess",
            name = "Coven Priestess",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 7,
            health = 6,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "coven_priestess_combat",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
						effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain Ritual
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 4), incrementCounterEffect("p2_ritual", 4)),
				layout = createLayout({
									name = "Coven Priestess",
									art = "art/epicart/scarred_priestess",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="+4 Ritual" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2: Perform Ritual							
			{
				effect = ef_ritual_4,
				layout = createLayout({
							name = "Coven Priestess",
							art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Perform a
level 1-4 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
),
					}	  
                ),
				createAbility(
                    {
                        id = "coven_priestess_ally",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = gainCombatEffect(6),
					}	  
                ),
				createAbility(
                    {
                        id = "coven_priestess_ally2",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction, necrosFaction},
                        effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 4), incrementCounterEffect("p2_ritual", 4))
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Coven Priestess",
                    art = "art/epicart/scarred_priestess",
                    frame = "frames/necros_champion_cardframe",
					cost = 7,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{expend}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="+4 Ritual or
Perform a level 1-4 Ritual" fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="{combat_6}" fontsize="34" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.5">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="0">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="+4 Ritual" fontsize="24" />
</box>
</hlayout>
</vlayout>
					]],
                    health = 6,
                    isGuard = false
                }
            )
        }
    )
end

function acs_knight_of_karamight_carddef()
    return createChampionDef(
        {
            id = "acs_knight_of_karamight",
            name = "Knight of Karamight",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 3,
            health = 3,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "knight_of_karamight_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitSelfEffect(2).seq(gainCombatEffect(4)),
						check = getPlayerHealth(currentPid).gte(3),
						promptType = showPrompt,
						layout = createLayout({
									name = "Knight of Karamight",
									art = "art/epicart/dark_knight",
                                    frame = "frames/necros_champion_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="-{health_2} {combat_4}" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
					}	  
                ),
				createAbility(
                    {
                        id = "knight_of_karamight_ally",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = hitSelfEffect(2).seq(gainCombatEffect(4)),
						
						check = getPlayerHealth(currentPid).gte(3),
						promptType = showPrompt,
						layout = createLayout({
									name = "Knight of Karamight",
									art = "art/epicart/dark_knight",
                                    frame = "frames/necros_champion_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="-{health_2} {combat_4}" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
					}	  
                ),
				createAbility(
                    {
                        id = "knight_of_karamight_ally2",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction, necrosFaction},
                        effect = gainCombatEffect(3)
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Knight of Karamight",
                    art = "art/epicart/dark_knight",
                    frame = "frames/necros_champion_cardframe",
					cost = 3,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{expend}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="-{health_2} {combat_4}" fontsize="34" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="-{health_2} {combat_4}" fontsize="34" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.5">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="0">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="{combat_3}" fontsize="34" />
</box>
</hlayout>
</vlayout>
					]],
                    health = 3,
                    isGuard = false
                }
            )
        }
    )
end

function acs_occultist_carddef()
    return createChampionDef(
        {
            id = "acs_occultist",
            name = "Occultist",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 6,
            health = 5,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "occultist_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain Ritual
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 3), incrementCounterEffect("p2_ritual", 3)),
				layout = createLayout({
									name = "Occultist",
									art = "art/epicart/endbringer_ritualist",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{gold_2}
&lt;size=75%&gt;1 Ritual" fontsize="36" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2: Perform Ritual							
			{
				effect = ef_ritual_4,
				layout = createLayout({
							 name = "Occultist",
							art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{gold_2}
&lt;size=75%&gt;Perform a
level 1-2 Ritual." fontsize="36" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
)
					}	  
                ),
				createAbility(
                    {
                        id = "occultist_ally",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
						promptType = showPrompt,
						layout = createLayout({
									name = "Occultist",
									art = "art/epicart/endbringer_ritualist",
                                    frame = "frames/necros_champion_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="You may sacrifice 1 card from the market." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),

                        effect = pushTargetedEffect({
									desc = "Sacrifice a card in the market.",
									validTargets = selectLoc(centerRowLoc),
									min = 0,
									max = 1,
									targetEffect = sacrificeTarget(),
									}),
					}	  
                ),
				createAbility(
                    {
                        id = "occultist_sac",
                        trigger = uiTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
						promptType = showPrompt,
						layout = createLayout({
									name = "Occultist",
									art = "art/epicart/endbringer_ritualist",
                                    frame = "frames/necros_champion_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="8 Ritual." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
                        effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 8), incrementCounterEffect("p2_ritual", 8))
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Occultist",
                    art = "art/epicart/endbringer_ritualist",
                    frame = "frames/necros_champion_cardframe",
					cost = 6,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{expend}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="Ritual 3 or
Perform a level 1-4 Ritual" fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="You may sacrifice 1 card in the market." fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.5">
<box flexiblewidth="1">
<tmpro text="{scrap}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="Ritual 8" fontsize="24" />
</box>
</hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end

function acs_the_chosen_carddef()

    return createChampionDef(
        {
            id = "acs_the_chosen",
            name = "The Chosen",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 8,
            health = 7,
            isGuard = true,
            abilities = {
				createAbility(
                    {
                        id = "the_chosen_ally",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = drawCardsEffect(1).seq(forceDiscard(1)),
						promptType = showPrompt,
						layout = createLayout({
									name = "The Chosen",
									art = "art/epicart/wave_of_transformation",
                                    frame = "frames/necros_champion_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Draw 1.
Discard 1." fontsize="30" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),

					}	  
                ),
				createAbility(
                    {
                        id = "the_chosen_ally2",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction, necrosFaction},
                        effect = drawCardsEffect(1),
						promptType = showPrompt,
						layout = createLayout({
									name = "The Chosen",
									art = "art/epicart/wave_of_transformation",
                                    frame = "frames/necros_champion_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <box flexiblewidth="0">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Draw 1" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),

					}	  
                ),

				createAbility(
                    {
                        id = "the_chosen_sac_skill",
                        trigger = onLeavePlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
						promptType = showPrompt,
                        effect = waitForClickEffect("Dark One, take me.", "").seq(waitForClickEffect("Aaarrrrggh!", ""))
						.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -8), incrementCounterEffect("p2_ritual", -8)))
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, inPlayPloc)).where(isCardName("acs_the_chosen"))))
				.seq(damageTarget(4).apply(selectLoc(loc(currentPid, inPlayPloc)).union(selectLoc(loc(oppPid, inPlayPloc)))))
				.seq(waitForClickEffect("I am... inevitable", ""))
				.seq(createCardEffect(acs_cthugnogoth_carddef(), loc(currentPid, inPlayPloc))),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(8),
				cost = sacrificeSelfCost

					}	  
                )
            },
            layout = createLayout(
                {
                    name = "The Chosen",
                    art = "art/epicart/wave_of_transformation",
                    frame = "frames/necros_champion_cardframe",
					cost = 8,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="0.5">
<box flexiblewidth="0.5">
<tmpro text="{necro}" fontsize="28"/>
</box>
<box flexiblewidth="7">
<tmpro text="Draw 1. Discard 1." fontsize="20" />
</box>
</hlayout>
<divider/><hlayout flexibleheight="0.5">
<box flexiblewidth="0.5">
<tmpro text="{necro}" fontsize="28"/>
</box>
<box flexiblewidth="0.5">
<tmpro text="{necro}" fontsize="28"/>
</box>
<box flexiblewidth="7">
<tmpro text="Draw 1" fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1">
<box flexiblewidth="0.5
">
<tmpro text="{necro}" fontsize="28"/>
</box>
<box flexiblewidth="0.5">
<tmpro text="{necro}{necro}" fontsize="28"/>
</box>
<box flexiblewidth="7">
<tmpro text="-8 Ritual. Deal 4 damage to all champions. Transform 
this card permanently into
Arch Demon Cthugnogoth." fontsize="18" />
</box>
</hlayout>
</vlayout>
					]],
                    health = 7,
                    isGuard = true
                }
            )
        }
    )
end

function acs_cthugnogoth_carddef()
    return createChampionDef(
        {
            id = "acs_cthugnogoth",
            name = "Cthugnogoth",
			types = {championType, noStealType},
			factions = {necrosFaction},
            health = 5,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "cthugnogoth_combat",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(7),

					}	  
                ),
				createAbility(
                    {
                        id = "cthugnogoth_onplay",
                        trigger = onPlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = damageTarget(2).apply(selectLoc(loc(currentPid, inPlayPloc)).union(selectLoc(loc(oppPid, inPlayPloc))))
					}	  
                ),
				createAbility(
                    {
                        id = "cthugnogoth_onleave",
                        trigger = onLeavePlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = grantHealthTarget(1, { SlotExpireEnum.never }, nullEffect(), "shadow").apply(selectSource())
						,
					}	  
                ),
				createAbility(
                    {
                        id = "cthugnogoth_ritual",
                        trigger = uiTrigger,
                        cost = noCost,
						allyFactions = {necro},
                        activations = singleActivations,
						promptType = showPrompt,
				layout = createLayout({
					name = "Summon Cthugnogoth",
					art = "art/epicart/raxxa_s_curse",
					frame = "frames/necros_action_cardframe",
					xmlText = [[	
<vlayout>
    <hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="40"/>
</box>
        <box flexiblewidth="7">
            <tmpro text="Spend 2 Ritual.
+1{shield} permanently." fontsize="24" />
        </box>
    </hlayout>
</vlayout>
					]]					
				}),
                        effect = incrementCounterEffect("p1_ritual", -2)
						.seq(grantHealthTarget(1, { SlotExpireEnum.never }, nullEffect(), "shadow").apply(selectSource())),
						check = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(2),
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Cthugnogoth",
                    art = "art/epicart/raxxa_s_curse",
                    frame = "frames/necros_champion_cardframe",
					cost = 2,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="0.5">
            <tmpro text="{expend}" fontsize="30" flexiblewidth="2"/>
            <tmpro text="{combat_7}" fontsize="30" flexiblewidth="12" />
    </hlayout>

<divider/>
<hlayout flexibleheight="0.5">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="28"/>
</box>
<box flexiblewidth="7">
<tmpro text="Spend 2 Ritual.
+1{shield} permanently." fontsize="17" />
</box>   
    </hlayout>
<divider/>
    <hlayout flexibleheight="1">
            <tmpro text="When played deal 2 damage
to all other champions.
When this leaves play
gain +1{shield} permanently." fontsize="17" flexiblewidth="2" />
    </hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end

--Actions

function acs_demonic_runes_carddef()
    return createDef(
        {
            id = "acs_demonic_runes",
            name = "Demonic Runes",
            types = {actionType},
			factions = {necrosFaction},
            acquireCost = 5,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "acs_demonic_runes_main",
                        layout = cardLayout,
                          effect = gainGoldEffect(3).seq(pushTargetedEffect({
												desc = "Sacrifice a card from the market.",
												validTargets = selectLoc(centerRowLoc),
												min = 0,
												max = 1,
												targetEffect = sacrificeTarget(),
												}))
												,
						promptType = showPrompt,
						layout = createLayout({
									name = "Demonic Runes",
									art = "art/t_shadow_spell_09_blue",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="You may sacrifice 1 card from the market." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
                        trigger = uiTrigger,
                        tags = {}
                    }
                ),
				createAbility(
                    {
                        id = "acs_demonic_runes_ally",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Draw 1
			{
				effect = drawCardsEffect(1),
				layout = createLayout({
									name = "Demonic Runes",
									art = "art/t_shadow_spell_09_blue",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Draw 1" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2:  Rituals									
			{
				effect = ef_ritual_3,
				layout = createLayout({
									name = "Demonic Runes",
									art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Perform a
level 1-3 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
),
						promptType = showPrompt,
						layout = createLayout({
									name = "Demonic Runes",
									art = "art/t_shadow_spell_09_blue",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Draw 1
or
Perform a
level 1 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
					
					}	  
                ),
				
				createAbility(
                    {
                        id = "acs_demonic_runes_ally2",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = gainGoldEffect(2),					
					}	  
                )
            },
			
            layout = createLayout(
                {
                    name = "Demonic Runes",
					cost = 5,
                    art = "art/t_shadow_spell_09_blue",
                    frame = "frames/necros_action_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="2">
<box flexiblewidth="7">
<tmpro text="{gold_3} You may sacrifice 1 card from the market." fontsize="24" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="Draw 1 or
perform a level 1-3 Ritual" fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.5">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="0">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="{gold_2}" fontsize="34" />
</box>
</hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end

function acs_infernal_speech_carddef()
    return createDef(
        {
            id = "acs_infernal_speech",
            name = "Infernal Speech",
            types = {actionType,  noPlayPlayType},
			factions = {necrosFaction},
            acquireCost = 1,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "acs_infernal_speech",
                        layout = cardLayout,
                        effect = hitSelfEffect(2).seq(drawCardsEffect(1)).seq(gainCombatEffect(3)),
						check = getPlayerHealth(currentPid).gte(3),
                        trigger = uiTrigger,
						promptType = showPrompt,
						layout = cardLayout,
                        tags = {}
                    }
                )
            },
            cardLayout = createLayout(
                {
                    name = "Infernal Speech",
					cost = 1,
                    art = "art/epicart/citadel_scholar",
                    frame = "frames/necros_action_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="7">
        <tmpro text="{combat_3} -{health_2}" fontsize="42"/>
    </box>
<box flexibleheight="7">
        <tmpro text=" Draw 1" fontsize="32"/>
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function acs_dark_mass_carddef()
    return createDef(
        {
            id = "acs_dark_mass",
            name = "Dark Mass",
            types = {actionType},
			factions = {necrosFaction},
            acquireCost = 6,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "acs_dark_mass_main",
                        layout = cardLayout,
                        effect = pushTargetedEffect({
												desc = "Sacrifice a card from the market.",
												validTargets = selectLoc(centerRowLoc),
												min = 0,
												max = 1,
												targetEffect = sacrificeTarget().seq(hitSelfEffect(2)),
												})
										.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 4), incrementCounterEffect("p2_ritual", 4)))
										,
						check = getPlayerHealth(currentPid).gte(3),
						promptType = showPrompt,
						layout = createLayout({
									name = "Dark Mass",
									art = "art/epicart/ritual_of_scara",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="You may sacrifice 1 card from the market." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
                        trigger = uiTrigger,
                        tags = {}
                    }
                ),
				createAbility({
                        id = "acs_dark_mass_ritual",
                        promptType = showPrompt,
						layout = createLayout({
									name = "Dark Mass",
									art = "art/epicart/ritual_of_scara",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="+5 Ritual 
or
Perform a
level 1-3 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
                       
						trigger = uiTrigger,
						allyFactions = {necrosFaction},
						effect = pushChoiceEffectWithTitle({
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain ritual
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 5), incrementCounterEffect("p2_ritual", 5)),
				layout = createLayout({
									name = "Dark Mass",
									art = "art/epicart/ritual_of_scara",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="+5 Ritual" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2:  Perform Rituals									
			{
				effect = ef_ritual_3,
				layout = createLayout({
									name = "Dark Mass",
									art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Perform a
level 1-3 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
),

                        tags = {}
                    }
                ),
					
				createAbility(
                    {
                        id = "acs_dark_mass_ally2",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction, necrosFaction},
                        effect = ef_ritual_4,
						promptType = showPrompt,
						layout = createLayout({
									name = "Dark Mass",
									art = "art/epicart/ritual_of_scara",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="40"/>
</box>
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="40"/>
</box>
<box flexiblewidth="12">
<tmpro text="Perform a
level 1-4 Ritual" fontsize="28" />
</box>
</hlayout>
</vlayout>
                                    ]],
                                }),
					
					}	  
                ),

            },
            layout = createLayout(
                {
                    name = "Dark Mass",
					cost = 6,
                    art = "art/epicart/ritual_of_scara",
                    frame = "frames/necros_action_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1.5">
<box flexiblewidth="7">
<tmpro text="Ritual 4.
You may -{health_2} to sacrifice 1 card from the market." fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="7">
<tmpro text="Ritual 5 or
perform a level 1-3 Ritual" fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1">
<box flexiblewidth="0.5">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="0">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="10">
<tmpro text="Perform a
level 1-4 Rituall" fontsize="20" />
</box>
</hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end

function acs_blood_ritual_carddef()
    return createDef(
        {
            id = "acs_blood_ritual",
            name = "Blood Ritual",
			factions = {necrosFaction},
            types = {actionType},
            acquireCost = 3,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "acs_blood_ritual_main",
                        layout = cardLayout,
                        effect = gainCombatEffect(4),
                        trigger = autoTrigger,
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "acs_blood_ritual_ally",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Draw 1
			{
				effect = drawCardsEffect(1),
				layout = createLayout({
									name = "Blood Ritual",
									art = "art/epicart/corpsemonger",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Draw 1" fontsize="34" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2:  Rituals									
			{
				effect = ef_ritual_2,
				layout = createLayout({
									name = "Blood Ritual",
									art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Perform a
level 1-2 Ritual." fontsize="28" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
),
						promptType = showPrompt,
						layout = createLayout({
									name = "Blood Ritual",
									art = "art/epicart/corpsemonger",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="40"/>
</box>
<box flexiblewidth="12">
<tmpro text="Draw 1
or perform
a level 1-2 Ritual" fontsize="30" />
</box>
</hlayout>
</vlayout>
                                    ]],
                                }),						
					}	  
                ),
				
				createAbility(
                    {
                        id = "acs_blood_ritual_sac",
                        trigger = uiTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = pushTargetedEffect({
												desc = "Sacrifice a card from your hand or discard pile.",
												validTargets =  selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))),
												min = 0,
												max = 1,
												targetEffect = sacrificeTarget(),
												}),
						promptType = showPrompt,
						layout = createLayout({
									name = "Blood Ritual",
									art = "art/epicart/corpsemonger",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{scrap}" fontsize="40"/>
</box>
<box flexiblewidth="12">
<tmpro text="Sacrifice a card in your hand or discard pile." fontsize="28" />
</box>
</hlayout>
</vlayout>
                                    ]],
                                }),
					
					}	  
                ),

            },
            layout = createLayout(
                {
                    name = "Blood Ritual",
					cost = 3,
                    art = "art/epicart/corpsemonger",
                    frame = "frames/necros_action_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1.2">
<box flexiblewidth="7">
<tmpro text="{combat_4}" fontsize="34" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.2">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="34"/>
</box>
<box flexiblewidth="7">
<tmpro text="Draw 1 or
perform a level 1-2 Ritual." fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.2">
<box flexiblewidth="1">
<tmpro text="{scrap}" fontsize="34"/>
</box>
<box flexiblewidth="10">
<tmpro text="Sacrifice a card in your hand or discard pile." fontsize="22" />
</box>
</hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end

function acs_rite_of_the_coven_carddef()
    return createDef(
        {
            id = "acs_rite_of_the_coven",
            name = "Rite of the Coven",
            types = {actionType, noPlayPlayType},
			factions = {necrosFaction},
            acquireCost = 1,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "acs_rite_of_the_coven_main",
                        layout = cardLayout,
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Draw 1
			{
				effect = drawCardsEffect(1).seq(gainCombatEffect(1)),
				layout = createLayout({
									name = "Rite of the Coven",
									art = "art/epicart/scarred_cultist",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{combat_1}
&lt;size=75%&gt;Draw 1" fontsize="40" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2:  Rituals									
			{
				effect = gainCombatEffect(1).seq(ef_ritual_1),
				layout = createLayout({
									name = "Rite of the Coven",
									art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{necro}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{combat_1}
&lt;size=75%&gt;Perform a
level 1 Ritual." fontsize="40" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
),
                        trigger = autoTrigger,
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "acs_rite_of_the_coven_sac",
                        trigger = uiTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = pushTargetedEffect({
												desc = "Sacrifice a card from your hand or discard pile.",
												validTargets =  selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))),
												min = 0,
												max = 1,
												targetEffect = sacrificeTarget(),
												}),
						promptType = showPrompt,
						layout = createLayout({
									name = "Rite of the Coven",
									art = "art/epicart/scarred_cultist",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{scrap}" fontsize="40"/>
</box>
<box flexiblewidth="12">
<tmpro text="Sacrifice a card in your hand or discard pile." fontsize="28" />
</box>
</hlayout>
</vlayout>
                                    ]],
                                }),
					
					}	  
                ),

            },
            layout = createLayout(
                {
                    name = "Rite of the Coven",
                    art = "art/epicart/scarred_cultist",
					cost = 1,
                    frame = "frames/necros_action_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1.5">
<box flexiblewidth="7">
<tmpro text="{combat_1} &lt;size=70%&gt;Draw 1 or
&lt;size=100%&gt;{combat_1}&lt;size=70%&gt; and perform
a level 1 Ritual" fontsize="30" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{scrap}" fontsize="34"/>
</box>
<box flexiblewidth="10">
<tmpro text="Sacrifice a card in your hand or discard pile." fontsize="22" />
</box>
</hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end

function acs_sinister_propaganda_carddef()
    return createDef(
        {
            id = "acs_sinister_propaganda",
            name = "Sinister Propaganda",
            types = {actionType},
			factions = {necrosFaction},
            acquireCost = 4,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "acs_sinister_propaganda_main",
                        layout = cardLayout,
                        effect = gainGoldEffect(3),
                        trigger = autoTrigger,
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "acs_sinister_propaganda_ally",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction},
                        effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 3), incrementCounterEffect("p2_ritual", 3))
                        				
					}	  
                ),
				
				createAbility(
                    {
                        id = "acs_sinister_propaganda_ally2",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						allyFactions = {necrosFaction, necrosFaction},
                        effect = drawCardsEffect(2),
						promptType = showPrompt,
						layout = createLayout({
									name = "Sinister Propaganda",
									art = "art/epicart/amnesia",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="40"/>
</box>
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="40"/>
</box>
<box flexiblewidth="12">
<tmpro text="Draw 2" fontsize="34" />
</box>
</hlayout>
</vlayout>
                                    ]],
                                }),
					
					}	  
                ),

            },
            layout = createLayout(
                {
                    name = "Sinister Propaganda",
                    art = "art/epicart/amnesia",
					cost = 4,
                    frame = "frames/necros_action_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1.5">
<box flexiblewidth="7">
<tmpro text="{gold_3}" fontsize="40" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="7">
<tmpro text="Ritual 3" fontsize="32" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.5">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="0">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="10">
<tmpro text="Draw 2" fontsize="32" />
</box>
</hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end

function acs_ceremonial_altar_carddef()
    return createDef(
        {
            id = "acs_ceremonial_altar",
            name = "Ceremonial Altar",
            types = {actionType, noPlayPlayType},
			factions = {necrosFaction},
            acquireCost = 2,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "acs_ceremonial_altar_main",
                        layout = cardLayout,
                        effect = drawCardsEffect(1),
                        trigger = autoTrigger,
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "acs_ceremonial_altar_choice",
                        trigger = uiTrigger,
                        activations = singleActivations,
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain Ritual
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 3), incrementCounterEffect("p2_ritual", 3)),
				layout = createLayout({
									name = "Ceremonial Altar",
									art = "art/epicart/forbidden_research",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text=";+3 Ritual" fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2: Perform Ritual							
			{
				effect = ef_ritual_1,
				layout = createLayout({
							name = "Ceremonial Altar",
							art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Perform a
level 1 Ritual." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
)
					}	  
                ),

            },
            layout = createLayout(
                {
                    name = "Ceremonial Altar",
                    art = "art/epicart/forbidden_research",
					cost = 2,
                    frame = "frames/necros_action_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1.5">
<box flexiblewidth="7">
<tmpro text="Draw 1
then choose:

+3 Ritual or
Perform a level 1 Ritual" fontsize="24" />
</box>
</hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end

function acs_summoning_circle_carddef()
    return createDef(
        {
            id = "acs_summoning_circle",
            name = "Summoning Circle",
            types = {actionType},
			factions = {necrosFaction},
            acquireCost = 3,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "acs_summoning_circle_main",
                        layout = cardLayout,
                        trigger = uiTrigger,
						effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain Ritual
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 4), incrementCounterEffect("p2_ritual", 4)),
				layout = createLayout({
									name = "Summoning Circle",
									art = "art/epicart/ancient_chant",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{gold_2}
&lt;size=75%&gt;4 Ritual" fontsize="36" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2: Perform Ritual							
			{
				effect = ef_ritual_2,
				layout = createLayout({
							name = "Summoning Circle",
							art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{gold_2}
&lt;size=75%&gt;Perform a
level 1-2 Ritual." fontsize="36" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
),
                        tags = {}
                    }
                ),

                createAbility({
                        id = "acs_summoning_circle_ally",
                        layout = cardLayout,
						allyFactions = {necrosFaction},
                        effect = createCardEffect(acs_fel_hound_carddef(), currentInPlayLoc),
                        trigger = autoTrigger,
                        tags = {}
                    }
                ),

                createAbility({
                        id = "acs_summoning_circle_ally2",
                        layout = cardLayout,
						allyFactions = {necrosFaction, necrosFaction},
                        effect = createCardEffect(acs_fel_hound_carddef(), currentInPlayLoc),
                        trigger = autoTrigger,
                        tags = {}
                    }
                ),
				
            },
            layout = createLayout(
                {
                    name = "Summoning Circle",
                    art = "art/epicart/ancient_chant",
					cost = 3,
                    frame = "frames/necros_action_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="2">
<box flexiblewidth="7">
<tmpro text="Ritual 4.
Or perform a level 1-2 Ritual." fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="3">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="7">
<tmpro text="Put a Fel Hound token into play." fontsize="20" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="0">
<tmpro text="{necro}" fontsize="30"/>
</box>
<box flexiblewidth="7">
<tmpro text="Put a Fel Hound token into play." fontsize="20" />
</box>
</hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end



function setupGame(g)
    registerCards(
        g,
        {
--champions
acs_acolyte_carddef(),
acs_demonic_linguist_carddef(),
acs_servant_of_the_shade_carddef(),
acs_fanaticist_carddef(),
acs_coven_priestess_carddef(),
acs_knight_of_karamight_carddef(),
acs_occultist_carddef(),
acs_the_chosen_carddef(),
acs_cthugnogoth_carddef(),


--actions
acs_demonic_runes_carddef(),
acs_infernal_speech_carddef(),
acs_dark_mass_carddef(),
acs_blood_ritual_carddef(),
acs_rite_of_the_coven_carddef(),
acs_sinister_propaganda_carddef(),
acs_ceremonial_altar_carddef(),
acs_summoning_circle_carddef(),
--tokens
acs_fel_hound_carddef(),
acs_void_guard_carddef(),
acs_demonic_leech_carddef(),
acs_phase_demon_carddef(),
acs_phased_demon_carddef(),
acs_strange_thing_carddef(),
acs_stranger_thing_carddef()
        }
    )

    standardSetup(
        g,
        {
            description = "Alt Necros deck. With thanks to Jspeh & Azgalor. Created by Aarkenell 25/02/2026.",
            playerOrder = {plid1, plid2},
            ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
            timeoutAi = createTimeoutAi(),
            opponents = {{plid1, plid2}},
			centerRow = { },
            players = {
                {
                id = plid1,
				init = {
                    fromEnv = plid1
                },
                    cards = {
                        deck = {
						
                        },
                        skills = {
                        --{qty = 1, card = acs_ritual_summoning_p1_carddef() },
                        },
                        buffs = {
                            drawCardsCountAtTurnEndDef(5),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP1"),
							p1_ritual_buff,
							startOfGameBuffDef(),
                        }
                    }
                },
                {
                id = plid2,
				init = {
                    fromEnv = plid2
                },
                    cards = {
                        deck = {
                        },
                        skills = {
                        --{qty = 1, card = acs_ritual_summoning_p2_carddef()},
                        },
                        buffs = {
                            drawCardsCountAtTurnEndDef(5),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP1"),
							p2_ritual_buff,
                        }
                    }
                }
            }
        }
    )
end

function endGame(g)
end



function setupMeta(meta)
    meta.name = ""
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/tester base (don't edit).lua"
     meta.features = {
}

end