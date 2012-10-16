--[[

  Client animation library by arc_
               Version 1.0.0
  
  Licence
  ----------------
  
  You are free to modify this file and redistribute it with your changes.
  However, always mention that you changed it (and eventually what changes
  you made) and keep the original author, version number and licence intact.
  
  Selling this script or a derivative of it is not allowed.
  
  
  Documentation
  ----------------
  
  Terminology
  
    - Animation: a sequence of phases that act on one or more elements
	  and follow each other sequentially in time.
	  
	  Multiple animations can be running at the same time. All defined
	  animations run in parallel.
	  
	  An animation is in fact one phase with several subphases (see below),
	  with animation specific functions available.
	  
	- Phase: a part of an animation sequence. A phase consists of a
	  paramater that linearly goes from a given starting value to a
	  given ending value, over the specified amount of time, and is
	  applied to one certain element. While a phase is running, its
	  callback function will be called onClientRender with the following
	  arguments:
	  
	    phase.fn(element elem, float param, table phase)
	  
	  Specifying time and callback function is optional. If no time is
	  specified but a function is, phase.fn(elem) will be called once.
	  If no function is specified but a time is, the phase consists
	  of simply waiting during that time, doing nothing.
	  
	  A phase can be run once, repeated multiple times or loop infinitely.
	  
	  Phases can also contain phases. In that case the parent phase consists
	  of completing all child phases, in order. This allows you to f.e.
	  make an element move left and right continuously: define a phase for
	  moving it to the left, followed by a phase for moving it back to the
	  right, and encapsulate these two phases in a parent phase that loops
	  forever.
	  
	  Phases can be nested to arbitrary depth. The element a subphase works on
	  is inherited from its parent phase (or, if the parent phase doesn't
	  specify an element, from the grandparent, etc).

	  
  Definition of a phase
  
    A phase is simply a table containing properties and (optionally) subphases.
	Available phase properties are: (the values for the properties are examples,
	not default values)
	
	phase = {
		from = 0,           -- the starting value of the parameter
		to = 1,             -- the ending value of the parameter
		[time = 1000,]      -- the time (in ms) in which to go from start to end
		[fn = callback,]    -- the function to call on each frame update
		[repeats = 5,]      -- how many times to run this phase before going on to
		                    --   the next. defaults to 1

		[subphase1,]        -- optional subphases. if one or more of these are included,
		[subphase2,]        --   only the "repeats" property is valid for this parent phase
		...
	}

  Available functions
  
    anim = Animation.create(elem, phase1, phase2, ...)
	  Creates and returns a new animation. This means nothing more than
	  creating a new phase, putting the specified phases in it as subphases,
	  and making the functions of the Animation class available to it.
	  
	  Once an animation is created, it is not yet running.
	  
	anim = Animation.createAndPlay(elem, phase1, phase2, ...)
	  Creates a new animation and immediately starts playing it.
	
	anim = Animation.createNamed(name, elem, ...)
	  If an animation with the specified name exists, returns that animation.
	  Otherwise creates a new named animation. You can look the animation up
	  again later with Animation.getNamed(name).
	
	anim = Animation.createNamedAndPlay(name, elem, ...)
	  Self explanatory.
	  
	anim = Animation.getNamed(name)
	  Returns the animation with the specified name if it exists,
	  false otherwise.
	  
	anim:play()
	  Start playing a newly created animation or resume a paused animation.
	  
	anim:pause()
	  Pauses the animation. Resume it later with anim:play() or delete it
	  with anim:remove().
	  
	anim:remove()
	  Deletes the animation completely. It can not be resumed anymore.
	
	anim:isPlaying()
	  Returns true if the animation is currently playing, false if not.
	  
	Animation.playingAnimationsExist()
	  Returns true if there is any animation that is currently playing.
	  
	  
	anim:addPhase(phase3), phase2:addPhase(phase3)
	  Appends a new subphase to the animation or phase. Can be done while
	  the animation is playing. Note that to be able to use phase2:addPhase(),
	  phase2 first has to be processed (default values filled in, made part of
	  the Phase class) by being passed as an argument to
	  Animation.create[AndPlay] or addPhase.
	  
	  
  Examples
  
    Fade in a picture:
	
	  local pict = guiCreateStaticImage(...)
	  Animation.createAndPlay(pict, { from = 0, to = 1, time = 2000, fn = guiSetAlpha })
	  
	Fade in a picture using a preset (for more presets, see the end of this file):
	
	  local pict = guiCreateStaticImage(...)
	  Animation.createAndPlay(pict, Animation.presets.guiFadeIn(2000))
	  
	Move a label to the right while fading it in:
	
	  local label = guiCreateLabel(10, 100, 150, 20, 'Test', false)
	  Animation.createAndPlay(label, Animation.presets.guiMove(200, 100, 2000))
	  Animation.createAndPlay(label, Animation.presets.guiFadeIn(2000))
	  
	Move a label left and right forever, without presets:
	
	  function guiSetX(elem, x)
	      local curX, curY = guiGetPosition(elem, false)
		  guiSetPosition(elem, x, curY, false)
	  end
	  local label = guiCreateLabel(10, 100, 150, 20, 'Test', false)
	  Animation.createAndPlay(
	      label,
		  {
		      repeats = 0,
			  { from = 10, to = 200, time = 2000, fn = guiSetX },
			  { from = 200, to = 10, time = 2000, fn = guiSetX }
		  }
	  )
	  
]]--

-- Made few changes into the small details -Socialz

-- Miniatures
local cRoot = getRootElement()
local cThis = getThisResource()
local cThisRoot = getResourceRootElement(cThis)

-- Functions
dxText = {}
dxText_mt = {__index = dxText}
local idAssign,idPrefix = 0, "c"
local g_screenX,g_screenY = guiGetScreenSize()
local visibleText = {}
local defaults = {
	fX							= 0.5,
	fY							= 0.5,
	bRelativePosition			= true,
	strText						= "",
	bVerticalAlign 				= "center",
	bHorizontalAlign 			= "center",
	tColor 						= {255,255,255,255},
	fScale 						= 1,
	strFont 					= "default",
	strType						= "normal",
	tAttributes					= {},
	bPostGUI 					= false,
	bClip 						= false,
	bWordWrap	 				= true,
	bVisible 					= true,
	tBoundingBox				= false,
	bRelativeBoundingBox		= true,
}

local validFonts = {
	default						= true,
	["default-bold"]			= true,
	clear						= true,
	arial						= true,
	pricedown					= true,
	bankgothic					= true,
	diploma						= true,
	beckett						= true,
}

local validTypes = {
	normal						= true,
	shadow						= true,
	border						= true,
	stroke						= true,
}

local validAlignTypes = {
	center						= true,
	left						= true,
	right						= true,
}

function dxText:create(text, x, y, relative)
	assert(not self.fX, "attempt to call method 'create' (a nil value)")
	if (type(text) ~= "string") or (not tonumber(x)) or (not tonumber(y)) then
		outputDebugString("dxText:create - Bad argument", 0, 112, 112, 112)
		return false
	end
    local new = {}
	setmetatable(new, dxText_mt)
	for i,v in pairs(defaults) do
		new[i] = v
	end
	idAssign = idAssign + 1
	new.id = idPrefix..idAssign
	new.strText = text or new.strText
	new.fX = x or new.fX
	new.fY = y or new.fY
	if type(relative) == "boolean" then
		new.bRelativePosition = relative
	end
	visibleText[new] = true
	return new
end

function dxText:text(text)
	if type(text) ~= "string" then return self.strText end
	self.strText = text
	return true
end

function dxText:position(x,y,relative)
	if not tonumber(x) then return self.fX, self.fY end
	self.fX = x
	self.fY = y
	if type(relative) == "boolean" then
		self.bRelativePosition = relative
	else
		self.bRelativePosition = true
	end
	return true
end

function dxText:color(r,g,b,a)
	if not tonumber(r) then return unpack(self.tColor) end
	g = g or self.tColor[2]
	b = b or self.tColor[3]
	a = a or self.tColor[4]
	self.tColor = { r,g,b,a }
	return true
end

function dxText:scale(scale)
	if not tonumber(scale) then return self.fScale end
	self.fScale = scale
	return true
end

function dxText:visible(bool)
	if type(bool) ~= "boolean" then return self.bVisible end
	self.bVisible = bool
	if bool then
		visibleText[self] = true
	else
		visibleText[self] = nil
	end
	return true
end

function dxText:destroy()
	self.bDestroyed = true
	setmetatable( self, self )
	return true
end

function dxText:extent()
	local extent = dxGetTextWidth ( self.strText, self,fScale, self.strFont )
	if self.strType == "stroke" or self.strType == "border" then
		extent = extent + self.tAttributes[1]
	end
	return extent
end

function dxText:height()
	local height = dxGetFontHeight ( self,fScale, self.strFont )
	if self.strType == "stroke" or self.strType == "border" then
		height = height + self.tAttributes[1]
	end
	return height
end

function dxText:font(font)
	if not validFonts[font] then return self.strFont end
	self.strFont = font
	return true
end

function dxText:postGUI(bool)
	if type(bool) ~= "boolean" then return self.bPostGUI end
	self.bPostGUI = bool
	return true
end

function dxText:clip(bool)
	if type(bool) ~= "boolean" then return self.bClip end
	self.bClip = bool
	return true
end

function dxText:wordWrap(bool)
	if type(bool) ~= "boolean" then return self.bWordWrap end
	self.bWordWrap = bool
	return true
end

function dxText:type(type, ...)
	if not validTypes[type] then return self.strType, unpack(self.tAttributes) end
	self.strType = type
	self.tAttributes = {...}
	return true
end

function dxText:align(horzA, vertA)
	if not validAlignTypes[horzA] then return self.bHorizontalAlign, self.bVerticalAlign end
	vertA = vertA or self.bVerticalAlign
	self.bHorizontalAlign, self.bVerticalAlign = horzA, vertA
	return true
end

function dxText:boundingBox(left, top, right, bottom, relative)
	if left == nil then
		if self.tBoundingBox then
			return unpack(boundingBox)
		else
			return false
		end
	elseif tonumber(left) and tonumber(right) and tonumber(top) and tonumber(bottom) then
		self.tBoundingBox = {left, top, right, bottom}
		if type(relative) == "boolean" then
			self.bRelativeBoundingBox = relative
		else
			self.bRelativeBoundingBox = true
		end
	else
		self.tBoundingBox = false
	end
	return true
end

addEventHandler("onClientRender", cRoot,
	function()
		for self,_ in pairs(visibleText) do
			while true do
				if self.bDestroyed then
					visibleText[self] = nil
					break
				end
				local l,t,r,b
				if not self.tBoundingBox then
					local p_screenX,p_screenY = 1,1
					if self.bRelativePosition then
						p_screenX,p_screenY = g_screenX,g_screenY
					end
					local fX,fY = (self.fX)*p_screenX,(self.fY)*p_screenY
					if self.bHorizontalAlign == "left" then
						l = fX
						r = fX + g_screenX
					elseif self.bHorizontalAlign == "right" then
						l = fX - g_screenX
						r = fX
					else
						l = fX - g_screenX
						r = fX + g_screenX
					end
					if self.bVerticalAlign == "top" then
						t = fY
						b = fY + g_screenY
					elseif self.bVerticalAlign == "bottom" then
						t = fY - g_screenY
						b = fY
					else
						t = fY - g_screenY
						b = fY + g_screenY
					end
				elseif type(self.tBoundingBox) == "table" then
					local b_screenX,b_screenY = 1,1
					if self.bRelativeBoundingBox then
						b_screenX,b_screenY = g_screenX,g_screenY
					end
					l,t,r,b = self.tBoundingBox[1],self.tBoundingBox[2],self.tBoundingBox[3],self.tBoundingBox[4]
					l = l*b_screenX
					t = t*b_screenY
					r = r*b_screenX
					b = b*b_screenY
				end
				local type,att1,att2,att3,att4,att5 = self:type()
				if type == "border" or type == "stroke" then
					att2 = att2 or 0
					att3 = att3 or 0
					att4 = att4 or 0
					att5 = att5 or self.tColor[4]
					outlinesize = att1 or 2
					outlinesize = math.min(self.fScale,outlinesize)
					if outlinesize > 0 then
						for offsetX=-outlinesize,outlinesize,outlinesize do
							for offsetY=-outlinesize,outlinesize,outlinesize do
								if not (offsetX == 0 and offsetY == 0) then
									dxDrawText(self.strText, l + offsetX, t + offsetY, r + offsetX, b + offsetY, tocolor(att2, att3, att4, att5), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI)
								end
							end
						end
					end
				elseif type == "shadow" then
					local shadowDist = att1
					att2 = att2 or 0
					att3 = att3 or 0
					att4 = att4 or 0
					att5 = att5 or self.tColor[4]
					dxDrawText(self.strText, l + shadowDist, t + shadowDist, r + shadowDist, b + shadowDist, tocolor(att2, att3, att4, att5), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI)
				end
				dxDrawText(self.strText, l, t, r, b, tocolor(unpack(self.tColor)), self.fScale, self.strFont, self.bHorizontalAlign, self.bVerticalAlign, self.bClip, self.bWordWrap, self.bPostGUI)
				break
			end
		end
	end
)