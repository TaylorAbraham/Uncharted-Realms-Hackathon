require("Script.card")
require("Script.player")
local http = require "socket.http"
local json = require "Script.json"
local scaleX, scaleY

local deckSize = 12
local handSize = 3
local fieldSize = 0
local timer = 0

deck = {}
hand = {}
field = {}

-- Run once, at the start of the program
function love.load()

    canvas = love.graphics.newCanvas(1280, 800)

    love.window.setMode(1280, 800, {resizable=false, vsync=false, minwidth=400, minheight=300})    

    -- Fetch 12 random cards for the deck
    -- TODO: This will later be replaced by loading in the deck built from a deck editor
    result, statuscode, content = http.request("http://localhost:5000/cards/generate/12")

    parsedResult = json.decode(result)

    -- Add cards to the deck
    for i=1,deckSize do
        table.insert(deck,i,Card:create(parsedResult.cards[i].POW, parsedResult.cards[i].HP, parsedResult.cards[i].CLK, parsedResult.cards[i].NAME, parsedResult.cards[i].IMG))
    end

    -- Draw opening hand
    for i=1,handSize do
      hand[i] = deck[i]
    end

    -- Create players
    p1 = Player:new(deck,"player", hand, field, handSize, deckSize, fieldSize)

    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setBlendMode("alpha")
    love.graphics.setBackgroundColor(250, 215, 160)
    love.graphics.line(0, 445, 1280, 445)

    love.graphics.setLineWidth(5)
    love.graphics.line(0, 300, 1280, 300)
    love.graphics.setCanvas()

end
 
-- Run every frame
function love.draw()
 
    -- The rectangle from the Canvas was already alpha blended.
    -- Use the premultiplied alpha blend mode when drawing the Canvas itself to prevent improper blending.
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(canvas)
    -- Observe the difference if the Canvas is drawn with the regular alpha blend mode instead.
    love.graphics.setBlendMode("alpha")
    Card:drawpng_back(1000, 500)

    -- Draw every card in hand
    for i=1,handSize do
        hand[i]:drawpng_front(300*i - 200,500)
    end

    -- Draw the canvas
    love.graphics.draw(canvas)


    -- Draw player health
    heart = love.graphics.newImage("/Card/heart.png")
    scaleX, scaleY = getImageScaleForNewDimensions(heart, 100, 100)    
    love.graphics.draw(heart, 1100, 100, 0, scaleX, scaleY)
    love.graphics.print(p1.health,1200, 100, 0, 3,3)
    
end

function love.update(dt)

    timer=timer+dt
    if timer > 2 then 
        -- Run this every 2 seconds
        -- Perform all player actions for the turn
        p1:turn()
        timer=timer-2
    end

end


function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
