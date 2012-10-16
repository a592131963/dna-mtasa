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
local screenX,screenY = guiGetScreenSize()

local function setDXAlpha(dx, alpha) 
	local r,g,b = dx:color()
	dx:color(r, g, b, alpha)
end

function Animation.presets.dxTextFadeIn(time)
	return {from = 0, to = 255, time = time or 1000, fn = setDXAlpha}
end

function Animation.presets.dxTextFadeOut(time)
	return {from = 255, to = 0, time = time or 1000, fn = setDXAlpha}
end

