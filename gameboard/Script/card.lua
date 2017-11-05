local http = require "socket.http"

Card = {}
Card.__index = Card

function Card:create(atk, def, clk, name)
  local crd = {}
  setmetatable(crd, Card)
  crd.power = atk
  crd.toughness = def
  crd.clock = clk
  crd.name = name
  return crd
end

function Card:get_power()
  return self.power
end

function Card:get_toughness()
  return self.toughness
end

function Card:get_clock()
  return self.clock
end


back =  "/Card/BackTexture.png"
front =  "/Card/FrontTexture.png"
frame= "/Card/GoldFrame.png"
deckframe="/Card/SilverFrame.png"

function Card:drawpng_back(x, y)
    drawn = love.graphics.newImage(back)
    scaleX, scaleY = getImageScaleForNewDimensions(drawn, 80, 112)
    love.graphics.draw(drawn, x , y, 0 , scaleX, scaleY)
    frameback = love.graphics.newImage(deckframe)
    scaleX, scaleY = getImageScaleForNewDimensions(frameback, 80, 112)
    love.graphics.draw(frameback, x, y, 0, scaleX, scaleY)
end

function Card:drawpng_front(x, y, name)
    -- Card
    drawn = love.graphics.newImage(front)
    scaleX, scaleY = getImageScaleForNewDimensions(drawn, 150, 135)
    love.graphics.draw(drawn, x , y, 0, scaleX, scaleY)
    love.graphics.print(self.name, x+15, y+10, 0, 0.9, 0.9)        
    love.graphics.print("Atk: " .. self.power, x+20, y+92, 0, 1, 0.9)
    love.graphics.print("Def: " .. self.toughness, x+20, y+103, 0, 1, 0.9) 
    love.graphics.print("Clock: " .. self.clock, x+15, y+114, 0, 1, 0.9)

    -- Borders
    framefront = love.graphics.newImage(frame)
    scaleX, scaleY = getImageScaleForNewDimensions(framefront, 150, 135)
    love.graphics.draw(framefront, x , y, 0, scaleX, scaleY)

end


function Card:getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
