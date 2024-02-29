--- STEAMODDED HEADER
--- MOD_NAME: No More Mouse
--- MOD_ID: nomoremouse
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
    if G.STATE == G.STATES.SELECTING_HAND then
        if key == "1" or key == "2" or key == "3" or key == "4" or key == "5" or key == "q" or key == "w" or key == "e" or
            key == "r" or key == "t" then
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
    end
end

----------------------------------------------
------------MOD CODE END----------------------
