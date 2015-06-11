# PS2-Recoil
A project trying to model the recoil mechanics in Planetside 2

After seeing many discussions on weapon balance revolve around which guns are better to handle I decided that a set method would be nice to refer to. I will try to explain the reasoning behind each step of the program here.

Most of the theory behind the recoil mechanics comes from here: http://ps2guides.besaba.com/mechanics

IMPORTANT NOTE: All of this is pure speculation!! There has been no officially released mechanics explanation from DBG, so this could all be completely wrong.

1. Using the stats of the weapon the CoF is calculated

  a. If this is the first shot the starting CoF value is used
  
  b. This takes into account the distance from the target. The further you are, the larger the effective CoF at the target.
  
2. Using a function found online, a random point within the CoF circle is chosen

  a. This circle and the point are then plotted if desired
  
  b. If this is the first shot then the random point is where the actual shot goes
  
  c. If this is not the first shot then this is where recoil calculation begins
  
3. The recoil angle is randomly chosen between the min and max values

4. Vertical recoil is calculated

  a. If this is the first shot FSM is applied
  
  b. The vertical recoil is in the direction of the recoil angle
  
  c. The line connecting these points is plotted
  
5. Horizontal recoil is calculated

  a. A random direction is first chosen: -1 for left and 1 for right
  
  b. The recoil amount is randomly calculated
  
  c. Horizontal recoil is applied at 90° to the vertical recoil
  
  d. If this would place the shot outside of the tolerance the direction of the shot is manually chosen to bring the shot closer to the center
  
    i. If the recoil angle has a variance then the average angle is used for the calculation
    
  e. The actual shot is now placed
  
6. The horizontal recoil line and actual shot location can be plotted

  a. A line connecting the actual shots can also be plotted
  
7. Iterates the shot count and adds CoF bloom

8. Goes back to 1.

8. Calculates and plots the regression line for all shots in one run

9. Restarts if the run count is more than 1

10. Calculates and plots the average regression line over all of the runs

11. Plots the tolerance envelope

Places where I know issues exist: 
All of section 5 is crazy. Tolerance is a magical hand-wavy occurrence. If the recoil value varies I have no idea if the tolerance varies with it.
There is a max CoF for all guns, but I don't know what it is.
