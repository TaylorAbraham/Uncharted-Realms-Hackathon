local cardScript = require("Script.card")

function love.load()
    canvas = love.graphics.newCanvas(800, 600)

    -- cardScript.init(200, 100)   
 
    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        -- love.graphics.setBackgroundColor(255, 255, 255)
        -- love.graphics.rectangle('fill', 0, 0, 100, 100)
        -- love.graphics.rectangle('fill', 0, 0, 100, 200)
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
    cardScript.drawpng("/Card/BackTexture.png", 600, 300)
    -- cardScript.draw()
    love.graphics.draw(canvas, 100, 0)

 
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
 
    return animation
end