

-- returns an array with elements from <start> to <end>
fn range start end increment:1 =
(
	for i = start to end by increment collect i
)


fn randomizeArray arr:#() =
(
	local list = #()
	while arr.count != 0 do
	( 
		id = random 1 arr.count
		append list arr[id]
		deleteItem  arr id
	)
	list
)


-- todo: put all points in a table, only add if unique
-- f = float number f, d = decimal places
function f2s f d:7 =
(
	ss = formattedPrint f format:("." + d as string+"f")
)


-- turns obj meshes into a pointcloud containing maxPoints vertices
function createPointCloud obj maxPoints:100 =
(
	vertexList = #()
	normalList = #()
	if classof obj == Array then
	(
		-- pick first object, copy, convert to poly, add rest
		maxOps.cloneNodes (obj as array) cloneType:#copy newNodes:newNode #nodialog
		newNode = convertTo newNode Editable_Poly
		for i = 2 to obj.count do 
		(
			polyop.attach obj[i] newNode
		)
	)
	else
	(
		maxOps.cloneNodes obj cloneType:#copy newNodes:newNode #nodialog
		newNode = convertTo obj Editable_Poly
	)
	-- would be nice if we create a point cloud where the distance between the points ere maximized?
	newNode.name = "the_mesh"
	numVertices = getNumVerts newNode
	vertexFactor = int(numVertices/maxPoints)
	deleteVertsArray = #()
	-- remove vertices we don't want to export
	vertexIndices = RandomizeArray arr:(range 1 numVertices)
	i = 1
	for v in vertexIndices do 
	(
		i = i+1
		if mod i vertexFactor > 0 do
		(
			append deleteVertsArray v
		)
	)
	
	polyop.deleteVerts newNode deleteVertsArray
	newNode
)


-- Mesh
pc = createPointCloud $ maxPoints:200
numberOfPoints = getNumVerts pc
fs = openFile @"c:\temp\points3d.txt" mode:"w+"
format "# 3D point list with one line of data per point:\n" to:fs
format "#   POINT3D_ID, X, Y, Z, R, G, B, ERROR, TRACK[] as (IMAGE_ID, POINT2D_IDX)\n" to:fs
format "# Number of points: %, mean track length: 4.5525647836609409\n" (numberOfPoints as string) to:fs
--1 -7.0460523764069674 -3.275038568870837 8.493753835186558 193 130 71 0.75908267052016432 2 54 5 3932

pointIndices = range 1 numberOfPoints
-- fetch pointcloud and store the points
i = 0
for pointIndex in pointIndices do
(
	i = i + 1
	--format "%" pointIndex
	coordinate = polyop.getvert pc pointIndex
	x = coordinate.x
	y = coordinate.y
	z =	coordinate.z
	format "% % %" x y z to:fs -- X Y Z, use vertices of scene object
	format " % % %" 255 255 255 to:fs -- R G B, no color is needed
	format " %\n" 0.0 to:fs -- err
	--format "% % % %" 1 1 1 1 to:fs -- track[] image_id, point2d_idx
	--format "put this in" to:fs
)
close fs


obj = $
-- Images
-- filename to replace, use % to denote number
numberOfImages = 10
--formattedPrint <value> format:<string> userLocale:<boolean>

fs = openFile @"c:\temp\images_new.txt" mode:"w+"
-- 1 0.99999680587786954 0.00083786818153473751 -0.0013799993335300675 -0.0019446883576756462 4.4502234178478979 0.80494235239434864 1.9786919095398996 1 001.jpg

format "# Image list with two lines of data per image:\n" to:fs
format "# IMAGE_ID, QW, QX, QY, QZ, TX, TY, TZ, CAMERA_ID, NAME\n" to:fs
format "# POINTS2D[] as (X, Y, POINT3D_ID)\n" to:fs
format "# Number of images: %, mean observations per image: 3213.5416666666665\n" (numberOfImages  as string) to:fs

for imageID=1 to 10 do
(
	-- pick camera using frames
	sliderTime = imageID
	
	q = obj.transform.rotation
	t = obj.position
	
	format "%" (imageID as string) to:fs
	format " % % % %" (f2s q.w) (f2s q.x) (f2s q.y) (f2s q.z) to:fs -- Quaternion Q
	format " % % %" (f2s t.x) (f2s t.y) (f2s t.z) to:fs -- Translation T
	format " %" "1" to:fs -- CameraID
	
	filename = formattedPrint imageID format:".4d"
	format " %.jpg\n" filename to:fs-- Name
	i = 1
	
	format "0.0 0.0 0.0 " to:fs
	/*
	-- save the points (these are just random)
	for pointID = 1 to 1000 do 
	(
		i=i+1
		x = random 1.0 100
		y = random 1.0 100
		point3d_id = i
		format "% % % " (f2s x) (f2s y) (i as string) to:fs
	)
	*/
	format "\n"to:fs
	
)

close fs



-- Cameras
-- sees to be only one camera
/*
# Camera list with one line of data per camera:
#   CAMERA_ID, MODEL, WIDTH, HEIGHT, PARAMS[]
# Number of cameras: 1
1 PINHOLE 1054 1864 1767.7382558153508 1763.5642984930557 527 932
*/

fs = openFile @"c:\temp\cameras.txt" mode:"w+"

format "# Camera list with one line of data per camera:\n" to:fs
format "#   CAMERA_ID, MODEL, WIDTH, HEIGHT, PARAMS[]\n" to:fs
format "# Number of cameras: 1\n" to:fs
format "1 PINHOLE 1054 1864 1767.7382558153508 1763.5642984930557 527 932\n" to:fs


close fs








