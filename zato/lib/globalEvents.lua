-- Zato
-- global events file
-- Copyright Vilhelm Prytz 2017

-- vars
fps = {}
fps.enabled = false
fps.changeCooldown = 0

function globalEvent_update(dt, screen)
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

        screen.width = love.graphics.getWidth( )
        screen.height = love.graphics.getHeight( )
      else
        success = love.window.setFullscreen(false, "desktop")
        screen.mode = "window"
        screen.changeCooldown = 15

        screen.width = love.graphics.getWidth( )
        screen.height = love.graphics.getHeight( )
      end
    end
  end
end

function globalEvent_draw()
  -- global draw functions (hardcoded)
  if fps.enabled == true then
    love.graphics.setNewFont(14)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), screen.width-70, 5)
  end
end
