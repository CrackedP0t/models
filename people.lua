local util = require("util")
local fonts = require("fonts")
local colors = require("colors")

local drawCircle = function(x, y, r)
   love.graphics.circle("fill", x, y, r)
end

local p = setmetatable({
	  draw = function(self)
		 love.graphics.setColor(colors.red)
		 drawCircle(self.x, self.y, self.r)
	  end
					   }, {
	  __index = function(self, index)
		 if index == "x" then
			return util.w() / 2
		 elseif index == "y" then
			return util.h() / 2
		 elseif index == "r" then
			return util.w() / 6
		 end
	  end
})


return {
   {
	  name = "Democritus",
	  idea = "He thought that all matter was made up of discrete parts, which, as it happens, is true. His name for them was \"atom\", which meant, basically, \"unbreakable\".",
	  disproof = "What is lightning? Clearly, it's coming out of the clouds, but the clouds don't appear to be getting any smaller, so their atoms can't be breaking off to form it.",
	  proof = "Democritus had no proof. His theory was simply a lucky guess, which is why the Aristotilian model lasted for so long, as Democritus couldn't explain why things were made up of atoms.",
	  model = {
		 draw = function()
			p:draw()
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
			local smallR = util.w() / 10
			local totalR = p.r + smallR
			local offAngle = math.pi / 4

			local leftX = p.x - math.sin(offAngle) * totalR
			local rightX = p.x + math.sin(offAngle) * totalR
			local smallY = p.y + math.cos(offAngle) * totalR

			p:draw()
			
			love.graphics.setColor(colors.orange)
			drawCircle(leftX, smallY, smallR)
			drawCircle(rightX, smallY, smallR)

			love.graphics.setColor(colors.black)

			fonts.mol:set()
			
			love.graphics.print("O", p.x - 15, p.y - 15)

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
			local nX = 50
			local nY = 50
			local nR = 20

			p:draw()
			
			love.graphics.translate(util.w() / 2, util.h() / 2)

			love.graphics.setColor(colors.orange)
			drawCircle(nX, nY, nR)

			fonts.mol:set()
			love.graphics.setColor(colors.black)

			love.graphics.print("+", -6, -26)
			love.graphics.print("-", nX - 6, nY - 26)
		 end
	  }
   },
   {
	  name = "Ernest Rutherford",
	  idea = "He saw that as opposed to electrons and protons being in one chunk, electrons in fact flew all around the nucleus. This gave rise to the solar system model that still represents the atom in a lot of media today.",
	  proof = "He fired alpha particles through a very thin sheet of gold. Most passed through, but some bounced directly back at the gun. This told Rutherford that there must be a lot of empty space in the atom, but that there was a small, hard nucleus.",
	  disproof = "He could not describe how different elements glow different colors when energized.",
	  model = {
		 draw = function(t)
			local nR = 20

			local tvs = {}
			tvs[1] = -p.r / 3
			tvs[2] = p.r / 3

			tvs[3] = tvs[1] + p.r * 3/2
			tvs[4] = tvs[2] + p.r * 3/2

			tvs[7] = p.r / 3
			tvs[8] = -p.r / 3

			tvs[5] = tvs[7] + p.r * 3/2
			tvs[6] = tvs[8] + p.r * 3/2

			local tbezier = love.math.newBezierCurve(tvs)
			local rb = tbezier:render(6)

			p:draw()

			love.graphics.translate(util.w() / 2, util.h() / 2)
			
			love.graphics.setInvertedStencil(function()
				  love.graphics.push()
				  love.graphics.translate(-util.w() / 2, -util.h() / 2)
				  p:draw()
				  love.graphics.pop()
			end)
			love.graphics.setColor(colors.white)
			for i=1, #rb - 2, 2 do
			   love.graphics.line(rb[i], rb[i + 1], rb[i + 2], rb[i + 3])
			   love.graphics.line(-rb[i], -rb[i + 1], -rb[i + 2], -rb[i + 3])
			end
			love.graphics.setStencil()

			for i = 1, #rb / 4 - 2, 2 do
			   love.graphics.line(rb[i], rb[i + 1], rb[i + 2], rb[i + 3])
			end
			for i = math.floor(#rb * 3 / 4), #rb - 2, 2 do
			   love.graphics.line(-rb[i], -rb[i + 1], -rb[i + 2], -rb[i + 3])
			end

			local f = 100
			
			local place = (t * f % #rb) + 2
			place = math.min(place, #rb - 2)
			
			local mod = 1
			if t * f % (#rb * 2) > #rb then
			   mod = -mod
			end

			place = place - (place % 2)

			local nX = mod * rb[place]
			local nY = mod * rb[place + 1]
			local nR = 20

			if mod == 1 and place < #rb / 2 or mod == -1 and place > #rb / 2 then
			   love.graphics.setInvertedStencil(function()
				  love.graphics.push()
				  love.graphics.translate(-util.w() / 2, -util.h() / 2)
				  p:draw()
				  love.graphics.pop()
			   end)
			end

			
			fonts.mol:set()

			love.graphics.setColor(colors.orange)
			drawCircle(nX, nY, nR)

			love.graphics.setColor(colors.black)
			love.graphics.print("-", nX - 6, nY - 26)
			

			love.graphics.setStencil()

			love.graphics.setColor(colors.black)
			love.graphics.print("+", -6, -26)
		 end
	  }
   },
   {
	  name = "Niels Bohr",
	  idea = "He found that the electrons didn't fall into the nucleus because there were only certain distances/energy states they could be in.",
	  proof = "This model perfectly explained the emission spectrum of Hydrogen, as it explained that when an atom was energized, its electron moved up to a higher energy state and back down, emitting a proton in the process.",
	  disproof = "He couldn't figure out why they confined themselves to certain energy states.",
	  model = {
		 draw = function(t)
			fonts.mol:set()
			
			p:draw()

			love.graphics.translate(util.w() / 2, util.h() / 2)
			love.graphics.setColor(colors.black)
			love.graphics.print("+", -6, -26)
			
			love.graphics.setColor(colors.white)

			love.graphics.circle("line", 0, 0, util.w() / 4)
			love.graphics.circle("line", 0, 0, util.w() / 3)

			local eR = util.w() / 4

			local nX = math.cos(t) * eR
			local nY = math.sin(t) * eR
			local nR = 20
			
			love.graphics.setColor(colors.orange)
			drawCircle(nX, nY, nR)

			love.graphics.setColor(colors.black)
			love.graphics.print("-", nX - 6, nY - 26)
		 end
	  }
   },
   {
	  name = "Louis de Broglie",
	  idea = "He realized that the electrons in an atom, in fact, actually behave in a wave-like manner as well as a particle-like manner.",
	  proof = "The electron states that Bohr discovered could actually be explained if one looked at electrons as having a wave behaviour, as opposed to Bohr, who had no explanation for why electrons had energy states.",
	  disproof = "He couldn't predict the emission spectra of any atoms other than hydrogen.",
	  model = {
		 draw = function(t)
			fonts.mol:set()

			p:draw()
			
			love.graphics.translate(util.w() / 2, util.h() / 2)
			
			love.graphics.setColor(colors.black)
			love.graphics.print("+", -6, -26)

			local nP = {}
			local nR = util.w() / 3

			for a = 0, 2 * math.pi, 0.01 do
			   local r = nR + 20 * math.sin(t + a * 30)
			   table.insert(nP, math.cos(a) * r)
			   table.insert(nP, math.sin(a) * r)
			end

			love.graphics.setColor(colors.orange)
			
			love.graphics.setLineWidth(20)
			love.graphics.polygon("line", nP)
			love.graphics.setLineWidth(1)
		 end
	  }
   },
   {
	  name = "Erwin Schrödinger",
	  idea = "He figured out that electrons in an atom do not travel in a circle around the nucleus, but actually can be found anywhere in the universe. However, they are most likely to be found in certain clouds whose shapes depend on the element around the nucleus.",
	  proof = "Schrödinger used advanced math to figure this out, and that's the extent of my understanding of it. It works to predict many things about atoms, though, such as the emission spectra of every element.",
	  disproof = "This model is the current one we use today, and it has not yet been disproved.",
	  model = {
		 draw = function()
			fonts.mol:set()

			love.graphics.translate(util.w() / 2, util.h() / 2)


			local r = p.r
			local o = 20
			
			local c = -r - o / 2
			
			local cloud = function()
			   love.graphics.setColor(colors.orange)
			   
			   love.graphics.rectangle("fill", c, c, r, r)
			   drawCircle(c, c, r)
			end

			cloud()

			love.graphics.rotate(math.pi / 2)
			cloud()

			love.graphics.rotate(math.pi)
			cloud()

			love.graphics.rotate(math.pi * 3 / 2)
			cloud()

			love.graphics.rotate(0)
			
			love.graphics.setColor(colors.black)

			love.graphics.print("-", c - 6, c - 26)
			love.graphics.print("-", -c - 6, c - 26)
			love.graphics.print("-", c - 6, -c - 26)
			love.graphics.print("-", -c - 6, -c - 26)
			
		 end
	  }
   }
}
