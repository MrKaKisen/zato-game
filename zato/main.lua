-- Zato
-- main file
-- Copyright Vilhelm Prytz 2017

-- require stuff (lib)
require("lib/server")
require("lib/setup")
-- require different states (used soon)
--require("gamestates/mainmenu.lua")
--require("gamestates/serverselect.lua")
require("gamestates/ingame.lua")


-- setup love
setup_love()

-- do things
while true do
  -- mainmenu_main()
  -- serverselect_main()
  ingame_main()
end
