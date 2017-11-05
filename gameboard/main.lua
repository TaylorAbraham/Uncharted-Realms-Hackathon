local http = require "socket.http"
local json = require "Script.json"
local scaleX, scaleY
require("Script.card")
require("Script.player")

deckSize = 12
handSize = 3
fieldSize = 0

deck = {}
hand = {}
field = {}

function love.load()
    canvas = love.graphics.newCanvas(1280, 800)

    love.window.setMode(1280, 800, {resizable=false, vsync=false, minwidth=400, minheight=300})    

    result, statuscode, content = http.request("http://localhost:5000/cards/generate/12")
        
    parsedResult = json.decode(result)

    for i=1,deckSize do
        table.insert(deck,i,Card:create(parsedResult.cards[i].POW, parsedResult.cards[i].HP, parsedResult.cards[i].CLK, parsedResult.cards[i].NAME, parsedResult.cards[i].IMG))
    end

    for i=1,handSize do
        hand[i] = deck[i]
        table.remove(deck,i)
    end
    
    p1= Player:new(deck,"player", hand, field, handSize, deckSize, fieldSize)

    

    --[[print(p1.deck[1].power)
    print(p1.hand[1].power)
    print(p1.hand[2].power)
    print(p1.hand[3].power)--]]
    

    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setBackgroundColor(250, 215, 160)
        love.graphics.line(0, 445, 1280, 445)

        love.graphics.setLineWidth(5)
        love.graphics.line(0, 300, 1280, 300)
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
    Card:drawpng_back(1000, 500)

    for i=1,handSize do
        hand[i]:drawpng_front(300*i - 200,500)
    end


    love.graphics.draw(canvas)

    p1:turn()

    heart = love.graphics.newImage("/Card/heart.png")
    scaleX, scaleY = getImageScaleForNewDimensions(heart, 100, 100)    
    love.graphics.draw(heart, 1100, 100, 0, scaleX, scaleY)
    love.graphics.print(p1.health,1200, 100, 0, 3,3)
    
end

function love.update(dt)

end


function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
