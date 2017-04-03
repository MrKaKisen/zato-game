-- Learning LOVE 2D

enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
love.graphics.setDefaultFilter("nearest", "nearest")
enemies_controller.image = love.graphics.newImage("enemy.png")
explosion_sound = love.audio.newSource("explosion.mp3")

-- particle system
particle_systems = {}
particle_systems.list = {}
particle_systems.img = love.graphics.newImage("particle.png")

function particle_systems:spawn(x, y)
  local ps = {}
  ps.x = x
  ps.y = y
  ps.ps = love.graphics.newParticleSystem(particle_systems.img, 32)
  ps.ps:setParticleLifetime(2, 4)
  ps.ps:setEmissionRate(5)
  ps.ps:setSizeVariation(1)
  ps.ps:setLinearAcceleration(-20, -20, 20, 20)
  ps.ps:setColors(100, 255, 100, 255, 0, 255, 0, 255)
  table.insert(particle_systems.list, ps)
end

function particle_systems:draw()
  for _,v in pairs(particle_systems.list) do
    love.graphics.draw(v.ps, v.x, v.y)
  end
end

function particle_systems:update(dt)
  for _,v in pairs(particle_systems.list) do
    v.ps:update()
  end
end

function particle_systems:cleanup()

end

-- check collision
function checkCollisions(enemies, bullets)
  for i,e in ipairs(enemies) do
    for _, b in pairs(bullets) do
      if b.y <= e.y + e.height and b.x > e.x and  b.x < e.x + e.width then
        particle_systems:spawn(e.x, e.y)
        table.remove(enemies, i)
        love.audio.play(explosion_sound)
      end
    end
  end
end

-- load function
function love.load()
  -- set game title
  love.window.setTitle("Invaders")
  -- game status
  game_over = false
  game_win = false

  -- bg image
  background_image = love.graphics.newImage("background.png")
  -- menu vars
  menu = {}
  menu.active = "False"
  menu.timer = 0
  menu.just_quit = "False"
  menu.timer_quit = 20

  -- player vars
  player = {}
  player.x = 0
  player.y = 110
  player.bullets = {}
  player.cooldown = 20
  player.speed = 2

  -- player image
  player.image = love.graphics.newImage("player.png")

  -- sound
  player.fire_sound = love.audio.newSource("shoot.mp3")
  background = {}
  background.music = love.audio.newSource("bg-music.mp3")
  background.music:setLooping(true)
  -- just play it once
  love.audio.play(background.music)


  player.fire = function()
    if player.cooldown <= 0 then
      love.audio.play(player.fire_sound)
      player.cooldown = 20
      bullet = {}
      bullet.x = player.x + 4
      bullet.y = player.y + 3
      table.insert(player.bullets, bullet)
    end
  end
  for i=0, 10 do
    enemies_controller:spawnEnemy(i * 15, 0)
  end

end

function enemies_controller:spawnEnemy(x, y)
  -- enemey vars
  enemy = {}
  enemy.x = x
  enemy.y = y
  enemy.height = 10
  enemy.width = 10
  enemy.bullets = {}
  enemy.cooldown = 20
  enemy.speed = .2
  table.insert(self.enemies, enemy)
end
function enemy:fire()
  if self.cooldown <= 0 then
    self.cooldown = 20
    bullet = {}
    bullet.x = self.x + 35
    bullet.y = self.y
    table.insert(self.bullets, bullet)
  end
end

-- update function
function love.update(dt)
  if menu.just_quit == "True" then
    menu.timer_quit = menu.timer_quit - 1
    if menu.timer_quit == 0 then
      menu.timer_quit = 20
      menu.just_quit = "False"
    end
  end
  if (menu.active ==  "True") then
    if menu.timer <= 0 then

    else
      menu.timer = menu.timer - 1
    end
    if menu.timer == 0 then
      menu.timer = 0
      if love.keyboard.isDown("escape") then
        menu.active = "False"
        menu.just_quit = "True"
      end
    end
  else
    player.cooldown = player.cooldown - 1
    if (love.keyboard.isDown("right")) then
      player.x = player.x + player.speed
    elseif (love.keyboard.isDown("left")) then
      player.x = player.x - player.speed
    end

    -- fire bullet
    if love.keyboard.isDown( "space" ) then
      player.fire()
    end

    -- menu pause
    if love.keyboard.isDown("escape") then
      if menu.just_quit == "False" then
        menu.active = "True"
        menu.timer = 40
      end
    end


    -- checking if no enemies left
    if #enemies_controller.enemies == 0 then
      game_win = true
    end
    -- moving enemies
    for _,e in pairs(enemies_controller.enemies) do
      if e.y >= love.graphics.getHeight()/5 then
        game_over = true
      else
        e.y = e.y + 1 * e.speed
      end
    end

    -- moving bullets
    for i,b in ipairs(player.bullets) do
      if b.y < -10 then
        table.remove(player.bullets, i)
      end
      b.y = b.y - 2
    end

    -- check collision
    checkCollisions(enemies_controller.enemies, player.bullets)
  end
end

-- draw function
function love.draw()
  -- bg in the beggining
  love.graphics.draw(background_image)

  -- if win / lose statements
  if game_over then
    love.graphics.print("Game Over!")
    menu.active = "True"
  elseif game_win then
    love.graphics.print("You won!")
  end

  -- my own menu stuff
  if menu.active == "True" then
    if game_over == false then
      love.graphics.print("PAUSED", 10, 10)
    end
  end
  -- global scale
  love.graphics.scale(5)
  -- draw player
  love.graphics.setColor(255,255,255)
  love.graphics.draw(player.image, player.x, player.y)

  -- draw enemies
  for _,e in pairs(enemies_controller.enemies) do
    love.graphics.draw(enemies_controller.image, e.x, e.y, 0)
  end


  -- draw bullets
  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 2, 2)
  end
end
