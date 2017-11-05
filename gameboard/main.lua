local http = require "socket.http"
local json = require "Script.json"
local scaleX, scaleY
require("Script.card")

deckSize = 30
handSize = 3

deck = {}
hand = {}

function love.load()
    canvas = love.graphics.newCanvas(800, 600)

    result, statuscode, content = http.request("http://localhost:5000/cards/generate/20")
    
    parsed = json.decode('{"cards": [{"NAME": "Phantom Blink", "HP": 6, "IMG": "https://phantomdotexe.deviantart.com/art/Villains-474588558", "CLK": 5, "POW": 3}]}')


    print("Result is: "..result)
    print("content is: "..content)    
    --parsedResult = json.decode(result)
    

    -- print("here is")

    for i=1,deckSize do
        --deck[i] = Card:createCard(parsedResult.cards[i].POW, parsedResult.cards[i].HP, parsedResult.cards[i].CLK)
        deck[i] = Card:createCard(1,2,3)
    end

    for i=1,handSize do
        hand[i] = deck[i]
    end
    
    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setBackgroundColor(250, 215, 160)
        love.graphics.line(0, 445, 800, 445)

        love.graphics.setLineWidth(5)
        love.graphics.line(0, 300, 800, 300)
    love.graphics.setCanvas()

end
 
function love.draw()
 
    -- The rectangle from the Canvas was already alpha blended.
    -- Use the premultiplied alpha blend mode when drawing the Canvas itself to prevent improper blending.
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(canvas)
    -- Observe the difference if the Canvas is drawn with the regular alpha blend mode instead.
    love.graphics.setBlendMode("alpha")
    -- cardScript.drawandpos(300, 400, "HI LOVE")
    Card:drawpng_back(600, 480)

    Card:drawpng_front(200, 465)
    Card:drawpng_front(300, 465)
    Card:drawpng_front(400, 465)

    love.graphics.draw(canvas)
end


function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
