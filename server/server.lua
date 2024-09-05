-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/RetryR1v2/mms-oilpumps/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

      
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('Current Version: %s'):format(currentVersion))
            versionCheckPrint('success', ('Latest Version: %s'):format(text))
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

local VORPcore = exports.vorp_core:GetCore()

exports.vorp_inventory:registerUsableItem(Config.PumpItem, function(data)
    local src = data.source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
                exports.vorp_inventory:subItem(src, Config.PumpItem, 1, nil,nil)
                local pumpname = result[1].pumpname
                Citizen.Wait(500)
                TriggerClientEvent('mms-oilpumps:client:spawnpumpitem',src,pumpname)
        else
            VORPcore.NotifyTip(src, _U('AlreadyGotPump'), 5000)
        end
    end)
end)


RegisterServerEvent('mms-oilpumps:server:buypump',function(PumpName)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    local firstname = Character.firstname
    local lastname = Character.lastname
    local stash = 0
    local Money = Character.money
    if Config.UseLevelSystem then
        local Level1 = Config.Levels[1]
        local Price = Level1.Price
        local Level = Level1.Level
        local PRate = Level1.PRate
        local PTime = Level1.PTime
        MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
            if result[1] ~= nil then
                VORPcore.NotifyTip(src, _U('AlreadyGotPump'), 5000)
            else
                if Money >= Price then
                    VORPcore.NotifyTip(src, _U('PumpBought'), 5000)
                    Character.removeCurrency(0,Price)
                    exports.vorp_inventory:addItem(src, Config.PumpItem, 1, nil,nil)
                    MySQL.insert('INSERT INTO `mms_oilpumps` (identifier,firstname,lastname,pumpname,stash,pumplevel,prate,ptime) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                    {identifier,firstname,lastname,PumpName,stash,Level,PRate,PTime}, function()end)
                else
                    VORPcore.NotifyTip(src, _U('NotEnoghMoney'), 5000)
                end
            end
        end)
    else
        MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
            if result[1] ~= nil then
                VORPcore.NotifyTip(src, _U('AlreadyGotPump'), 5000)
            else
                if Money >= Config.PumpPrice then
                    VORPcore.NotifyTip(src, _U('PumpBought'), 5000)
                    Character.removeCurrency(0,Config.PumpPrice)
                    exports.vorp_inventory:addItem(src, Config.PumpItem, 1, nil,nil)
                    MySQL.insert('INSERT INTO `mms_oilpumps` (identifier,firstname,lastname,pumpname,stash) VALUES (?, ?, ?, ?, ?)',
                    {identifier,firstname,lastname,PumpName,stash}, function()end)
                else
                    VORPcore.NotifyTip(src, _U('NotEnoghMoney'), 5000)
                end
            end
        end)
    end

end)


RegisterServerEvent('mms-oilpumps:server:placepumpfirsttime',function(posx,posy,posz)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            MySQL.update('UPDATE `mms_oilpumps` SET  posx = ?, posy = ?, posz = ? WHERE identifier = ?',{posx,posy,posz,identifier})
        end
    end)
end)

RegisterServerEvent('mms-oilpumps:server:AddOiltoDB',function(oil)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            local oldamount = result[1].stash
            local newamount = oldamount + oil
            MySQL.update('UPDATE `mms_oilpumps` SET stash = ? WHERE identifier = ?',{newamount, identifier})
        end
    end)
end)

VORPcore.Callback.Register('mms-oilpumps:callback:getoilfromdb', function(source,cb)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            oilamount = result[1].stash
            cb(oilamount)
        else
            oilamount = 0
            cb(oilamount)
        end
    end)
end)

VORPcore.Callback.Register('mms-oilpumps:callback:getpumplevelfromdb', function(source,cb)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            pumplevel = result[1].pumplevel
            cb(pumplevel)
        else
            pumplevel = 0
            cb(pumplevel)
        end
    end)
end)

VORPcore.Callback.Register('mms-oilpumps:callback:getpratefromdb', function(source,cb)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            prate = result[1].prate
            cb(prate)
        else
            prate = 0
            cb(prate)
        end
    end)
end)

VORPcore.Callback.Register('mms-oilpumps:callback:getptimefromdb', function(source,cb)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            ptime = result[1].ptime
            cb(ptime)
        else
            ptime = 0
            cb(ptime)
        end
    end)
end)

RegisterServerEvent('mms-oilpumps:server:DeletePump',function()
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            MySQL.execute('DELETE FROM `mms_oilpumps` WHERE identifier = ?', { identifier }, function() end)
        end
    end)
end)

RegisterServerEvent('mms-oilpumps:server:givebackpumpitem',function()
    local src = source
    exports.vorp_inventory:addItem(src, Config.PumpItem, 1, nil,nil)
end)

RegisterServerEvent('mms-oilpumps:server:TakeOil',function(TakeOilAmount)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    local cancarryitems = exports.vorp_inventory:canCarryItems(src, TakeOilAmount, nil)
    local cancarryitem = exports.vorp_inventory:canCarryItem(source, Config.OilItem, TakeOilAmount, nil)
    if cancarryitem and cancarryitems then
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            oilamount = result[1].stash
            if oilamount >= TakeOilAmount then
                newoil = oilamount - TakeOilAmount
                MySQL.update('UPDATE `mms_oilpumps` SET stash = ? WHERE identifier = ?',{newoil, identifier})
                exports.vorp_inventory:addItem(src, Config.OilItem, TakeOilAmount, nil,nil)
                VORPcore.NotifyTip(src, _U('TakeOutPump') .. TakeOilAmount .. _U('TakeOutPump2'), 5000)
            else
                VORPcore.NotifyTip(src, _U('NotEnoghOil'), 5000)
            end
        end
        end)
    else
        VORPcore.NotifyTip(src, _U('NotEnoghSpace'), 5000)
    end
end)

RegisterServerEvent('mms-oilpumps:server:CheckforPump',function()
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            local posx = result[1].posx
            local posy = result[1].posy
            local posz = result[1].posz
            local pumpname = result[1].pumpname
            TriggerClientEvent('mms-oilpumps:client:spawnpumponplayerjoin',src,posx,posy,posz,pumpname)
        end
    end)
end)

RegisterServerEvent('mms-oilpumps:server:UpgradePump',function (newlevel,newrate,newtime,upgradeprice)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.charIdentifier
    local Money = Character.money
    
    MySQL.query('SELECT * FROM `mms_oilpumps` WHERE identifier = ?', {identifier}, function(result)
    if result[1] ~= nil then
        if Money >= upgradeprice then
            MySQL.update('UPDATE `mms_oilpumps` SET pumplevel = ?,prate = ?,ptime = ? WHERE identifier = ?',{newlevel,newrate,newtime,identifier})
            VORPcore.NotifyTip(src, _U('Upgraded'), 5000)
            Character.removeCurrency(0,upgradeprice)
        else
            VORPcore.NotifyTip(src, _U('NotEnoghMoney'), 5000)
        end
    end
end)
end)

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()