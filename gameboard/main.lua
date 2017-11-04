local cardScript = require("Script.card")

deckSize = 30
handSize = 3

deck = {}
hand = {}

function love.load()
    canvas = love.graphics.newCanvas(800, 600)

    for i=1,deckSize do
        deck[i] = cardScript.createCard(1, 2, {"a"}, "/Card/BackTexture.png", "/Card/FrontTexture.png")
    end

    for i=1,handSize do
        hand[i] = deck[i]
    end

    -- cardScript.init(200, 100)   
 
    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setBackgroundColor(250, 215, 160)
        love.graphics.line(0, 500, 800, 500)

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
    cardScript.drawpng_back(600, 540)
    cardScript.drawpng_front(200, 540)
    cardScript.drawpng_front(300, 540)
    cardScript.drawpng_front(400, 540)

    -- cardScript.draw()
    love.graphics.draw(canvas)


end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
 
    return animation
end