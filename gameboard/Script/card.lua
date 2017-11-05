local http = require "socket.http"

Card = {}
Card.__index = Card
local logo

function Card:create(atk, def, clk, name, link)
  local crd = {}
  setmetatable(crd, Card)
  crd.power = atk
  crd.toughness = def
  crd.clock = clk
  crd.name = name
  crd.link = link
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
    scaleX, scaleY = getImageScaleForNewDimensions(drawn, 200, 275)
    love.graphics.draw(drawn, x , y, 0 , scaleX, scaleY)
    frameback = love.graphics.newImage(deckframe)
    scaleX, scaleY = getImageScaleForNewDimensions(frameback, 200, 275)
    love.graphics.draw(frameback, x, y, 0, scaleX, scaleY)
end

function Card:drawpng_front(x, y)
    -- Card
    drawn = love.graphics.newImage(front)
    scaleX, scaleY = getImageScaleForNewDimensions(drawn, 190, 272)
    love.graphics.draw(drawn, x , y, 0, scaleX, scaleY)
    love.graphics.print(self.name, x+20, y+20, 0, 1, 1)        
    love.graphics.print("Atk: " .. self.power, x+25, y+198, 0, 1, 1)
    love.graphics.print("Def: " .. self.toughness, x+25, y+218, 0, 1, 1) 
    love.graphics.print("Clock: " .. self.clock, x+25, y+238, 0, 1, 1)

    logo = http.request(self.link)
    logo = love.filesystem.newFileData(logo, "logo.png")
    logo = love.graphics.newImage(logo)
    scaleX, scaleY = getImageScaleForNewDimensions(logo, 130, 130)
    love.graphics.draw(logo, x+30, y+40, 0, scaleX, scaleY)

    -- Borders
    framefront = love.graphics.newImage(frame)
    scaleX, scaleY = getImageScaleForNewDimensions(framefront, 190, 272)
    love.graphics.draw(framefront, x , y, 0, scaleX, scaleY)



end


function Card:getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
