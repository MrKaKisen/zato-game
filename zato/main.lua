-- Zato
-- main file
-- Copyright Vilhelm Prytz 2017

-- require stuff (lib)
require("lib/server")
require("lib/setup")
ingame ={},

-- require different states (used soon)
require("gamestates/mainmenu")
require("gamestates/serverselect")
require("gamestates/ingame")

local gamestates = {
  mainmenu = 1,
  ingame = 2,
  serverselect = 3
}

gamestate = gamestates.mainmenu

-- love load
function love.load()
  -- setup love
  setup_love()

end

-- love update
function love.update(dt)
  if gamestate == gamestates.mainmenu then
    mainmenu_update(dt)
  elseif gamestate == gamestates.ingame then
    ingame_update(dt)
  elseif gamestate == gamestates.serverselect then
    serverselect_update(dt)
  end
end


-- love draw
function love.draw()
  if gamestate == gamestates.mainmenu then
    mainmenu_draw()
  elseif gamestate == gamestates.ingame then
    ingame_draw()
  elseif gamestate == gamestates.serverselect then
    serverselect_draw()
  end
end
