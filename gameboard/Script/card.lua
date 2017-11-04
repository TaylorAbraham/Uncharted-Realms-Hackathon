local card = {}

local function init(x,y)
    love.window.setPosition(x,y)
end

local function draw()
    love.graphics.print("hello")
end

local function drawandpos(x,y,z)
    love.graphics.print(z, x, y)
end

local function drawpng(path, x, y)
    drawn = love.graphics.newImage(path)
    love.graphics.draw(drawn, x , y)
end

card.init = init
card.draw = draw
card.drawandpos = drawandpos
card.drawpng = drawpng

return card

