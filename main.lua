la = love.audio
ld = love.data
le = love.event
lfile = love.filesystem
lf = love.font
lg = love.graphics
li = love.image
lj = love.joystick
lk = love.keyboard
lm = love.math
lmouse = love.mouse
lp = love.physics
lsound = love.sound
lsys = love.system
lth = love.thread
lt = love.timer
ltouch = love.touch
lv = love.video
lw = love.window

lg.setDefaultFilter("nearest", "nearest", 1)
lg.setLineStyle('rough')

splash = require "libs/splash"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 2, {}, function()

input = require "libs/input"

push = require "libs/push"
game_width, game_height = 512, 1024
window_width, window_height = game_width, game_height
lw.setMode(window_width, window_height, {borderless = false})
push:setupScreen(game_width, game_height, window_width, window_height, {fullscreen = false, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())

font = love.graphics.newFont(30)

player = require "Player"
opp_car = require "opp_car"

score = 0
highscore = 0

random = 10

oof_alpha = 0

function love.draw()
    screen:apply()
    push:start()

    lg.setColor(0.1, 0.1, 0.1)
    lg.rectangle("fill", 0, 0, game_width, game_height)
    lg.setColor(1, 1, 1)

    lg.print("leaving work with your phone", font, 15, 200)
    lg.print("highscore: "..math.floor(highscore), font, 15, 55)
    lg.print("score: "..math.floor(score), font, 15, 15)

    lg.setColor(1, 1, 1, oof_alpha)
    lg.print("DIED.", font, 15, 250)
    lg.setColor(1, 1, 1, 1)

    player:Draw()
    opp_car:Draw()

    push:finish()
end

function love.update(dt)
    screen:update(dt)

    player:Update(dt)
    opp_car:Update(dt)
    score = score + dt
    random = random - dt
    if random < 0 then
        random =  lm.random(1) + 5
        love.window.setPosition(lm.random(1000), lm.random(1000))
    end

    if player.x + player.image:getWidth() > opp_car.x and player.x < opp_car.x + opp_car.image:getWidth() and player.y + player.image:getHeight() > opp_car.y and player.y < opp_car.y + opp_car.image:getHeight() then
        if score > highscore then highscore = score end
        score = 0
        oof_alpha = 1.5
    end
    oof_alpha = oof_alpha - dt
end

function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
end

function love.resize(w, h)
  push:resize(w, h)
  lg.clear()
end

end)