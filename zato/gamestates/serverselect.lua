-- zato
-- serverselect
-- runs when in the serverselect

function serverselect_keypressed()

end

function serverselect_update(dt)
  -- love update when gamestate is in serverselect

end

function serverselect_draw()
  -- love draw when gamestate is in serverselect
  love.graphics.print("Zato - Select Server" , 10, 10)
end
