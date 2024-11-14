# GaussianSplatting
Contains my experiments with Gaussian Splatting.

# Camera Rigger
This script creates a camera animation based on a surface constraint on an object of your choice. The reason why I chose this solution is because 3ds max became slow after I added 300 cameras so I thought it's better with one camera and move that around.

The main reason for creating a rigger is to render views to feed a GS pipe but also provide the camera, image and point cloud information to that pipe. In this way we can properly investigate the different GS variants.


# variants
3DGS
2DGS
G^3
Textured GS
