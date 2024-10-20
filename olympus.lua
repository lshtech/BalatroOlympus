--- STEAMODDED HEADER
--- MOD_NAME: Olympus
--- MOD_ID: Olympus
--- MOD_AUTHOR: [AbhinavR314]
--- MOD_DESCRIPTION: Some Jokers based on Greek Myth
--- BADGE_COLOUR: a86037
--- PREFIX: olymp

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
	key = "apollo",
	path = "j_apollo.png",
	px = 71,
	py = 95,
}
local apollo = SMODS.Joker{
	name = "apollo",
	key = "apollo",
	config = { },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Apollo",
        text = {
            "Creates a {C:attention}The Sun{} {C:tarot}Tarot{} card",
            "when {C:attention}Blind{} is selected"
        }
	},
	rarity = 3,
	cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "apollo",
	loc_vars = function(self, info_queue, center)
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then --check if there is space to create tarot card
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local new_card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_sun', 'art') --add sun card
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end}))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    return true
                end)}))
        end
        if context.other_joker and context.other_joker.ability.name == 'artemis' and card ~= context.other_joker and context.scoring_hand then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Hearts') then suits["Hearts"] = suits["Hearts"] + 1 end
                    if context.scoring_hand[i]:is_suit('Diamonds') then suits["Diamonds"] = suits["Diamonds"] + 1 end
                    if context.scoring_hand[i]:is_suit('Spades') then suits["Spades"] = suits["Spades"] + 1 end
                    if context.scoring_hand[i]:is_suit('Clubs') then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then suits["Clubs"] = suits["Clubs"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0  then suits["Hearts"] = suits["Hearts"] + 1 end
                end
            end
            if suits["Hearts"] > 0 and
            suits["Clubs"] > 0 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={2.5}},
                    Xmult_mod = 2.5
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "artemis",
	path = "j_artemis.png",
	px = 71,
	py = 95,
}
local artemis = SMODS.Joker{
	name = "artemis",
	key = "artemis",
	config = { },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Artemis",
        text = {
            "Creates a {C:attention}The Moon{} {C:tarot}Tarot{} card",
        }
	},
	rarity = 3,
	cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "artemis",
	loc_vars = function(self, info_queue, center)
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then --check if there is space to create tarot card
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local new_card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_moon', 'art') --add moon card
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end}))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    return true
                end)}))
        end
        if context.other_joker and context.other_joker.ability.name == 'apollo' and card ~= context.other_joker and context.scoring_hand then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Hearts') then suits["Hearts"] = suits["Hearts"] + 1 end
                    if context.scoring_hand[i]:is_suit('Diamonds') then suits["Diamonds"] = suits["Diamonds"] + 1 end
                    if context.scoring_hand[i]:is_suit('Spades') then suits["Spades"] = suits["Spades"] + 1 end
                    if context.scoring_hand[i]:is_suit('Clubs') then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then suits["Clubs"] = suits["Clubs"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0  then suits["Hearts"] = suits["Hearts"] + 1 end
                end
            end
            if suits["Hearts"] > 0 and
            suits["Clubs"] > 0 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={2.5}},
                    Xmult_mod = 2.5
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "hades",
	path = "j_hades.png",
	px = 71,
	py = 95,
}
local hades = SMODS.Joker{
	name = "hades",
	key = "hades",
    config = {
        extra = 3,
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Hades",
        text = {
            "If {C:attention}first hand{} of round",
            "has only {C:attention}1{} card, destroy",
            "it and earn {C:money}$3{}"
        }
	},
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "hades",
	loc_vars = function(self, info_queue, center)
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.full_hand and #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
                ease_dollars(card.ability.extra)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                    context.full_hand[1]:start_dissolve()
                    return true
                end }))
                for i = 1, #G.jokers.cards do
                    G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = context.full_hand[1]})
                end
            end
        end
	end,
}

SMODS.Atlas{
	key = "hephaestus",
	path = "j_hephaestus.png",
	px = 71,
	py = 95,
}
local hephaestus = SMODS.Joker{
	name = "hephaestus",
	key = "hephaestus",
    config = { },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Hephaestus",
        text = {
            "All cards become {C:attention}Steel{} cards",
            "when scored"
        }
	},
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "hephaestus",
	loc_vars = function(self, info_queue, center)
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            context.other_card:set_ability(G.P_CENTERS.m_steel, nil, true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    return true
                end}))
        end
	end,
}

SMODS.Atlas{
	key = "hera",
	path = "j_hera.png",
	px = 71,
	py = 95,
}
local hera = SMODS.Joker{
	name = "hera",
	key = "hera",
    config = {
        extra = 13,
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Hera",
        text = {
            "Each played {C:attention}Queen{}",
            "gives {C:mult}+13{} Mult when scored"
        }
	},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "hera",
	loc_vars = function(self, info_queue, center)
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 then
            return {
                mult = card.ability.extra,
                card = card
            }
        end
        if context.other_joker and context.other_joker.ability.name == 'zeus' and card ~= context.other_joker and context.scoring_hand then
            local ranks = {
                ['Queens'] = 0,
                ['Kings'] = 0
            }

            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 12 then ranks["Queens"] = ranks["Queens"] + 1 end
                if context.scoring_hand[i]:get_id() == 13 then ranks["Kings"] = ranks["Kings"] + 1 end
            end
            if ranks["Queens"] > 0 and
            ranks["Kings"] > 0 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={1.5}},
                    Xmult_mod = 1.5
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "zeus",
	path = "j_zeus.png",
	px = 71,
	py = 95,
}
local zeus = SMODS.Joker{
	name = "zeus",
	key = "zeus",
    config = {
        extra = 13,
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Zeus",
        text = {
            "Each played {C:attention}King{}",
            "gives {C:mult}+13{} Mult when scored"
        }
	},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "zeus",
	loc_vars = function(self, info_queue, center)
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 13 then
            return {
                mult = card.ability.extra,
                card = card
            }
        end
        if context.other_joker and context.other_joker.ability.name == 'hera' and card ~= context.other_joker and context.scoring_hand then
            local ranks = {
                ['Queens'] = 0,
                ['Kings'] = 0
            }

            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 12 then ranks["Queens"] = ranks["Queens"] + 1 end
                if context.scoring_hand[i]:get_id() == 13 then ranks["Kings"] = ranks["Kings"] + 1 end
            end
            if ranks["Queens"] > 0 and
            ranks["Kings"] > 0 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={1.5}},
                    Xmult_mod = 1.5
                }
            end
        end
	end,
}

if _G["JokerDisplay"] then
	local jd_def = JokerDisplay.Definitions
    local test = true
    jd_def['j_olymp_apollo'] = {
        text = {
            {
                border_nodes = {
                    { text = 'X'},
                    { ref_table = 'card.joker_display_values', ref_value = 'x_mult', retrigger_type = 'exp' },
                }
            }
        },
        calc_function = function (card)
            if next(find_joker("artemis")) then
                local _, _, scoring_hand = JokerDisplay.evaluate_hand()
                card.joker_display_values.active = false
                local has_heart = false
                local has_club = false
                for _,card in pairs(scoring_hand) do
                    has_club = has_club or card:is_suit("Clubs")
                    has_heart = has_heart or card:is_suit("Hearts")
                end
                if has_club and has_heart then
                    card.joker_display_values.x_mult = 2.5
                    card.joker_display_values.active = true
                    return
                end
            end
            card.joker_display_values.x_mult = 1
        end,
        style_function = function(card, text, reminder_text, extra)
            if text and text.children[1] then
                text.children[1].states.visible = card.joker_display_values.active
            end
            return false
        end,
    }
    jd_def['j_olymp_artemis'] = {
        text = {
            {
                border_nodes = {
                    { text = 'X'},
                    { ref_table = 'card.joker_display_values', ref_value = 'x_mult', retrigger_type = 'exp' },
                }
            }
        },
        calc_function = function (card)
            if next(find_joker("apollo")) then
                local _, _, scoring_hand = JokerDisplay.evaluate_hand()
                card.joker_display_values.active = false
                local has_heart = false
                local has_club = false
                for _,card in pairs(scoring_hand) do
                    has_club = has_club or card:is_suit("Clubs")
                    has_heart = has_heart or card:is_suit("Hearts")
                end
                if has_club and has_heart then
                    card.joker_display_values.x_mult = 2.5
                    card.joker_display_values.active = true
                    return
                end
            end
            card.joker_display_values.x_mult = 1
        end,
        style_function = function(card, text, reminder_text, extra)
            if text and text.children[1] then
                text.children[1].states.visible = card.joker_display_values.active
            end
            return false
        end,
    }
    jd_def['j_olymp_hera'] = {
        text = {
            { text = " +",                             colour = G.C.MULT },
            { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" },
            { text = "" },
            {
                border_nodes = {
                    { ref_table = "card.joker_display_values", ref_value = "X"},
                    { ref_table = 'card.joker_display_values', ref_value = 'x_mult', retrigger_type = 'exp' },
                },
            }
        },
        calc_function = function (card)
            local _, _, scoring_hand = JokerDisplay.evaluate_hand()
            card.joker_display_values.active = false
            local has_king = false
            local has_queen = false
            local mult = 0
            for _,played_card in pairs(scoring_hand) do
                has_king = has_king or played_card:get_id() == 13
                has_queen = has_queen or played_card:get_id() == 12
            end
            if has_queen then
                mult = card.ability.extra
            end
            card.joker_display_values.mult = mult
            if has_king and has_queen and next(find_joker("zeus")) then
                card.joker_display_values.X = "X"
                card.joker_display_values.x_mult = 1.5
                card.joker_display_values.active = true
                return
            end
            card.joker_display_values.x_mult = ""
            card.joker_display_values.X = ""
        end,
        style_function = function(card, text, reminder_text, extra)
            if text and text.children[4] then
                text.children[4].states.visible = card.joker_display_values.active
            end
            return false
        end,
    }
    jd_def['j_olymp_zeus'] = {
        text = {
            { text = " +",                             colour = G.C.MULT },
            { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" },
            { text = "" },
            {
                border_nodes = {
                    { ref_table = "card.joker_display_values", ref_value = "X"},
                    { ref_table = 'card.joker_display_values', ref_value = 'x_mult', retrigger_type = 'exp' },
                },
            }
        },
        calc_function = function (card)
            local _, _, scoring_hand = JokerDisplay.evaluate_hand()
            card.joker_display_values.active = false
            local has_king = false
            local has_queen = false
            local mult = 0
            for _,played_card in pairs(scoring_hand) do
                has_king = has_king or played_card:get_id() == 13
                has_queen = has_queen or played_card:get_id() == 12
            end
            if has_king then
                mult = card.ability.extra
            end
            card.joker_display_values.mult = mult
            if has_king and has_queen and next(find_joker("hera")) then
                card.joker_display_values.X = "X"
                card.joker_display_values.x_mult = 1.5
                card.joker_display_values.active = true
                return
            end
            card.joker_display_values.x_mult = ""
            card.joker_display_values.X = ""
        end,
        style_function = function(card, text, reminder_text, extra)
            if text and text.children[4] then
                text.children[4].states.visible = card.joker_display_values.active
            end
            return false
        end,
    }
end

----------------------------------------------
------------MOD CODE END----------------------