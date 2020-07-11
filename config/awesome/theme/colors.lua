local Cairo = require "oocairo"

local colors = {}

function colors.getColorDistribution(filename)
    local surface = Cairo.image_surface_create_from_png(filename)
    
end

return colors
