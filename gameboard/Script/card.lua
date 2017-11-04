local card = {}

power = 0
toughness = 0
effects = ""
back = ""
front = ""

local function createCard(int1, int2, strArr, backPath, frontPath)
    print("Test function called")
    power = int1
    toughness = int2
    effects = strArr
    back = backPath
    front = frontPath
end

local function init(x,y)
    love.window.setPosition(x,y)
end

local function draw()
    love.graphics.print("hello")
end

local function drawandpos(x,y,z)
    love.graphics.print(z, x, y)
end

local function drawpng_back(x, y)
    drawn = love.graphics.newImage(back)
    love.graphics.draw(drawn, x , y)
end

local function drawpng_front(x, y)
    drawn = love.graphics.newImage(front)
    love.graphics.draw(drawn, x , y)
end

local function getValues()
    return power, toughness, effects
end

card.createCard = createCard
card.getValues = getValues

card.init = init
card.draw = draw
card.drawandpos = drawandpos
card.drawpng_back = drawpng_back
card.drawpng_front = drawpng_front

return card