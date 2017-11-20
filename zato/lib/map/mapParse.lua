-- Zato
-- parse map
-- Copyright Vilhelm Prytz 2017

function parseMapConf(mapsList)
  for mapName, mapConf in pairs(mapsList) do
    require("../../assets/maps/" .. mapConf)
    print("Name: " .. map.name)
    print("Description: " .. map.description)
    print("Fg Mapfile: " .. map.foregrund_mapFile)
    print("Bg mapfile: " .. map.background_mapFile)
    print("Spritefile: " .. map.spriteFile)
  end
end
