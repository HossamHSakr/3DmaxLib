/* 
--------------------------------------------------
--- 	AO scene convert  			---
--- 	Created By Hossam Hassan		---
---			sniper.hh@gmail.com				---
----												---
---			Finished 30-5-2017 				---
---------------------------------------------------

*/
	----- Main Fn
	global selectedMaterial =""
	global selectedMaterial1 =""
	global selectedMaterial2 = ""
	global selectedMaterialF = ""
	global selectedMaterialB = ""
	global selectedMaterialname = ""
	global OStanderdMap = ""
	global selectedMaterialMain = ""
	global selectedMaterialMainList = ""
	global VRayDirtRadius = 75
	
	global 	i 
	global 	H
	global 	StdMtl
	global 	VRMtl
	global 	VRFastSSS2Mtl
	global 	VRSkinMtl
	global 	CarPaint
	global 	VRBlendMtl
	global	ToStanderdMTl
	global	ToVRayMtl
	global	ToVRayMtlWrapper
	global	ToVRay2SidedMtl
	global	ToShellac
	global	ToVRayFastSSS2
	global	ToVRaySkinMtl
	global	ToDoublesided
	global	ToVRayCarPaintMtl
	global	ToBlend
	global	ToVRayBlendMtl
	global	ToMultimaterial

	global SceneObjects 
	free SceneObjects
	SceneObjects= $* as array
try (
	fn StdMtl =
		(
			if selectedMaterial.opacityMapEnable != true then  
			(																----if there is no opacity map
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on  
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+selectedMaterialname  --- Change material Name
			)
			else 			----if there is opacity map
			(
				OStanderdMap =  selectedMaterial.opacityMap --- get opacity map
				try (OStanderdMap.rgbOutput = 1 )catch() --RGB Alpha as Gray
				--print " has opacityMap " + OStanderdMap.name
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on opacity_texmap:OStanderdMap 
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname  --- Change material Name
			)
		)

	fn VRMtl =
		(
			if selectedMaterial.texmap_opacity == undefined then  
			(																----if there is no opacity map
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on  
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+selectedMaterialname  --- Change material Name
			)
			else 			----if there is opacity map
			(
				OStanderdMap =  selectedMaterial.texmap_opacity --- get opacity map
				try (OStanderdMap.rgbOutput = 1 )catch()--RGB Alpha as Gray
				print " has opacityMap " + OStanderdMap.name
				print " Create AO for this one"
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on opacity_texmap:OStanderdMap 
				selectedMaterial.texmap = VRayDirt radius:75 work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname  --- Change material Name
			)
		)
		
	fn VRFastSSS2Mtl =
		(
			if selectedMaterial.texmap_opacity == undefined then  
			(																----if there is no opacity map
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on  
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+selectedMaterialname  --- Change material Name
			)
			else 			----if there is opacity map
			(
				OStanderdMap =  selectedMaterial.texmap_opacity --- get opacity map
				try (OStanderdMap.rgbOutput = 1 )catch() --RGB Alpha as Gray
				print " has opacityMap " + OStanderdMap.name
				print " Create AO for this one"
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on opacity_texmap:OStanderdMap 
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname  --- Change material Name
				--selectedMaterial.opacity_texmap = OStanderdMap
			)
		)
		
	fn VRSkinMtl =
		(
			if selectedMaterial.texmap_opacity == undefined then  
			(																----if there is no opacity map
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on  
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+selectedMaterialname  --- Change material Name	
			)
			 else			----if there is opacity map
			(
				OStanderdMap =  selectedMaterial.texmap_opacity --- get opacity map
				try (OStanderdMap.rgbOutput = 1 )catch() --RGB Alpha as Gray
				print " has opacityMap " + OStanderdMap.name
				print " Create AO for this one"
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on opacity_texmap:OStanderdMap 
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname  --- Change material Name
				selectedMaterial.opacity_texmap = OStanderdMap
			)
		)

		fn CarPaint =
		(
			print "2"
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on  
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+selectedMaterialname  --- Change material Name
		)
		
		fn VRBlendMtl =
		(
					if classof selectedMaterialMain.baseMtl == standardmaterial  do --- Standerd Material
					(
					selectedMaterial = selectedMaterialMain.baseMtl
					StdMtl()
					selectedMaterialMain.baseMtl = selectedMaterial
					)
					
					if classof selectedMaterialMain.baseMtl == VRayMtl  do --- Standerd Material
					(
					selectedMaterial = selectedMaterialMain.baseMtl
					VRMtl()
					selectedMaterialMain.baseMtl = selectedMaterial
					)

					for i = 1 to 9 do 
					(
					if selectedMaterialMain.coatMtl[i] != undefined then  --- check if it is geo or not 
						(
							--selectedMaterialMainList = selectedMaterialMain.coatMtl[i]
							if classof selectedMaterialMain.coatMtl[i] == standardmaterial  then --- Standerd Material
							(
							selectedMaterial = selectedMaterialMain.coatMtl[i]
							StdMtl()
							selectedMaterialMain.coatMtl[i]= selectedMaterial
							)
							if classof selectedMaterialMain.coatMtl[i] == VRayMtl  do --- Standerd Material
							(
							selectedMaterial = selectedMaterialMain.coatMtl[i]
							VRMtl()
							selectedMaterialMain.coatMtl[i] = selectedMaterial
							)
						)
					else
						(
							i+1
						)				
					)
				
					if classof selectedMaterialMain.baseMtl == standardmaterial  do --- Standerd Material
					(
						selectedMaterial = selectedMaterialMain.baseMtl
						StdMtl()
						selectedMaterialMain.baseMtl = selectedMaterial
					)
						
					if classof selectedMaterialMain.baseMtl == VRayMtl then --- Vray Material
					(
						selectedMaterial = selectedMaterialMain.baseMtl
						VRMtl()
						selectedMaterialMain.baseMtl = selectedMaterial
					)

		)
		
		fn ToStanderdMTL _i =
			(
				-- print "2 standardmaterial "   + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
				selectedMaterial = SceneObjects[_i].Material
				selectedMaterialname = SceneObjects[_i].Material.name
				StdMtl()
				SceneObjects[_i].Material = selectedMaterial
			)
		fn ToVRayMtl _i = 
			(
			---print "3 VRayMtl"  + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
			selectedMaterial = SceneObjects[_i].Material
			VRMtl()
			SceneObjects[_i].Material = selectedMaterial
			)
		fn ToVRayMtlWrapper _i =
			(
				--print "12 VRayMtlWrapper"  + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
				
				selectedMaterialMain =SceneObjects[_i].Material
				if classof selectedMaterialMain.baseMtl == VRayMtl then
					(
					selectedMaterial =selectedMaterialMain.baseMtl
					VRMtl()
					selectedMaterialMain.baseMtl = selectedMaterial
					SceneObjects[_i].Material = selectedMaterialMain
				)
				
				if classof selectedMaterialMain.baseMtl == standardmaterial then
				(
					selectedMaterial =selectedMaterialMain.baseMtl
					StdMtl()
					selectedMaterialMain.baseMtl= selectedMaterial
					
				)
				SceneObjects[_i].Material = selectedMaterialMain
			)
		fn ToVRay2SidedMtl _i =
			(
			--print "5 VRay2SidedMtl" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
			selectedObj = SceneObjects[_i]
			
				selectedMaterialMain = SceneObjects[_i].Material 
				selectedMaterialname = SceneObjects[_i].Material.name
				selectedMaterialF = SceneObjects[_i].Material.frontMtl
				selectedMaterialFname = SceneObjects[_i].Material.frontMtl.name
				if SceneObjects[_i].Material.backMtl != undefined do 
				(
				selectedMaterialB= SceneObjects[_i].Material.backMtl
				selectedMaterialBname = SceneObjects[_i].Material.BackMtl.name
				)--- 
				if classof selectedMaterialF == standardmaterial do
				(
					selectedMaterial = SceneObjects[_i].Material.frontMtl
					selectedMaterialname = SceneObjects[_i].Material.name
					StdMtl()
					selectedMaterialF = selectedMaterial
					--print "5.MFSt"
				)
				if classof selectedMaterialF == VRayMtl do
				(
					selectedMaterial = SceneObjects[_i].Material.frontMtl
					selectedMaterialname = SceneObjects[_i].Material.name
					VRMtl()
					selectedMaterialF = selectedMaterial
					--print "5.MFVr"
				)
				
				selectedObj.Material = selectedMaterialMain
				selectedMaterialMain.frontMtl = selectedMaterialF 
				
				if classof selectedMaterialB == standardmaterial do
				(
					selectedMaterial = SceneObjects[_i].Material.backMtl
					selectedMaterialname = SceneObjects[_i].Material.name
					StdMtl()
					selectedMaterialB = selectedMaterial
					--print "5.BFSt"
				)
				if classof selectedMaterialB == VRayMtl do
				(
					selectedMaterial = SceneObjects[_i].Material.backMtl
					selectedMaterialname = SceneObjects[_i].Material.name
					VRMtl()
					selectedMaterialB = selectedMaterial
					--print "5.BFVr"
				)
					
					selectedMaterialMain.backMtl = selectedMaterialB 
					selectedMaterialMain.name =   "NewMatAO_"+selectedMaterialname
					SceneObjects[_i].Material
			)
		fn ToShellac _i = 
			(
				---print "6 Shellac" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
				SceneObject = SceneObjects[_i].Material
				selectedMaterialnameShellac = SceneObjects.name
				
				if classof SceneObject.shellacMtl1 == standardmaterial do  --- Standerd Material
				(
					selectedMaterial = SceneObject.shellacMtl1
					selectedMaterialname = SceneObject.shellacMtl1.name
					StdMtl()
					SceneObject.shellacMtl1.name = "NewMatAO_"+selectedMaterialname
					(SceneObject.shellacMtl1 = selectedMaterial)
					--print "6.1"
				)
				
				if classof SceneObject.shellacMtl1 == VRayMtl do --- Vray Material
				(
					selectedMaterial = SceneObject.shellacMtl1
					selectedMaterialname = SceneObject.shellacMtl1.name
					VRMtl()
					SceneObject.shellacMtl1.name = "NewMatAO_"+selectedMaterialname
					(SceneObject.shellacMtl1 = selectedMaterial) --<======
					--print "6.2"
				)
				
				if classof SceneObject.shellacMtl2 == standardmaterial do  --- Standerd Material
				(
					selectedMaterial = SceneObject.shellacMtl2
					selectedMaterialname = SceneObject.shellacMtl2.name
					StdMtl()
					SceneObject.shellacMtl2.name = "NewMatAO_"+selectedMaterialname
					(SceneObject.shellacMtl2 = selectedMaterial)
					---print "6.1"
				)
				
				if classof SceneObject.shellacMtl2 == VRayMtl do --- Vray Material
				(
					selectedMaterial = SceneObject.shellacMtl2
					selectedMaterialname = SceneObject.shellacMtl2.name
					VRMtl()
					SceneObject.shellacMtl2.name = "NewMatAO_"+selectedMaterialname
					(SceneObject.shellacMtl2 = selectedMaterial)
					print "6.2"
				)
				SceneObjects.name = "NewMatAO_"+ selectedMaterialnameShellac
			)
		fn ToVRayFastSSS2 _i =
			(
				--print "7 VRayFastSSS2" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
				selectedMaterial = SceneObjects[_i].Material
				selectedMaterialname = SceneObjects[_i].Material.name
				VRFastSSS2Mtl()
				SceneObjects[_i].Material = selectedMaterial
				selectedMaterial.name = "NewMatAO_"+ selectedMaterialname
			)
		fn ToVRaySkinMtl _i =
			(
				--print "8 VRaySkinMtl" + SceneObjects[i].name + "     -     "+  selectedMaterialname
				selectedMaterial = SceneObjects[_i].Material
				selectedMaterialname = SceneObjects[_i].Material.name
				VRSkinMtl()
				SceneObjects[_i].Material = selectedMaterial
			)
		fn ToDoublesided _i  =
			(
				---print "5 Doublesided " + SceneObjects[i].name + "     -     "+  selectedMaterialname
				selectedObj = SceneObjects[_i]
				selectedMaterialMain = SceneObjects[_i].Material 
				selectedMaterialname = SceneObjects[_i].Material.name
				
				selectedMaterialF = selectedMaterialMain.material1
				selectedMaterialFname = selectedMaterialF.name
				
				selectedMaterialB= selectedMaterialMain.material2
				selectedMaterialBname = selectedMaterialMain.material2.name
				 --- 
				if classof selectedMaterialF == VRayBlendMtl do
				(
					selectedMaterialMain = selectedMaterialMain.material1
					selectedMaterialMainBase = selectedMaterialMain.baseMtl 
					VRBlendMtl()
					selectedMaterialF = selectedMaterial
					selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
				)					
				
				if classof selectedMaterialF == standardmaterial do
				(
					selectedMaterial = selectedMaterialMain.material1
					selectedMaterialname = selectedMaterial.name
					StdMtl()
					selectedMaterialF = selectedMaterial
					--print "5.MFSt"
				)
				
				if classof selectedMaterialF == VRayMtl do
				(
					selectedMaterial = selectedMaterialMain.material1
					selectedMaterialname = selectedMaterial.name
					VRMtl()
					selectedMaterialF = selectedMaterial
					--print "5.MFVr"
				)
				
				selectedObj.Material = selectedMaterialMain
				selectedMaterialMain = selectedMaterialF 
				
				if classof selectedMaterialB == standardmaterial do
				(
					selectedMaterial = selectedMaterialMain.material2
					selectedMaterialname = selectedMaterial.name
					StdMtl()
					selectedMaterialB = selectedMaterial
					--print "5.BFSt"
				)
				if classof selectedMaterialB == VRayMtl do
				(
					selectedMaterial = selectedMaterialMain.material2
					selectedMaterialname = selectedMaterial.name
					VRMtl()
					selectedMaterialB = selectedMaterial
					--print "5.BFVr"
				)
				selectedMaterialMain.material2 = selectedMaterialB 
				selectedMaterialMain.name =   "NewMatAO_"+selectedMaterialname
				SceneObjects[_i].Material
			)
		fn ToVRayCarPaintMtl _i  =
			(
				--print "13 VRayCarPaintMtl " + SceneObjects[i].name + "     -     "+  selectedMaterialname
				selectedMaterial = SceneObjects[_i].Material
				CarPaint()
				SceneObjects[_i].Material = selectedMaterial
			)
		fn ToBlend _i  =
			(
				--print "11 Blend" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
				selectedMaterialMain = SceneObjects[_i].Material 
				selectedMaterialMainBase = selectedMaterialMain.MAP1 
				
				if classof selectedMaterialMain.MAP1 == standardmaterial  do --- Standerd Material
				(
				selectedMaterial = selectedMaterialMain.MAP1
				StdMtl()
				selectedMaterialMain.MAP1 = selectedMaterial
				)
				
				if classof selectedMaterialMain.MAP1 == VRayMtl  do --- Standerd Material
				(
				selectedMaterial = selectedMaterialMain.MAP1
				VRMtl()
				selectedMaterialMain.MAP1 = selectedMaterial
				)
				
				if classof selectedMaterialMain.MAP2 == standardmaterial  do --- Standerd Material
				(
				selectedMaterial = selectedMaterialMain.MAP2
				StdMtl()
				selectedMaterialMain.MAP2 = selectedMaterial
				)
				
				if classof selectedMaterialMain.MAP2 == VRayMtl  do --- Standerd Material
				(
				selectedMaterial = selectedMaterialMain.MAP2
				VRMtl()
				selectedMaterialMain.MAP2 = selectedMaterial
				)
				
				selectedMaterial = SceneObjects[_i].Material
				selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
			)
		fn ToVRayBlendMtl  _i =
			(
						-- print "9 VRayBlendMtl" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
						--print SceneObjects[i].Material
						selectedMaterialMain = SceneObjects[_i].Material 
						selectedMaterialMainBase = selectedMaterialMain.baseMtl 
						
						if classof selectedMaterialMain.baseMtl == standardmaterial  do --- Standerd Material
						(
						selectedMaterial = selectedMaterialMain.baseMtl
						StdMtl()
						selectedMaterialMain.baseMtl = selectedMaterial
						)
						
						if classof selectedMaterialMain.baseMtl == VRayMtl  do --- Standerd Material
						(
						selectedMaterial = selectedMaterialMain.baseMtl
						VRMtl()
						selectedMaterialMain.baseMtl = selectedMaterial
						)
							
								for s = 1 to 9 do 
								(
								if selectedMaterialMain.coatMtl[s] != undefined then  --- check if it has Matt or not 
									(
										--selectedMaterialMainList = selectedMaterialMain.coatMtl[i]
										if classof selectedMaterialMain.coatMtl[s] == standardmaterial  then --- Standerd Material
										(
										selectedMaterial = selectedMaterialMain.coatMtl[s]
										StdMtl()
										selectedMaterialMain.coatMtl[s]= selectedMaterial
										)
										if classof selectedMaterialMain.coatMtl[s] == VRayMtl  do --- Standerd Material
										(
										selectedMaterial = selectedMaterialMain.coatMtl[s]
										VRMtl()
										selectedMaterialMain.coatMtl[s] = selectedMaterial
										)
									)
								else
									(
										s+1
									)
								)
					
				if classof selectedMaterialMain.baseMtl == standardmaterial  do --- Standerd Material
					(
					selectedMaterial = selectedMaterialMain.baseMtl
					StdMtl()
					selectedMaterialMain.baseMtl = selectedMaterial
					)
					
				--print "04"
				selectedMaterial = SceneObjects[_i].Material
				selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
			)
		fn ToMultimaterial  _i =
			(
				print "10 Multimaterial " + (SceneObjects[_i].name) as string + "     -     "+  selectedMaterialname
				print SceneObjects[_i].Material
				selectedMaterialMain = SceneObjects[_i].Material 
				selectedMaterialMainList = selectedMaterialMain.materialList 
				for n = 1 to selectedMaterialMainList.count do
				(
					if classof selectedMaterialMainList[n] == standardmaterial  do --- Standerd Material
					(
					selectedMaterial = selectedMaterialMainList[n]
					StdMtl()
					selectedMaterialMainList[n] = selectedMaterial
					)
					
					if classof selectedMaterialMainList[n] == VRayMtl  do --- VRayMtl Material
					(
					selectedMaterial = selectedMaterialMainList[n]
					VRMtl()
					selectedMaterialMainList[n] = selectedMaterial
					)
					
					if classof selectedMaterialMainList[n] == VRayCarPaintMtl do 
					(
						selectedMaterial = selectedMaterialMainList[n]
						CarPaint()
						selectedMaterialMainList[n] = selectedMaterial
					)
					
					if classof selectedMaterialMainList[n] == Multimaterial  do --- Multimaterial Material
					(--*****************Nested MultiMaterial*************
						selectedMaterialMain = selectedMaterialMainList[n]
						selectedMaterialMainList = selectedMaterialMain.materialList 
						for n = 1 to selectedMaterialMainList.count do
						(
							if classof selectedMaterialMainList[n] == standardmaterial  do --- Standerd Material
							(
							selectedMaterial = selectedMaterialMainList[n]
							StdMtl()
							selectedMaterialMainList[n] = selectedMaterial
							)
							if classof selectedMaterialMainList[n] == VRayMtl  do --- Standerd Material
							(
							selectedMaterial = selectedMaterialMainList[n]
							VRMtl()
							selectedMaterialMainList[n] = selectedMaterial
							)
							
							if classof selectedMaterialMainList[n] == VRayCarPaintMtl do 
							(
								selectedMaterial = selectedMaterialMainList[n]
								CarPaint()
								selectedMaterialMainList[n] = selectedMaterial
							)
							
							selectedMaterial = SceneObjects[_i].Material
							selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
						)
					)
					
					if classof selectedMaterialMainList[n] == VRayBlendMtl  do --- VRayBlendMtl Material
					(
						--print "9 VRayBlendMtl " + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
						--print SceneObjects[i].Material
						selectedMaterialMain = selectedMaterialMainList[n]
						selectedMaterialMainBase = selectedMaterialMain.baseMtl 
						
						if classof selectedMaterialMain.baseMtl == standardmaterial  do --- Standerd Material
						(
						selectedMaterial = selectedMaterialMain.baseMtl
						StdMtl()
						selectedMaterialMain.baseMtl = selectedMaterial
						)
						
						if classof selectedMaterialMain.baseMtl == VRayMtl  do --- Standerd Material
						(
						selectedMaterial = selectedMaterialMain.baseMtl
						VRMtl()
						selectedMaterialMain.baseMtl = selectedMaterial
						)
						
						for s = 1 to 9 do 
							(
							if selectedMaterialMain.coatMtl[s] != undefined then  --- check if it is geo or not 
								(
									--selectedMaterialMainList = selectedMaterialMain.coatMtl[i]
									if classof selectedMaterialMain.coatMtl[s] == standardmaterial  then --- Standerd Material
									(
									selectedMaterial = selectedMaterialMain.coatMtl[s]
									StdMtl()
									selectedMaterialMain.coatMtl[s]= selectedMaterial
									)
									if classof selectedMaterialMain.coatMtl[s] == VRayMtl  do --- Standerd Material
									(
									selectedMaterial = selectedMaterialMain.coatMtl[s]
									VRMtl()
									selectedMaterialMain.coatMtl[s] = selectedMaterial
									)
								)
							else
								(
									s+1
								)				
							)
						print "04"
						selectedMaterial = SceneObjects[_i].Material
						selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
					)
					
					if classof selectedMaterialMainList[n] == Doublesided then 
					(/******************************* Nested  Doublesided**************************/
						selectedObj = SceneObjects[_i]
						selectedMaterialMain = selectedMaterialMainList[n]
						selectedMaterialname = selectedMaterialMainList[n].name
						selectedMaterialF = selectedMaterialMain.material1
						selectedMaterialFname = selectedMaterialF.name
						selectedMaterialB= selectedMaterialMain.material2
						selectedMaterialBname = selectedMaterialB.name
						 --- 
						if classof selectedMaterialF == standardmaterial do
						(
							selectedMaterial = selectedMaterialMain.material1
							selectedMaterialname = selectedMaterial.name
							StdMtl()
							selectedMaterialF = selectedMaterial
							--print "5.MFSt"
						)
						
						if classof selectedMaterialF == VRayMtl do
						(
							selectedMaterial = selectedMaterialMain.material1
							selectedMaterialname = selectedMaterial.name
							VRMtl()
							selectedMaterialF = selectedMaterial
							--print "5.MFVr"
						)
						--*
						
						
						--*
						selectedObj.Material = selectedMaterialMain
						selectedMaterialMain.material1 = selectedMaterialF 
						
						if classof selectedMaterialB == standardmaterial do
						(
							selectedMaterial = selectedMaterialMain.material2
							selectedMaterialname = selectedMaterial.name
							StdMtl()
							selectedMaterialB = selectedMaterial
							--print "5.BFSt"
						)
						if classof selectedMaterialB == VRayMtl do
						(
							selectedMaterial = selectedMaterialMain.material2
							selectedMaterialname = selectedMaterial.name
							VRMtl()
							selectedMaterialB = selectedMaterial
							--print "5.BFVr"
						)
						selectedMaterialMain.material2 = selectedMaterialB 
						selectedMaterialMain.name =   "NewMatAO_"+selectedMaterialname
						SceneObjects[_i].Material
					)
					
					if classof selectedMaterialMainList[n] == Blend then 
					(/*******************************Nested Blend **********************************/
						-- print "11" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
						selectedMaterialMain = selectedMaterialMainList[n] 
						selectedMaterialMainBase = selectedMaterialMain.MAP1 
						
						if classof selectedMaterialMain.MAP1 == standardmaterial  do --- Standerd Material
						(
						selectedMaterial = selectedMaterialMain.MAP1
						StdMtl()
						selectedMaterialMain.MAP1 = selectedMaterial
						)
						
						if classof selectedMaterialMain.MAP1 == VRayMtl  do --- Standerd Material
						(
						selectedMaterial = selectedMaterialMain.MAP1
						VRMtl()
						selectedMaterialMain.MAP1 = selectedMaterial
						)
						
						if classof selectedMaterialMain.MAP2 == standardmaterial  do --- Standerd Material
						(
						selectedMaterial = selectedMaterialMain.MAP2
						StdMtl()
						selectedMaterialMain.MAP2 = selectedMaterial
						)
						
						if classof selectedMaterialMain.MAP2 == VRayMtl  do --- Standerd Material
						(
						selectedMaterial = selectedMaterialMain.MAP2
						VRMtl()
						selectedMaterialMain.MAP2 = selectedMaterial
						)
						
						selectedMaterial = SceneObjects[_i].Material
						selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
					)
					selectedMaterial = SceneObjects[_i].Material
					selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
					
					if classof selectedMaterialMainList[n] == VRayFastSSS2 then 
					(

						--print "7" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
						selectedMaterial = selectedMaterialMainList[n]
						selectedMaterialname = SceneObjects[_i].Material.name
						VRFastSSS2Mtl()
						selectedMaterialMainList[n] = selectedMaterial
						selectedMaterial.name = "NewMatAO_"+ selectedMaterialname
					)
					
					if classof selectedMaterialMainList[n] == VRay2SidedMtl then 
					(
						print "5 VRay2SidedMtl" + (SceneObjects[_i].name) as string + "     -     "+  selectedMaterialname
						
						selectedObj = selectedMaterialMainList[n]
						
							selectedMaterialMain = selectedMaterialMainList[n].Material 
							selectedMaterialname = selectedMaterialMainList[n].Material.name
							selectedMaterialF = selectedMaterialMainList[n].Material.frontMtl
							selectedMaterialFname = selectedMaterialMainList[n].Material.frontMtl.name
							if SceneObjects[_i].Material.backMtl != undefined do 
							(
							selectedMaterialB= selectedMaterialMainList[n].Material.backMtl
							selectedMaterialBname = selectedMaterialMainList[n].Material.BackMtl.name
							)--- 
							if classof selectedMaterialF == standardmaterial do
							(
								selectedMaterial = selectedMaterialMainList[n].Material.frontMtl
								selectedMaterialname = selectedMaterialMainList[n].Material.name
								StdMtl()
								selectedMaterialF = selectedMaterial
								print "5.MFSt"
							)
							if classof selectedMaterialF == VRayMtl do
							(
								selectedMaterial = selectedMaterialMainList[n].Material.frontMtl
								selectedMaterialname = selectedMaterialMainList[n].Material.name
								VRMtl()
								selectedMaterialF = selectedMaterial
								print "5.MFVr"
							)
							
							selectedObj.Material = selectedMaterialMain
							selectedMaterialMain.frontMtl = selectedMaterialF 
							
							if classof selectedMaterialB == standardmaterial do
							(
								selectedMaterial = selectedMaterialMainList[n].Material.backMtl
								selectedMaterialname = selectedMaterialMainList[n].Material.name
								StdMtl()
								selectedMaterialB = selectedMaterial
								print "5.BFSt"
							)
							if classof selectedMaterialB == VRayMtl do
							(
								selectedMaterial = selectedMaterialMainList[n].Material.backMtl
								selectedMaterialname = selectedMaterialMainList[n].Material.name
								VRMtl()
								selectedMaterialB = selectedMaterial
								print "5.BFVr"
							)
						
							selectedMaterialMain.backMtl = selectedMaterialB 
							selectedMaterialMain.name =   "NewMatAO_"+selectedMaterialname
							SceneObjects[_i].Material
					)
				)
			)
	)Catch(  )
	---- Core of script ----
	

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
					H = i
				case classof SceneObjects[H].Material OF 
					(
						standardmaterial: ToStanderdMTL(H)
						VRayMtl: ToVRayMtl( H)
						VRayMtlWrapper: ToVRayMtlWrapper( H ) 
						VRay2SidedMtl: ToVRay2SidedMtl(H) -- need to check again 
						-- Shellac: ToShellac( H ) --- no more avaliable
						VRayFastSSS2: ToVRayFastSSS2( H )
						VRaySkinMtl: ToVRaySkinMtl( H )
						Doublesided: ToDoublesided ( H) --- need to check again 
						VRayCarPaintMtl: ToVRayCarPaintMtl( H )
						--- Blend: ToBlend( H)   --- no more avaliable
						VRayBlendMtl: ToVRayBlendMtl(H )
						Multimaterial: ToMultimaterial( H )
					)
				)
			
			)else(
				selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on  
				selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
				selectedMaterial.name =   "NewMatAO_"+selectedMaterialname  --- Change material Name
				SceneObjects[i].Material = selectedMaterial
				)
		)else(
				append SceneObjects i 
				)

	print "All Done Correctly"