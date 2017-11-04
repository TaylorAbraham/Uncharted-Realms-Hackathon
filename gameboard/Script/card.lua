local http = require "socket.http"
local card = {}

power = 0
toughness = 0
clock = 0
back = ""
front = ""
frame= "/Card/GoldFrame.png"
deckframe="/Card/SilverFrame.png"

local function createCard(atk, def, clk, backPath, frontPath)
    --print("Test function called")
    power = atk
    toughness = def
    clock = clk
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
    scaleX, scaleY = getImageScaleForNewDimensions(drawn, 80, 112)
    love.graphics.draw(drawn, x , y, 0 , scaleX, scaleY)
    frameback = love.graphics.newImage(deckframe)
    scaleX, scaleY = getImageScaleForNewDimensions(frameback, 80, 112)
    love.graphics.draw(frameback, x, y, 0, scaleX, scaleY)
end

local function drawpng_front(x, y)
    -- Card
    drawn = love.graphics.newImage(front)
    scaleX, scaleY = getImageScaleForNewDimensions(drawn, 80, 135)
    love.graphics.draw(drawn, x , y, 0, scaleX, scaleY)
    love.graphics.print("Atk: " .. power, x+20, y+80, 0, 1, 0.9)
    love.graphics.print("Def: " .. toughness, x+20, y+95, 0, 1, 0.9) 
    love.graphics.print("Clock: " .. clock, x+17, y+108, 0, 1, 0.9)    

    -- Borders
    framefront = love.graphics.newImage(frame)
    scaleX, scaleY = getImageScaleForNewDimensions(framefront, 80, 135)
    love.graphics.draw(framefront, x , y, 0, scaleX, scaleY)

end

local function getValues()
    return power, toughness, effects
end

local function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end



card.createCard = createCard
card.getValues = getValues

card.init = init
card.draw = draw
card.drawandpos = drawandpos
card.drawpng_back = drawpng_back
card.drawpng_front = drawpng_front
card.getImageScaleForNewDimensions = getImageScaleForNewDimensions

return card