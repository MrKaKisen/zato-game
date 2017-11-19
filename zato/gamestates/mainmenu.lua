-- zato
-- mainmenu
-- runs when in the mainmenu

-- require lib stuff
require("../lib/map/mapParse")

menu = {}

local menuOptions = {
  play = 1,
  settings = 2,
  quit = 3
}

local menuStates = {
  main = 1,
  play = 2,
  settings = 3
}

menu.menuState = menuStates.main
menu.Option = menuOptions.play
menu.Cooldown = 0
menu.JustChanged = false
menu.CooldownSet = 10

playState = {}
playState.loaded = false

settingState = {}

function mainmenu_update(dt)
  if menu.menuState == menuStates.main then
    if menu.JustChanged == true then
      if menu.Cooldown > 0 then
        menu.Cooldown = menu.Cooldown-1
      end
    end

    -- love update when gamestate is in mainmenu
    if love.keyboard.isDown("down") then
      if menu.Cooldown == 0 then
        if menu.Option == menuOptions.quit then
          menu.Option = menuOptions.play
        else
          menu.Option = menu.Option+1
        end
        menu.Cooldown = menu.CooldownSet
        menu.JustChanged = true
      end
    end

    if love.keyboard.isDown("up") then
      if menu.Cooldown == 0 then
        if menu.Option == menuOptions.play then
          menu.Option = menuOptions.quit
        else
          menu.Option = menu.Option-1
        end
        menu.Cooldown = menu.CooldownSet
        menu.JustChanged = true
      end
    end

    if love.keyboard.isDown("return") then
      if menu.Option == menuOptions.play then
        menu.menuState = menuStates.play
      elseif menu.Option == menuOptions.settings then
        menu.menuState = menuStates.settings
      elseif menu.Option == menuOptions.quit then
        love.event.quit(0)
      end
    end

  elseif menu.menuState == menuStates.play then
    if love.keyboard.isDown("escape") or love.keyboard.isDown("backspace") then
      menu.menuState = menuStates.main
      playState.loaded = false
    end

    if playState.loaded == false then
      playState.loaded = true

      require("../assets/maps/maps-list")
      parseMapConf(availableMaps)
    end

  elseif menu.menuState == menuStates.settings then
    if love.keyboard.isDown("escape") or love.keyboard.isDown("backspace") then
      menu.menuState = menuStates.main
    end
  end
end

function mainmenu_draw()
  -- love draw when gamestate is in mainmenu
  -- global font for WHOLE menu
  love.graphics.setNewFont(18)

  if menu.menuState == menuStates.main then
    love.graphics.print("Zato" , 10, 10)
    love.graphics.print(menu.Option , 75, 10)
    love.graphics.print(menu.Cooldown , 125, 10)
    love.graphics.print(love.graphics.getWidth() .. "x" .. love.graphics.getHeight(), 175, 10)

    if menu.Option == menuOptions.play then
      love.graphics.print("[Play]", 10, 35)
    else
      love.graphics.print("Play", 10, 35)
    end

    if menu.Option == menuOptions.settings then
      love.graphics.print("[Settings]", 10, 50)
    else
      love.graphics.print("Settings", 10, 50)
    end

    if menu.Option == menuOptions.quit then
      love.graphics.print("[Quit]", 10, 65)
    else
      love.graphics.print("Quit", 10, 65)
    end
  elseif menu.menuState == menuStates.play then
    if playState.loaded == true then
      love.graphics.print("Zato" , 10, 10)
      love.graphics.print("Play" , 50, 10)

    end
  elseif menu.menuState == menuStates.settings then
    love.graphics.print("Zato" , 10, 10)
    love.graphics.print("Settings" , 50, 10)
  end

end
