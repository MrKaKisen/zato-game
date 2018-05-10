-- Zato
-- main file
-- Copyright Vilhelm Prytz 2017

-- require stuff (lib)
require("lib/setup")
require("lib/globalEvents")
require("lib/networking")
ingame ={},

-- require different states (used soon)
require("gamestates/login")
require("gamestates/mainmenu")
require("gamestates/serverselect")
require("gamestates/ingame")

-- vars
local gamestates = {
  login = 0,
  mainmenu = 1,
  ingame = 2,
  serverselect = 3
}

gamestate = gamestates.login

-- love load
function love.load()
  -- setup love
  screen = setup_love()

end


-- Love keypressed
function love.keypressed(key)
  if gamestate == gamestates.login then
    login_keypressed(key)
  elseif gamestate == gamestates.mainmenu then
    mainmenu_keypressed(key)
  elseif gamestate == gamestates.ingame then
    ingame_keypressed(key)
  elseif gamestate == gamestates.serverselect then
    serverselect_keypressed(key)
  end
end

-- love update
function love.update(dt)
  -- global events
  globalEvent_update(dt, screen)

  if gamestate == gamestates.login then
    gamestateReturn = login_update(dt)
  elseif gamestate == gamestates.mainmenu then
    gamestateReturn = mainmenu_update(dt)
  elseif gamestate == gamestates.ingame then
    gamestateReturn = ingame_update(dt)
  elseif gamestate == gamestates.serverselect then
    gamestateReturn = serverselect_update(dt)
  end

  if gamestateReturn ~= nil then
    gamestate = gamestateReturn
  end
end


-- love draw
function love.draw()
  -- global events
  globalEvent_draw()

  if gamestate == gamestates.login then
    login_draw()
  elseif gamestate == gamestates.mainmenu then
    mainmenu_draw()
  elseif gamestate == gamestates.ingame then
    ingame_draw()
  elseif gamestate == gamestates.serverselect then
    serverselect_draw()
  end
end
