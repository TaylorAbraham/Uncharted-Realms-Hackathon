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

local function createCard(int1, int2, strArr)
    print("Test function called")
    power = int1
    toughness = int2
    effects = strArr
end

local function getValues()
    return power, toughness, effects
end

card.createCard = createCard
card.getValues = getValues

card.init = init
card.draw = draw
card.drawandpos = drawandpos
card.drawpng = drawpng

return card