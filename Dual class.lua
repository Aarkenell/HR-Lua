require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

--=======================================================================================================
-- This is a proof of concept script to be able to play a custom class at any level without needing
-- to remember what level to send a challenge. 


--=======================================================================================================
-- simple choice effect, showing two layouts and executing selected one, triggers at the game start
local function chooseTheClass()

	local ef_learn_levels = leftStoryTellEffectWithPortrait("ambushers", "Because of this, it is recommended you play this mod with characters at level 5 or higher, as this is when the secondary skill is granted.")
		.seq(leftStoryTellEffectWithPortrait("ambushers", "Whatever level you choose to play at though, I hope you enjoy the chaos...err.. I mean fun, of the Dual-class experience."))
		.seq(pushChoiceEffect({
							choices = {
								{
                                effect = nullEffect(),
                                layout = createLayout({
									name = "Return to Select Card Packs",
									art = "avatars/ambushers",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
<vlayout  forceheight="true">
<tmpro text="Select 'Undo' to return to top menu, then select 'Choose a Dual Class'." fontsize="28" />
</vlayout>
                                    ]],
                                }),
                            
                            },
							}}))

	local RandomWiz = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomThief = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomRanger = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomFighter = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomCleric = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomBard = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomBarb = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomAlch = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomMonk = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
				})

	local RandomDruid = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomNecro = randomEffect({
					valueItem(1, createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

    return cardChoiceSelectorEffect({
        id = "SoG_Choice",
        name = "First choice",
        trigger = startOfTurnTrigger,

        upperTitle  = "Welcome! How would you like to proceed?",
        lowerTitle  = "",
-- 1. choose and play
        effectFirst= pushChoiceEffectWithTitle(
                                {
								
                                    choices = {  
								-- Choice 1.1: Choose dual
                                        {
                                            effect =  moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(clericType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_cleric_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(fighterType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_fighter_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(rangerType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_ranger_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(thiefType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_thief_carddef(), loc(currentPid, handPloc))))
        .seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(wizardType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_wizard_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(alchemistType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_alchemist_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(barbarianType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_barbarian_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(bardType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_bard_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(druidType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_druid_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(monkType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_monk_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(necromancerType)).count().gte(1),nullEffect(),createCardEffect(ST_TG_choose_necromancer_carddef(), loc(currentPid, handPloc)))),

											layout = layoutCard(
                                                {
                                                    title = "Dual Class",
													art = "art/T_Storm_Siregar",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Pick your
secondary class
and get playing." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
								-- Choice 1.2 - Random selection
                                        {
                                             effect =  storyTellEffectWithPortrait("journeys/fettered_imp", "Allow me to assist you.")
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(clericType)).count().gte(1),addEffect(RandomCleric),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(fighterType)).count().gte(1),addEffect(RandomFighter),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(rangerType)).count().gte(1),addEffect(RandomRanger),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(thiefType)).count().gte(1),addEffect(RandomThief),nullEffect()))
        .seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(wizardType)).count().gte(1),addEffect(RandomWiz),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(alchemistType)).count().gte(1),addEffect(RandomAlch),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(barbarianType)).count().gte(1),addEffect(RandomBarb),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(bardType)).count().gte(1),addEffect(RandomBard),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(druidType)).count().gte(1),addEffect(RandomDruid),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(monkType)).count().gte(1),addEffect(RandomMonk),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(necromancerType)).count().gte(1),addEffect(RandomNecro),nullEffect()))
		,
                                            layout = layoutCard(
                                                {
                                                    title = "Select Randomly",
													art = "avatars/journeys/fettered_imp",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Have your dual-class chosen by one of our highly-trained AI demons." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                                                                    },
										
                                    },
					
        upperTitle  = "Choose yourself or let our AI Imp decide.",
        lowerTitle  = "",

					}),

-- 1.2 choice		
		effectSecond = waitForClickEffect("After years of competition and arguing between the various Guilds and Schools in Thandar...", "")
		.seq(waitForClickEffect("...the Emperor decreed that they should open their doors to each other...", ""))
		.seq(waitForClickEffect("...so that the Heroes of the Realm could learn new skills and diversify their battle tactics.", ""))
		
.seq(leftStoryTellEffectWithPortrait("ambushers", "Welcome to the Dual-class mod!"))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "This mod allows you to choose a second class to utilise alongside that of your hero."))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "Selecting a secondary class will do a number of things."))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "For most classes, one Gold in your starting deck will be replaced with an economy card from your new secondary class."))
  .seq(leftStoryTellEffectWithPortrait("ambushers", "And, for most classes, another card from your secondary class will be added to your deck."))
   .seq(leftStoryTellEffectWithPortrait("ambushers", "There are some exceptions, including some classes that get 2 cards added, on top of the change to a gold."))
    .seq(leftStoryTellEffectWithPortrait("ambushers", "The exact changes to each secondary class are listed on each of the cards for selecting that class as your Dual-class."))
	 .seq(leftStoryTellEffectWithPortrait("ambushers", "Lastly, new skills, abilities and cards will be added depending on your Hero Level."))
	 .seq(leftStoryTellEffectWithPortrait("ambushers", "These are not listed on the cards, but we'll show you them here."))
	 .seq(leftStoryTellEffectWithPortrait("ambushers", "Here's how upgrades work..."))
.seq(pushChoiceEffectWithTitle(
                                {
								
                                    choices = {  
								-- 1.2a Gold cahnge & add cards					
										{
                                           effect = ef_learn_levels,
        
            layout = createLayout({
            name = "Deck Changes",
            art = "art/epicart/arm",
            xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="
Dual-class selection:
-Replaces a Gold with a new economy card. E.g. Spell Components or Horn of Calling.
-Adds an extra card to your deck. This is the card that upgrades at level 15 (e.g. Cat Familiar).
" fontsize="18" alignment="left"/>
</hlayout>
</vlayout>		
			]]
			}),
                                            tags = {}
                                        },
										-- 1.2b Exceptions					
										{
                                           effect = ef_learn_levels,
        
            layout = createLayout({
            name = "Exceptions to Deck Changes",
            art = "art/epicart/arm",
            xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="
Exceptions:
Fighter: Gold is not replaced.
Monk: Replace 2 Gold with
	2 Spring Blossom.
Ranger: Add 2 cards - Hunting
	Bow and Black Arrow.
Thief: Add 2 Throwing Knives
" fontsize="18" alignment="left"/>
</hlayout>
</vlayout>	
			]]
			}),
                                            tags = {}
                                        },
								-- 1.2c Level prog 1
										{
                                           effect = ef_learn_levels,
                                            layout = createLayout({
            name = "Level Progression",
            art = "art/epicart/halt_",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="
Level 1: Ability, level 1.
Level 3: Ability, level 2. 
Level 5: Skill, level 1. 
Level 7: Ability, level 3. 
Level 9: Skill, level 2. 
Level 11: Add one of the two level
	7 cards to your deck.
Level 13: Ability, level 4.
" fontsize="18" alignment="left"/>
</hlayout>
</vlayout>	
			]] }),
                                            tags = {}
                                        },
										  		
								-- 1.2d Level prog 2
										{
                                           effect = ef_learn_levels,
                                            layout = createLayout({
            name = "Level Progression cont.",
            art = "art/epicart/halt_",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="
Level 15: Gain a level 9 Armour. 
Level 17: Add one of the two level
	11 cards to your deck. 
Level 19: Skill, level 3. 
Level 21: Ability, level 5. 
Level 23: Gain a level 15 upgrade
	e.g. Cat Familiar, Spiked
	Mace or Longsword. 
" fontsize="18" alignment="left"/>
</hlayout>
</vlayout>
			]] }),
                                            tags = {}
                                        }
                                    
                                    },
					
        upperTitle  = "When done, click any card to continue.",
        lowerTitle  = "",

					})),	 
	 

                            


-- 1.1 layout
         layoutFirst = createLayout({
            name = "Choose a Dual Class",
            art = "art/T_Storm_Siregar",
			frame = "frames/generic_CardFrame",
            xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Pick your
secondary class
and get playing." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
			]] }),

-- 1.2 layout
        layoutSecond = createLayout({
            name = "Learn about the mod",
            art = "art/treasures/T_Magic_Scroll_Souveraine",
			frame = "frames/generic_CardFrame",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Learn how this mod changes the game and what upgrades you'll receive based on your Hero Level." fontsize="26"/>
</hlayout>
</vlayout>			
			]]
			}),

        turn = 1
    })
end



local function goFirstEffect()
	return createGlobalBuff({
        id="draw_three_start_buff",
        name = "Go First",
        abilities = {
            createAbility({
                id="go_first_draw_effect",
                trigger = endOfTurnTrigger,
                effect = ElseEffect(
					getTurnsPlayed(oppPid).eq(1),
					nullEffectif(),
					drawCardsEffect(2)
				)
            })
        }
    })
end

--=======================================================================================================
function setupGame(g)
	registerCards(g, {
	})

    standardSetup(g, {
        description = "Dual-class Heroes - by Aarkenell (utilising WardenSlayer's Balanced Random Script). Updated 31.10.2024",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                -- isAi = true,
                startDraw = 0,
				init = {
                    fromEnv = plid1
                },
                cards = {
					buffs = {
						chooseTheClass(),
						drawCardsCountAtTurnEndDef(5),
						discardCardsAtTurnStartDef(),
						fatigueCount(42, 1, "FatigueP1"),
					}
                }
            },
            {
                id = plid2,
                isAi = false,
                startDraw = 0,
				init = {
                    fromEnv = plid2
                },
                cards = {
					buffs = {
						chooseTheClass(),
						drawCardsCountAtTurnEndDef(5),
						discardCardsAtTurnStartDef(),
						fatigueCount(42, 1, "FatigueP2"),
					}
                }
            },            
        }
    })
end

function endGame(g)
end

-- Created by WardenSlayer


function setupMeta(meta)
    meta.name = "wardenslayer_level_agnostic"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/WardenSlayer/wardenslayer_level_agnostic.lua"
     meta.features = {
}

end


-- Buff to disable skills after first used each turn
-- from Randomnoob, based on buff to turn off second abilityType
--[[ It checks if there's non ancestry ability in sacrifice location and disables ability left until end of turn
not sure it will work for your case
yet you might make a custom trigger which fires when either skill is activated and a have an ability listening to that trigger on both skills. When it triggers - put disable buff on the skill
]]

--[[function disableSkillsBuff()
    return createGlobalBuff({
        id = "disable_skills_buff",
        name = "Disable Skills",
        abilities = {
            createAbility({
                id = "disable_skills_buff_ability",
                trigger = onSacrificeGlobalTrigger,
                effect = disableTarget({ endOfTurnExpiry }).apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardType(abilityType).And(isCardType(ancestryType).invert())))
                            .seq(sacrificeSelf()),
                check = selectLoc(loc(currentPid, skillSacrificePloc)).where(isCardType(abilityType).And(isCardType(ancestryType).invert())).count().gte(1),
            })
        }
    })
end]]

------
function ST_TG_choose_wizard_carddef()
    return createDef(
        {
            id = "ST_TG_choose_wizard",
            name = "Dual-class Wizard",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_wizard",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualWizard", expiry = { Never } }))
						.seq(createCardEffect(dualWizardBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Wizard",
                    art = "avatars/wizard_01",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Spell Components.

Add a Cat Familiar." fontsize="20"/>
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

function ST_TG_choose_cleric_carddef()
    return createDef(
        {
            id = "ST_TG_choose_cleric",
            name = "Dual-class Cleric",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "ST_TG_choose_cleric",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualcleric", expiry = { Never } }))
						.seq(createCardEffect(dualclericBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Cleric",
                    art = "avatars/cleric_02",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Spiked Mace.

Add a Follower." fontsize="20"/>
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

function ST_TG_choose_fighter_carddef()
    return createDef(
        {
            id = "ST_TG_choose_fighter",
            name = "Dual-class Fighter",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "ST_TG_choose_fighter",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualfighter", expiry = { Never } }))
						.seq(createCardEffect(dualFighterBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Fighter",
                    art = "avatars/fighter_01",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Add a Longsword." fontsize="20"/>
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

function ST_TG_choose_thief_carddef()
    return createDef(
        {
            id = "ST_TG_choose_thief",
            name = "Dual-class Thief",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_thief",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualthief", expiry = { Never } }))
						.seq(createCardEffect(dualThiefBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Thief",
                    art = "avatars/thief_01",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with a Ruby.

Add 2 Throwing Knives." fontsize="20"/>
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

function ST_TG_choose_ranger_carddef()

    return createDef(
        {
            id = "ST_TG_choose_ranger",
            name = "Dual-class ranger",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "ST_TG_choose_ranger",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualranger", expiry = { Never } }))
						.seq(createCardEffect(dualrangerBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Ranger",
                    art = "avatars/ranger_02",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Horn of Calling.

Add a Hunting Bow
and a Black Arrow." fontsize="20"/>
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

function ST_TG_choose_bard_carddef()
    return createDef(
        {
            id = "ST_TG_choose_bard",
            name = "Dual-class Bard",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_bard",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualbard", expiry = { Never } }))
						.seq(createCardEffect(dualbardBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Bard",
                    art = "avatars/bard_01",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold with either
Song of the Wild, Guild Tale,
or Imperial Anthem.

Add a Harp." fontsize="20"/>
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

function ST_TG_choose_druid_carddef()
    return createDef(
        {
            id = "ST_TG_choose_druid",
            name = "Dual-class Druid",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_druid",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualdruid", expiry = { Never } }))
						.seq(createCardEffect(dualdruidBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class druid",
                    art = "avatars/druid_01",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with a Squirrel.

Add a Fox." fontsize="20"/>
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

function ST_TG_choose_barbarian_carddef()
    return createDef(
        {
            id = "ST_TG_choose_barbarian",
            name = "Dual-class Barbarian",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_barbarian",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualbarbarian", expiry = { Never } }))
						.seq(createCardEffect(dualbarbarianBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class barbarian",
                    art = "avatars/barbarian_01",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Plunder.

Add Headbutt." fontsize="20"/>
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

function ST_TG_choose_monk_carddef()
    return createDef(
        {
            id = "ST_TG_choose_monk",
            name = "Dual-class Monk",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_monk",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualmonk", expiry = { Never } }))
						.seq(createCardEffect(dualmonkBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Monk",
                    art = "avatars/monk_02",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace 2 gold
with 2 Spring Blossoms.

Add either
Cobra Fang or Serene Wind." fontsize="20"/>
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

function ST_TG_choose_alchemist_carddef()
    return createDef(
        {
            id = "ST_TG_choose_alchemist",
            name = "Dual-class Alchemist",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_alchemist",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualalchemist", expiry = { Never } }))
						.seq(createCardEffect(dualalchemistBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Alchemist",
                    art = "avatars/alchemist_02",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Philosopher's Stone.

Add another
Philosopher's Stone." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>					]],

                }
            )
        }
    )
end

function ST_TG_choose_necromancer_carddef()
    return createDef(
        {
            id = "ST_TG_choose_necromancer",
            name = "Dual-class Necromancer",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_necromancer",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "dualnecromancer", expiry = { Never } }))
						.seq(createCardEffect(dualnecromancerBuffDef(), loc(currentPid, buffsPloc)))
						.seq(sacrificeTarget().apply(selectSource()))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Necromancer",
                    art = "avatars/necromancer_01",
                    frame = "frames/generic_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Soul Prism.

Add Rod of Unlife." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>				]],

                }
            )
        }
    )
end


--=======================================================================================================
--Buffs
function dualWizardBuffDef()
	--
	local name = "Dual Wizard"
	local ef1_Wizard = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("wizard_spell_components").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(wizard_cat_familiar_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(wizard_flame_burst_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_Wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_flame_burst")))
				.seq(createCardEffect(wizard_fire_blast_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_Wizard = createCardEffect(wizard_channel_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_Wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_fire_blast")))
					.seq(createCardEffect(wizard_fireball_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_Wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_channel")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_calm_channel_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_deep_channel_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_Wizard = randomEffect({
					valueItem(1, createCardEffect(wizard_arcane_wand_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(wizard_silverskull_amulet_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_Wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_fireball")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_rolling_fireball_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_scorching_fireball_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_Wizard = randomEffect({
					valueItem(1, createCardEffect(wizard_runic_robes_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_spellcaster_gloves_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_Wizard = randomEffect({
					valueItem(1, createCardEffect(wizard_magic_mirror_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(wizard_alchemist_s_stone_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_Wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_calm_channel").Or(isCardName("wizard_deep_channel"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_soul_channel_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_serene_channel_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_pure_channel_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_Wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_rolling_fireball").Or(isCardName("wizard_scorching_fireball"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_barreling_fireball_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(wizard_searing_fireball_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_explosive_fireball_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_Wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("wizard_cat_familiar")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_wizened_familiar_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(wizard_content_familiar_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_Wizard
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_Wizard
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_Wizard
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_Wizard
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_Wizard
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_Wizard
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_Wizard
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_Wizard
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_Wizard
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_Wizard
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_Wizard
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_Wizard
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualWizard"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualclericBuffDef()
	--
	local name = "Dual Cleric"
	local ef1_cleric = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("cleric_spiked_mace").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(cleric_follower_a_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(cleric_minor_resurrect_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_minor_resurrect")))
				.seq(createCardEffect(cleric_lesser_resurrect_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_cleric = createCardEffect(cleric_bless_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_lesser_resurrect")))
					.seq(createCardEffect(cleric_resurrect_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_bless")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_bless_of_iron_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_bless_of_heart_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_cleric = randomEffect({
					valueItem(1, createCardEffect(cleric_redeemed_ruinos_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(cleric_brightstar_shield_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_resurrect")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_holy_resurrect_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_battle_resurrect_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_cleric = randomEffect({
					valueItem(1, createCardEffect(cleric_phoenix_helm_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_shining_breastplate_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_cleric = randomEffect({
					valueItem(1, createCardEffect(cleric_hammer_of_light_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(cleric_talisman_of_renewal_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_bless_of_iron").Or(isCardName("cleric_bless_of_heart"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_bless_the_flock_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_bless_of_soul_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_bless_of_steel_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_holy_resurrect").Or(isCardName("cleric_battle_resurrect"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_divine_resurrect_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(cleric_mass_resurrect_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_righteous_resurrect_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("cleric_spiked_mace")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_spiked_mace_of_glory_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(cleric_spiked_mace_of_might_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_cleric
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_cleric
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_cleric
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_cleric
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_cleric
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_cleric
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_cleric
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_cleric
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_cleric
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_cleric
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_cleric
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_cleric
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualcleric"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualThiefBuffDef()
	--
	local name = "Dual thief"
	local ef1_thief = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("ruby").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(thief_throwing_knife_carddef(), loc(currentPid, asidePloc)))
				--Extra gold-transform for thief/ranger/bard?
				.seq(transformTarget("thief_throwing_knife").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(thief_pilfer_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_pilfer")))
				.seq(createCardEffect(thief_theft_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_thief = createCardEffect(thief_pickpocket_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_theft")))
					.seq(createCardEffect(thief_heist_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_pickpocket")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_sleight_of_hand_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_swipe_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_thief = randomEffect({
					valueItem(1, createCardEffect(thief_knife_belt_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(thief_sacrificial_dagger_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_heist")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_skillful_heist_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_timely_heist_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_thief = randomEffect({
					valueItem(1, createCardEffect(thief_shadow_mask_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_silent_boots_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_thief = randomEffect({
					valueItem(1, createCardEffect(thief_blackjack_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(thief_jewelers_loupe_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_sleight_of_hand").Or(isCardName("thief_swipe"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_distracted_exchange_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_misdirection_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_lift_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_skillful_heist").Or(isCardName("thief_timely_heist"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_masterful_heist_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(thief_practiced_heist_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_smooth_heist_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("ruby")).take(1))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_brilliant_ruby_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(thief_sharpened_ruby_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_thief
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_thief
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_thief
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_thief
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_thief
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_thief
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_thief
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_thief
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_thief
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_thief
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_thief
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_thief
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualthief"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualFighterBuffDef()
	--
	local name = "Dual Fighter"
	local ef1_fighter = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				--no gold substitute for fighter
				.seq(createCardEffect(fighter_longsword_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(fighter_precision_blow_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_precision_blow")))
				.seq(createCardEffect(fighter_powerful_blow_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_fighter = createCardEffect(fighter_shoulder_bash_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_powerful_blow")))
						.seq(createCardEffect(fighter_crushing_blow_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_shoulder_bash")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_knock_back_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_shoulder_smash_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_fighter = randomEffect({
					valueItem(1, createCardEffect(fighter_double_bladed_axe_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(fighter_jagged_spear_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_crushing_blow")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_smashing_blow_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_sweeping_blow_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_fighter = randomEffect({
					valueItem(1, createCardEffect(fighter_helm_of_fury_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_spiked_pauldrons_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_fighter = randomEffect({
					valueItem(1, createCardEffect(fighter_sharpening_stone_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(fighter_rallying_flag_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_knock_back").Or(isCardName("fighter_shoulder_smash"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_knock_down_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_group_tackle_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_shoulder_crush_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_smashing_blow").Or(isCardName("fighter_sweeping_blow"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_devastating_blow_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_mighty_blow_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_whirling_blow_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("fighter_longsword")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_flaming_longsword_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(fighter_lightning_longsword_carddef(), loc(currentPid, asidePloc)))
					}))


-- P1 draws 5 for fighter, even though only 3 for Wiz
	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="dual_fighter_class_buff",
        name = "Fighter Dual Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_fighter
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_fighter
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_fighter
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_fighter
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_fighter
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_fighter
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_fighter
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_fighter
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_fighter
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_fighter
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_fighter
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_fighter
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualfighter"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualrangerBuffDef()
	--
	local name = "Dual Ranger"
	local ef1_ranger = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("ranger_horn_of_calling").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(ranger_black_arrow_carddef(), loc(currentPid, asidePloc)))
				--Extra gold-transform for thief/ranger/bard?
				.seq(transformTarget("ranger_hunting_bow").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(ranger_steady_shot_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_steady_shot")))
				.seq(createCardEffect(ranger_well_placed_shot_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_ranger = createCardEffect(ranger_track_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_well_placed_shot")))
					.seq(createCardEffect(ranger_headshot_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_track")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_fast_track_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_careful_track_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_ranger = randomEffect({
					valueItem(1, createCardEffect(ranger_snake_pet_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(ranger_unending_quiver_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_headshot")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_twin_shot_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_quickshot_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_ranger = randomEffect({
					valueItem(1, createCardEffect(ranger_hunters_cloak_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_sureshot_bracer_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_ranger = randomEffect({
					valueItem(1, createCardEffect(ranger_pathfinder_compass_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(ranger_flashfire_arrow_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_fast_track").Or(isCardName("ranger_careful_track"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_flawless_track_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_instinctive_track_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_relentless_track_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_twin_shot").Or(isCardName("ranger_quickshot"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_longshot_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(ranger_snapshot_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_triple_shot_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("ranger_horn_of_calling")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_horn_of_need_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(ranger_horn_of_command_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_ranger
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_ranger
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_ranger
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_ranger
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_ranger
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_ranger
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_ranger
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_ranger
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_ranger
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_ranger
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_ranger
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_ranger
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualranger"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualbardBuffDef()
	--
	local name = "Dual bard"
	local ef1_bard = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("bard_harp").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_guild_tale_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_song_of_the_wild_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_imperial_anthem_carddef(), loc(currentPid, asidePloc)))
					}))
				.seq(createCardEffect(bard_brave_story_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_brave_story")))
				.seq(createCardEffect(bard_epic_poem_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_bard = createCardEffect(bard_moving_melody_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_epic_poem")))
					.seq(createCardEffect(bard_valiant_verse_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_moving_melody")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_rousing_ode_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_inspiring_tune_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_bard = randomEffect({
					valueItem(1, createCardEffect(bard_silencing_scepter_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_summoning_drum_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_valiant_verse")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_intrepid_tale_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_heroic_fable_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_bard = randomEffect({
					valueItem(1, createCardEffect(bard_collecting_cap_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_coat_of_encores_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_bard = randomEffect({
					valueItem(1, createCardEffect(bard_lute_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_goblet_of_whimsy_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_rousing_ode").Or(isCardName("bard_inspiring_tune"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_stirring_song_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_rally_hymn_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_battle_march_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_intrepid_tale").Or(isCardName("bard_heroic_fable"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_mythic_chronicle_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(bard_grand_legend_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_bold_saga_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("bard_harp")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_golden_harp_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_lullaby_harp_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_bard
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_bard
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_bard
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_bard
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_bard
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_bard
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_bard
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_bard
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_bard
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_bard
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_bard
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_bard
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbard"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualdruidBuffDef()
	--
	local name = "Dual Druid"
	local ef1_druid = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("druid_squirrel").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(druid_fox_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(druid_animal_strength_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_animal_strength")))
				.seq(createCardEffect(druid_bear_strength_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_druid = createCardEffect(druid_forest_rage_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_bear_strength")))
					.seq(createCardEffect(druid_bear_form_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_forest_rage")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_spirit_of_the_forest_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_forest_fury_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_druid = randomEffect({
					valueItem(1, createCardEffect(druid_owl_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(druid_heartwood_splinter_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_bear_form")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_spirit_bear_form_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_grizzly_form_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_druid = randomEffect({
					valueItem(1, createCardEffect(druid_circlet_of_flowers_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_grass_weave_sash_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_druid = randomEffect({
					valueItem(1, createCardEffect(druid_rabbit_carddef(), loc(currentPid, asidePloc)).seq(createCardEffect(druid_rabbit_carddef(), loc(currentPid, asidePloc)))),
					valueItem(1, createCardEffect(druid_ursine_rod_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_spirit_of_the_forest").Or(isCardName("druid_forest_fury"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_forest_vengeance_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_soul_of_the_forest_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_way_of_the_forest_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_spirit_bear_form").Or(isCardName("druid_grizzly_form"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_polar_bear_form_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_spirit_grizzly_form_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_pure_bear_form_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("druid_fox")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_feral_fox_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(druid_nimble_fox_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_druid
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_druid
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_druid
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_druid
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_druid
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_druid
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_druid
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_druid
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_druid
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_druid
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_druid
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_druid
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualdruid"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualbarbarianBuffDef()
	--
	local name = "Dual barbarian"
	local ef1_barbarian = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("barbarian_plunder").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(barbarian_headbutt_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(barbarian_growl_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_growl")))
				.seq(createCardEffect(barbarian_bellow_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_barbarian = createCardEffect(barbarian_inner_rage_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_bellow")))
					.seq(createCardEffect(barbarian_roar_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9 -- Skill 4
	local ef9_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_inner_rage")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_flaring_rage_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_smoldering_rage_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_barbarian = randomEffect({
					valueItem(1, createCardEffect(barbarian_flail_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(barbarian_wolf_companion_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_roar")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_terrifying_roar_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_battle_cry_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_barbarian = randomEffect({
					valueItem(1, createCardEffect(barbarian_razor_bracers_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_stomping_boots_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_barbarian = randomEffect({
					valueItem(1, createCardEffect(barbarian_bone_axe_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(barbarian_crushed_coin_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_flaring_rage").Or(isCardName("barbarian_smoldering_rage"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_fiery_rage_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_explosive_rage_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_eternal_rage_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_terrifying_roar").Or(isCardName("barbarian_battle_cry"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_battle_roar_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(barbarian_terrifying_howl_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_war_cry_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("barbarian_headbutt")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_disorienting_headbutt_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(barbarian_shattering_headbutt_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_barbarian
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_barbarian
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_barbarian
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_barbarian
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_barbarian
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_barbarian
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_barbarian
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_barbarian
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_barbarian
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_barbarian
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_barbarian
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_barbarian
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualbarbarian"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualmonkBuffDef()
	--
	local name = "Dual Monk"
	local ef1_monk = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("monk_spring_blossom").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(2)))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_cobra_fang_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(monk_serene_wind_carddef(), loc(currentPid, asidePloc)))
				}))
				.seq(createCardEffect(monk_calm_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_calm")))
				.seq(createCardEffect(monk_focus_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_monk = createCardEffect(monk_flowing_technique_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_focus")))
					.seq(createCardEffect(monk_qi_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9 -- Skill 4
	local ef9_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_flowing_technique")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_flowing_technique_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_practiced_technique_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_monk = randomEffect({
					valueItem(1, createCardEffect(monk_stillness_of_water_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(monk_ring_of_1000_palms_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_qi")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_jing_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_focused_strike_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_monk = randomEffect({
					valueItem(1, createCardEffect(monk_wraps_of_strength_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_slippers_of_the_crane_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_monk = createCardEffect(monk_tonfas_of_balance_carddef(), loc(currentPid, asidePloc))
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_flowing_technique").Or(isCardName("monk_practiced_technique"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_fluid_technique_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_masterful_technique_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_precise_technique_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_jing").Or(isCardName("monk_focused_strike"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_yin_yang_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(monk_qigong_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_dim_mak_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("monk_spring_blossom")).take(1))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_resplendent_blossom_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(monk_radiant_blossom_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_monk
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_monk
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_monk
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_monk
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_monk
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_monk
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_monk
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_monk
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_monk
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_monk
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_monk
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_monk
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualmonk"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualalchemistBuffDef()
	--
	local name = "Dual Alchemist"
	local ef1_alchemist = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("alchemist_philosophers_stone").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(alchemist_dissolve_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_dissolve")))
				.seq(createCardEffect(alchemist_minor_transmutation_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_alchemist = createCardEffect(alchemist_reflect_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_minor_transmutation")))
					.seq(createCardEffect(alchemist_transmutation_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9 -- Skill 4
	local ef9_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_reflect")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_refraction_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_dispersion_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_alchemist = randomEffect({
					valueItem(1, createCardEffect(alchemist_crucible_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(alchemist_bottled_tempest_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_transmutation")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_rapid_transmogrification_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_rapid_transmutation_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_alchemist = randomEffect({
					valueItem(1, createCardEffect(alchemist_spectrum_spectacles_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_auric_gloves_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_alchemist = randomEffect({
					valueItem(1, createCardEffect(alchemist_brittle_gas_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_alchemy_powders_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_refraction").Or(isCardName("alchemist_dispersion"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_wide_diffusion_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_prismatic_dispersion_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_perfect_refraction_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_rapid_transmogrification").Or(isCardName("alchemist_rapid_transmutation"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_rapid_transmogrification_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(alchemist_major_transmogrification_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_instant_transmutation_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("alchemist_philosophers_stone")).take(1))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_swirling_philosophers_stone_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(alchemist_polished_philosophers_stone_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_alchemist
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_alchemist
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_alchemist
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_alchemist
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_alchemist
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_alchemist
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_alchemist
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_alchemist
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_alchemist
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_alchemist
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_alchemist
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_alchemist
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualalchemist"),
                effect = efShuffle
						
			
            })
        }
    })
end

function dualnecromancerBuffDef()
	--
	local name = "Dual necromancer"
	local ef1_necromancer = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("necromancer_soul_prism").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(necromancer_rod_of_unlife_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(necromancer_reanimate_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_reanimate")))
				.seq(createCardEffect(necromancer_final_return_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_necromancer = createCardEffect(necromancer_bone_raising_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_final_return")))
					.seq(createCardEffect(necromancer_raise_dead_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9 -- Skill 4
	local ef9_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_bone_raising")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_raise_skeleton_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_fresh_harvest_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_necromancer = randomEffect({
					valueItem(1, createCardEffect(necromancer_puzzle_box_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(necromancer_anguish_blade_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_raise_dead")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_corpse_raising_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_animate_dead_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_necromancer = randomEffect({
					valueItem(1, createCardEffect(necromancer_rotting_crown_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_plague_belt_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_necromancer = randomEffect({
					valueItem(1, createCardEffect(necromancer_voidstone_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_onyx_skull_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_raise_skeleton").Or(isCardName("necromancer_fresh_harvest"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_strong_bones_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(necromancer_skull_swarm_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_corpse_horde_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_corpse_raising").Or(isCardName("necromancer_animate_dead"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_empty_graves_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(necromancer_grave_robbery_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_reawaken_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("necromancer_rod_of_unlife")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_rod_of_spite_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(necromancer_rod_of_reanimation_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--						
    return createGlobalBuff({
        id="custom_class_buff",
        name = "Custom Class",
        abilities = {
			createAbility({
                id="level_1_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(1)),
                effect = ef1_necromancer
            }),
			createAbility({
                id="level_3_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(3)),
                effect = ef3_necromancer
            }),
			createAbility({
                id="level_5_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(5)),
                effect = ef5_necromancer
            }),
			createAbility({
                id="level_7_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(7)),
                effect = ef7_necromancer
            }),
			createAbility({
                id="level_9_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(9)),
                effect = ef9_necromancer
            }),
			createAbility({
                id="level_11_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(11)),
				effect = ef11_necromancer
            }),
			createAbility({
                id="level_13_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(13)),
                effect = ef13_necromancer
            }),
			createAbility({
                id="level_15_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(15)),
                effect = ef15_necromancer
            }),
			createAbility({
                id="level_17_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(17)),
                effect = ef17_necromancer
            }),
			createAbility({
                id="level_19_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(19)),
                effect = ef19_necromancer
            }),
			createAbility({
                id="level_21_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(21)),
                effect = ef21_necromancer
            }),
			createAbility({
                id="level_23_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer").And(getHeroLevel(currentPid).gte(23)),
                effect = ef23_necromancer
            }),
			
			createAbility({
                id="shuffle_effect",
                trigger = startOfTurnTrigger,
				check = hasPlayerSlot(currentPid, "dualnecromancer"),
                effect = efShuffle
						
			
            })
        }
    })
end
