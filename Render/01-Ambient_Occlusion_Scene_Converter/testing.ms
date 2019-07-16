
	SceneObjects= $* as array

	for i=1 to SceneObjects.count do 
	(
		if (superclassof SceneObjects[i] == GeometryClass) or (superclassof SceneObjects[i] == shape)  then
		(
			if SceneObjects[i].Material != undefined then  --- check if it has material or not 
			(
				print "1 " + (SceneObjects[i].Material.name) as string + "     -     "+  selectedMaterialname   
				append SceneObjects i 
				--- check if it is geo  matrial changed or not
				
				ObjMatName = (SceneObjects[i].Material.name)
				FilterObjMatName =  filterstring ObjMatName "_"  as array
				selectedMaterialname = SceneObjects[i].Material.name
					
				if FilterObjMatName[1] != "NewMatAO" do 
				(
					H =i
				case classof SceneObjects[i].Material OF 
					(
						standardmaterial: ToStanderdMTL( i )
						VRayMtl: ToVRayMtl(i)
						VRayMtlWrapper: ToVRayMtlWrapper( i ) 
						VRay2SidedMtl: ToVRay2SidedMtl(i)
						Shellac: ToShellac( i )
						VRayFastSSS2: ToVRayFastSSS2( i )
						VRaySkinMtl: ToVRaySkinMtl( i )
						Doublesided: ToDoublesided ( i)
						VRayCarPaintMtl: ToVRayCarPaintMtl( i )
						Blend: ToBlend( i)
						VRayBlendMtl: ToVRayBlendMtl(i )
						Multimaterial: ToMultimaterial( i )

					)
				)
			)
		)
	)
	
	
