function love.load()
  love.window.setTitle("Prueba")
  love.window.setMode(1000, 500)
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  titleFont = love.graphics.newFont("Cartoonish.ttf", 30)
  titleFont2 = love.graphics.newFont("Cartoonish.ttf", 50)
  love.graphics.setFont(titleFont)
  --love.window.setFullscreen(true)
  love.physics.setMeter(64)
  world = love.physics.newWorld(0,0)
  --pelota = love.physics.newBody(world,100,100,"dynamic",0)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

--ball
pelota = crearPelota()
pelota.ball.fixture:setUserData("pelota")
print(pelota.ball.shape:getRadius())

--Players
playersDimensionsWidth = width * 2 / 100 -- Dimension of 2% of the widht screen
playersDimensionsHeight = height * 20 / 100 -- Dimension of 20% of the height screen

player1 = crearPlayer(12)
player1X = player1.paleta.body:getX()
player1Y = player1.paleta.body:getY()
player1.paleta.fixture:setUserData("player1")
player2 = crearPlayer(12 / 11)
player2X = player2.paleta.body:getX()
player2.paleta.fixture:setUserData("player2")

puntajePlayer1 = 0
puntajePlayer2 = 0

--Vertical Walls
muroIzq = crearMurosVert(0,height / 2)
muroIzq.comp.fixture:setUserData("muroIzq")
muroDer = crearMurosVert(width, height / 2)
muroDer.comp.fixture:setUserData("muroDer")

muroArr = crearMurosHor(width / 2, 0)
muroAbj = crearMurosHor(width / 2, height)
--beginContact(pelota.ball.fixture, player1.paleta.fixture)
--beginContact(pelota.ball.fixture, player2.paleta.fixture)
--beginContact(pelota.ball.fixture, muroIzq.comp.fixture)
--beginContact(pelota.ball.fixture, muroDer.comp.fixture)
inicioPelota = love.math.random(0,1)
print(inicioPelota)
end

function love.update(dt)
  world:update(dt)
  if(love.keyboard.isDown("d")) then
    pelota.ball.body:applyForce(5000 * dt,0)
    --player.paleta.body:applyForce(3000 * dt, 0)
    --player1.paleta.body:setLinearVelocity(5000 * dt, 0)
    --print(pelota.ball.body:getLinearVelocity())
  end
  if(love.keyboard.isDown("a")) then
    if not(pelota.ball.body:isDestroyed()) then
      pelota.ball.body:applyForce(-5000 * dt, 0)
    end
  end

  if not(player1.paleta.body:isDestroyed()) then
    if(love.keyboard.isDown("w")) then
      --pelota.ball.body:applyForce(0, -5000 * dt)
      player1.paleta.body:applyForce(0, -9000 * dt)
      print(player1.paleta.body:getLinearVelocity())
    end
    if(love.keyboard.isDown("s")) then
      --pelota.ball.body:applyForce(0, 5000 * dt)
      player1.paleta.body:applyForce(0, 9000 * dt)
    end
    player1.paleta.body:setX(player1X)
  end

  if not(player2.paleta.body:isDestroyed()) then
    if(love.keyboard.isDown("up")) then
      player2.paleta.body:applyForce(0, -9000 * dt)
    end
    if(love.keyboard.isDown("down")) then
      player2.paleta.body:applyForce(0,9000 * dt)
    end
    player2.paleta.body:setX(player2X)
  end

  --beginContact(pelota.ball.fixture, player1.paleta.fixture)
  if(pelota.ball.body:isDestroyed()) then
    pelota = crearPelota()
    pelota.ball.fixture:setUserData("pelota")
    player1.paleta.body:destroy()
    player2.paleta.body:destroy()
    player1 = crearPlayer(12)
    player1.paleta.fixture:setUserData("player1")
    player2 = crearPlayer(12 / 11)
    player2.paleta.fixture:setUserData("player2")
  end

end

function love.draw()
  if not(pelota.ball.body:isDestroyed()) then
    love.graphics.circle("fill", pelota.ball.body:getX(), pelota.ball.body:getY(), pelota.ball.shape:getRadius())
  end
  if not(player1.paleta.body:isDestroyed()) then
    love.graphics.setColor(0,0,255)
    love.graphics.rectangle("fill", player1.paleta.body:getX() - playersDimensionsWidth / 2, player1.paleta.body:getY() - playersDimensionsHeight / 2, playersDimensionsWidth, playersDimensionsHeight)
  end
  if not(player2.paleta.body:isDestroyed()) then
    love.graphics.setColor(255,0,00)
    love.graphics.rectangle("fill", player2.paleta.body:getX() - playersDimensionsWidth / 2, player2.paleta.body:getY() - playersDimensionsHeight / 2, playersDimensionsWidth, playersDimensionsHeight)
  end
  love.graphics.setColor(255,255,255)
  puntaje = {}
  --puntaje.text = love.graphics.newText(titleFont, "")
  --puntaje.text:add("Juego", 100, 100)
  love.graphics.setFont(titleFont)
  love.graphics.print("Juego", width / 2, 10)
  love.graphics.setFont(titleFont2)
  love.graphics.print(puntajePlayer1, width / 12 + 50, 10)
  love.graphics.print(puntajePlayer2, (width / (12 / 11)) - 50, 10)
  --love.graphics.print(":)", 200, 200)
  --Puntaje = love.graphics.newText("Hola")
  --Vertical Walls
  love.graphics.rectangle("fill",muroIzq.comp.body:getX() - 2.5, muroIzq.comp.body:getY() - height / 2, 5, height)
  love.graphics.rectangle("fill",muroDer.comp.body:getX() - 2.5, muroDer.comp.body:getY() - height / 2, 5, height)
  love.graphics.setColor(0,255,0)
  love.graphics.rectangle("fill",muroArr.comp.body:getX() - width / 2, muroArr.comp.body:getY() - 2.5, width, 5)
  love.graphics.rectangle("fill",muroAbj.comp.body:getX() - width / 2, muroAbj.comp.body:getY() - 2.5, width, 5)
end

function crearPlayer(positionX)
  --player Components
    playerPosWidth = width / positionX
    playerPosHeight = height / 2
    player = {}
    player.paleta = {}
    player.paleta.body = love.physics.newBody(world, playerPosWidth, playerPosHeight, "dynamic",0)
    player.paleta.shape = love.physics.newRectangleShape(playersDimensionsWidth, playersDimensionsHeight)
    --player.paleta.shape = love.physics.newPolygonShape(playerPosWidth -15, playerPosHeight, playerPosWidth + 15, playerPosHeight, playerPosWidth + 15, playerPosHeight + 100, playerPosWidth - 15, playerPosHeight + 100 )
    player.paleta.fixture = love.physics.newFixture(player.paleta.body, player.paleta.shape, 0)
    --player.paleta.fixture:setRestitution(0)
    --print(width)
    --print(width / 2)
    --print(height / 2)
    --print(player.paleta.body:getX())
    --print(player.paleta.body:getY())
    return player
end

function crearMurosVert(positionX,positionY)
  --Walls Components
  muros = {}
  muros.comp = {}
  muros.comp.body = love.physics.newBody(world, positionX, positionY, "static",0)
  muros.comp.shape = love.physics.newRectangleShape(5,height)
  muros.comp.fixture = love.physics.newFixture(muros.comp.body, muros.comp.shape)
  return muros
end

function crearMurosHor(positionX, positionY)
  --Walls Components
  muros = {}
  muros.comp = {}
  muros.comp.body = love.physics.newBody(world, positionX, positionY, "static",0)
  muros.comp.shape = love.physics.newRectangleShape(width,5)
  muros.comp.fixture = love.physics.newFixture(muros.comp.body, muros.comp.shape)
  --muros.comp.fixture:setRestitution(0.9)
  muros.comp.fixture:setFriction(0)
  return muros
end

function love.keypressed(key)
  if(key == "w") then
    player1.paleta.body:setLinearVelocity(0,0)
    player1.paleta.body:setLinearVelocity(0,-180)
  end
  if(key == "s") then
    player1.paleta.body:setLinearVelocity(0,0)
    player1.paleta.body:setLinearVelocity(0,180)
  end
  if(key == "up") then
    player2.paleta.body:setLinearVelocity(0,0)
    player2.paleta.body:setLinearVelocity(0, -180)
  end
  if(key == "down") then
    player2.paleta.body:setLinearVelocity(0,0)
    player2.paleta.body:setLinearVelocity(0, 180)
  end
  if(key == "space" and pelota.ball.body:getLinearVelocity() == 0) then
    if(inicioPelota == 0) then
      pelota.ball.body:applyLinearImpulse(-80, 0)
    else
      pelota.ball.body:applyLinearImpulse(80,0)
    end
  end
end

function love.keyreleased(key)
  if(key == "w") then
    player1.paleta.body:setLinearVelocity(0,0)
  end
  if(key == "s") then
    player1.paleta.body:setLinearVelocity(0,0)
  end
  if(key == "up") then
    player2.paleta.body:setLinearVelocity(0,0)
  end
  if(key == "down") then
    player2.paleta.body:setLinearVelocity(0,0)
  end
end

function crearPelota()
  --Ball Components
    pelota = {}
    pelota.ball = {}
    pelota.ball.body = love.physics.newBody(world,width / 2,height / 2,"dynamic",0)
    pelota.ball.shape = love.physics.newCircleShape(((width - height) * 3) / 100)
    pelota.ball.fixture = love.physics.newFixture(pelota.ball.body, pelota.ball.shape, 1)
    pelota.ball.fixture:setRestitution(0.9)
    return pelota
end

function beginContact(a,b,col)
  --x,y = coll.getNormal()

    print(a:getUserData())
    print(b:getUserData())
    if(a:getUserData() == "muroIzq" and b:getUserData() == "pelota") then
      --print("GOL")
      pelota.ball.body:destroy()
      inicioPelota = 0
      puntajePlayer2 = puntajePlayer2 + 1
      print(inicioPelota)
    end
    if(a:getUserData() == "muroDer" and b:getUserData() == "pelota") then
      pelota.ball.body:destroy()
      inicioPelota = 1
      puntajePlayer1 = puntajePlayer1 + 1
      print(inicioPelota)
    end

    if(a:getUserData() == "player1" and b:getUserData() == "pelota") then
      actualVelX, actualVelY = pelota.ball.body:getLinearVelocity()
      actualPlayer1VelX, actualPlayer1VelY = player1.paleta.body:getLinearVelocity()
      print(actualVelY)
      pelota.ball.body:setLinearVelocity(30,0)
      pelota.ball.body:applyForce(5000,(actualVelY + actualPlayer1VelY) * 10)
      print("yay")
    end
    if(a:getUserData() == "player2" and b:getUserData() == "pelota") then
      actualVelX, actualVelY = pelota.ball.body:getLinearVelocity()
      actualPlayer2VelX, actualPlayer2VelY = player2.paleta.body:getLinearVelocity()
      pelota.ball.body:setLinearVelocity(-30,0)
      pelota.ball.body:applyForce(-5000,(actualVelY + actualPlayer2VelY) * 10)
    end
end
