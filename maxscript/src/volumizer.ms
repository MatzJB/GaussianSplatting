-- matz JB
-- if you update the geometry, we want to update the camera animation each time, add a button for that

--ConvertTo $ Editable_Poly
-- if cameras are already attached to objects, remove them

fn removeCamerasFromGeometry geo =
(
	for c in (cameras as array)  do
	(
		if classof c.position.controller == Attachment and c.position.controller.node == geo do
			(
				delete c
			)
	)
	
)


removeCamerasFromGeometry $
-- list cameras and be able to click through them





-- rigObject is not supposed to be rendered and it's half transparent in viewport
rigObject = $
rigObject.xray = on
rigObject.renderable = off
maxOps.cloneNodes rigObject cloneType:#instance newNodes:&tempObject
ConvertTo tempObject Editable_Poly

-- place camera on to faces of geometry
--for j = 1 to 0.5*(getNumFaces $) by 2 do
numberOfFaces = getNumFaces tempObject[1]
delete tempObject[1]
-- rotate camera so it targets the center of the object at the first fram
-- target center, save transform apply to camera without target

cam = vrayCreateVRayPhysicalCamera()
attachmentControl = Attachment()
animationRange = interval 1f (float(numberOfFaces))
cameraName = "rig_cam"
cam.rotation = EulerAngles 90 0 0
cam.target = rigObject

-- you modify the box segments, maybe update with this?
	
for j = 1 to 2*numberOfFaces by 2 do 
-- everything is converted to triangles, so each face is a triangle, we need to skip every other face/triangle and find the center
(		
	
	--cameraName = "vray_camera_" + (j as string)
	--maxOps.cloneNodes (cam) cloneType:#instance newNodes:&newObj
	cam.position.controller = attachmentControl
	cam.name = cameraName
	attachmentControl.node = rigObject
	--addNewKey attachmentControl 1 -- add to frame

	--akey = AttachCtrl.getKey attachmentControl 1
	akey = AttachCtrl.addNewKey attachmentControl j
	akey.face = j
	akey.time = j/2
	akey.coord = point2 1 0 -- move into middle of triangle pair
	--akey.coord = point2 0.5 0 -- move into middle of triangle pair
)

-- rotate camera 
-- A: 0.5, B=0
-- possible to take each two faces and interpolate?
-- we need to skip every other face because of triangles, each face is a triangle
--rotate $rig_cam (eulerangles 180 0 0) --flip camera




-- create geometry of nested objects
originalObject = $
n = 5 -- number of objects inside original object to fill the volume

m = (n+1)*0.5 -- we need to halve the number
sc = 1.0
i = 0
nestedGeometries = #()
--append nestedGeometries originalObject 
ConvertTo originalObject Editable_Poly
-- assume selection is just one object

while i <= m do
(
	i = i + 1
	sc = sc - 1.0/m
	maxOps.cloneNodes (selection as array) cloneType:#copy newNodes:&nnl #nodialog
	oldScale = selection[1].scale
	scTemp = #(1, 1, 1)
	scTemp[1]  = oldScale[1]*sc
	scTemp[2]  = oldScale[2]*sc
	scTemp[3]  = oldScale[3]*sc
	
	nnl.scale = (point3 scTemp[1] scTemp[2] scTemp[3])
	nnl.center = originalObject.center
	append nestedGeometries nnl[1]
)
	
-- attach all objects:
for geo in nestedGeometries do 
(
	polyop.attach originalObject geo
)


-- random surfaces, direction inward7
-- use array!


