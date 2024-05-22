import 'CoreLibs/object'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import "transition"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, moveSpeed)
    local enemyImage = gfx.image.new("images/goblin")
    self:setImage(enemyImage)
    self:moveTo(x, y)
    self:add()

    self:setCollideRect(0, 0, self:getSize())

    self.moveSpeed = moveSpeed
end

function Enemy:update()
    self:moveBy(-self.moveSpeed, 0)
    if self.x < 0 then
        resetGame()
    end
end

function Enemy:collisionResponse()
    return "overlap"
end

-- Add function to check collision with the player
function Enemy:checkCollisionWithPlayer(player)
    if self:overlappingSprites()[1] == player then
        screenWipeTransition(1000, "left", function()
            print("Transition complete")
            -- Add any logic you want to execute after the transition
        end)
    end
end

return Enemy