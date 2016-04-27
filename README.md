# Maze-solving
Solving real world maze by taking picture of it from normal cell phone camera and finding the solution to it. In addition, the robot moves in the maze following the exact path obtained

The code is in MATLAB format and the robot uses arduino. 
MATLAB to Arduino has been used to complete this project.

Some of the image processing operations involved include:
1. Dilation                                                                                       
2. Erosion                                                              
3. Pruing                                                       
4. Skeleton                                                                     

The obtained path is then overlaid on the original image to visualize the results.
The next step involves converting the pixels location in image to real world frame as per scale and also finding the direction with respect to previous pixel. 
After this information is obtained, the bot is given appropriate direction commands which it follows to complete solving the maze.
