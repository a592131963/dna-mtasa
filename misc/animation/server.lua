function animationani (thePlayer, ani)
  if (ani == "drunk") then
    setPedAnimation (thePlayer, "ped", "WALK_drunk", -1, true)
  elseif (ani == "piss") then
    setPedAnimation (thePlayer, "PAULNMAC", "Piss_loop", -1, true)
  elseif (ani == "sit1") then
    setPedAnimation (thePlayer, "CAR", "Sit_relaxed", -1, true)
  elseif (ani == "sit2") then
    setPedAnimation (thePlayer, "FOOD", "FF_Sit_Loop", -1, true)
  elseif (ani == "sit3") then
    setPedAnimation (thePlayer, "Attractors", "Stepsit_loop", -1, true)
  elseif (ani == "lay") then
    setPedAnimation (thePlayer, "BEACH", "Lay_Bac_Loop", -1, true)
  elseif (ani == "dance1") then
    setPedAnimation (thePlayer, "DANCING", "dance_loop", -1, true)
  elseif (ani == "show") then
    setPedAnimation (thePlayer, "CLOTHES", "CLO_Pose_Shoes", -1, true)
  elseif (ani == "stopani") then
    setPedAnimation (thePlayer, nil, nil, -1, true)
  end
end
addCommandHandler ("drunk",animationani)
addCommandHandler ("piss",animationani)
addCommandHandler ("sit1",animationani)
addCommandHandler ("sit2",animationani)
addCommandHandler ("sit3",animationani)
addCommandHandler ("lay",animationani)
addCommandHandler ("dance1",animationani)
addCommandHandler ("show",animationani)
addCommandHandler ("stopani",animationani)