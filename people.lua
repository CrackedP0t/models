local util = require("util")
local fonts = require("fonts")
local colors = require("colors")

return {
   {
	  name = "Democritus",
	  idea = "He thought that all matter was made up of discrete parts, which, as it happens, is true. His name for them was \"atom\", which meant, basically, \"unbreakable\".",
	  disproof = "What is lightning? Clearly, it's coming out of the clouds, but the clouds don't appear to be getting any smaller, so their atoms can't be breaking off to form it.",
	  proof = "Democritus had no proof. His theory was simply a lucky guess, which is why the Aristotilian model lasted for so long.",
	  model = {
		 draw = function()
			love.graphics.setColor({255, 0, 0})
			love.graphics.circle("fill", util.w() / 2, util.h() / 2, util.w() / 6)
		 end
	  }
   },
   {
	  name = "John Dalton",
	  idea = "Also thought that all matter was made up of discrete parts. However, he had experimental proof of it, unlike Democritus.",
	  disproof = "His model cannot account for the behaviour of a Crookes tube. If atoms are simple, unbreakable particles, then what's all the stuff coming off of them in a Crookes tube?",
	  proof = "He noticed that when certain chemicals were formed, exact proportions of component chemicals were used up. This lead him to believe that little parts of them were discrete, and exact numbers of the component particles formed the particles inside the new chemical.",
	  model = {
		 draw = function()
			love.graphics.setColor({255, 0, 0})
			local centerX = util.w() / 2
			local centerY = util.h() / 2
			local bigR = util.w() / 6
			local smallR = util.w() / 10
			local totalR = bigR + smallR
			local offAngle = math.pi / 4

			local leftX = centerX - math.sin(offAngle) * totalR
			local rightX = centerX + math.sin(offAngle) * totalR
			local smallY = centerY + math.cos(offAngle) * totalR

			love.graphics.circle("fill", centerX, centerY, bigR)

			love.graphics.setColor({255, 127, 0})
			love.graphics.circle("fill", leftX, smallY, smallR)
			love.graphics.circle("fill", rightX, smallY, smallR)

			love.graphics.setColor({0, 0, 0})

			fonts.mol:set()
			
			love.graphics.print("O", centerX - 15, centerY - 15)

			love.graphics.print("H", leftX - 15, smallY - 15)
			love.graphics.print("H", rightX - 15, smallY - 15)
		 end
	  }
   },
   {
	  name = "J. J. Thomson",
	  idea = "After seeing a Crookes tube, he figured out that each atom had some negative electrons in it as well as a bunch of positive stuff. He supposed that they were embedded in it, like currants in a plum pudding.",
	  proof = "He knew that negatively charged particles were flying off of the atoms, so he knew that there must be multiple parts to the atoms.",
	  disproof = "He couldn't explain how multiple isotopes of matter could exist. For example, deutrium behaves like regular hydrogen in every way except its mass, which makes no sense with the plum pudding model.",
	  model = {
		 draw = function()
			local pX = 0
			local pY = 0
			local pR = util.w() / 6

			local nX = 50
			local nY = 50
			local nR = 20
			
			local drawCircle = function(x, y, r)
			   love.graphics.circle("fill", x, y, r)
			end

			love.graphics.translate(util.w() / 2, util.h() / 2)

			love.graphics.setColor(colors.red)
			drawCircle(pX, pY, pR)

			love.graphics.setColor(colors.orange)
			drawCircle(nX, nY, nR)

			fonts.mol:set()
			love.graphics.setColor(colors.black)

			love.graphics.print("+", pX - 6, pY - 25)
			love.graphics.print("-", nX - 6, nY - 25)
		 end
	  }
   }
}
