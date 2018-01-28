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
