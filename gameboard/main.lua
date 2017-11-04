local http = require "socket.http"
local cardScript = require("Script.card")
local scaleX, scaleY

deckSize = 30
handSize = 3

deck = {}
hand = {}

function love.load()
    canvas = love.graphics.newCanvas(800, 600)

    for i=1,deckSize do
        deck[i] = cardScript.createCard(1, 2, 3, "/Card/BackTexture.png", "/Card/FrontTexture.png", "http://piq.codeus.net/static/media/userpics/piq_415347_400x400.png")
    end

    for i=1,handSize do
        hand[i] = deck[i]
    end

    -- cardScript.init(200, 100)   

    -- cat = http.request("http://piq.codeus.net/static/media/userpics/piq_415347_400x400.png")
    -- cat = love.filesystem.newFileData(cat, "cat.png")
    -- cat = love.graphics.newImage(cat)

    -- scaleX, scaleY = getImageScaleForNewDimensions(cat, 100, 100)
    

    -- cat2 = http.request("http://pixelartmaker.com/art/f48aa81644fa18f.png")
    -- cat2 = http.request("https://static.pexels.com/photos/104827/cat-pet-animal-domestic-104827.jpeg")
    -- cat2 = love.filesystem.newFileData(cat2, "cat2.png")
    -- cat2 = love.graphics.newImage(cat2)
    
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
    -- very important!: reset color before drawing to canvas to have colors properly displayed
    -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
    -- love.graphics.setColor(255, 255, 255, 255)
 
    -- The rectangle from the Canvas was already alpha blended.
    -- Use the premultiplied alpha blend mode when drawing the Canvas itself to prevent improper blending.
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(canvas)
    -- Observe the difference if the Canvas is drawn with the regular alpha blend mode instead.
    love.graphics.setBlendMode("alpha")
    -- cardScript.drawandpos(300, 400, "HI LOVE")
    cardScript.drawpng_back(600, 480)

    cardScript.drawpng_front(200, 465)
    cardScript.drawpng_front(300, 465)
    cardScript.drawpng_front(400, 465)
    -- love.graphics.draw(cat, 300, 300, 0, 0.5, 0.5)
    -- love.graphics.draw(cat2, 300, 100, 0, 0.5, 0.5)

    -- scaleX, scaleY = getImageScaleForNewDimensions(cat, 30, 30)    

    --love.graphics.draw(cat, 200, 540, 0, scaleX, scaleY)

    --scaleX, scaleY = getImageScaleForNewDimensions(cat2, 50, 50)
    
    --love.graphics.draw(cat2, 300, 500, 0, scaleX, scaleY)

    -- cardScript.draw()
    love.graphics.draw(canvas)
end

function love.load()
    
       --require lure library
       require('lure//lure.lua')
    
       --create new XMLHttpRequest Object
       http = XMLHttpRequest.new()
    
       --create a new request, set method, url, and sync option
       http.open("GET", "/cards/generate/3", true)
    
       --create callback function to trigger when request readyState changes
       http.onReadyStateChange = function()
           print(http.readyState)
           print(http.status)
           print(http.statusText)
           print(http.responseText)	
       end
    
       --send your GET request!
       http.send()
   end

function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
