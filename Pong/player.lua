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
