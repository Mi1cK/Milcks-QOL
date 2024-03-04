--- STEAMODDED HEADER
--- MOD_NAME: Milck QOL
--- MOD_ID: milkqol
--- MOD_AUTHOR: [Milck]
--- MOD_DESCRIPTION: Add keyboard shortcuts to the game
----------------------------------------------
------------MOD CODE -------------------------
local keyupdate_ref = Controller.key_press_update
function Controller.key_press_update(self, key, dt)
    keyupdate_ref(self, key, dt)
    keys_to_nums = {
        ["1"] = 1,
        ["2"] = 2,
        ["3"] = 3,
        ["4"] = 4,
        ["5"] = 9,
        ["q"] = 5,
        ["w"] = 6,
        ["e"] = 7,
        ["r"] = 8,
        ["t"] = 10
    }
    keys_to_ui = {
        ["z"] = "sort_value",
        ["x"] = "sort_rank",
        ["return"] = "play_hand",
        ["space"] = "discard_hand",
        ["a"] = "run_info",
    }
    if G.STATE == G.STATES.SELECTING_HAND then
        if tableContains(keys_to_nums, key) then
            num = keys_to_nums[key]
            in_list = false
            if num <= #G.hand.cards then
                card = G.hand.cards[num]
                for i = #G.hand.highlighted, 1, -1 do
                    if G.hand.highlighted[i] == card then
                        in_list = true
                        break
                    end
                end
                if in_list then
                    G.hand:remove_from_highlighted(card, false)
                    play_sound('cardSlide2', nil, 0.3)
                else
                    G.hand:add_to_highlighted(card)
                end
            end
        end
        if tableContains(keys_to_ui, key) then
            if keys_to_ui[key] == "play_hand" then
                local play_button = G.buttons:get_UIE_by_ID('play_button')
                if play_button.config.button == 'play_cards_from_highlighted' then
                    G.FUNCS.play_cards_from_highlighted()
                end
            elseif keys_to_ui[key] == "discard_hand" then
                local discard_button = G.buttons:get_UIE_by_ID('discard_button')
                if discard_button.config.button == 'discard_cards_from_highlighted' then
                    G.FUNCS.discard_cards_from_highlighted()
                end
            elseif keys_to_ui[key] == "sort_value" then
                G.FUNCS.sort_hand_value()
            elseif keys_to_ui[key] == "sort_rank" then
                G.FUNCS.sort_hand_suit()
            elseif keys_to_ui[key] == "run_info" then
                local run_info_button = G.HUD:get_UIE_by_ID('run_info_button')
                if run_info_button.config.button == 'run_info' then
                    G.FUNCS.run_info()
                end
            end
        end
    end
end

function tableContains(table, key)
  for k,v in pairs(table) do
    if k == key then
        return true
    end
  end
  return false
end

----------------------------------------------
------------MOD CODE END----------------------
