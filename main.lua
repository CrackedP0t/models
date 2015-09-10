local people = require("people")
local util = require("util")
local fonts = require("fonts")
local timer = require("hump.timer")

local index = 1

local stencilRect = nil

local textoff = {
   x = 0,
   y = 0
}
local textpos = {
   x = 15,
   y = 60
}
local textWidth = nil

local lastoff = {
   x = 0,
   y = 0
}

local textanim = 0.5

local btns = nil

local lastPerson = nil

local drawText = function(person, off)
   love.graphics.setColor({255, 255, 255})
   local text = "Name: " .. person.name .. "\n\n"
	  .. "Idea: " .. person.idea .. "\n\n"
	  .. "Proof: " .. person.proof .. "\n\n"
	  .. "Disproof: " .. person.disproof
   
   fonts.text:set()
   love.graphics.printf(text, textpos.x + off.x, textpos.y + off.y, textWidth)
end

local switch = function(dir)
   lastPerson = people[index]
   
   local outX = textWidth + textoff.x
   if dir == "left" then
	  outX = 1 * outX
	  index = index - 1
   elseif dir == "right" then
	  outX = -1 * outX
	  index = index + 1
   else
	  error("dir must be \"left\" or \"right\"!")
   end

   textoff.x = -outX

   timer.tween(textanim, lastoff, {x = outX}, "linear", function()
				  lastPerson = nil
				  lastoff.x = 0
   end)
   timer.tween(textanim, textoff, {x = 0}, "linear")
end

local drawRect = function(r)
   love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)
end

local drawArrow = function(dir, x, y, w, h)
   local rect = {
	  x = x,
	  y = y + h / 4,
	  w = w / 2,
	  h = h / 2
   }

   local tri = {}
   tri[1] = x + w / 2
   tri[2] = y
   tri[3] = x + w / 2
   tri[4] = y + h
   tri[6] = y + h / 2

   if dir == "left" then
	  rect.x = x + w / 2
	  tri[5] = y
   elseif dir == "right" then
	  rect.x = x
	  tri[5] = x + w
   end

   drawRect(rect)
   love.graphics.polygon("fill", tri)
end

function love.load()
   love.window.setMode(1600, 900, {fsaa = 8})

   fonts()
end

function love.update(dt)
   timer.update(dt)

   stencilRect = {}
   stencilRect.x = 10
   stencilRect.y = 40
   stencilRect.w = util.w() / 2 - 2 * stencilRect.x
   stencilRect.h = util.h() / 2 - 2 * stencilRect.y	  
   
   btns = {
	  l = {
		 x = 0,
		 y = 0,
		 w = 50,
		 h = 50
	  },
	  r = {
		 x = util.w() / 2 - 50,
		 y = 0,
		 w = 50,
		 h = 50
	  }
   }

   textWidth = util.w() / 2 - textpos.x * 2
end

function love.draw()
   local person = people[index]
   
   love.graphics.setColor({255 * 0.75, 0, 0})
   love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth() / 2, love.graphics.getHeight())

   love.graphics.setColor({125, 0, 255})
   love.graphics.rectangle("fill", love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, love.graphics.getHeight())

   
   love.graphics.setStencil(function()
		 drawRect(stencilRect)
   end)
   drawText(person, textoff)
   if lastPerson then drawText(lastPerson, lastoff) end
   love.graphics.setStencil()


   love.graphics.push()
   util.resize(0.5, 1)
   
   love.graphics.translate(love.graphics.getWidth() / 2, 0)

   person.model.draw()

   util.resize(1, 1)
   love.graphics.pop()

   love.graphics.setColor({0, 255, 0})
   
   drawArrow("left", btns.l.x, btns.l.y, btns.l.w, btns.l.h)
   drawArrow("right", btns.r.x, btns.r.y, btns.r.w, btns.r.h)
end

function love.mousereleased(x, y)
   if util.pir(x, y, btns.r.x, btns.r.y, btns.r.w, btns.r.h) and index < #people then
	  switch("right")
   elseif util.pir(x, y, btns.l.x, btns.l.y, btns.l.w, btns.l.h) and index > 1 then
	  switch("left")
   end
end
