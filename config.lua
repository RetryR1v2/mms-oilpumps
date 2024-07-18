Config = {}

Config.defaultlang = "de_lang" -- Set Language (Current Languages: "de_lang" German)

Config.Debug = false

-------------- Prompt Settings

Config.PumpTraderBlip = true
Config.CreateNPC = true


Config.PumpDealer = {
{ 
    NpcCoords = vector3(498.07, 672.91, 120.18),
    NpcHeading = 78.67,
},


-- add more as required
}

Config.pumpblipSprite= 'blip_donate_food'
Config.pumpblipScale = 5.0
Config.pumpblipName = 'Deine Ölpumpe'

--------- Pump Settings

Config.PumpItem = 'OilPump'  -- <-- DB Item
Config.OilItem = 'oil'  -- <-- DB Item
Config.Model = 'p_enginefactory01x'
Config.PumpPrice = 1000
Config.AddOil = 10         ---------------- oil amount that added every min
Config.WorkTime = 10    ---------------- Time in Sek
Config.PumpBlip = true
Config.PumpBlipSprite= 'blip_donate_food'
Config.PumpBlipScale = 5.0
Config.MaxStash = 250

-------------------- Level System

Config.UseLevelSystem = true

Config.Levels = {
    {
        Level = 1,          ---- Level 1
        PRate = 3,          ---- Amount Oil this Level Produce Fix Amount Not Added 
        Price = 100,        ---- Price to Buy Pump Level 1 
        PTime = 60,         ---- Time in Sec this Level Produce Oil
    },
    {
        Level = 2,
        PRate = 6,
        Price = 150,        ---- Price Upgrade Costs
        PTime = 50,
    },
    {
        Level = 3,
        PRate = 9,
        Price = 200,
        PTime = 40,
    },
    {
        Level = 4,
        PRate = 12,
        Price = 250,
        PTime = 30,
    },
    {
        Level = 5,
        PRate = 15,
        Price = 300,
        PTime = 20,
    },
}


------------------------- Config  Town Distance


Config.NotNearTowns = false
Config.TownDistanceNeeded = 300

Config.OnlyOilField = true 
Config.RadiusAround = 300

---- Town Coords Middle of Town ----
Config.TownValentine = vector3(-281.13, 715.79, 113.93)  --Check
Config.TownRhodes = vector3(1341.21, -1277.12, 76.94)  --Check
Config.TownStrawberry = vector3(-1798.92, -457.03, 159.48)  --Check
Config.TownBlackwater = vector3(-850.22, -1298.28, 43.37)  --Check
Config.TownAnnesburg = vector3(2919.48, 1368.80, 45.24)  -- Check
Config.TownVanhorn = vector3(2962.95, 547.93, 44.50)   -- Check
Config.TownSaintdenise = vector3(2613.23, -1216.01, 53.39)   --Check
Config.TownTumbleweed = vector3(-5506.68, -2941.55, -1.80)   --Check
Config.TownArmadillo = vector3(-3689.10, -2609.74, -14.03)   --Check
Config.Oilfield = vector3(519.70, 629.69, 111.31) -- Check


