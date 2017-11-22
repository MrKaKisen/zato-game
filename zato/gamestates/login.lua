-- zato
-- login
-- runs when in the login

-- global gamestates
local gamestates = {
  login = 0,
  mainmenu = 1,
  ingame = 2,
  serverselect = 3
}

function login_keypressed()

end

function login_update(dt)
  -- love update when gamestate is in login
  return gamestates.mainmenu
end

function login_draw()
  -- love draw when gamestate is in login

end
