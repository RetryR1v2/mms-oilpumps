local VORPcore = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()
local FeatherMenu =  exports['feather-menu'].initiate()






local SpawnedPump = false

RegisterNetEvent('vorp:SelectedCharacter')
AddEventHandler('vorp:SelectedCharacter', function()
    Citizen.Wait(10000)
    TriggerServerEvent('mms-oilpumps:server:CheckforPump')
end)


    Citizen.CreateThread(function()
        local OilPumpPrompt = BccUtils.Prompts:SetupPromptGroup()
            local pumptraderprompt = OilPumpPrompt:RegisterPrompt(_U('PromptName'), 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
            if Config.PumpTraderBlip then
                for h,v in pairs(Config.PumpDealer) do
                PumpTraderBlip = BccUtils.Blips:SetBlip(_U('BlipName'), 'blip_shop_coach_fencing', 5.0, v.NpcCoords.x,v.NpcCoords.y,v.NpcCoords.z)
                end
            end
            if Config.CreateNPC then
                for h,v in pairs(Config.PumpDealer) do
                PumpTraderPed = BccUtils.Ped:Create('A_M_O_SDUpperClass_01', v.NpcCoords.x, v.NpcCoords.y, v.NpcCoords.z -1, 0, 'world', false)
                PumpTraderPed:Freeze()
                PumpTraderPed:SetHeading(v.NpcHeading)
                PumpTraderPed:Invincible()
                end
            end
            while true do
                Wait(1)
                for h,v in pairs(Config.PumpDealer) do
                local playerCoords = GetEntityCoords(PlayerPedId())
                local dist = #(playerCoords - v.NpcCoords)
                if dist < 3 then
                    OilPumpPrompt:ShowGroup(_U('PromptName'))
        
                    if pumptraderprompt:HasCompleted() then
                        PumpShopMenu:Open({
                            startupPage = PumpShopMenuPage1,
                        })
                    end
                end
            end
            end
        end)

------------- Create Feather Menu

Citizen.CreateThread(function()  --- RegisterFeather Menu
            PumpShopMenu = FeatherMenu:RegisterMenu('PumpShop', {
                top = '50%',
                left = '50%',
                ['720width'] = '500px',
                ['1080width'] = '700px',
                ['2kwidth'] = '700px',
                ['4kwidth'] = '8000px',
                style = {
                    ['border'] = '5px solid orange',
                    -- ['background-image'] = 'none',
                    ['background-color'] = '#FF8C00'
                },
                contentslot = {
                    style = {
                        ['height'] = '450px',
                        ['min-height'] = '400px'
                    }
                },
                draggable = true,
            })
        PumpShopMenuPage1 = PumpShopMenu:RegisterPage('pumpenseite1')
        PumpShopMenuPage1:RegisterElement('header', {
            value = _U('TraderMenuLabel'),
            slot = "header",
            style = {
                ['color'] = 'orange',
            }
        })
        PumpShopMenuPage1:RegisterElement('line', {
            slot = "header",
            style = {
                ['color'] = 'orange',
            }
        })
        if Config.UseLevelSystem then
            local Level1 = Config.Levels[1]

            PumpenInfo = PumpShopMenuPage1:RegisterElement('textdisplay', {
                value = _U('Costs') ..Level1.Price.. _U('Dollarand').. Level1.PRate .._U('OilAll') .. Level1.PTime .. _U('Sec'),
                style = {
                    ['color'] = 'orange',
                }
            })
        else
        PumpenInfo = PumpShopMenuPage1:RegisterElement('textdisplay', {
            value = _U('Costs') ..Config.PumpPrice.. _U('Dollarand').. Config.AddOil .._U('OilAll') .. Config.WorkTime .. _U('Sec'),
            style = {
                ['color'] = 'orange',
            }
        })
        end
        PumpShopMenuPage1:RegisterElement('button', {
            label = _U('BuyPump'),
            style = {
                ['background-color'] = '#FF8C00',
                ['color'] = 'orange',
                ['border-radius'] = '6px'
            },
        }, function()
            TriggerEvent('mms-oilpumps:client:buypump')
        end)
        PumpShopMenuPage1:RegisterElement('button', {
            label = _U('CloseMenu'),
            style = {
                ['background-color'] = '#FF8C00',
                ['color'] = 'orange',
                ['border-radius'] = '6px'
            },
        }, function()
            PumpShopMenu:Close({ 
            })
        end)
        PumpShopMenuPage1:RegisterElement('subheader', {
            value = _U('TraderMenuLabel'),
            slot = "footer",
            style = {
                ['color'] = 'orange',
            }
        })
        PumpShopMenuPage1:RegisterElement('line', {
            slot = "footer",
            style = {
                ['color'] = 'orange',
            }
        })
end)

Citizen.CreateThread(function()
        PumpMenu = FeatherMenu:RegisterMenu('PumpMenu', {
        top = '50%',
        left = '50%',
        ['720width'] = '500px',
        ['1080width'] = '700px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '8000px',
        style = {
            ['border'] = '5px solid orange',
            -- ['background-image'] = 'none',
            ['background-color'] = '#FF8C00'
        },
        contentslot = {
            style = {
                ['height'] = '450px',
                ['min-height'] = '400px'
            }
        },
        draggable = true,
    })
        PumpMenuPage1 = PumpMenu:RegisterPage('pumpenmenuseite1')
        PumpMenuPage1:RegisterElement('header', {
            value = _U('PumpenMenuLabel'),
            slot = "header",
            style = {
                ['color'] = 'orange',
            }
        })
        PumpMenuPage1:RegisterElement('line', {
            slot = "header",
            style = {
                ['color'] = 'orange',
            }
        })
        OilAmount = PumpMenuPage1:RegisterElement('textdisplay', {
            value = _U('OilAmount'),
            style = {
                ['color'] = 'orange',
            }
        })
        if Config.UseLevelSystem then
        PumpLevel = PumpMenuPage1:RegisterElement('textdisplay', {
            value = _U('PLevel'),
            style = {
                ['color'] = 'orange',
            }
        })
        NextPrice = PumpMenuPage1:RegisterElement('textdisplay', {
            value = _U('PUPrice'),
            style = {
                ['color'] = 'orange',
            }
        })
    end
        PumpMenuPage1:RegisterElement('button', {
            label = _U('TakeOil'),
            style = {
                ['background-color'] = '#FF8C00',
                ['color'] = 'orange',
                ['border-radius'] = '6px'
            },
        }, function()
            TriggerEvent('mms-oilpumps:client:TakeOil')
        end)
        if Config.UseLevelSystem then
            PumpMenuPage1:RegisterElement('button', {
                label = _U('UpgradePump'),
                style = {
                    ['background-color'] = '#FF8C00',
                    ['color'] = 'orange',
                    ['border-radius'] = '6px'
                },
            }, function()
                TriggerEvent('mms-oilpumps:client:UpgradePump')
            end)
        end
        PumpMenuPage1:RegisterElement('button', {
            label = _U('DeletePump'),
            style = {
                ['background-color'] = '#FF8C00',
                ['color'] = 'orange',
                ['border-radius'] = '6px'
            },
        }, function()
            PumpMenu:Close({ 
            })
            TriggerEvent('mms-oilpumps:client:DeletePump')
        end)
        PumpMenuPage1:RegisterElement('button', {
            label = _U('PumpenMenuLabelClose'),
            style = {
                ['background-color'] = '#FF8C00',
                ['color'] = 'orange',
                ['border-radius'] = '6px'
            },
        }, function()
            PumpMenu:Close({ 
            })
        end)
        PumpMenuPage1:RegisterElement('subheader', {
            value = _U('PumpenMenuLabel'),
            slot = "footer",
            style = {
                ['color'] = 'orange',
            }
        })
        PumpMenuPage1:RegisterElement('line', {
            slot = "footer",
            style = {
                ['color'] = 'orange',
            }
        })
    
end)


RegisterNetEvent('mms-oilpumps:client:buypump')
AddEventHandler('mms-oilpumps:client:buypump',function ()
    local PumpNameInput = {
        type = "enableinput",
        inputType = "input",
        button = _U('Confirm'),
        placeholder = "",
        style = "block",
        attributes = {
            inputHeader = _U('EnterName'),
            type = "text",
            pattern = "[A-Za-z]+",
            title = _U('TextOnly'),
            style = "border-radius: 10px; background-color: ; border:none;"
        }
    }
    TriggerEvent("vorpinputs:advancedInput", json.encode(PumpNameInput), function(result)
        
        if result ~= "" and result then
            local PumpName = result
            TriggerServerEvent('mms-oilpumps:server:buypump',PumpName)
            PumpShopMenu:Close({ 
            })
        else
            print(_U('NoEntry')) 
        end
    end)
end)

RegisterNetEvent('mms-oilpumps:client:UpgradePump')
AddEventHandler('mms-oilpumps:client:UpgradePump',function()
    Citizen.Wait(1000)
    local getpumplevel =  VORPcore.Callback.TriggerAwait('mms-oilpumps:callback:getpumplevelfromdb')
    local MaxLevel = #Config.Levels
    local Upgraded = false
    for n,v in ipairs(Config.Levels) do
        if Upgraded == false then
            if getpumplevel < MaxLevel then
                if getpumplevel < v.Level then
                    Upgraded = true
                    local newlevel = v.Level
                    local newrate = v.PRate
                    local newtime = v.PTime
                    local upgradeprice = v.Price
                    TriggerServerEvent('mms-oilpumps:server:UpgradePump',newlevel,newrate,newtime,upgradeprice)
                    PumpMenu:Close({ 
                    })
                end
            else
                VORPcore.NotifyTip(_U('AlreadyMaxLevel'), 5000)
            end
        end
    end
    Upgraded = false
end)




RegisterNetEvent('mms-oilpumps:client:spawnpumpitem')
AddEventHandler('mms-oilpumps:client:spawnpumpitem', function(pumpname)
    local MyCoords = GetEntityCoords(PlayerPedId())
    if Config.OnlyOilField then 
        local oilfields = Config.Oilfield
        local distanceoilfield = #(MyCoords - oilfields)
        if distanceoilfield <= Config.RadiusAround then
            local modelHash = GetHashKey(Config.Model)
	        while not HasModelLoaded(modelHash) do
		    RequestModel(modelHash)
		    Citizen.Wait(0)
	        end

    PumpObject = CreateObject(modelHash, MyCoords.x +1 , MyCoords.y +1 , MyCoords.z -1, true, false, false) 
    isSpawned = true
    PlaceObjectOnGroundProperly(PumpObject)
    SetEntityAsMissionEntity(PumpObject,true,true)
    Wait(200)
    FreezeEntityPosition(PumpObject,true)
    SetModelAsNoLongerNeeded(modelHash)
    local PumpCoords = GetEntityCoords(PumpObject)
    SpawnedPump = true
    if Config.PumpBlip then
        PumpBlip = BccUtils.Blips:SetBlip(pumpname, Config.PumpBlipSprite, Config.PumpBlipScale, PumpCoords.x,PumpCoords.y,PumpCoords.z)
    end

    local posx = PumpCoords.x
    local posy = PumpCoords.y
    local posz = PumpCoords.z
    
    TriggerServerEvent('mms-oilpumps:server:placepumpfirsttime', posx,posy,posz)
    
    Citizen.Wait(1000)
    TriggerEvent('mms-oilpumps:client:PumpPrompt',PumpCoords,pumpname)
    Citizen.Wait(1000)
        TriggerEvent('mms-oilpumps:client:workoil')
        else
            VORPcore.NotifyTip(_U('OnlyOilField'), 5000)
            TriggerServerEvent('mms-oilpumps:server:givebackpumpitem')
        end
    elseif Config.NotNearTowns then
    local valentine = Config.TownValentine
    local rhodes = Config.TownRhodes
    local strawberry = Config.TownStrawberry
    local blackwater = Config.TownBlackwater
    local annesburg = Config.TownAnnesburg
    local vanhorn = Config.TownVanhorn
    local saintdenise = Config.TownSaintdenise
    local tumbleweed = Config.TownTumbleweed
    local armadillo = Config.TownArmadillo
    local distancevalentine = #(MyCoords - valentine)
    local distancerhodes = #(MyCoords - rhodes)
    local distancestrawberry = #(MyCoords - strawberry)
    local distanceblackwater = #(MyCoords - blackwater)
    local distanceannesburg = #(MyCoords - annesburg)
    local distancevanhorn = #(MyCoords - vanhorn)
    local distancesaintdenise = #(MyCoords - saintdenise)
    local distancetumbleweed = #(MyCoords - tumbleweed)
    local distancearmadillo = #(MyCoords - armadillo)
        if distancevalentine and distancerhodes and distancestrawberry and distanceblackwater and distanceannesburg and distancevanhorn and distancesaintdenise and distancetumbleweed and distancearmadillo <= Config.TownDistanceNeeded then
            local modelHash = GetHashKey(Config.Model)
	        while not HasModelLoaded(modelHash) do
		    RequestModel(modelHash)
		    Citizen.Wait(0)
	        end

    PumpObject = CreateObject(modelHash, MyCoords.x +1 , MyCoords.y +1 , MyCoords.z -1, true, false, false) 
    isSpawned = true
    PlaceObjectOnGroundProperly(PumpObject)
    SetEntityAsMissionEntity(PumpObject,true,true)
    Wait(200)
    FreezeEntityPosition(PumpObject,true)
    SetModelAsNoLongerNeeded(modelHash)
    local PumpCoords = GetEntityCoords(PumpObject)
    SpawnedPump = true
    if Config.PumpBlip then
        PumpBlip = BccUtils.Blips:SetBlip(pumpname, Config.PumpBlipSprite, Config.PumpBlipScale, PumpCoords.x,PumpCoords.y,PumpCoords.z)
    end

    local posx = PumpCoords.x
    local posy = PumpCoords.y
    local posz = PumpCoords.z
    
    TriggerServerEvent('mms-oilpumps:server:placepumpfirsttime', posx,posy,posz)
    
    Citizen.Wait(1000)
    TriggerEvent('mms-oilpumps:client:PumpPrompt',PumpCoords,pumpname)
    Citizen.Wait(1000)
        TriggerEvent('mms-oilpumps:client:workoil')
    else
        VORPcore.NotifyTip(_U('NotNearTown'), 5000)
        TriggerServerEvent('mms-oilpumps:server:givebackpumpitem')
    end
end
end)



RegisterNetEvent('mms-oilpumps:client:PumpPrompt')
AddEventHandler('mms-oilpumps:client:PumpPrompt',function(PumpCoords,pumpname)
    local PumpPrompt = BccUtils.Prompts:SetupPromptGroup()
        local pumpprompt = PumpPrompt:RegisterPrompt(pumpname, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
    while SpawnedPump do
            Wait(1)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local dist = #(playerCoords - PumpCoords)
        if dist < 4 then
            PumpPrompt:ShowGroup(pumpname)
            if pumpprompt:HasCompleted() then
                PumpMenu:Open({
                    startupPage = PumpMenuPage1,
                })
            end
        end
    end
end)



RegisterNetEvent('FeatherMenu:opened', function(menudata)
    if menudata.menuid == 'PumpMenu' then
            local oilamount =  VORPcore.Callback.TriggerAwait('mms-oilpumps:callback:getoilfromdb')
            OilAmount:update({
                value = _U('OilAmount') .. oilamount .. _U('Oil'),
                style = {}
            })
            Citizen.Wait(100)
            if Config.UseLevelSystem then
            local pumplevel =  VORPcore.Callback.TriggerAwait('mms-oilpumps:callback:getpumplevelfromdb')
            local pumprate = VORPcore.Callback.TriggerAwait('mms-oilpumps:callback:getpratefromdb')
            local pumptime = VORPcore.Callback.TriggerAwait('mms-oilpumps:callback:getptimefromdb')
            PumpLevel:update({
                value = _U('PLevel') .. pumplevel .. _U('PRate') .. pumprate .. _U('All') .. pumptime .._U('PTime'),
                style = {}
            })
            local nextlevel = false
            local getpumplevel =  VORPcore.Callback.TriggerAwait('mms-oilpumps:callback:getpumplevelfromdb')
            local MaxLevel = #Config.Levels
            for n,v in ipairs(Config.Levels) do
                if nextlevel == false then
                    if getpumplevel < MaxLevel then
                        if getpumplevel < v.Level then
                            nextlevel = true
                            nextprice = v.Price
                            NextPrice:update({
                                value = _U('PUPrice') .. nextprice .. ' $',
                                style = {}
                            })
                        end
                    else
                        NextPrice:update({
                        value = _U('AlreadyMaxLevel'),
                        style = {}
                        })
                    end
                end
            end
        nextlevel = false
        end
    end
end)

RegisterNetEvent('FeatherMenu:closed', function(menudata)
    if menudata.menuid == 'PumpMenu' then
    end
end)


RegisterNetEvent('mms-oilpumps:client:workoil')
AddEventHandler('mms-oilpumps:client:workoil',function()
    while SpawnedPump do
        if Config.UseLevelSystem then
            local pumprate = VORPcore.Callback.TriggerAwait('mms-oilpumps:callback:getpratefromdb')
            local pumptime = VORPcore.Callback.TriggerAwait('mms-oilpumps:callback:getptimefromdb')
            local oil = pumprate
            TriggerServerEvent('mms-oilpumps:server:AddOiltoDB', oil)
            Citizen.Wait(pumptime * 1000)
        else
            local oil = Config.AddOil
            TriggerServerEvent('mms-oilpumps:server:AddOiltoDB', oil)
            Citizen.Wait(Config.WorkTime * 1000)
        end
     end
    Citizen.Wait(1000)
end)


RegisterNetEvent('mms-oilpumps:client:DeletePump')
AddEventHandler('mms-oilpumps:client:DeletePump',function()
    DeleteObject(PumpObject)
    SpawnedPump = false
    PumpBlip:Remove()
    TriggerServerEvent('mms-oilpumps:server:DeletePump')
end)

RegisterNetEvent('mms-oilpumps:client:TakeOil')
AddEventHandler('mms-oilpumps:client:TakeOil',function ()
    local TakeOilAmoun = {
        type = "enableinput",
        inputType = "input",
        button = _U('Confirm'),
        placeholder = "",
        style = "block",
        attributes = {
            inputHeader = _U('Amount'),
            type = "text",
            pattern = "[0-9]+",
            title = _U('NumberOnly'),
            style = "border-radius: 10px; background-color: ; border:none;"
        }
    }
    TriggerEvent("vorpinputs:advancedInput", json.encode(TakeOilAmoun), function(result)
        
        if result ~= "" and result then
            local TakeOilAmount = tonumber(result)
            TriggerServerEvent('mms-oilpumps:server:TakeOil',TakeOilAmount)
            PumpMenu:Close({ 
            })
        else
            print(_U('NoEntry')) 
        end
    end)
end)


RegisterNetEvent('mms-oilpumps:client:spawnpumponplayerjoin')
AddEventHandler('mms-oilpumps:client:spawnpumponplayerjoin',function(posx,posy,posz,pumpname)
            local modelHash = GetHashKey(Config.Model)
	        while not HasModelLoaded(modelHash) do
		    RequestModel(modelHash)
		    Citizen.Wait(0)
	        end

            PumpObject = CreateObject(modelHash, posx +1 , posy +1 , posz -1, true, false, false)
    isSpawned = true
    PlaceObjectOnGroundProperly(PumpObject)
    SetEntityAsMissionEntity(PumpObject,true,true)
    Wait(200)
    FreezeEntityPosition(PumpObject,true)
    SetModelAsNoLongerNeeded(modelHash)
    local PumpCoords = GetEntityCoords(PumpObject)
    SpawnedPump = true
    if Config.PumpBlip then
        PumpBlip = BccUtils.Blips:SetBlip(pumpname, Config.PumpBlipSprite, Config.PumpBlipScale, PumpCoords.x,PumpCoords.y,PumpCoords.z)
    end

    
    Citizen.Wait(1000)
    TriggerEvent('mms-oilpumps:client:PumpPrompt',PumpCoords,pumpname)
    Citizen.Wait(1000)
    TriggerEvent('mms-oilpumps:client:workoil')
end)

----- Cleaup on Resource Restart

RegisterNetEvent('onResourceStop',function()
    PumpTraderPed:Remove()
    PumpTraderBlip:Remove()
    if SpawnedPump then
        PumpBlip:Remove()
    end
    if SpawnedPump then
        DeleteObject(PumpObject)
    end
    SpawnedPump = false
end)





