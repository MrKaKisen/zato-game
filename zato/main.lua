-- Zato
-- main file
-- Copyright Vilhelm Prytz 2017

-- require stuff (lib)
require("lib/server")
require("lib/setup")
-- require different states (used soon)
require("gamestates/mainmenu")
require("gamestates/serverselect")
require("gamestates/ingame")


-- setup love
setup_love()

-- do things
-- mainmenu_main()
-- serverselect_main()
ingame_main()
