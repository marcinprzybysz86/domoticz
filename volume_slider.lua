commandArray = {}

-- Name of the dummy Domoticz dimmer:
DomDevice = 'GŁOŚNOŚĆ'

if devicechanged[DomDevice] then
    --print(DomDevice..' received order: '..devicechanged[DomDevice]) -- DEBUG:
    
    if string.match(devicechanged[DomDevice], 'Set Level: ') then -- "Set Level: 42 %" type of order
        print(DomDevice..' level changed ('..otherdevices_svalues[DomDevice]..')') -- DEBUG:

        -- Compute the volume: Use the "Set Level: 42 %" order and strip anything that's not a digit
        volume = devicechanged[DomDevice]:gsub('%D', '')
        volumestr = tonumber(volume)
        fullurl = 'http://[OPENWEBIF_IP]/web/vol?set=set' .. volumestr
        print('adres: ' .. fullurl)
        -- Supports level=0 (even though Domoticz seems to handle it: Setting device's level/slider to "0", sets device to "Off")
       commandArray['OpenURL']= fullurl
    end
end

return commandArray
