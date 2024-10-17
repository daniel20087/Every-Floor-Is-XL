local XLCurseEveryFloor = RegisterMod("Every Floor Is XL", 1)

function XLCurseEveryFloor:GiveXLCurse()
    
    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then -- no greed or challenge
        return
    end

    -- Get current level.
    local level = Game():GetLevel()

    -- stage is The Void (Stage 12) skip
    if level:GetAbsoluteStage() == LevelStage.STAGE7 then -- STAGE7 corresponds to The Void (Stage 12)
        return
    end

    -- stage is the Hush floor skip
    if level:GetAbsoluteStage() == LevelStage.STAGE6 and level:IsAltStage() then -- STAGE6 (Stage 10) + AltStage for Hush
        return
    end

        return LevelCurse.CURSE_OF_LABYRINTH
end

XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, XLCurseEveryFloor.GiveXLCurse)
