local fonts = {}

fonts.text = {
   file = "Helvetica.otf",
   size = 20
}
fonts.mol = {
   file = "DroidSerif-Bold.ttf",
   size = 40
}

for k, v in pairs(fonts) do
end

setmetatable(fonts, {
				__call = function()
				   for k, v in pairs(fonts) do
					  v.font = love.graphics.newFont(v.file, v.size)
					  v.set = function(self)
						 love.graphics.setFont(self.font)
					  end
				   end
				end
})

return fonts
