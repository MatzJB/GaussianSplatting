-- we already have a rig
cameras_ = #()
cameras_ = $vray_camera_* as array




for i= 1 to (amin cameras_.count 3) do (
	render camera:_cameras[i] outputfile:("c:\\temp\\rig\\" + _cameras[i].name + ".jpg")  vfb:false
	renderSceneDialog.close()
)

