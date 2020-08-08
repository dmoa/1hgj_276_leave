local Cars = {
    image = lg.newImage("car_opp.png"),
    x = 50,
    y = -100,
    colors = {1, 0, 0},
    yv = -1
}


function Cars:Draw()
    lg.setColor(self.colors, 1)
    lg.draw(self.image, self.x, self.y)
    lg.setColor(1, 1, 1, 1)
end

function Cars:Update(dt)
    self.y = self.y + self.yv * dt

    if self.y > game_height then self:Reset() end
end

function Cars:Reset()
    self.x = lm.random(game_width - self.image:getWidth())
    self.y = - lm.random(1000) - self.image:getHeight() * 2
    self.colors = {lm.random(), lm.random(), lm.random()}
    self.yv = lm.random(500) + 100
end

Cars:Reset()
return Cars