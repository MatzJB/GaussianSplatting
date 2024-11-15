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

2DGS

G^3

Textured GS

