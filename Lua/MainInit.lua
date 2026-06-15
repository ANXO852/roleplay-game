-- Main map initialization script
-- Place this in ServerScriptService

local ZoneManager = require(game.ServerScriptService:WaitForChild("ZoneManager"))
local DistrictData = require(game.ServerScriptService:WaitForChild("DistrictData"))
local VehicleSystem = require(game.ServerScriptService:WaitForChild("VehicleSystem"))
local ShopSystem = require(game.ServerScriptService:WaitForChild("ShopSystem"))

-- Initialize systems
local zoneManager = ZoneManager.new()
local vehicleSystem = VehicleSystem.new()
local shopSystem = ShopSystem.new()

-- Set up zones
zoneManager:InitializeZones()

-- Create shops
shopSystem:CreateShop("Downtown Store", "Clothing", DistrictData.Districts.Downtown.spawn, {
	{name = "Shirt", price = 50},
	{name = "Pants", price = 50},
	{name = "Shoes", price = 30}
})

shopSystem:CreateShop("Police Equipment", "Weapons", DistrictData.Districts.PoliceDistrict.spawn, {
	{name = "Police Badge", price = 0},
	{name = "Radio", price = 0}
})

shopSystem:CreateShop("Hospital Store", "Medical", DistrictData.Districts.MedicalDistrict.spawn, {
	{name = "Medical Kit", price = 100},
	{name = "Bandages", price = 25}
})

-- Handle player joining
local Players = game.Players

Players.PlayerAdded:Connect(function(player)
	print("👤 " .. player.Name .. " joined the game")
	
	-- Spawn player at random district
	local spawnPos = DistrictData:GetRandomSpawn()
	player.CharacterAdded:Connect(function(character)
		character:MoveTo(spawnPos)
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	print("👤 " .. player.Name .. " left the game")
end)

print("✅ Roleplay game initialized!")
print("🗺️ Map system loaded with " .. #zoneManager:GetAllZones() .. " zones")
