local XLCurseEveryFloor = RegisterMod("Every Floor Is XL", 1)

function XLCurseEveryFloor:GiveXLCurse()
    
    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then -- no greed or challenge
        return
    end

    -- get current floor.
    local level = Game():GetLevel()

    -- stage is The Void (Stage 12) skip
    if level:GetAbsoluteStage() == LevelStage.STAGE7 then -- dellirium floor
        return
    end

    if level:GetAbsoluteStage() == LevelStage.STAGE4_2 then -- if player uses we need to go deeper to get to womb 2
        return
    end

    -- stage is the Hush floor skip
    if level:GetAbsoluteStage() == LevelStage.STAGE4_3 then -- hush floor
        return
    end

        return LevelCurse.CURSE_OF_LABYRINTH
end

XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, XLCurseEveryFloor.GiveXLCurse)
