local XLCurseEveryFloor = RegisterMod("Every Floor Is XL", 1)

function XLCurseEveryFloor:GiveXLCurse()

    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then -- no greed or challenge
        return
    end
    local isaacPlayerID = Isaac.GetPlayer()
    -- get current floor.
    local level = Game():GetLevel()
    local stageXL = level:GetAbsoluteStage()
    --below code stops void, mom, womb ii, and hush from having xl
    if stageXL == LevelStage.STAGE7 or stageXL == LevelStage.STAGE3_2 or stageXL == LevelStage.STAGE4_2 or stageXL == LevelStage.STAGE4_3 then
        return
    end
    local hasKeyPiece1 = isaacPlayerID:GetCollectibleNum(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
    local hasKeyPiece2 = isaacPlayerID:GetCollectibleNum(CollectibleType.COLLECTIBLE_KEY_PIECE_2)
    if stageXL == LevelStage.STAGE6 then -- this is for the player to be able to reach void in a run as void portal doesnt spawn in blue baby fight so they enter via mega satan fight
        if hasKeyPiece1 == 0 then
            isaacPlayerID:AddCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
        end

        if hasKeyPiece2 == 0 then
            isaacPlayerID:AddCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2)
        end

        return
            LevelCurse.CURSE_OF_LABYRINTH
    end

    return LevelCurse.CURSE_OF_LABYRINTH
end

--change all black candle spawns to random item
function XLCurseEveryFloor:OnPickupMorph(pickup)
    if pickup.Variant ~= PickupVariant.PICKUP_COLLECTIBLE then return end
    if pickup.SubType ~= CollectibleType.COLLECTIBLE_BLACK_CANDLE then return end

    local randomItemID
    local isPassive = false
    local itemConfig = Isaac.GetItemConfig()

    while not isPassive do
        randomItemID = math.random(1, 732) --if anyone wants to maintain this code in the future go right ahead
        local collectibleConfig = itemConfig:GetCollectible(randomItemID)
        if collectibleConfig and collectibleConfig.Type == ItemType.ITEM_PASSIVE and randomItemID ~= CollectibleType.COLLECTIBLE_BLACK_CANDLE then
            isPassive = true
        end
    end

    pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItemID, true, true, true)
end
function XLCurseEveryFloor:MegaSatanWarning()
    local isaacHud = Game():GetHUD()
    if Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE6 then

        isaacHud:ShowFortuneText("Go through mega satan to reach void")
        
    end
end
XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, XLCurseEveryFloor.GiveXLCurse)
XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, XLCurseEveryFloor.OnPickupMorph)
XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, XLCurseEveryFloor.MegaSatanWarning)