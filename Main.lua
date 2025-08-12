local XLCurseEveryFloor = RegisterMod("Every Floor Is XL", 1)

function XLCurseEveryFloor:GiveXLCurse()

    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then -- no greed or challenge
        return
    end

    -- get current floor.
    local level = Game():GetLevel()
    --below code stops void, mom, womb ii, and hush from having xl
    if level:GetAbsoluteStage() == LevelStage.STAGE7 or level:GetAbsoluteStage() == LevelStage.STAGE3_2 or level:GetAbsoluteStage() == LevelStage.STAGE4_2 or level:GetAbsoluteStage() == LevelStage.STAGE4_3 then
        return
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
        randomItemID = math.random(1, 719) --if anyone wants to maintain this code in the future go right ahead
        local collectibleConfig = itemConfig:GetCollectible(randomItemID)
        if collectibleConfig and collectibleConfig.Type == ItemType.ITEM_PASSIVE and randomItemID ~= CollectibleType.COLLECTIBLE_BLACK_CANDLE then
            isPassive = true
        end
    end

    pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItemID, true, true, true)
end

XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, XLCurseEveryFloor.GiveXLCurse)
XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, XLCurseEveryFloor.OnPickupMorph)