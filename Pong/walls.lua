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
