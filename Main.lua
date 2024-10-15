local XLCurseEveryFloor = RegisterMod("Every Floor Is XL", 1)

function XLCurseEveryFloor:GiveXLCurse()
    -- Disregard mod if it's a challenge run or if it's Greed Mode.
    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then
        return
    end

    -- Get current level.
    local level = Game():GetLevel()

    -- Check if the current stage is The Void (Stage 12) and skip it.
    if level:GetAbsoluteStage() == LevelStage.STAGE7 then -- STAGE7 corresponds to The Void (Stage 12)
        return
    end

    -- Check if the current stage is the Hush floor and skip it.
    if level:GetAbsoluteStage() == LevelStage.STAGE6 and level:IsAltStage() then -- STAGE6 (Stage 10) + AltStage for Hush
        return
    end

    -- Check if it's already an XL floor, and if not, apply the XL curse.
    local curses = level:GetCurses()
    if curses ~= LevelCurse.CURSE_OF_LABYRINTH then
        -- Set to XL curse.
        level:AddCurse(LevelCurse.CURSE_OF_LABYRINTH)
    end
end

XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, XLCurseEveryFloor.GiveXLCurse)
