local Player = {
    x = 150,
    y = 800,
    xv = 0,
    max_xv = 300,
    image = lg.newImage("car.png")
}

function Player:Draw()
    lg.draw(self.image, self.x, self.y)
end

function Player:Update(dt)
    self.x = self.x + self.xv * dt

    if not (input.right() and input.left()) then
        if input.right() then
            self.xv = self.xv + 500 * dt
        elseif input.left() then
            self.xv = self.xv - 500 * dt
        else
            self.xv = self.xv * math.pow(0.4, dt)
        end
    end
    if self.xv > self.max_xv then self.xv = self.max_xv elseif self.xv < - self.max_xv then self.xv = - self.max_xv end
    if self.x < 0 then
        self.x = 0
        self.xv = 0
    elseif self.x + self.image:getWidth() > game_width then
        self.x = game_width - self.image:getWidth()
        self.xv = 0
    end
end

return Player