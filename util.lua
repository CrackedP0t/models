local util = {}

util.rw = 1
util.rh = 1

util.resize = function(w, h)
   util.rw = w
   util.rh = h
end

util.w = function()
   return love.graphics.getWidth() * util.rw
end

util.h = function()
   return love.graphics.getHeight() * util.rh
end

util.pir = function(px, py, x, y, w, h)
   return px - x >= 0 and px - (x + w) <= 0
	  and py - y >= 0 and py - (y + h) <= 0
end

return util
