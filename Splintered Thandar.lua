require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

-- Updated 08.10.2024 by Aarkenell
nullPloc = CardLocEnum.Null

-- Game start --
function startOfGameBuffDef()
    return createGlobalBuff({
        id="startOfGameBuff",
        name = "Start of Game Story",
        abilities = {
            createAbility({
                id="SoG_effect",
                trigger = startOfGameTrigger,
                effect = waitForClickEffect("Welcome to the Splintered Thandar mod.", "")
		.seq(waitForClickEffect("As Player 1, you may now choose which Battlefield to play on.", ""))
			})
        }   
	})
end

local function P1_chooseBattlefieldBuff()
    return cardChoiceSelectorEffect({
        id = "choose_battlefield_options",
        name = "Choose one",
        trigger = startOfTurnTrigger,

        upperTitle  = "Get playing. Or learn what this mod is about.",
        lowerTitle  = "",
 
 effectFirst = pushChoiceEffect(
                                {
                                    choices = {
									-- Choice 1: Marauder Mo Battlefields
                                        {
                                            effect = createCardEffect(choose_supply_cache_carddef(), loc(currentPid, asidePloc))
										   .seq(createCardEffect(choose_armoury_carddef(), loc(currentPid, asidePloc)))
										   --.seq(createCardEffect(choose_scorcerors_tower_carddef(), loc(currentPid, asidePloc)))
										   --.seq(createCardEffect(choose_smugglers_den_carddef(), loc(currentPid, asidePloc)))
										   .seq(createCardEffect(choose_crypt_carddef(), loc(currentPid, asidePloc)))
										   .seq(createCardEffect(choose_beast_pit_carddef(), loc(currentPid, asidePloc)))
										   .seq(createCardEffect(choose_apothecary_carddef(), loc(currentPid, asidePloc)))
										   .seq(createCardEffect(choose_great_hall_carddef(), loc(currentPid, asidePloc)))
										  -- .seq(createCardEffect(choose_scorcerors_tower_carddef(), loc(currentPid, asidePloc)))
										   
										   .seq(moveTarget(handPloc).apply(selectLoc(loc(currentPid, asidePloc))))
											.seq(waitForClickEffect("Please play the card corresponding to the Battlefield you wish to play in.", "")),
                                            
											layout = layoutCard(
                                                {
                                                    title = "Splintered Thandar",
                                                    art = "art/epicart/ceasefire",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Choose from 6 of Marauder Mo's original Splintered Thandar Battlefields" fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
										-- Choice 2: Aarkenell Battlefields
                                        {
                                            effect = createCardEffect(choose_alchemist_lab_carddef(), loc(currentPid, asidePloc))
											.seq(createCardEffect(choose_sheild_bearers_hall_carddef(), loc(currentPid, asidePloc)))
											.seq(createCardEffect(choose_colosseum_carddef(), loc(currentPid, asidePloc)))
											.seq(createCardEffect(choose_operaHouse_carddef(), loc(currentPid, asidePloc)))
											.seq(createCardEffect(choose_zombiehorde_carddef(), loc(currentPid, asidePloc)))
											.seq(createCardEffect(choose_investment_bank_carddef(), loc(currentPid, asidePloc)))
											.seq(createCardEffect(choose_fight_club_carddef(), loc(currentPid, asidePloc)))
											
											--.seq(createCardEffect(choose_training_ground_carddef(), loc(currentPid, asidePloc)))
											
										   
										   .seq(moveTarget(handPloc).apply(selectLoc(loc(currentPid, asidePloc))))
											.seq(waitForClickEffect("Please play the card corresponding to the Battlefield you wish to play in.", "")),
                                            
                                            layout = layoutCard(
                                                {
                                                    title = "Fractured  Thandar",
                                                    art = "art/epicart/apocalypse",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Choose from Aarkenell's 7 Fractured Thandar Battlefields" fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                                                                    },
																					
											-- Choice 3: Random Selections										
                                        {
                                            effect = pushChoiceEffect(
                                {
                                    choices = {
									-- Choice 3.1: ST only Random
                                        {
                                            effect =  randomEffect({
					valueItem(1, createCardEffect(choose_supply_cache_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_armoury_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_crypt_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_great_hall_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_beast_pit_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_apothecary_carddef(), currentHandLoc)),
				--	valueItem(1, createCardEffect(choose_scorcerors_tower_carddef(), currentHandLoc))
					
				})
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(noUndoEffect()),
											layout = layoutCard(
                                                {
                                                    title = "Splintered Thandar",
                                                    art = "art/epicart/ceasefire",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Randomly choose one of Marauder Mo's original Splintered Thandar Battlefields" fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
										-- Choice 3.2 - FT only Random
                                        {
                                             effect =  randomEffect({
					valueItem(1, createCardEffect(choose_alchemist_lab_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_sheild_bearers_hall_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_colosseum_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_zombiehorde_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_operaHouse_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_investment_bank_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_fight_club_carddef(), currentHandLoc)),
					
					--valueItem(1, createCardEffect(choose_training_ground_carddef(), currentHandLoc))
				
				})
				
		
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(noUndoEffect()),
                                            layout = layoutCard(
                                                {
                                                    title = "Fractured  Thandar",
                                                    art = "art/epicart/apocalypse",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Randomly choose one of Aarkenell's Fractured Thandar Battlefields" fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                                                                    },
																					
											-- Choice 3.3: All Random										
                                        {
                                             effect =  randomEffect({
					valueItem(1, createCardEffect(choose_supply_cache_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_armoury_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_crypt_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_great_hall_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_beast_pit_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_apothecary_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_alchemist_lab_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_sheild_bearers_hall_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_colosseum_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_zombiehorde_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_operaHouse_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_investment_bank_carddef(), currentHandLoc)),
				--	valueItem(1, createCardEffect(choose_scorcerors_tower_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_fight_club_carddef(), currentHandLoc)),
					--valueItem(1, createCardEffect(choose_training_ground_carddef(), currentHandLoc))
				})
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(noUndoEffect()),	
                                            layout = layoutCard(
                                                {
                                                    title = "Random Battlefield",
                                                    art = "art/epicart/angel_of_death_alt",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Randomly choose a Battlefield from both Splintered Thandar and Fractured Thandar." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    },																					
                                    }
                                }
                        ),
													
                                            layout = layoutCard(
                                                {
                                                    title = "Random Battlefield",
                                                    art = "art/epicart/angel_of_death_alt",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Let Fate decide" fontsize="26" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    },																					
                                    }
                                }
                        )
		,


effectSecond= storyTellEffectWithPortrait("barbarian_02", "This mod is based on the Real Life 'Splintered Thandar' events created by Marauder Mo.")
.seq(storyTellEffectWithPortrait("barbarian_01", "With support from Birdlaw and Anvroser."))
 .seq(storyTellEffectWithPortrait("barbarian_02", "Each game starts with Player 1 choosing a 'Battlefield' to play on."))
 .seq(storyTellEffectWithPortrait("barbarian_02", "Each Battlefield introduces a small variation to the rules of standard play."))
 .seq(storyTellEffectWithPortrait("barbarian_01", "A rules buff will be created for each scenario for your reference."))
 .seq(leftStoryTellEffectWithPortrait("druid_01", "Choose between Battlefields based on Marauder Mo's original IRL events, or new Battlefields created by Aarkenell for the digital environment."))
 .seq(leftStoryTellEffectWithPortrait("druid_01", "Or dance with fate and let the Battlefield be selected randomly."))
 .seq(pushChoiceEffect({
							choices = {
								{
                                effect = nullEffect(),
                                layout = createLayout({
									name = "Return to Choose Battlefield",
									art = "avatars/barbarian_02",
                                    frame = "frames/generic_CardFrame",
                                    xmlText = [[
<vlayout  forceheight="true">
<tmpro text="Select 'Undo' to return to top menu, then select
'To Battle!'." fontsize="28" />
</vlayout>
                                    ]],
                                }),
                            
                            },
							}})),

        layoutFirst = createLayout({
            name = "To Battle!",
            art = "art/epicart/ceasefire",
			frame = "frames/generic_CardFrame",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Choose a Battlefield and get playing." fontsize="26"/>
</hlayout>
</vlayout>
			]] }) ,

        layoutSecond = createLayout({
            name = "Learn about the mod",
            art = "art/treasures/T_Magic_Scroll_Souveraine",
			frame = "frames/generic_CardFrame",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Learn how this mod changes the game." fontsize="26"/>
</hlayout>
</vlayout>			
			]]
			}),

        turn = 1
    })
end


local function P2_chooseInfoBuff()
    return cardChoiceSelectorEffect({
        id = "choose_game_options",
        name = "Choose one",
        trigger = startOfTurnTrigger,

        upperTitle  = "Learn what's new in this mod. Or just get playing.",
        lowerTitle  = "",
 
 effectFirst = ifElseEffect(selectLoc(loc(currentPid, handPloc)).where(isCardName("T_TG_choose_thief").Or(isCardName("T_TG_choose_bard"))).count().gte(1),nullEffect(),addEffect(endTurnEffect())),
 
effectSecond= storyTellEffectWithPortrait("barbarian_02", "This mod is based on the Real Life 'Splintered Thandar' events created by Marauder Mo.")
.seq(storyTellEffectWithPortrait("barbarian_01", "With support from Birdlaw and Anvroser."))
 .seq(storyTellEffectWithPortrait("barbarian_02", "Each game starts with Player 1 choosing a 'Battlefield' to play on."))
 .seq(storyTellEffectWithPortrait("barbarian_02", "Each Battlefield introduces a small variation to the rules of standard play."))
  .seq(storyTellEffectWithPortrait("barbarian_01", "A rules buff will be created for each scenario for your reference."))
 .seq(leftStoryTellEffectWithPortrait("druid_01", "Player 1 may choose between Battlefields based on Marauder Mo's original IRL events, or new Battlefields created by Aarkenell for the digital environment.."))
 .seq(leftStoryTellEffectWithPortrait("druid_01", "or dance with fate and let the Battlefield be selected randomly."))
 .seq(pushChoiceEffect({
							choices = {
								{
                                effect = nullEffect(),
                                layout = createLayout({
									name = "Return to Choose Battlefield",
									art = "avatars/barbarian_02",
                                    frame = "frames/generic_CardFrame",
                                    xmlText = [[
<vlayout  forceheight="true">
<tmpro text="Select 'Undo' to return to top menu to either repeat this information or to select 'Play' to begin the game.
'Choose Battlefield'." fontsize="24" />
</vlayout>
                                    ]],
                                }),
                            
                            },

							}})),
 


        layoutFirst = createLayout({
            name = "Play",
            art = "art/epicart/ceasefire",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Get playing." fontsize="26"/>
</hlayout>
</vlayout>
			]] }) ,

        layoutSecond = createLayout({
            name = "Learn about the mod",
            art = "art/treasures/T_Magic_Scroll_Souveraine",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Learn how this mod changes the game." fontsize="26"/>
</hlayout>
</vlayout>			
			]]
			}),
        turn = 1
    })
end


function winGameBuffDef()
    return createGlobalBuff({
        id="endOfGameBuff",
        name = "End of Game Story",
        abilities = {
            createAbility({
                id="EoG_effect",
                trigger = endOfGameTrigger,
                effect = waitForClickEffect("Thanks for playing the Splintered Thandar mod.", "")
						.seq(waitForClickEffect("Join the Realms Rising server on Discord to share feedback.", ""))
        .seq(waitForClickEffect("For latest news on this and other Lua mods, as well as the latest Hero Realms strats and chats, listen to the Sparks and Recreations podcast.", ""))
				.seq(waitForClickEffect("If you enjoyed this game, be sure to 'Favourite' it so you can play it again. Find out how at: https://www.realmsrising.com/lua/hero-realms-lua-play-at-home-edition/", ""))
            
})
        },
    })
end

function loseGameBuffDef()
    return createGlobalBuff({
        id="LostBuff",
        name = "Lost Story",
        abilities = {
            createAbility({
                id="EoG_lost_effect",
                trigger = endOfGameTrigger,
				effect = waitForClickEffect("Thanks for playing the Splintered Thandar mod.", "")
				.seq(waitForClickEffect("Join the Realms Rising server on Discord to share feedback.", ""))
        .seq(waitForClickEffect("For latest news on this and other Lua mods, as well as the latest Hero Realms strats and chats, listen to the Sparks and Recreations podcast.", ""))
				.seq(waitForClickEffect("If you enjoyed this game, be sure to 'Favourite' it so you can play it again. Find out how at: https://www.realmsrising.com/lua/hero-realms-lua-play-at-home-edition/", ""))
           
            })
        },
    })
end

-- Alchemist's Lab
function choose_alchemist_lab_carddef()
    return createDef({
        id="choose_alchemist_lab",
        name="The Alchemist's Lab",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_alchemist_lab",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(alchLabBuffDef(), loc(currentPid, buffsPloc)))
								.seq(createCardEffect(alchLabBuffDef(), loc(oppPid, buffsPloc)))
								.seq(createCardEffect(alchemist_crucible_carddef(), loc(currentPid, deckPloc)))
								.seq(createCardEffect(alchemist_crucible_carddef(), loc(oppPid, deckPloc)))
								.seq(shuffleEffect(loc(currentPid, deckPloc)))
								.seq(shuffleEffect(loc(oppPid, deckPloc)))

								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(storyTellEffectWithPortrait("Alchemist_02", "Get out of my lab!"))
								.seq(waitForClickEffect("The laboratory is a cramped space. Bottles and vials line the shelves. Objects of strange design and origin clutter the tables.", ""))
								.seq(waitForClickEffect("Grab whatever is in reach and hurl it at your opponent.", ""))
								.seq(addEffect(endTurnEffect())),					
								
						
                    }
                )
            },
        layout = createLayout({
            name = "The Alchemist's Lab",
            art = "art/classes/alchemist/dissolve",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Setup: Each player starts with a Crucible in their deck.

On turn: Add 1 random Alchemist item to your hand. Put a copy of the same item into your opponent's discard pile." fontsize="18" alignment="left"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function alchLabBuffDef()

return createGlobalBuff({
	id="AlchLabBuff",
	name = "The Alchemist's Lab",
	abilities = {
		createAbility({
			id="AlchLabBuff",
			trigger = startOfTurnTrigger,
			check = getTurnsPlayed(currentPid).gte(2),
			effect = randomEffect({
				--valueItem(1, createCardEffect(alchemist_crucible_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_dissolve_carddef(), loc(oppPid, discardPloc)))),
				valueItem(2, createCardEffect(alchemist_dissolve_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_dissolve_carddef(), loc(oppPid, discardPloc)))),
				valueItem(1, createCardEffect(alchemist_minor_transmutation_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_minor_transmutation_carddef(), loc(oppPid, discardPloc)))),
				valueItem(1, createCardEffect(alchemist_brittle_gas_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_brittle_gas_carddef(), loc(oppPid, discardPloc)))),
				
				valueItem(2, createCardEffect(alchemist_frothing_potion_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_frothing_potion_carddef(), loc(oppPid, discardPloc)))),
				valueItem(2, createCardEffect(alchemist_sloshing_potion_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_sloshing_potion_carddef(), loc(oppPid, discardPloc)))),
				valueItem(2, createCardEffect(alchemist_philosophers_stone_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(oppPid, discardPloc)))),
				valueItem(2, createCardEffect(alchemist_swirling_philosophers_stone_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_swirling_philosophers_stone_carddef(), loc(oppPid, discardPloc)))),
				valueItem(2, createCardEffect(alchemist_polished_philosophers_stone_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_polished_philosophers_stone_carddef(), loc(oppPid, discardPloc)))),
				valueItem(2, createCardEffect(alchemist_kaleidoscope_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_kaleidoscope_carddef(), loc(oppPid, discardPloc)))),
				
				
				valueItem(3, createCardEffect(alchemist_vial_of_acid_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_vial_of_acid_carddef(), loc(oppPid, discardPloc)))),
				valueItem(3, createCardEffect(alchemist_bottled_tempest_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_bottled_tempest_carddef(), loc(oppPid, discardPloc)))),
				valueItem(3, createCardEffect(alchemist_alchemy_powders_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_alchemy_powders_carddef(), loc(oppPid, discardPloc)))),
				
				valueItem(2, createCardEffect(alchemist_recalibration_crystal_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_recalibration_crystal_carddef(), loc(oppPid, discardPloc)))),
				valueItem(2, createCardEffect(alchemist_fireworks_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_fireworks_carddef(), loc(oppPid, discardPloc)))),
				
				valueItem(2, createCardEffect(alchemist_rainbow_potion_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_rainbow_potion_carddef(), loc(oppPid, discardPloc)))),
				valueItem(1, createCardEffect(alchemist_recipe_book_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_recipe_book_carddef(), loc(oppPid, discardPloc)))),
				valueItem(1, createCardEffect(alchemist_silver_scales_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_silver_scales_carddef(), loc(oppPid, discardPloc)))),
				valueItem(1, createCardEffect(alchemist_diamond_carddef(), loc(currentPid, handPloc)).seq(createCardEffect(alchemist_diamond_carddef(), loc(oppPid, discardPloc)))),
			})
		})   
	},
	buffDetails = createBuffDetails({
		name = "Alchemist's Lab",
		art = "art/classes/alchemist/dissolve",
		text = "<size=70%>Start the game with a Crucible in your deck. Each turn add 1 random Alchemist item to your hand. Put a copy of the same item into your opponent's discard pile."
	})
})
end

-- Supply Cache
    local supplycachebuff = createGlobalBuff({
        id="supplycachebuff",
        name = "Supply Cache",
        abilities = {
            createAbility({
                id="supplycachebuff",
				trigger = startOfGameTrigger,
                effect = nullEffect(),
				
            })
        },
		buffDetails = createBuffDetails({
					name = "Supply Cache",
                    art = "art/T_Taxation",
					text = "At game start 1 Ruby and 1 Shortsword was added to each player's deck."
							})
    })

function choose_supply_cache_carddef()
    return createDef({
        id="choose_supply_cache",
        name="The Supply Cache",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_supply_cache",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(ruby_carddef(), loc(currentPid, deckPloc)))
								.seq(createCardEffect(shortsword_carddef(), loc(currentPid, deckPloc)))
								.seq(shuffleEffect(currentDeckLoc))
								.seq(createCardEffect(ruby_carddef(), loc(oppPid, deckPloc)))
								.seq(createCardEffect(shortsword_carddef(), loc(oppPid, deckPloc)))
								.seq(createCardEffect(supplycachebuff, loc(currentPid, buffsPloc)))
								.seq(createCardEffect(supplycachebuff, loc(oppPid, buffsPloc)))
								.seq(shuffleEffect(loc(oppPid, deckPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),					
								
						
                    }
                )
            },
        layout = createLayout({
            name = "The Supply Cache",
            art = "art/T_Taxation",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Add 1 Ruby and 
1 Shortsword
to each player's deck." fontsize="26"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

-- Armoury
    local armourybuff = createGlobalBuff({
        id="armourybuff",
        name = "The Armoury",
        abilities = {
            createAbility({
                id="armourybuff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "The Armoury",
                    art = "art/t_cleric_brightstar_shield",
					text = "<size=80%>On your turn you may spend <sprite name=\"gold_1\"> to randomly acquire either a Dagger or a Shortsword into your hand."
							})
    })

function choose_armoury_carddef()
    return createDef({
        id="choose_armoury",
        name="The Armoury",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_armoury",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(armouryskill_carddef(), currentSkillsLoc))
								.seq(createCardEffect(armouryskill_carddef(), loc(oppPid, skillsPloc)))
								.seq(createCardEffect(armourybuff, loc(currentPid, buffsPloc)))
								.seq(createCardEffect(armourybuff, loc(oppPid, buffsPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "The Armoury",
            art = "art/t_cleric_brightstar_shield",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="On your turn you may spend 1{gold} to randomly acquire either a Dagger or a Shortsword into your hand." fontsize="24"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function armouryskill_carddef()
    local cardLayout = createLayout({
        name = "Armoury",
        art = "art/t_cleric_brightstar_shield",
        frame = "frames/Coop_Campaign_CardFrame",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_1}" fontsize="60" flexiblewidth="0"/>
            <tmpro text="Put either a Dagger or a Shortsword
in your hand." fontsize="24" flexiblewidth="10" />
    </hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "armouryskill_skill",
        name = "Armoury",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/t_cleric_brightstar_shield",
        abilities = {
            createAbility({
                id = "armouryskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = randomEffect({
					valueItem(1, createCardEffect(dagger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(shortsword_carddef(), loc(currentPid, handPloc)))
}).seq(noUndoEffect()),
				cost = combineCosts({expendCost, goldCost(1)}),
            }),
        }
        
    })
end

-- Crypt - NullPloc Shuffle not working
function choose_crypt_carddef()
    return createDef({
        id="choose_crypt",
        name="The Crypt",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_crypt",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = singleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(cryptskill_carddef(), currentSkillsLoc))
								.seq(createCardEffect(cryptskill_carddef(), loc(oppPid, skillsPloc)))
								.seq(createCardEffect(cryptBuffDef(), loc(currentPid, buffsPloc)))
								.seq(createCardEffect(cryptBuffDef(), loc(oppPid, buffsPloc)))
								.seq(createCardEffect(lich_abomination_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_banshee_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_ghoul_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_revenant_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_wall_of_bones_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_wall_of_fire_minion_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(lich_zombie_minion_carddef(), loc(nil, nullPloc)))
								--
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "The Crypt",
            art = "art/epicart/watchful_gargoyle",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Setup: Put 10 Lich Champions into the Crypt Deck.
On your turn: You may lose {health_3} to take a card from the Crypt Deck and put it into play.
All game: Vampire, Necromancer and Demon Champions cost -{gold_1} to buy from the Market.
" fontsize="18" alignment="left"/>

    </box>
</vlayout>
			]]
			}),
        })
	end
	
function cryptBuffDef()

local priceBuff = getCostDiscountBuff("Crypt", 1, selectLoc(centerRowLoc).where(isCardType(vampireType).Or(isCardType(demonType).Or(isCardType(necromancerType)))))

    return createGlobalBuff({
        id="CryptPriceBuff",
        name = "The Crypt",
        abilities = {
            createAbility({
                id="CryptPriceBuff",
                trigger = startOfTurnTrigger,
                effect = createCardEffect(priceBuff, loc(currentPid, buffsPloc))
			})
        },
		buffDetails = createBuffDetails({
					name = "The Crypt",
                    art = "art/epicart/watchful_gargoyle",
					text = "<size=60%>Vampire, Necromancer and Demon Champions cost <sprite name=\"gold_1\"> less to buy from the Market. You may lose <sprite name=\"health_3\"> to take a card from the Crypt Deck and put it into play. Return Crypt cards to the Crypt deck when they leave play."
							})  
	})
end

--[[function cryptSetupBuffDef()

    return createGlobalBuff({
        id="setupCryptBuff",
        name = "Setup Crypt",
        abilities = {
            createAbility({
                id="setupCryptBuff",
                trigger = startOfGameTrigger,
                effect = createCardEffect(CryptBuff, loc(oppPid, buffsPloc))
				.seq(createCardEffect(cryptskill_carddef(), loc(currentPid, skillsPloc)))
				.seq(createCardEffect(cryptskill_carddef(), loc(currentPid, skillsPloc)))
				
			createCardEffect(lich_abomination_minion_carddef(), loc(currentPid, asidePloc))
				.seq(createCardEffect(lich_banshee_minion_carddef(), loc(currentPid, asidePloc)))
				.seq(saveTarget("Crypt").apply(selectLoc(loc(currentPid, asidePloc))))
				.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, asidePloc))))		
				
			})
        }   
	})
end
]]

function cryptskill_carddef()
    local cardLayout = createLayout({
        name = "Open Crypt",
        art = "art/epicart/watchful_gargoyle",
        frame = "frames/Coop_Campaign_CardFrame",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend}" fontsize="40" flexiblewidth="0"/>>
            <tmpro text="{health_-3}
&lt;size=60%&gt;Randomly select 1 of 10 cards (comprised of 8 unique Lich Champions) and put it into play." fontsize="34" flexiblewidth="10" />
    </hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryptskill_skill",
        name = "Open Crypt",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/watchful_gargoyle",
        abilities = {
            createAbility({
                id = "cryptskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
				effect = hitSelfEffect(3)
				.seq(randomTarget(const(1), moveTarget(inPlayPloc)).apply(selectLoc(loc(nil, nullPloc)))).seq(noUndoEffect()),
				check = selectLoc(loc(nil, nullPloc)).count().gte(1).And(minHealthCurrent(4)),
				cost = expendCost,
            }),
        }
        
    })
end

function lich_abomination_minion_carddef()
	return createChampionDef({
		id = "lich_abomination_minion",
		name = "Lich Abomination Minion",
		acquireCost = 0,
		health = 6,
		isGuard = true,
		types = { minionType, undeadType, constructType },
		layout = createLayout({
					name = "Abomination",
					art = "art/epicart/scrap_golem_token",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 6,
					isGuard = true,
					xmlText=
					[[
						<vlayout forceheight="false" spacing="6">
							<hlayout forcewidth="true" spacing="10">         <icon text="{expend}" fontsize="55"/>
								<hlayout spacing="10">
									<text text="{combat_4}" fontsize="85"/>
								</hlayout>          
								<icon text=" " fontsize="22"/>
							</hlayout>
						<divider/>
							<hlayout flexibleheight="7">
								<vlayout flexiblewidth="8">
									<tmpro text="&lt;space=1em/&gt;It feels neither pain nor fear." fontsize="13" flexiblewidth="10" fontstyle="italic" flexibleheight="1"/>
									<tmpro text="&lt;space=1em/&gt;But you will..." fontsize="13" flexiblewidth="10" fontstyle="italic" flexibleheight="0.3"/>
								</vlayout>
							</hlayout>
						</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_abomination_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(4),
			}),
			
			createAbility({
				id = "lich_abomination_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_banshee_minion_carddef()
	return createChampionDef({
		id = "lich_banshee_minion",
		name = "Lich Banshee Minion",
		acquireCost = 0,
		health = 3,
		isGuard = false,
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Banshee",
					art = "art/T_Banshee",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 3,
					isGuard = false,
					xmlText=
					[[
<vlayout>
    <hlayout flexibleheight="3">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">

            <box flexibleheight="2">
                <tmpro text="Deal 2 damage to each opposing champion and 6 damage to your opponent." fontsize="22" />
            </box>
<box flexibleheight="0.5">
 <tmpro text="(Guards do not prevent this.)" fontstyle="italic" fontsize="18" />
</box>
        </vlayout>
    </hlayout>

</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_banshee_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = hitOpponentEffect(6).seq(damageTarget(2).apply(selectLoc(loc(oppPid, inPlayPloc))))
			}),
			
			createAbility({
				id = "lich_banshee_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_ghoul_minion_carddef()
	return createChampionDef({
		id = "lich_ghoul_minion",
		name = "Lich Ghoul Minion",
		acquireCost = 0,
		health = 5,
		isGuard = true,
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Ghoul",
					art = "art/epicart/carrion_demon",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 5,
					isGuard = true,
					xmlText=
					[[
	<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{combat_3}
&lt;size=50%&gt;+{combat_1} for each champion in your discard pile." fontsize="50
" flexiblewidth="12" />
    </hlayout>
    
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_ghoul_minion_main",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = layoutCard(
                                                {
                                                    name = "Ghoul",
													art = "art/epicart/carrion_demon",
													frame = "frames/necromancer_frames/necromancer_item_cardframe",
													xmlText=[[
														<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{combat_3}
&lt;size=50%&gt;+{combat_1} for each champion in your discard pile." fontsize="50
" flexiblewidth="12" />
    </hlayout>
    
</vlayout>
													]]
                                                }
                                            ),
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(3).seq(gainCombatEffect(selectLoc(currentDiscardLoc).where(isCardChampion()).count())),
				--ifElseEffect(selectLoc(currentInPlayLoc).where(isCardType(demonType)).count().gte(1),gainCombatEffect(3),gainCombatEffect(1))
			}),
			
			createAbility({
				id = "lich_ghoul_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_revenant_minion_carddef() 
	return createChampionDef({
		id = "lich_revenant_minion",
		name = "Lich Revenant Minion",
		acquireCost = 0,
		health = 5,
		isGuard = false,
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Revenant",
					art = "art/epicart/scara_s_will",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 5,
					isGuard = false,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="7.7">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{health_5}" fontsize="40" alignment="Center" flexibleheight="1"/>
                                <tmpro text="&lt;size=80%&gt;or
&lt;size=100%&gt;Stun an opposing champion." fontsize="26" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>
    </hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_revenant_minion_main",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = pushChoiceEffect
				(
					{
						choices =
						{
							
							-- Gain 5 health
							{
								effect = gainHealthEffect(5),
								layout = layoutCard(
									{
										title = "Revenant",
										art = "art/epicart/scara_s_will",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										xmlText = 
										[[
											<vlayout>
												<hlayout flexibleheight="1">
													<box flexiblewidth="7">
														<text text="{health_5}" fontsize="60"/>
													</box>
												</hlayout>
											</vlayout>
										]]
									}
								),
							},
							-- Stun an opposing champion
							{
								effect = pushTargetedEffect({
									desc = "Stun an opposing champion.",
									validTargets = oppStunnableSelector(),
									min = 0,
									max = 1,
									targetEffect = stunTarget(),
									}),
								condition = selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion()).count().gte(1),	
								layout = layoutCard(
									{
										title = "Revenant",
										art = "art/epicart/scara_s_will",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										xmlText = 
										[[
											<vlayout>
												<hlayout flexibleheight="1">
													<box flexiblewidth="7">
														<text text="Stun an opposing champion." fontsize="25"/>
													</box>
												</hlayout>
											</vlayout>
										]]
									}
								),
							},
							
						}
					}
				)
			}),
			
			createAbility({
				id = "lich_revenant_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})		
		},
	})
end

function lich_skeleton_horde_minion_carddef() 
	return createChampionDef({
		id = "lich_skeleton_horde_minion",
		name = "Lich Skeleton Horde Minion",
		acquireCost = 0,
		health = 4,
		isGuard = false,
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Skeleton Horde",
					art = "art/epicart/reap_or_sow",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 4,
					isGuard = false,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="7.7">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{combat_3}" fontsize="60" alignment="Center" flexibleheight="1"/>
                                     
            </vlayout>
    </hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_skeleton_horde_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(3),
			}),
			
			createAbility({
				id = "lich_skeleton_horde_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end


function lich_wall_of_bones_minion_carddef() 
	return createChampionDef({
		id = "lich_wall_of_bones_minion",
		name = "Lich Wall of Bones Minion",
		acquireCost = 0,
		health = 8,
		isGuard = true,
		types = { minionType, undeadType, constructType },
		layout = createLayout({
					name = "Wall of Bones",
					art = "art/T_skeleton",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 8,
					isGuard = true,
					xmlText=
					[[
						<vlayout forceheight="false" spacing="6">
							<hlayout flexibleheight="7">
								<vlayout flexiblewidth="8">
									<tmpro text="&lt;space=1em/&gt;''Pray you don't become a part of it.''" fontsize="14.5" flexiblewidth="10" fontstyle="italic" flexibleheight="1"/>
								</vlayout>
							</hlayout>
						</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_wall_of_bones_minion_main",
				trigger = autoTrigger,
				--cost = expendCost,
				effect = nullEffect()
			}),
			
			createAbility({
				id = "lich_wall_of_bones_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_wall_of_fire_minion_carddef()
	return createChampionDef({
		id = "lich_wall_of_fire_minion",
		name = "Lich Wall of Fire Minion",
		acquireCost = 0,
		health = 7,
		isGuard = false,
		types = { minionType, magicType, constructType },
		layout = createLayout({
					name = "Wall of Fire",
					art = "art/T_charing_guardian",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 7,
					isGuard = false,
					xmlText=
					[[
						<vlayout>
							<hlayout flexibleheight="1">
								<tmpro text="{expend}" fontsize="55" flexiblewidth="1"/>
									<tmpro text="Deal 6 damage to your opponent." fontsize="22" flexiblewidth="4"/>
							</hlayout>
						</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_wall_of_fire_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = hitOpponentEffect(6),
			}),
			
			createAbility({
				id = "lich_wall_of_bones_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_zombie_minion_carddef() 
	return createChampionDef({
		id = "lich_zombie_minion",
		name = "Lich Zombie Minion",
		acquireCost = 0,
		health = 1,
		isGuard = false,
		cardTypeLabel = "undeadType",
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Zombie",
					art = "art/sets/promos1art/zombie",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 1,
					isGuard = false,
					xmlText=
					[[
<vlayout forceheight="false" spacing="6">
<hlayout forcewidth="true" spacing="10">
<icon text="{expend}" fontsize="40"/>
<hlayout spacing="10">
<text text="{combat_2}" fontsize="60"/>
</hlayout>          
<icon text=" " fontsize="22"/>
</hlayout>
	<divider/>
<hlayout flexibleheight="2">
	<tmpro text="&lt;space=1em/&gt;Where the Lich walks, the dead rise." fontsize="13" flexiblewidth="10" fontstyle="italic"/>
</hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_zombie_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(2)
			}),
			
			createAbility({
				id = "lich_zombie_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		
		},
	})
end

--Beast Pit
local the_beast_Buff = createGlobalBuff({
    id="the_beast_Buff",
    name = "The Beast",
    abilities = {
        createAbility({
            id="the_beast_Buff",
            trigger = startOfTurnTrigger,
            check = getTurnsPlayed(currentPid).gte(2),
            effect = drawCardsEffect(1).seq(hitSelfEffect(1)).seq(gainCombatEffect(3))
        })
    },
    buffDetails = createBuffDetails({
        name = "The Beast",
        art = "art/epicart/rage",
        text = "Each turn: Draw 1. Lose <sprite name=\"health_1\">. Gain <sprite name=\"combat_3\">."
    })
})

function choose_beast_pit_carddef()

    return createDef({
        id="choose_beast_pit",
        name="The Beast Pit",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_beast_pit",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(beast_within_carddef(), loc(currentPid, deckPloc)))
								.seq(createCardEffect(beast_within_carddef(), loc(oppPid, deckPloc)))
								.seq(shuffleEffect(currentDeckLoc))
								.seq(shuffleEffect(loc(oppPid, deckPloc)))
								.seq(createCardEffect(the_beast_Buff, loc(currentPid, buffsPloc)))
								.seq(createCardEffect(the_beast_Buff, loc(oppPid, buffsPloc)))
								
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "The Beast Pit",
            art = "art/epicart/rage",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Setup: Add a 'Beast Within' card to your deck. (This draws 1 and you may pay {health_1} for {combat_3}.)

Each turn: Draw 1. {health_-1} {combat_3}" fontsize="24" alignment="left"/>
    </box>
</vlayout>
			]]
			}),
        })
	end


function beast_within_carddef()
    return createDef(
        {
            id = "beast_within",
            name = "The Beast Within",
            types = {noStealType, actionType, noPlayType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "beast_within_draw",
                        layout = cardLayout,
                        effect = drawCardsEffect(1),
						activations = singleActivations,
                        trigger = autoTrigger,
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "beast_within_main",
                        layout = cardLayout,
						promptType = showPrompt,
						activations = singleActivations,
                        effect = hitSelfEffect(1).seq(gainCombatEffect(3)),
						check = minHealthCurrent(2),
						layout = layoutCard(
                                                {
                                                    title = "The Beast Within",
                                                    art = "art/treasures/thief_brillant_ruby",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{health_-1} {combat_3}" fontsize="60"/>
    </box>
</vlayout>
													]]
                                                }
                                            ),
                        trigger = uiTrigger,
												
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "The Beast Within",
                    art = "art/epicart/stealthy_predator",
                    frame = "frames/generic_CardFrame",
                    xmlText=[[
				<vlayout>
    <box flexibleheight="2">
        <tmpro text="Draw 1.
You may pay {health_1} for {combat_3}." fontsize="32"/>
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

--Town Square
function ST_tasty_meal_carddef()
    return createDef(
        {
            id = "tasty_meal",
            name = "Tasty Meal",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 2,
            abilities = {
				createAbility(
                    {
                        id = "tasty_meal_gold",
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						effect = gainGoldEffect(2),
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "tasty_meal_meal",
						cost = sacrificeSelfCost,
						trigger = uiTrigger,
                        activations = singleActivations,
						effect = gainHealthEffect(4),
                        tags = {}
                    }
                )
            },
            
            layout = createLayout(
                {
                    name = "Tasty Meal",
                    art = "art/treasures/t_bottle_of_rum",
                    frame = "frames/generic_CardFrame",
					cost = 2,
                    xmlText=[[
<vlayout>
    <box flexibleheight="9">
        <tmpro text="{gold_2}" fontsize="50"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="" fontsize="24" />
    </box>
<divider/>
    <hlayout flexibleheight="14">
            <tmpro text="{scrap}" fontsize="40" flexiblewidth="1" />
            <tmpro text="{health_4}" fontsize="50" alignment="center" flexiblewidth="10" />
    </hlayout> </vlayout>
					]],

                }
            )
        }
    )
end

function ST_shopkeeper_s_keys_carddef()
    return createDef(
        {
            id = "shopkeeper_s_keys",
            name = "Shopkeeper's Keys",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 2,
            abilities = {
				createAbility(
                    {
                        id = "shopkeeper_s_keys_gold",
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						effect = gainGoldEffect(2),
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "shopkeeper_s_keys_keys",
						cost = sacrificeSelfCost,
						trigger = uiTrigger,
                        activations = singleActivations,
						effect = pushTargetedEffect({
												desc = "Expend target opponent's champion of cost 4 gold or less, then drag it into your play area. At end of turn, return it to opponent's play area. Prepare it..",
												validTargets = selectLoc(centerRowLoc),
												min = 1,
												max = 1,
												targetEffect = moveTarget(nullPloc),
												}),
                        tags = {}
                    }
                )
            },
            
            layout = createLayout(
                {
                    name = "Shopkeeper's Keys",
                    art = "art/T_theft",
                    frame = "frames/generic_CardFrame",
					cost = 2,
                    xmlText=[[
<vlayout>
    <box flexibleheight="6">
        <tmpro text="{gold_2}" fontsize="40"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="" fontsize="24" />
    </box>
<divider/>
    <hlayout flexibleheight="14">
            <tmpro text="{scrap}" fontsize="30" flexiblewidth="1" />
            <tmpro text="Set aside the top card of the market deck. For the rest of the game, any player may pay to acquire that card (by using the Town Square skill)." fontsize="18" alignment="center" flexiblewidth="10" />
    </hlayout> </vlayout>
					]],

                }
            )
        }
    )
end


-- sheild_bearers_hall
local shieldbearerhallbuff = createGlobalBuff({
        id="shieldbearerhallbuff",
        name = "Shield Bearer's Hall",
        abilities = {
            createAbility({
                id="shieldbearerhallbuff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "Shield Bearer's Hall",
                    art = "art/t_shield_bearer",
					text = "<size=70%>On turn: You may pay <sprite name=\"gold_2\"> to put a Shield Bearer token (or pay <sprite name=\"gold_3\"> for a Seasoned Shield Bearer token) in play and a Brightstar Shield in your hand."
							})
    })

function choose_sheild_bearers_hall_carddef()
    return createDef({
        id="choose_sheild_bearers_hall",
        name="Sheild Bearer's Hall",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_sheild_bearers_hall",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(sheild_bearers_hallskill_carddef(), currentSkillsLoc))
								.seq(createCardEffect(sheild_bearers_hallskill_carddef(), loc(oppPid, skillsPloc)))
								.seq(createCardEffect(shieldbearerhallbuff , loc(currentPid, buffsPloc)))
								.seq(createCardEffect(shieldbearerhallbuff , loc(oppPid, buffsPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "Sheild Bearer's Hall",
            art = "art/t_shield_bearer",
			frame = "frames/generic_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="On turn: You may pay {gold_2} to put a Shield Bearer token in play and a Brightstar Shield in your hand. Or pay {gold_3} to put a Seasoned Shield Bearer token in play and a Brightstar Shield in your hand." fontsize="20"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function sheild_bearers_hallskill_carddef()
    local cardLayout = createLayout({
        name = "Sheild Bearer's Hall",
        art = "art/t_shield_bearer",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="0.5">
         <tmpro text="{expend}" fontsize="28" flexiblewidth="1" />
        </box>
        <box flexiblewidth="4">
         <tmpro text="Pay {gold_2}: Put a Shield Bearer token in play and a Brightstar Shield in hand." fontsize="18" alignment="left" flexiblewidth="2" />
        </box>

    </hlayout>  
    <divider/>
    
     <hlayout flexibleheight="1">
        <box flexiblewidth="0.5">
         <tmpro text="{expend}" fontsize="28" flexiblewidth="2" />
        </box>
        <box flexiblewidth="4">
         <tmpro text="Pay {gold_3}: Put a Seasoned Shield Bearer token in play and a Brightstar Shield in hand." fontsize="18" flexiblewidth="7" alignment="left" />

        </box>
    </hlayout> 
</vlayout>
		]]
    })

    return createSkillDef({
        id = "sheild_bearers_hallskill_skill",
        name = "Sheild Bearer's Hall",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/t_cleric_brightstar_shield",
        abilities = {
            createAbility({
                id = "sheild_bearers_hallskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
				cost = combineCosts({expendCost, goldCost(2)}),
                effect = pushChoiceEffect({
                        choices = {
                            {
                                effect = createCardEffect(shieldbearertoken_carddef(), loc(currentPid, inPlayPloc))
								.seq(createCardEffect(cleric_brightstar_shield_carddef(), loc(currentPid, handPloc))),
                                layout = createLayout({
								name = "Call Shield Bearer",
								art = "art/t_shield_bearer",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <hlayout flexibleheight="1">

        <box flexiblewidth="3">
         <tmpro text="Put a Shield Bearer token in play and a Brightstar Shield in your hand." fontsize="24" alignment="center" flexiblewidth="2" />
        </box>

    </hlayout>  

</vlayout>
                                    ]],
                                }),
                                tags = { }
                            },
                            {
                                effect = gainGoldEffect(-1)
								.seq(createCardEffect(seasonedshieldbearertoken_carddef(), loc(currentPid, inPlayPloc)))
								.seq(createCardEffect(cleric_brightstar_shield_carddef(), loc(currentPid, handPloc))),
                                condition = getPlayerGold(currentPid).gte(1),
								layout = createLayout({
								name = "Call Shield Bearer",
								art = "art/t_fighter_seasoned_shield_bearer",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <hlayout flexibleheight="1">

        <box flexiblewidth="3">
         <tmpro text="Put a Seasoned Shield Bearer token in play and a Brightstar Shield in your hand." fontsize="24" alignment="center" flexiblewidth="2" />
        </box>

    </hlayout>  

</vlayout>
                                    ]],
                                }),
                                tags = { }
                            }
                        },

            }),
        })
		}
        
    })
end

function shieldbearertoken_carddef()
    return createChampionDef(
        {
            id = "shieldbearertoken",
            name = "Shield Bearer",
			types = {championType, nosteaalType},
            acquireCost = 0,
            health = 3,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "Shield_Bearer_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = nullEffect()
                    }),
					--self-sac ability
                createAbility(
                    {
                        id = "shieldbearertoken_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
                
            },
            layout = createLayout(
                {
                    name = "Seasoned Shield Bearer",
                    art = "art/t_shield_bearer",
                    frame = "frames/generic_CardFrame",
                    xmlText=[[
					<vlayout>
            <vlayout flexiblewidth="6">
 <tmpro text="'Your shield,
my liege.'" fontsize="36" fontstyle ="italic" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>

</vlayout>
					]],
                    health = 3,
                    isGuard = true
                }
            )
        }
    )
end

function seasonedshieldbearertoken_carddef()
    return createChampionDef(
        {
            id = "seasonedshieldbearertoken",
            name = "Seasoned Shield Bearer",
			types = {championType, nosteaalType},
            acquireCost = 0,
            health = 5,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "Seasoned_Shield_Bearer_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = nullEffect()
                    }),
					--self-sac ability
                createAbility(
                    {
                        id = "seasonedshieldbearertoken_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
                
            },
            layout = createLayout(
                {
                    name = "Seasoned Shield Bearer",
                    art = "art/t_fighter_seasoned_shield_bearer",
                    frame = "frames/generic_CardFrame",
                    xmlText=[[
					<vlayout>
            <vlayout flexiblewidth="6">
 <tmpro text="'Your shield
again, my liege.'" fontsize="36" fontstyle ="italic" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>

</vlayout>
					]],
                    health = 5,
                    isGuard = true
                }
            )
        }
    )
end

--The Apothecary
local apothecarybuff = createGlobalBuff({
        id="apothecarybuff",
        name = "The Apothecary",
        abilities = {
            createAbility({
                id="apothecarybuff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "The Apothecary",
                    art = "art/treasures/T_Green_Potions_Large",
					text = "<size=70%>On turn: You may pay <sprite name=\"gold_1\"> to add 1 of 5 random potions into your inventory. You may repeat this action for <sprite name=\"gold_1\"> more each time you use it on a single turn."
								})
    })

function choose_apothecary_carddef()
    return createDef({
        id="choose_apothecary",
        name="Apothecary",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_apothecary",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(apothecaryskill_carddef(), currentSkillsLoc))
								.seq(createCardEffect(apothecaryskill_carddef(), loc(oppPid, skillsPloc)))
								.seq(createCardEffect(ST_apothecary_elixir_of_endurance_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(ST_apothecary_elixir_of_strength_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(ST_apothecary_elixir_of_fortune_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(ST_apothecary_elixir_of_concentration_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(ST_apothecary_elixir_of_wisdom_carddef(), loc(nil, nullPloc)))
								.seq(createCardEffect(apothecarybuff , loc(currentPid, buffsPloc)))
								.seq(createCardEffect(apothecarybuff , loc(oppPid, buffsPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "Apothecary",
            art = "art/treasures/T_Green_Potions_Large",
			frame = "frames/generic_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="On turn: You may pay {gold_1} to add 1 of 5 random potions into your inventory. (These act as Abilities.) You may repeat this action for {gold_1} more each time you use it on a single turn." fontsize="20"/>
    </box>
</vlayout>
			]]
			}),
        })
	end
	
	function apothecaryskill_carddef()
    local cardLayout = createLayout({
        name = "Buy Potion",
        art = "art/treasures/T_Green_Potions_Large",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
		<vlayout>
    <box flexibleheight="2">
        <tmpro text="Pay {gold_1} Take a potion from the Apothecary Pile and add it to your inventory.

You may repeat this action for {gold_1} more each time you use it this turn." fontsize="20"/>
    </box>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "apothecary_skill",
        name = "Buy Potion",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/treasures/T_Green_Potions_Large",
        abilities = {
            createAbility({
                id = "apothecaryskill_ab",
                trigger = uiTrigger,
                activations = multipleActivations,
                layout = cardLayout,
				promptType = showPrompt,
				cost = goldCost(1),
                effect = randomEffect({
					valueItem(1, createCardEffect(ST_apothecary_elixir_of_endurance_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ST_apothecary_elixir_of_fortune_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ST_apothecary_elixir_of_strength_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ST_apothecary_elixir_of_wisdom_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ST_apothecary_elixir_of_concentration_carddef(), loc(currentPid, skillsPloc))),
					})
				.seq(addSlotToPlayerEffect(controllerPid, createPlayerIntExpressionSlot(skillCostModKey, toIntExpression(1), { endOfTurnExpiry })))
				.seq(noUndoEffect()),
                                layout = createLayout({
								name = "Buy Potion",
								art = "art/treasures/T_Green_Potions_Large",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <box flexibleheight="2">
        <tmpro text="Pay {gold_1} to add 1 of 5 random potions into your inventory.

You may repeat this action for {gold_1} more each time you use it this turn." fontsize="20"/>
    </box>
</vlayout>
                                    ]],
                                }),
                                tags = { },
        })
		}
        
    })
end

function ST_apothecary_elixir_of_endurance_carddef()
    local cardLayout = createLayout({
        name = "Elixir of Endurance",
        art = "art/T_elixir_of_endurance",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
		<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="{health_5}" fontsize="60"/>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "ST_apothecary_elixir_of_endurance",
        name = "Elixir of Endurance",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/T_elixir_of_endurance",
        abilities = {
            createAbility({
                id = "ST_apothecary_elixir_of_endurance_ab",
                trigger = uiTrigger,
                activations = singleActivations,
                layout = cardLayout,
				promptType = showPrompt,
				cost = sacrificeSelfCost,
                effect = gainHealthEffect(5),
                                layout = createLayout({
								name = "Elixir of Endurance",
								art = "art/T_elixir_of_endurance",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                        <vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="{health_5}" fontsize="60"/>
</hlayout>
</vlayout>
                                    ]],
                                }),
                                tags = { },
        })
		}
        
    })
end

function ST_apothecary_elixir_of_wisdom_carddef()
    local cardLayout = createLayout({
        name = "Elixir of Wisdom",
        art = "art/T_elixir_of_wisdom",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
		<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="Draw 1. Discard 1." fontsize="24"/>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "ST_apothecary_elixir_of_wisdom",
        name = "Elixir of Wisdom",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/T_elixir_of_wisdom",
        abilities = {
            createAbility({
                id = "ST_apothecary_elixir_of_wisdom_ab",
                trigger = uiTrigger,
                activations = singleActivations,
                layout = cardLayout,
				promptType = showPrompt,
				cost = sacrificeSelfCost,
                effect = drawCardsEffect(1).seq(forceDiscard(1)),
                                layout = createLayout({
								name = "Elixir of wisdom",
								art = "art/T_elixir_of_wisdom",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                        <vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="Draw 1. Discard 1." fontsize="24"/>
</hlayout>
</vlayout>
                                    ]],
                                }),
                                tags = { },
        })
		}
        
    })
end
function ST_apothecary_elixir_of_concentration_carddef()
    local cardLayout = createLayout({
        name = "Elixir of Concentration",
        art = "art/T_elixir_of_concentration",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
		<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="You may sacrifice
a card in your hand." fontsize="24"/>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "ST_apothecary_elixir_of_concentration",
        name = "Elixir of Concentration",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/T_elixir_of_concentration",
        abilities = {
            createAbility({
                id = "ST_apothecary_elixir_of_concentration_ab",
                trigger = uiTrigger,
                activations = singleActivations,
                layout = cardLayout,
				promptType = showPrompt,
				cost = sacrificeSelfCost,
                effect = pushTargetedEffect({
							desc = "Sacrifice a card in your hand.",
							validTargets = selectLoc(loc(currentPid, handPloc)),
							min = 0,
							max = 1,
							targetEffect = sacrificeTarget(),
			    }),
                                layout = createLayout({
								name = "Elixir of concentration",
								art = "art/T_elixir_of_concentration",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                        <vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="You may sacrifice
a card in your hand." fontsize="24"/>
</hlayout>
</vlayout>
                                    ]],
                                }),
                                tags = { },
        })
		}
        
    })
end

function ST_apothecary_elixir_of_strength_carddef()
    local cardLayout = createLayout({
        name = "Elixir of Strength",
        art = "art/T_elixir_of_strength",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
		<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="{combat_3}" fontsize="60"/>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "ST_apothecary_elixir_of_strength",
        name = "Elixir of Strength",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/T_elixir_of_strength",
        abilities = {
            createAbility({
                id = "ST_apothecary_elixir_of_strength_ab",
                trigger = uiTrigger,
                activations = singleActivations,
                layout = cardLayout,
				promptType = showPrompt,
				cost = sacrificeSelfCost,
                effect = gainCombatEffect(3),
                                layout = createLayout({
								name = "Elixir of strength",
								art = "art/T_elixir_of_strength",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                        <vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="{combat_3}" fontsize="60"/>
</hlayout>
</vlayout>
                                    ]],
                                }),
                                tags = { },
        })
		}
        
    })
end
 
	function ST_apothecary_elixir_of_fortune_carddef()
	
	local priceBuff = getCostDiscountBuff("Elixir of Fortune", 1, selectLoc(centerRowLoc).where(isCardType(actionType)), endOfTurnExpiry)
    local eofFortuneBuff = createGlobalBuff({
        id="Elixir of Fortune",
        name = "Elixir of Fortune",
        abilities = {
            createAbility({
                id="STapoth_Eoffortune_Buff",
                trigger = autoTrigger,
                effect = createCardEffect(priceBuff, loc(oppPid, buffsPloc)).seq(sacrificeSelf())
            })
        },
		
    })
    local cardLayout = createLayout({
        name = "Elixir of fortune",
        art = "art/T_elixir_of_fortune",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
		<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="The next action you acquire this turn costs {gold_1} less." fontsize="24"/>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "ST_apothecary_elixir_of_fortune",
        name = "Elixir of Fortune",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/T_elixir_of_fortune",
        abilities = {
            createAbility({
                id = "ST_apothecary_elixir_of_fortune_ab",
                trigger = uiTrigger,
                activations = singleActivations,
                layout = cardLayout,
				promptType = showPrompt,
				cost = sacrificeSelfCost,
                effect = createCardEffect(eofFortuneBuff, loc(currentPid, buffsPloc)),
                                layout = createLayout({
								name = "Elixir of Fortune",
								art = "art/T_elixir_of_fortune",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                       <vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="The next action you acquire this turn costs {gold_1} less." fontsize="24"/>
</hlayout>
</vlayout>
                                    ]],
                                }),
                                tags = { },
        })
		}
        
    })
end

--Great Hall
local greatHallbuff = createGlobalBuff({
        id="greatHallbuff ",
        name = "The Great Hall",
        abilities = {
            createAbility({
                id="greatHallbuff ",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "The Great Hall",
                    art = "art/treasures/t_cleric_elixir_golden",
					text = "<size=70%>Each turn you may pay <sprite name=\"gold_3\"> to put a Poison card in your opponent's discard pile. If you have an 'Assassin' card in play you may take this action for free."
							})
    })

function choose_great_hall_carddef()
    return createDef({
        id="choose_great_hall",
        name="The Great Hall",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_great_hall",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(greathallskill_carddef(), currentSkillsLoc))
								.seq(createCardEffect(greathallskill_carddef(), loc(oppPid, skillsPloc)))
								.seq(createCardEffect(greatHallbuff , loc(currentPid, buffsPloc)))
								.seq(createCardEffect(greatHallbuff , loc(oppPid, buffsPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "The Great Hall",
            art = "art/treasures/t_cleric_elixir_golden",
			frame = "frames/generic_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Each turn you may pay {gold_3} to put a Poison card in your opponent's discard pile.

If you have an 'Assassin' in play you may take this action for free." fontsize="18"/>
    </box>
</vlayout>
			]]
			}),
        })
	end


function greathallskill_carddef()
    local cardLayout = createLayout({
        name = "Poison",
        art = "art/treasures/t_cleric_elixir_green",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
		<vlayout>
    <box flexibleheight="2">
        <tmpro text="Pay {gold_3}: Put a Poison card in your opponent's discard pile.

If you have an 'Assassin' in play you may take this action for free." fontsize="18"/>
    </box>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "greathallskill",
        name = "Poison",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/treasures/t_cleric_elixir_green",
        abilities = {
            createAbility({
                id = "greathallskill_ab",
                trigger = uiTrigger,
                activations = singleActivations,
                layout = cardLayout,
				promptType = showPrompt,
				check = getPlayerGold(currentPid).gte(3).Or(selectLoc(loc(currentPid, inPlayPloc)).where(isCardType(assassinType)).count().gte(1)).Or(selectLoc(loc(currentPid, castPloc)).where(isCardType(assassinType)).count().gte(1)),
				cost = expendCost,
                effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainGoldEffect(-3).seq(createCardEffect(ST_poison_carddef(), loc(oppPid, discardPloc))),
                                            condition = getPlayerGold(currentPid).gte(3),
											layout = layoutCard(
                                                {
                                                    title = "Poison",
                                                    art = "art/treasures/t_cleric_elixir_green",
                                                     xmlText= [[
													 <vlayout>
    <box flexibleheight="2">
        <tmpro text="Pay {gold_3}
		Put a Poison card in your opponent's discard pile." fontsize="18"/>
    </box>
</vlayout>
													 ]]
                                                }
                                            ),
                                            tags = {gainCombat2Tag}
                                        },
                                        {
                                            effect = createCardEffect(ST_poison_carddef(), loc(oppPid, discardPloc)),
											condition = selectLoc(loc(currentPid, inPlayPloc)).where(isCardType(assassinType)).count().gte(1),
											--selectLoc(currentInPlayLoc).where(isCardType("assassinType")).count().gte(1),
											
                                            layout = layoutCard(
                                                {
                                                    title = "Poison",
                                                    art = "art/treasures/t_cleric_elixir_green",
                                                    xmlText = [[
													<vlayout>
    <box flexibleheight="2">
        <tmpro text="(You have an Assassin card in play.)
		
		Put a Poison card in your opponent's discard pile for free." fontsize="18"/>
    </box>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainHealth2Tag}
                                        }
                                    }
                                }
                        ),
                                layout = createLayout({
								name = "Poison",
								art = "art/treasures/t_cleric_elixir_green",
								frame = "frames/generic_CardFrame",
                                    xmlText = [[
                                        <vlayout>
    <box flexibleheight="2">
        <tmpro text="Pay {gold_3}: Put a Poison card in your opponent's discard pile.

If you have an 'Assassin' in play you may take this action for free." fontsize="18"/>
    </box>
</vlayout>
                                    ]],
                                }),
                                tags = { },
        })
		}
        
    })
end

function ST_poison_carddef()
    return createDef(
        {
            id = "poison_drink",
            name = "Poison",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "poison_drink_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = nullEffect()
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Poison",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="10">
        <tmpro text="Does this taste funny to you?" fontstyle="italic" fontsize="20"/>
    </box>
    <hlayout flexibleheight="1">
    </hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

--Investment Bank
local investment_bank_buff = createGlobalBuff({
        id="investment_bank_buff",
        name = "The Investment Bank",
        abilities = {
            createAbility({
                id="investment_bank_buff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "The Investment Bank",
                    art = "art/t_bribe",
					text = "<size=70%>Each turn you may pay <sprite name=\"gold_2\"> to upgrade a Gold, Ruby, or Diamond card in your hand or discard pile."
							})
    })


function choose_investment_bank_carddef()
    return createDef({
        id="choose_investment_bank",
        name="The Investment Bank",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_investment_bank",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(investmentskill_carddef(), currentSkillsLoc))
								.seq(createCardEffect(investmentskill_carddef(), loc(oppPid, skillsPloc)))
								.seq(createCardEffect(investment_bank_buff, loc(currentPid, buffsPloc)))
								.seq(createCardEffect(investment_bank_buff, loc(oppPid, buffsPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),
						
								
                    }
                )
            },
        layout = createLayout({
            name = "The Investment Bank",
            art = "art/t_bribe",
			frame = "frames/generic_CardFrame",
            xmlText=[[
<vlayout>
<box flexibleheight="4">
<tmpro text="Each turn you may pay {gold_2} 
to upgrade a
Gold, Ruby, or Diamond
in your hand or discard pile." fontsize="20" />
</box>
</vlayout>
			]]
			}),
        })
	end

function investmentskill_carddef()
    local cardLayout = createLayout({
        name = "Investment",
        art = "art/t_bribe",
        frame = "frames/generic_CardFrame",
        xmlText = 
		[[
<vlayout>
<hlayout flexibleheight="7.7">
         <tmpro text="{expend_2}" fontsize="72" flexiblewidth="1.5"/>

 <vlayout flexiblewidth="8">
            <tmpro text="Upgrade a Gold, Ruby, or Diamond 
in your discard pile." fontsize="24" flexibleheight="7"/>

</vlayout> 

    </hlayout> 
</vlayout>
		]]
    })

    return createSkillDef({
        id = "investmentskill",
        name = "Investment",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/t_bribe",
        abilities = {
            createAbility({
					id = "investmentskill_ab",
					trigger = uiTrigger,
					activations = singleActivations,
					layout = cardLayout,
					promptType = showPrompt,
					cost = combineCosts({ expendCost, goldCost(2) }),
					check = selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName('gold').Or(isCardName('ruby')).Or(isCardName('diamond'))).count().gte(1),
					effect = pushChoiceEffectWithTitle({
								choices = {
								{
									effect = pushTargetedEffect({
											desc = "Transform a Gold in your discard pile into a Ruby.",
											validTargets = selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName('gold')),
											min = 0,
											max = 1,
											targetEffect = transformTarget("ruby"),
											}),
									condition =  selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName('gold')).count().gte(1),

									layout = createLayout({
											name = "Invest in Rubies",
											art = "art/T_Ruby",
											frame = "frames/Generic_CardFrame",
											xmlText = [[
												<vlayout>
												<box flexibleheight="4">
												<tmpro text="Transform a Gold in your discard pile into a Ruby, permanently." fontsize="20" />
												</box>
												<divider/>
												<box flexibleheight="1">
												<tmpro text="Ruby: {gold_2}" fontsize="20" />
												</box>	</vlayout>
											]],
									}),
									
									tags = {  }
								},
								
								{
									effect = pushTargetedEffect({
										desc = "Transform a Ruby in your discard pile into a Diamond.",
										validTargets = selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName('ruby')),
										min = 0,
										max = 1,
										targetEffect = transformTarget("ST_IB_diamond"),

									}),
								condition =  selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName('ruby')).count().gte(1),

								layout = createLayout({
										name = "Invest in Diamonds",
										art = "art/treasures/alchemist_diamond",
										frame = "frames/Generic_CardFrame",
										xmlText = [[
										<vlayout>
										<box flexibleheight="4">
										<tmpro text="Transform a Ruby in your discard pile into a Diamond, permanently." fontsize="20" />
										</box>
										<divider/>
										<box flexibleheight="1">
										<tmpro text="Diamond: {gold_3}" fontsize="20" />
										</box>	</vlayout>
										]],
								}),
								tags = {  }
								},
								
								{
									effect = pushTargetedEffect({
											desc = "Transform a Diamond in your discard pile into a Jewel of Thandarlore.",
											validTargets = selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName('ST_IB_diamond')),
											min = 0,
											max = 1,
											targetEffect = transformTarget("gold"),
									}),
									condition =  selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName('ST_IB_diamond')).count().gte(1),

									layout = createLayout({
											name = "Invest in Jewel of Thandarlore",
											art = "art/T_Prism_RainerPetter",
											frame = "frames/Generic_CardFrame",
											xmlText = [[
<vlayout>
<box flexibleheight="4">
<tmpro text="Transform a Diamond in your discard pile into a Jewel of Thandarlore, permanently." fontsize="20" />
</box>
<divider/>
<box flexibleheight="1">
<tmpro text="Jewel of Thandarlore: {gold_4}" fontsize="20" />
</box>	</vlayout>
											]],
											}),
									tags = {  }
								}
								}
								}),
								
								layout = createLayout({
										name = "Investment",
										art = "art/t_bribe",
										frame = "frames/generic_CardFrame",
										xmlText = [[
<vlayout>
<box flexibleheight="2">
<tmpro text="Pay {gold_2}

Upgrade a Gold, Ruby or Diamond in your hand or discard pile." fontsize="24"/>
</box>
</vlayout>
										]],
								}),
								tags = { },
						})
					}})
		

end

function ST_IB_diamond_carddef()
    return createDef(
        {
            id = "ST_IB_diamond",
            name = "Diamond",
			types = {actionType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "ST_IB_diamond",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainGoldEffect(3)
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Diamond",
                    art = "art/treasures/alchemist_diamond",
					frame = "frames/Generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout  forceheight="true">
                                            <icon text="{gold_3}" fontsize="80" />
                                        </vlayout> 
					]],

                }
            )
        }
    )
end


function jewelofthandarlore_carddef()
    return createDef(
        {
            id = "jewelofthandarlore",
            name = "Jewel of Thandarlore",
			types = {actionType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "jewelofthandarlore",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainGoldEffect(4)
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Jewel of Thandarlore",
                    art = "art/T_Prism_RainerPetter",
					frame = "frames/Generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout  forceheight="true">
                                            <icon text="{gold_4}" fontsize="80" />
                                        </vlayout> 
					]],

                }
            )
        }
    )
end



-- Smuggler's Den
function choose_smugglers_den_carddef()
    return createDef({
        id="choose_smugglers_den",
        name="The Smuggler's Den",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_smugglers_den",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								--.seq(createCardEffect(smuggleskill_carddef(), currentSkillsLoc))
								--.seq(createCardEffect(smuggleskill_carddef(), loc(oppPid, skillsPloc)))
								--.seq(createCardEffect(smuggleskill_carddef(), currentSkillsLoc))
								--.seq(createCardEffect(smuggleskill_carddef(), loc(oppPid, skillsPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "The Smuggler's Den",
            art = "art/t_rasmus_the_smuggler",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Each turn you may pay {gold_1} to move a card from the market to the Smuggler's Den.

If you have a 'Rogue' in play you may buy a card from the Smuggler's Den." fontsize="18"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function stashskill_carddef()
    local cardLayout = createLayout({
        name = "Stash",
        art = "art/t_smash_and_grab",
        frame = "frames/Coop_Campaign_CardFrame",
        xmlText = 
		[[
		<vlayout>
    <box flexibleheight="2">
        <tmpro text="Pay {gold_1} to move a card from the market to the Smuggler's Den." fontsize="24"/>
    </box>
</vlayout>

		]]
    })

    return createSkillDef({
        id = "stashskill_skill",
        name = "Stash",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/t_smash_and_grab",
        abilities = {
            createAbility({
                id = "stashskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = pushTargetedEffect({
												  desc = "Sacrifice a card from the Market. Move it to The Smuggler's Den.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(centerRowLoc),
												  targetEffect = moveTarget(nullPloc)
																
												  }),
				cost = combineCosts({expendCost, goldCost(1)}),
            }),
        }
        
    })
end

function smuggleskill_carddef()
    local cardLayout = createLayout({
        name = "Smuggle",
        art = "art/t_smash_and_grab",
        frame = "frames/Coop_Campaign_CardFrame",
        xmlText = 
		[[
		<vlayout>
    <box flexibleheight="2">
        <tmpro text="Pay {gold_1} to move a card from the market to the Smuggler's Den." fontsize="24"/>
    </box>
</vlayout>

		]]
    })

    return createSkillDef({
        id = "smuggleskill_skill",
        name = "Smuggle",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/t_smash_and_grab",
        abilities = {
            createAbility({
                id = "smuggleskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = moveTarget(myRevealPloc).apply(selectLoc(nullPLoc))
						.seq(promptSplit({
								selector = selectLoc(currentRevealLoc),
								take = const(), -- number of cards to take for split
								sort = const(1), -- number of cards to be sorted for ef2
								minTake = const(1), -- number of mandatory cards moved to ef2
								ef1 = moveTarget(nullPloc), -- effect to be applied to cards left
								ef2 = moveTarget(centerRow), -- effect to be applied to sorted cards
								header = "", -- prompt header
								description = "Sacrifice the top 3 cards of the market deck. Choose 1 for Stone of Laughing Shadow to become a copy of this turn.",
								rightPileDesc = "Right card to copy.",
								pile1Name = "Sacrifice",
								pile2Name = "Copy then Sacrifice",
								eff1Tags = { buytopdeckTag },
								eff2Tags = { cheapestTag }
})),
				cost = combineCosts({expendCost, goldCost(1)}),
            }),
        }
        
    })
end

-- Reliquary
function tooth_of_ingarash_carddef_carddef()
    return createDef(
        {
            id = "tooth_of_ingarash_carddef",
            name = "Tooth of Ingarash",
			types = {itemType},
			factions = { wildFaction },
			acquireCost = 6,
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "tooth_of_ingarash_carddef_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(selectLoc(loc(currentPid, discardPloc).count()))
						.seq(drawCardsEffect(1))
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Tooth of Ingarash",
                    art = "art/t_skeleton_green",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="10">
        <tmpro text="Gain {combat} equal to the number of cards in your discard pile.

Draw a card."  fontsize="20"/>
    </box>
    <hlayout flexibleheight="1">
    </hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function shard_of_slaughterclaw_carddef_carddef()
    return createDef(
        {
            id = "shard_of_slaughterclaw_carddef",
            name = "Shard of Slaughterclaw",
			types = {itemType},
			factions = { necrosFaction },
			acquireCost = 6,
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "shard_of_slaughterclaw_carddef_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = moveTarget(revealPloc).apply(selectLoc(tradeDeckLoc)).take(3)
							.seq(gainCombatEffect(selectLoc(loc(revealPloc)).sum(getCardCost())))
							.seq(sacrificeTarget(selectLoc(loc(revealPloc))))
						
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Shard of Slaughterclaw",
                    art = "art/t_skeleton",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="10">
        <tmpro text="Sacrifice the top 3 cards of the market deck.
Gain {combat} equal to the total cost of those cards."  fontsize="20"/>
    </box>
    <hlayout flexibleheight="1">
    </hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function steel_of_karakan_carddef_carddef()
    return createDef(
        {
            id = "steel_of_karakan_carddef",
            name = "Steel of Karakan",
			types = {itemType},
			factions = { necrosFaction },
			acquireCost = 6,
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "steel_of_karakan_carddef_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = moveTarget(revealPloc).apply(selectLoc(tradeDeckLoc)).take(4)
							.seq(gainHealthEffect(selectLoc(loc(revealPloc)).sum(getCardCost())))
							.seq(sacrificeTarget(selectLoc(loc(revealPloc))))
						
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Steel of Karakan",
                    art = "art/t_thief_sacrificial_dagger",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="10">
        <tmpro text="Sacrifice the top 4 cards of the market deck.
Gain {health} equal to the total cost of those cards."  fontsize="20"/>
    </box>
    <hlayout flexibleheight="1">
    </hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

--Stone of LS - NOT FINISHED
function stone_of_laughing_shadow_carddef_carddef()
    return createDef(
        {
            id = "stone_of_laughing_shadow_carddef",
            name = "Stone of Laughing Shadow",
			types = {itemType},
			factions = { necrosFaction },
			acquireCost = 6,
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "stone_of_laughing_shadow_carddef_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = moveTarget(myRevealPloc).apply(selectLoc(tradeDeckLoc)).take(3)
						.seq(promptSplit({
								selector = selectLoc(currentRevealLoc),
								take = const(1), -- number of cards to take for split
								sort = const(1), -- number of cards to be sorted for ef2
								minTake = const(1), -- number of mandatory cards moved to ef2
								ef1 = sacrificeTarget(true, 1), -- effect to be applied to cards left
								ef2 = moveToBottomDeckTarget(true, 1), -- effect to be applied to sorted cards
								header = "", -- prompt header
								description = "Sacrifice the top 3 cards of the market deck. Choose 1 for Stone of Laughing Shadow to become a copy of this turn.",
								rightPileDesc = "Right card to copy.",
								pile1Name = "Sacrifice",
								pile2Name = "Copy then Sacrifice",
								eff1Tags = { buytopdeckTag },
								eff2Tags = { cheapestTag }
}))
							.seq(gainHealthEffect(selectLoc(loc(revealPloc)).sum(getCardCost())))
							.seq(sacrificeTarget(selectLoc(loc(revealPloc))))
						
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Stone of Laughing Shadow",
                    art = "art/t_shadow_spell_09_blue",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="10">
        <tmpro text="Sacrifice the top 3 cards of the market deck. This card becomes a copy of one of those cards (your choice) until the end of your turn. It is still a {guild} card in addition to the copied card's faction."  fontsize="19"/>
    </box>
    <hlayout flexibleheight="1">
    </hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function malvan_s_staff_carddef_carddef()
    return createDef(
        {
            id = "malvan_s_staff_carddef",
            name = "Malvan's Staff",
			types = {itemType},
			factions = { wildFaction },
			acquireCost = 3,
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {createAbility(
                    {
                        id = "malvan_draw",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
						effect = drawCardsEffect(1)
						
                    }
                ),
				
				createAbility({
				  id = "malvan_imperial",
				  trigger = autoTrigger, 
				  cost = noCost,
				  activations = singleActivation,
				  effect = gainHealthEffect(3),
				  allyFactions = {imperialFaction}
				}),
                
				createAbility({
				  id = "malvan_necros",
				  trigger = autoTrigger, 
				  cost = noCost,
				  activations = singleActivation,
				  effect = gainCombatEffect(2),
				  allyFactions = {necrosFaction}
				}),
				createAbility({
				  id = "malvan_wild",
				  trigger = autoTrigger, 
				  cost = noCost,
				  activations = singleActivation,
				  effect = drawCardsEffect(1).seq(forceDiscardEffect(1)),
				  allyFactions = {wildFaction}
				}),
				createAbility({
				  id = "malvan_guild",
				  trigger = autoTrigger, 
				  cost = noCost,
				  activations = singleActivation,
				  effect = gainGoldEffect(2),
				  allyFactions = {guildFaction}
				}),
            },
            layout = createLayout(
                {
                    name = "Malvan's Staff",
                    art = "art/t_wizard_serpentine_staff",
                    frame = "frames/HR_CardFrame_Action_Wild",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="10">
        <tmpro text="Sacrifice the top 3 cards of the market deck. This card becomes a copy of one of those cards (your choice) until the end of your turn. It is still a {guild} card in addition to the copied card's faction."  fontsize="19"/>
    </box>
    <hlayout flexibleheight="1">
    </hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

--Sorceror's Tower

local sorcTowerbuff = createGlobalBuff({
        id="sorcTowerbuff",
        name = "Sorceror's Tower",
        abilities = {createAbility({
        id = "sorc_tower_buff",
        layout = loadLayoutData("layouts/base/wizard_arcane_wand"),
        effect = drawCardsWithAnimation(1)
                .seq(gainCombatEffect(selectLoc(currentCastLoc).where(isCardType(spellType).Or(isCardType(curseType))).count())),
        cost = noCost,
        trigger = onPlayTrigger,
        playAllType = playFirstPlayType,
        tags = {draw1Tag},
        aiPriority = toIntExpression(300)
    })},
		createCardEffectAbility = createCardEffectAbility(
            {
                trigger = locationChangedCardTrigger,
                effect = e.Filtered(selectLoc(currentCastLoc).where(isCardType(spellType).Or(isCardType(curseType))), ignoreTarget(gainCombatEffect(selectTargets().sum(const(1)))))
            }
    ),
		buffDetails = createBuffDetails({
					name = "Sorceror's Tower",
                    art = "art/t_calm_channel",
					text = "<size=70%>Setup: Champions with the 'Mage' tag get +1{shield}. On turn: When you play an Action with the 'Spell' or 'Curse' tag that costs 1{gold} or more, gain {combat_1}."
							})
    })



function choose_scorcerors_tower_carddef()
    return createDef({
        id="choose_scorcerors_tower",
        name="The Scorceror's Tower",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_scorcerors_tower",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = singleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(grantHealthTarget(1, { SlotExpireEnum.never }, nullEffect(), "Gaze upon my power.").apply(selectLoc(tradeDeckLoc).where(isCardType(mageType))))
								.seq(createCardEffect(sorcTowerbuff, loc(currentPid, buffsPloc)))
								.seq(createCardEffect(sorcTowerbuff, loc(oppPid, buffsPloc)))
								
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "The Scorceror's Tower",
            art = "art/t_calm_channel",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Setup: Champions with the 'Mage' tag get +1{shield}.

On turn: When you play an Action with the 'Spell' or 'Curse' tag that costs 1{gold} or more, gain {combat_1}." fontsize="20" alignment="left"/>
    </box>
</vlayout>
			]]
			}),
        })
	end


--[[   local scorcerors_tower_Buff = createGlobalBuff({
        id="scorcerors_tower_Buff",
        name = "Scorceror's Tower",
        abilities = {
            createAbility({
                id="scorcerors_tower_Action_Buff",
                trigger = startOfTurnTrigger,
                effect = gainCombatEffect(selectLoc(loc(currentPid, castPloc)).where(isCardType("spellType").Or(isCardType("curseType")).And(getCardCost().gte(1))).count())
				
            })

        },
		buffDetails = createBuffDetails({
					name = "Scorceror's Tower",
                    art = "art/t_calm_channel",
					text = "When you play an Action with the 'Spell' or 'Curse' tag that costs 1{gold} or more, gain {combat_1}"
							})
    })
]]



--Fight Club - NOT WORKING
function fightClubBuffDef()

local fightClubPriceBuff = getCostDiscountBuff("Fight Club", -2, selectLoc(centerRowLoc).where(isCardType(warriorType)))

    return createGlobalBuff({
        id="fightClub",
        name = "Fight Club",
        abilities = {
            createAbility({
                id="fightClubPriceBuff",
                trigger = startOfTurnTrigger,
                effect = createCardEffect(fightClubPriceBuff, loc(currentPid, buffsPloc))
			})
        },
		buffDetails = createBuffDetails({
					name = "Fight Club",
                    art = "art/T_shoulder_crush",
					text = "<size=80%>Setup: All 'Warrior' champions cost +{gold_2} to buy, but can prepare for free once per turn."
					})  
	})
end	
	
function choose_fight_club_carddef()


local ab = createAbility({
    id = "expendio",
    effect = prepareTarget().apply(selectSource()),
    cost = noCost,
    check = selectSource().where(isCardExpended()).count().eq(1),
    trigger = autoTrigger,
    activations = singleActivation,
    tags = {  }
})

    return createDef({
        id="choose_fight_club",
        name="Fight Club",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_fight_club",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))			
								.seq(addSlotToTarget(createAbilitySlot({
														ability = ab,
														expiry = { neverExpiry },
														displayText = "Can prepares once for free each turn.",
													})).apply(selectLoc(tradeDeckLoc).where(isCardChampion().And(isCardType(warriorType)))))
								
								.seq(createCardEffect(fightClubBuffDef(), loc(currentPid, buffsPloc)))
								.seq(createCardEffect(fightClubBuffDef(), loc(oppPid, buffsPloc)))
								
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "Fight Club",
            art = "art/T_shoulder_crush",
			frame = "frames/generic_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Setup:
All 'Warrior' champions cost +{gold_2} to buy, but can prepare for free once each turn." fontsize="20" alignment="left"/>
    </box>
</vlayout>
			]]
			}),
        })
	end



-- Colosseum
local colosseumbuff = createGlobalBuff({
        id="colosseumbuff",
        name = "The Colosseum",
        abilities = {
            createAbility({
                id="colosseumbuff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "The Colosseum",
                    art = "art/epicart/lord_of_the_arena",
					text = "<size=80%>Setup: All market champions start with +3<sprite name=\"shield\"> permanently. On Turn: +<sprite name=\"combat_2\"> each time you play a champion with a cost."
							})
    })
	
function choose_colosseum_carddef()
    return createDef({
        id="choose_colosseum",
        name="Colosseum",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_colosseum",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(grantHealthTarget(3, { SlotExpireEnum.never }, nullEffect(), "To those about to die...").apply(selectLoc(tradeDeckLoc).where(isCardChampion())))								
															
								.seq(addSlotToTarget(createAbilitySlot({
														ability = createAbility({
															id = "Colosseum",
															effect = gainCombatEffect(2),
															trigger = onPlayTrigger
														}),
														expiry = { neverExpiry },
														displayText = "+1 Combat on play",
													})).apply(selectLoc(tradeDeckLoc).where(isCardChampion())))
								
								.seq(createCardEffect(colosseumbuff , loc(currentPid, buffsPloc)))
								.seq(createCardEffect(colosseumbuff , loc(oppPid, buffsPloc)))
								
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "Colosseum",
            art = "art/epicart/lord_of_the_arena",
			frame = "frames/generic_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Setup: All market champions start with +3{shield} permanently.

On turn: +{combat_2} when you play a champion with a cost." fontsize="20" alignment="left"/>
    </box>
</vlayout>
			]]
			}),
        })
	end


-- Opera House
    local operaHousebuff = createGlobalBuff({
        id="operaHousebuff",
        name = "Opera House",
        abilities = {
            createAbility({
                id="operaHousebuff",
				trigger = startOfTurnTrigger,
                effect = ifElseEffect(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_bold_saga")).count().eq(0), createCardEffect(bard_bold_saga_carddef(), loc(currentPid, skillsPloc)), nullEffect()),
			
            })
        },
		buffDetails = createBuffDetails({
					name = "Opera House",
                    art = "art/classes/bard/bard_bold_saga",
					text = "<size=80%>On your turn gain a Bold Saga ability (if you do not already have one)."
							})
    })

function choose_operaHouse_carddef()
    return createDef({
        id="choose_operaHouse",
        name="Opera House",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_operaHouse",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = singleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(operaHousebuff, loc(currentPid, buffsPloc)))
								.seq(createCardEffect(operaHousebuff, loc(oppPid, buffsPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(storyTellEffectWithPortrait("bard_02", "La la la!"))
								.seq(waitForClickEffect("The Bard's songs draw a crowd. Don't just let them stand around - recruit them to your cause.", ""))
								
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "Opera House",
            art = "art/classes/bard/bard_bold_saga",
			frame = "frames/generic_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="On your turn gain a Bold Saga ability (if you do not already have one)." fontsize="24"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

--Zombie Horde
 function zombiehordebuff()
 return createGlobalBuff({
        id="zombiehordebuff",
        name = "Zombie Apocalypse",
        abilities = {
            createAbility({
                id="zombiehordebuff",
				trigger = startOfTurnTrigger,
				check = getTurnsPlayed(currentPid).gte(2),
                effect = createCardEffect(zombiehorde_carddef(), loc(oppPid, inPlayPloc))
				.seq(createCardEffect(zombiehorde_carddef(), loc(oppPid, inPlayPloc)))
					.seq(hitSelfEffect(selectLoc(loc(oppPid, inPlayPloc)).where(isCardName("zombiehorde")).count()))
            })
        },
		buffDetails = createBuffDetails({
					name = "Zombie Apocalypse",
                    art = "art/epicart/zombie_token",
					text = "<size=80%>On your turn 2 Zombie Hordes appear and attack you. At end of turn, all Zombie Hordes change side."
							})
    })
end

function choose_zombiehorde_carddef()
    return createDef({
        id="choose_zombiehorde",
        name="Zombie Apocalypse",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
                createAbility(
                    {
                        id = "choose_zombiehorde",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = singleActivations,
                        effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))
								.seq(sacrificeTarget().apply(selectSource()))
								.seq(createCardEffect(zombiehordebuff(), loc(currentPid, buffsPloc)))
								.seq(createCardEffect(zombiehordebuff(), loc(oppPid, buffsPloc)))
								
								.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
								.seq(shuffleTradeDeckEffect())
								.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
								.seq(addEffect(endTurnEffect())),

								
                    }
                )
            },
        layout = createLayout({
            name = "Zombie Apocalypse",
            art = "art/epicart/zombie_token",
			frame = "frames/generic_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="On turn: Two Zombie Horde cards will spawn on your opponent's side. All Zombie Hordes then deal you 1 damage.

End of turn: The Zombie Horde moves to your side." fontsize="18" alignment="left"/>
    </box>
</vlayout>
			]]
			}),
        })
	end


function zombiehorde_carddef()
    return createChampionDef(
        {
            id = "zombiehorde",
            name = "Zombie Horde",
			types = {championType, nosteaalType,},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "zombiehorde_main",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = moveTarget(loc(oppPid, inPlayPloc)).apply(selectSource())
						
                    }
                ),
				--self-sac ability
                createAbility(
                    {
                        id = "zombiehorde_sac",
                        trigger = onStunTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Zombie Horde",
                    art = "art/epicart/zombie_token",
                    frame = "frames/generic_cardframe",
                    xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="Deal 1 damage directly to your opponent.

Will change side at end of turn and attack you next." fontsize="22" alignment="left"/>
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

--[[function zombiehordeBuff()
    return createGlobalBuff({
        id="zombiehordeBuff",
        name = "Zombie Horde",
        abilities = {
            createAbility({
                id="zombiehordeBuff",
                trigger = startOfTurnTrigger,
                effect = createCardEffect(zombiehorde_carddef(), loc(oppPid, inPlayPloc))
				.seq(createCardEffect(zombiehorde_carddef(), loc(oppPid, inPlayPloc)))
					.seq(hitSelfEffect(geCardName(zombiehorde).count()))				
			})
        }   
	})
end

function endGame(g)
end]]

-- Auxiliary effects
local function goFirstEffect()
-- this is a dirty hack to make player going first only draw three cards for their first turn. Feel free to replace it with a better implementation.
	return createGlobalBuff({
        id="draw_three_start_buff",
        name = "Go First",
        abilities = {
            createAbility({
                id="go_first_draw_effect",
                trigger = endOfTurnTrigger,
                effect = ifElseEffect(
					getTurnsPlayed(oppPid).eq(1),
					nullEffect(),
					drawCardsEffect(2)
				)
            })
        }
    })
end

function setupGame(g)
    registerCards(
        g,
        {
		choose_supply_cache_carddef(),
		choose_armoury_carddef(),
		choose_apothecary_carddef(),
			ST_apothecary_elixir_of_endurance_carddef(),
			ST_apothecary_elixir_of_fortune_carddef(),
			ST_apothecary_elixir_of_strength_carddef(),
			ST_apothecary_elixir_of_wisdom_carddef(),
			ST_apothecary_elixir_of_concentration_carddef(),
		choose_crypt_carddef(),
			lich_abomination_minion_carddef(),
			lich_banshee_minion_carddef(),
			lich_ghoul_minion_carddef(),
			lich_revenant_minion_carddef(),
			lich_skeleton_horde_minion_carddef(),
			lich_wall_of_bones_minion_carddef(),
			lich_wall_of_fire_minion_carddef(),
			lich_zombie_minion_carddef(),
		choose_scorcerors_tower_carddef(),
		choose_smugglers_den_carddef(),
			stashskill_carddef(),
			--smuggleskill_carddef(),
		choose_beast_pit_carddef(),
			beast_within_carddef(),
		choose_great_hall_carddef(),
			ST_poison_carddef(),
		choose_colosseum_carddef(),
		choose_investment_bank_carddef(),
			ST_IB_diamond_carddef(),
			jewelofthandarlore_carddef(),
		
		choose_alchemist_lab_carddef(),
		choose_sheild_bearers_hall_carddef(),
			shieldbearertoken_carddef(),
			seasonedshieldbearertoken_carddef(),
		choose_zombiehorde_carddef(),
			zombiehorde_carddef(),
					
			ST_tasty_meal_carddef(),
			ST_shopkeeper_s_keys_carddef(),
			
			
			--shard_of_slaughterclaw_carddef(),
			--stone_of_laughing_shadow_carddef(),
			--tooth_of_ingarash_carddef(),
			--steel_of_karakan_carddef(),
			--malvan_s_staff_carddef(),
		
        }
    )

    standardSetup(
        g,
        {
            description = "Script by Aarkenell. Battlefields ideas by Marauder Mo, Birdlaw and Aarkenell. Created 14.10.2024.",
             playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
		centerRow = { --[["demon_hunter"]] },

		tradeDeckExceptions = {			
        },
        players = {
            {
                id = plid1,
                startDraw = 0,
                init = {
                    fromEnv = plid1
                },
                cards = {
                    buffs = {
						drawCardsCountAtTurnEndDef(3),
						goFirstEffect(),
                        discardCardsAtTurnStartDef(),
						fatigueCount(42, 1, "FatigueP2"),
						P1_chooseBattlefieldBuff()
                    }
                }
            },
            {
                id = plid2,
                startDraw = 0,
				init = {
                    fromEnv = plid2
                },
                cards = {
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						fatigueCount(42, 1, "FatigueP2"),
						P2_chooseInfoBuff()
                    }
                }
            }            
        }
    })
end



function endGame(g)
end


function setupMeta(meta)
    meta.name = "tester 2"
    meta.minLevel = 1
    meta.maxLevel = 5
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/tester 2.lua"
     meta.features = {
}

end