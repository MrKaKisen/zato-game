-- setup.lua
-- sets stuff up

function setup_love()
  love.window.setTitle("Zato")
  love.window.setMode(1280, 720, {resizable=false, vsync=true})
  love.window.setDisplaySleepEnabled(false)
  -- add later on when an icon is made
  -- local iconImage = love.graphics.newImage("assets/img/logos/icon.png")
  -- love.window.setIcon(iconImage)
end
