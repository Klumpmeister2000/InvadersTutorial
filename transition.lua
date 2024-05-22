-- transition.lua
import 'CoreLibs/graphics'
import 'CoreLibs/timer'

local gfx <const> = playdate.graphics

local function screenWipeTransition(duration, direction, onComplete)
    local startTime = playdate.getCurrentTimeMilliseconds()
    local screenWidth, screenHeight = playdate.display.getSize()

    local function update()
        local elapsedTime = playdate.getCurrentTimeMilliseconds() - startTime
        local progress = math.min(elapsedTime / duration, 1)

        if direction == "left" then
            gfx.clear(gfx.kColorBlack)
            gfx.setClipRect(screenWidth * progress, 0, screenWidth * (1 - progress), screenHeight)
        elseif direction == "right" then
            gfx.clear(gfx.kColorBlack)
            gfx.setClipRect(0, 0, screenWidth * (1 - progress), screenHeight)
        end

        -- Draw your game scene here
        -- Example: drawScene()

        gfx.clearClipRect()

        if progress >= 1 then
            playdate.timer.performAfterDelay(0, function()
                playdate.update = nil
                if onComplete then
                    onComplete()
                end
            end)
        end
    end

    playdate.update = update
end

return {
    screenWipeTransition = screenWipeTransition
}