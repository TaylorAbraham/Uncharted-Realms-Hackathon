local http = require "socket.http"
local json = require "Script.json"
local scaleX, scaleY
require("Script.card")
require("Script.player")

deckSize = 8
handSize = 3

deck = {}
hand = {}

function love.load()
    canvas = love.graphics.newCanvas(800, 600)

    result, statuscode, content = http.request("http://localhost:5000/cards/generate/8")
        
    parsedResult = json.decode(result)

    for i=1,deckSize do
        table.insert(deck,i,Card:create(parsedResult.cards[i].POW, parsedResult.cards[i].HP, parsedResult.cards[i].CLK, parsedResult.cards[i].NAME))
    end

    for i=1,handSize do
        hand[i] = deck[i]
    end
    
    p1 = Player:new(deck,"test")
    p1:drawHand()
    --[[print(p1.deck[1].power)
    print(p1.hand[1].power)
    print(p1.hand[2].power)
    print(p1.hand[3].power)--]]
    

    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setBackgroundColor(250, 215, 160)
        love.graphics.line(0, 445, 800, 445)

        love.graphics.setLineWidth(5)
        love.graphics.line(0, 300, 800, 300)
    love.graphics.setCanvas()
    
    --[[local exit=false
    while(not exit)
    do
      exit=p1:turn()
    end
    print("end")--]]
end
 
function love.draw()
 
    -- The rectangle from the Canvas was already alpha blended.
    -- Use the premultiplied alpha blend mode when drawing the Canvas itself to prevent improper blending.
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(canvas)
    -- Observe the difference if the Canvas is drawn with the regular alpha blend mode instead.
    love.graphics.setBlendMode("alpha")
    Card:drawpng_back(600, 480)

    for i=1,handSize do
        hand[i]:drawpng_front(200*i - 200,465)
    end

    love.graphics.draw(canvas)
    p1= Player:new(deck,"test")
    p1:turn()

end


function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
