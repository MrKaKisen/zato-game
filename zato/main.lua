-- Zato
-- main file
-- Copyright Vilhelm Prytz 2017

-- require stuff (lib)
require("lib/server")
require("lib/setup")
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

fps = {}
fps.enabled = false
fps.changeCooldown = 0

screen = {}
screen.width = love.graphics.getWidth( )
screen.height = love.graphics.getHeight( )
screen.mode = "window"
screen.changeCooldown = 0

gamestate = gamestates.mainmenu

-- love load
function love.load()
  -- setup love
  setup_love()

end

-- love update
function love.update(dt)

  -- cooldowns
  if screen.changeCooldown > 0 then
    screen.changeCooldown = screen.changeCooldown-1
  end
  if fps.changeCooldown > 0 then
    fps.changeCooldown = fps.changeCooldown-1
  end

  -- global update functions (hardcoded)
  if love.keyboard.isDown("f5") then
    love.event.quit( "restart" )
  end
  if love.keyboard.isDown("f6") then
    if fps.changeCooldown == 0 then
      if fps.enabled == true then
        fps.enabled = false
        fps.changeCooldown = 15
      elseif fps.enabled == false then
        fps.enabled = true
        fps.changeCooldown = 15
      end
    end
  end
  if love.keyboard.isDown("f12") then
    if screen.changeCooldown == 0 then
      if screen.mode == "window" then
        success = love.window.setFullscreen(true, "desktop")
        screen.mode = "fullscren"
        screen.changeCooldown = 15
      else
        success = love.window.setFullscreen(false, "desktop")
        screen.mode = "window"
        screen.changeCooldown = 15
      end
    end
  end

  if gamestate == gamestates.login then
    login_update(dt)
  elseif gamestate == gamestates.mainmenu then
    mainmenu_update(dt)
  elseif gamestate == gamestates.ingame then
    ingame_update(dt)
  elseif gamestate == gamestates.serverselect then
    serverselect_update(dt)
  end
end


-- love draw
function love.draw()

  -- global draw functions (hardcoded)
  if fps.enabled == true then
    love.graphics.setNewFont(14)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), screen.width, 5)
  end

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
