--- STEAMODDED HEADER
--- MOD_NAME: Olympus
--- MOD_ID: Olympus
--- MOD_AUTHOR: [AbhinavR314]
--- MOD_DESCRIPTION: Some Jokers based on Greek Myth

----------------------------------------------
------------MOD CODE -------------------------

local MOD_ID = "Olympus";

-- Thanks GoldenEpsilon!
-- https://github.com/GoldenEpsilon/ShamPack/blob/main/ShamPack.lua
local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front);
    if _center then
        if _center.set then
            if (_center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher') and _center.atlas then
                self.children.center.atlas = G.ASSET_ATLAS
                    [(_center.atlas or (_center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher') and _center.set) or 'centers']
                self.children.center:set_sprite_pos(_center.pos)
            end
        end
    end
end

-- https://github.com/GoldenEpsilon/ShamPack/blob/main/ShamPack.lua
function add_item(mod_id, pool, id, data, desc)
    -- Add Sprite
    data.pos = { x = 0, y = 0 };
    data.key = id;
    data.atlas = mod_id .. id;
    SMODS.Sprite:new(mod_id .. id, SMODS.findModByID(mod_id).path, id .. ".png", 71, 95, "asset_atli"):register();

    data.key = id
    data.order = #G.P_CENTER_POOLS[pool] + 1
    G.P_CENTERS[id] = data
    table.insert(G.P_CENTER_POOLS[pool], data)

    if pool == "Joker" then
        table.insert(G.P_JOKER_RARITY_POOLS[data.rarity], data)
    end

    G.localization.descriptions[pool][id] = desc;
end

-- https://github.com/GoldenEpsilon/ShamPack/blob/main/ShamPack.lua
function refresh_items()
    for k, v in pairs(G.P_CENTER_POOLS) do
        table.sort(v, function(a, b) return a.order < b.order end)
    end

    -- Update localization
    for g_k, group in pairs(G.localization) do
        if g_k == 'descriptions' then
            for _, set in pairs(group) do
                for _, center in pairs(set) do
                    center.text_parsed = {}
                    for _, line in ipairs(center.text) do
                        center.text_parsed[#center.text_parsed + 1] = loc_parse_string(line)
                    end
                    center.name_parsed = {}
                    for _, line in ipairs(type(center.name) == 'table' and center.name or { center.name }) do
                        center.name_parsed[#center.name_parsed + 1] = loc_parse_string(line)
                    end
                    if center.unlock then
                        center.unlock_parsed = {}
                        for _, line in ipairs(center.unlock) do
                            center.unlock_parsed[#center.unlock_parsed + 1] = loc_parse_string(line)
                        end
                    end
                end
            end
        end
    end

    for k, v in pairs(G.P_JOKER_RARITY_POOLS) do
        table.sort(G.P_JOKER_RARITY_POOLS[k], function(a, b) return a.order < b.order end)
    end
end

function SMODS.INIT.Olympus()
    add_item(MOD_ID, "Joker", "j_artemis", {
        unlocked = true,
        discovered = true,
        rarity = 3,
        cost = 8,
        name = "Artemis",
        set = "Joker",
        config = {
            extra = nil,
        }
    }, {
        name = "Artemis",
        text = {
            "Creates a {C:attention}The Moon{} {C:tarot}Tarot{} card",
            "when {C:attention}Blind{} is selected"
        }
    });

    add_item(MOD_ID, "Joker", "j_apollo", {
        unlocked = true,
        discovered = true,
        rarity = 3,
        cost = 8,
        name = "Apollo",
        set = "Joker",
        config = {
            extra = nil,
        }
    }, {
        name = "Apollo",
        text = {
            "Creates a {C:attention}The Sun{} {C:tarot}Tarot{} card",
            "when {C:attention}Blind{} is selected"
        }
    });

    -- Apply our changes
    refresh_items();
end

local calculate_jokerref = Card.calculate_joker;
function Card:calculate_joker(context)
    local ret_val = calculate_jokerref(self, context);
    if self.ability.set == "Joker" and not self.debuff then
        --if context.cardarea == G.jokers then
         --   if context.before then end
         --   if context.joker_main then
        if context.setting_blind and not self.getting_sliced then
            if self.ability.name == 'Artemis' and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then --check if there is space to create tarot card
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_moon', 'art') --add moon card
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})                       
                        return true
                    end)}))
            end
            if self.ability.name == 'Apollo' and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then --check if there is space to create tarot card
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_sun', 'art') --add sun card
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})                       
                        return true
                    end)}))
            end
        
        end
    end
    return ret_val;
end                    
            

local add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck()
    if G.GAME and self.ability.set == "Joker" then
        if G.GAME[MOD_ID .. "unique_jokers_owned"] == nil then
            G.GAME[MOD_ID .. "unique_jokers_owned"] = {}
        end
        G.GAME[MOD_ID .. "unique_jokers_owned"][self.ability.name] = true
    end
    return add_to_deck_ref(self)
end

local card_uiref = Card.generate_UIBox_ability_table;
function Card:generate_UIBox_ability_table()
    local badges = {}
    local card_type = self.ability.set or "None"
    local loc_vars = nil


    if (card_type ~= 'Locked' and card_type ~= 'Undiscovered' and card_type ~= 'Default') or self.debuff then
        badges.card_type = card_type
    end
    if self.ability.set == 'Joker' and self.bypass_discovery_ui then
        badges.force_rarity = true
    end
    if self.edition then
        if self.edition.type == 'negative' and self.ability.consumeable then
            badges[#badges + 1] = 'negative_consumable'
        else
            badges[#badges + 1] = (self.edition.type == 'holo' and 'holographic' or self.edition.type)
        end
    end
    if self.seal then badges[#badges + 1] = string.lower(self.seal) .. '_seal' end
    if self.ability.eternal then badges[#badges + 1] = 'eternal' end
    if self.pinned then badges[#badges + 1] = 'pinned_left' end

    if self.sticker then
        loc_vars = loc_vars or {}; loc_vars.sticker = self.sticker
    end

    return card_uiref(self)
end
                
----------------------------------------------
------------MOD CODE END----------------------