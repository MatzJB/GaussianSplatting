# GaussianSplatting
Contains my experiments with Gaussian Splatting.

# Camera Rigger (Maxscript)
This script creates a camera animation based on a surface constraint on an object of your choice. The other solution
The reason why I chose this solution is because 3ds max became slow after I added 300 cameras so I thought it's better with one camera and move that around.

The main reason for creating a rigger is to render views to feed a GS pipe but also provide the cameras.txt, image3d.txt and points3d.txt information to that pipe. In this way we can properly investigate the different GS variants.


# Gaussian Splatting Overview
Research into realistically represent 3d worlds has been focused on separating geometry and materials with the use of triangles and textures together with UV mapping to map those textures onto geometry. Raytracing (Path Tracing) produce photo realistic images by calculating contribution of photons bouncing in the scene achieving effects such as color bleeding, caustics and soft shadows. It's computationally expensive, however. In real time render these effects have been implemented using various tricks. These tricks have been sped up by using several techniques such as baking and screen space calculations amongst others. 
With Gaussian Splatting, everything is geometry. It's only ellipsoids, called splats. They can be compared to gradiants (inkscape). These splats are then projected onto the screen, requiring sorting to be done in real time (hence artifacts such as "popping" occur).

Going from a number of 2D images to a 3D representation (i.e. a point cloud) requires us to use something like Colmap that is able to register the camera positions using only images. Sometimes it cannot do this because the input is of low contrast or where not enough pixels are common between the images.




# Variants
3DGS
Original gaussian splatting.

2DGS
Flattens the GS onto surfaces => can get normal and depth maps that are not fuzzy.

G^3
Relighting GS using a lighting rig.

Textured GS
Adds view dependent opacity to the GS, interesting when dealing with reflections?

Disentagling GS and texture for editing
https://slothfulxtx.github.io/TexGS/

N dimensional GS, for mother of pearl, mahogany, iridescent materials.

# Thoughts
Deadling with "sweeping under the rug" reflections by turning off splats if the view angle goes beyond certain points in space?
So, basically control splats based on XYZ position (well, maybe encoded as SH and a distance function that turns the splat on or off based on distance and angle). In this way the splats that are reflections in a mirror will be invisible if you look in the mirror from the other side.


