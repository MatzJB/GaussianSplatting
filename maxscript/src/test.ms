
*/
fn p2a p =
(
	tmp=#()
	append tmp p[1]
	append tmp p[2]
	append tmp p[3]
	return tmp
)

----------------------
obj = $
helper_radius = amax (p2a ($.max - $.min))
helper_radius = helper_radius
	
--scatter_object = geosphere segs:3 name:"Camera Grid Helper" pos:helper_center radius:(2*helper_radius)
scatter_object = geosphere segs:3 radius:helper_radius
scatter_object.transform = obj.transform
move scatter_object (obj.center - scatter_object.center)
	
vertexList = #()
normalList = #()
meshObj = snapshotAsMesh scatter_object

for v = 1 to getNumVerts meshObj do 
(
	append vertexList (getVert meshObj v)
	append normalList (getNormal meshObj v)
)

if obj != meshObj do delete meshObj
cam = vrayCreateVRayPhysicalCamera()
cam.name = "tmp"

_cameras = #()
for i = 1 to vertexList.count do
(
	cameraName = "vray_camera_" + (i as string)
	maxOps.cloneNodes (cam) cloneType:#instance newNodes:&newObj
	temp_cam = newObj[1]
	temp_cam.position = vertexList[i]
	temp_cam.name = cameraName
	temp_cam.targeted = true
	append _cameras temp_cam
)

for i=1 to _cameras.count do
(
	_camera = _cameras[i]
	--_camera.Target.pos = obj.center
	_camera.Target.pos = vertexList[i] + 2*normalList[i]
	--todo: align using geometry normal instead, will work better for different shapes


