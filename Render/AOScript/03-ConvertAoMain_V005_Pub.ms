/* 
--------------------------------------------------
--- 	AO scene convert  			---
--- 	Created By Hossam Hassan		---
---			sniper.hh@gmail.com				---
----												---
---			Finished 30-5-2017 				---
---			updated 9-7-2019					---
---------------------------------------------------

*/

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
----------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------		Change next line to match your script folder 		  ------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
::Filein @"D:\Tools\GitHub\3DmaxLib\Render\AOScript\03-ConvertAoFN.ms"
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------


SceneObjects= $* as array
--Try(
for i=1 to SceneObjects.count do 
(
	if (superclassof SceneObjects[i] == GeometryClass) or (superclassof SceneObjects[i] == shape)  then
	(
		if SceneObjects[i].Material != undefined then  --- check if it is geo or not 
		(
			print "1 " + (SceneObjects[i].Material.name) as string + "     -     "+  selectedMaterialname   
			append SceneObjects i 
			
			--- check if it is geo  matrial changed or not
			ObjMatName = (SceneObjects[i].Material.name)
			FilterObjMatName =  filterstring ObjMatName "_"  as array
			selectedMaterialname = SceneObjects[i].Material.name
				
			if FilterObjMatName[1] != "NewMatAO" do 
			(
				--print (SceneObjects[i].Name +  SceneObjects[i].Material )
				
				if classof SceneObjects[i].Material == standardmaterial then  --- Standerd Materialmm
				(/********************************************************************************************************************/
					print "2 standardmaterial "   + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					selectedMaterial = SceneObjects[i].Material
					selectedMaterialname = SceneObjects[i].Material.name
					StdMtl()
					SceneObjects[i].Material = selectedMaterial
				)
				
				if classof SceneObjects[i].Material == VRayMtl then --- Vray Material
				(/********************************************************************************************************************/
					print "3 VRayMtl"  + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					selectedMaterial = SceneObjects[i].Material
					VRMtl()
					SceneObjects[i].Material = selectedMaterial
				)
				
				if classof SceneObjects[i].Material == VRayMtlWrapper then --- VRayMtlWrapper Material
				(/********************************************************************************************************************/
					print "12 VRayMtlWrapper"  + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					
					selectedMaterialMain =SceneObjects[i].Material
					if classof selectedMaterialMain.baseMtl == VRayMtl then
						(
						selectedMaterial =selectedMaterialMain.baseMtl
						VRMtl()
						selectedMaterialMain.baseMtl = selectedMaterial
						SceneObjects[i].Material = selectedMaterialMain
					)
					
					if classof selectedMaterialMain.baseMtl == standardmaterial then
					(
						selectedMaterial =selectedMaterialMain.baseMtl
						StdMtl()
						selectedMaterialMain.baseMtl= selectedMaterial
						
					)
					SceneObjects[i].Material = selectedMaterialMain
				)
				
				if classof SceneObjects[i].Material == VRay2SidedMtl then 
				(/********************************************************************************************************************/
					print "5 VRay2SidedMtl" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					selectedObj = SceneObjects[i]
					try(
						selectedMaterialMain = SceneObjects[i].Material 
						selectedMaterialname = SceneObjects[i].Material.name
						selectedMaterialF = SceneObjects[i].Material.frontMtl
						selectedMaterialFname = SceneObjects[i].Material.frontMtl.name
						if SceneObjects[i].Material.backMtl != undefined do 
						(
						selectedMaterialB= SceneObjects[i].Material.backMtl
						selectedMaterialBname = SceneObjects[i].Material.BackMtl.name
						)--- 
						if classof selectedMaterialF == standardmaterial do
						(
							selectedMaterial = SceneObjects[i].Material.frontMtl
							selectedMaterialname = SceneObjects[i].Material.name
							StdMtl()
							selectedMaterialF = selectedMaterial
							print "5.MFSt"
						)
						if classof selectedMaterialF == VRayMtl do
						(
							selectedMaterial = SceneObjects[i].Material.frontMtl
							selectedMaterialname = SceneObjects[i].Material.name
							VRMtl()
							selectedMaterialF = selectedMaterial
							print "5.MFVr"
						)
						
						selectedObj.Material = selectedMaterialMain
						selectedMaterialMain.frontMtl = selectedMaterialF 
						
						if classof selectedMaterialB == standardmaterial do
						(
							selectedMaterial = SceneObjects[i].Material.backMtl
							selectedMaterialname = SceneObjects[i].Material.name
							StdMtl()
							selectedMaterialB = selectedMaterial
							print "5.BFSt"
						)
						if classof selectedMaterialB == VRayMtl do
						(
							selectedMaterial = SceneObjects[i].Material.backMtl
							selectedMaterialname = SceneObjects[i].Material.name
							VRMtl()
							selectedMaterialB = selectedMaterial
							print "5.BFVr"
						)
					)Catch()

					selectedMaterialMain.backMtl = selectedMaterialB 
					selectedMaterialMain.name =   "NewMatAO_"+selectedMaterialname
					SceneObjects[i].Material
					
				)
				try (
				if classof SceneObjects[i].Material == Shellac  then 
				(/********************************************************************************************************************/
					
					print "6 Shellac" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					SceneObject = SceneObjects[i].Material
					selectedMaterialnameShellac = SceneObjects.name
					
					if classof SceneObject.shellacMtl1 == standardmaterial do  --- Standerd Material
					(
						selectedMaterial = SceneObject.shellacMtl1
						selectedMaterialname = SceneObject.shellacMtl1.name
						StdMtl()
						SceneObject.shellacMtl1.name = "NewMatAO_"+selectedMaterialname
						(SceneObject.shellacMtl1 = selectedMaterial)
						print "6.1"
					)
					
					if classof SceneObject.shellacMtl1 == VRayMtl do --- Vray Material
					(
						selectedMaterial = SceneObject.shellacMtl1
						selectedMaterialname = SceneObject.shellacMtl1.name
						VRMtl()
						SceneObject.shellacMtl1.name = "NewMatAO_"+selectedMaterialname
						(SceneObject.shellacMtl1 = selectedMaterial) --<======
						print "6.2"
					)
					
					if classof SceneObject.shellacMtl2 == standardmaterial do  --- Standerd Material
					(
						selectedMaterial = SceneObject.shellacMtl2
						selectedMaterialname = SceneObject.shellacMtl2.name
						StdMtl()
						SceneObject.shellacMtl2.name = "NewMatAO_"+selectedMaterialname
						(SceneObject.shellacMtl2 = selectedMaterial)
						print "6.1"
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
				)catch()
				
				if classof SceneObjects[i].Material == VRayFastSSS2 then 
				(/********************************************************************************************************************/
					print "7 VRayFastSSS2" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					selectedMaterial = SceneObjects[i].Material
					selectedMaterialname = SceneObjects[i].Material.name
					VRFastSSS2Mtl()
					SceneObjects[i].Material = selectedMaterial
					selectedMaterial.name = "NewMatAO_"+ selectedMaterialname
				)
				
				if classof SceneObjects[i].Material == VRaySkinMtl then 
				(/********************************************************************************************************************/
					print "8 VRaySkinMtl" + SceneObjects[i].name + "     -     "+  selectedMaterialname
					selectedMaterial = SceneObjects[i].Material
					selectedMaterialname = SceneObjects[i].Material.name
					VRSkinMtl()
					SceneObjects[i].Material = selectedMaterial
				)
				
				if classof SceneObjects[1].Material == Doublesided do 
				(
					print "5 Doublesided " + SceneObjects[1].name + "     -     "+  selectedMaterialname
					selectedObj = SceneObjects[1]
					selectedMaterialMain = SceneObjects[1].Material 
					selectedMaterialname = SceneObjects[1].Material.name
					
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
						print "5.MFSt"
					)
					
					if classof selectedMaterialF == VRayMtl do
					(
						selectedMaterial = selectedMaterialMain.material1
						selectedMaterialname = selectedMaterial.name
						VRMtl()
						selectedMaterialF = selectedMaterial
						print "5.MFVr"
					)
					
					selectedObj.Material = selectedMaterialMain
					selectedMaterialMain = selectedMaterialF 
					
					if classof selectedMaterialB == standardmaterial do
					(
						selectedMaterial = selectedMaterialMain.material2
						selectedMaterialname = selectedMaterial.name
						StdMtl()
						selectedMaterialB = selectedMaterial
						print "5.BFSt"
					)
					if classof selectedMaterialB == VRayMtl do
					(
						selectedMaterial = selectedMaterialMain.material2
						selectedMaterialname = selectedMaterial.name
						VRMtl()
						selectedMaterialB = selectedMaterial
						print "5.BFVr"
					)
					selectedMaterialMain.material2 = selectedMaterialB 
					selectedMaterialMain.name =   "NewMatAO_"+selectedMaterialname
					SceneObjects[i].Material
				)
				
				if classof SceneObjects[i].Material == VRayCarPaintMtl do 
				(/****************************************** VRayCarPaintMtl ************************************/
					print "13 VRayCarPaintMtl " + SceneObjects[i].name + "     -     "+  selectedMaterialname
					selectedMaterial = SceneObjects[i].Material
					CarPaint()
					SceneObjects[i].Material = selectedMaterial
				)
					
				if classof SceneObjects[i].Material == Blend then 
				(/********************************************************************************************************************/
					print "11 Blend" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					selectedMaterialMain = SceneObjects[i].Material 
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
					
					selectedMaterial = SceneObjects[i].Material
					selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
				
				)
				
				if classof SceneObjects[i].Material == VRayBlendMtl then 
				(/********************************************************************************************************************/
					print "9 VRayBlendMtl" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					print SceneObjects[i].Material
					selectedMaterialMain = SceneObjects[i].Material 
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
					
				print "04"
				selectedMaterial = SceneObjects[i].Material
				selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
				)

				if classof SceneObjects[i].Material == Multimaterial then 
				(/********************************************************************************************************************/
					print "10 Multimaterial " + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
					print SceneObjects[i].Material
					selectedMaterialMain = SceneObjects[i].Material 
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
						(/******************************************Nested VRayCarPaintMtl ************************************/
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
								(/******************************************Nested VRayCarPaintMtl ************************************/
									selectedMaterial = selectedMaterialMainList[n]
									CarPaint()
									selectedMaterialMainList[n] = selectedMaterial
								)
								
								selectedMaterial = SceneObjects[i].Material
								selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
							)
						)
						
						if classof selectedMaterialMainList[n] == VRayBlendMtl  do --- VRayBlendMtl Material
						(/******************************* Nested  VRayBlendMtl**************************/
							print "9 VRayBlendMtl " + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
							print SceneObjects[i].Material
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
							print "04"
							selectedMaterial = SceneObjects[i].Material
							selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
						)
						
						if classof selectedMaterialMainList[n] == Doublesided then 
						(/******************************* Nested  Doublesided**************************/
							selectedObj = SceneObjects[i]
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
								print "5.MFSt"
							)
							
							if classof selectedMaterialF == VRayMtl do
							(
								selectedMaterial = selectedMaterialMain.material1
								selectedMaterialname = selectedMaterial.name
								VRMtl()
								selectedMaterialF = selectedMaterial
								print "5.MFVr"
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
								print "5.BFSt"
							)
							if classof selectedMaterialB == VRayMtl do
							(
								selectedMaterial = selectedMaterialMain.material2
								selectedMaterialname = selectedMaterial.name
								VRMtl()
								selectedMaterialB = selectedMaterial
								print "5.BFVr"
							)
							selectedMaterialMain.material2 = selectedMaterialB 
							selectedMaterialMain.name =   "NewMatAO_"+selectedMaterialname
							SceneObjects[i].Material
						)
						
						if classof selectedMaterialMainList[n] == Blend then 
						(/*******************************Nested Blend **********************************/
							print "11" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
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
							
							selectedMaterial = SceneObjects[i].Material
							selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
						)
						selectedMaterial = SceneObjects[i].Material
						selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname
						
						if classof selectedMaterialMainList[n] == VRayFastSSS2 then 
						(/*******************************Nested VRayFastSSS2 **********************************/

							print "7" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
							selectedMaterial = selectedMaterialMainList[n]
							selectedMaterialname = SceneObjects[i].Material.name
							VRFastSSS2Mtl()
							selectedMaterialMainList[n] = selectedMaterial
							selectedMaterial.name = "NewMatAO_"+ selectedMaterialname
						)
						
						if classof selectedMaterialMainList[n] == VRay2SidedMtl then 
						(/****************************************Nested VRay2SidedMtl **********************************/
							print "5 VRay2SidedMtl" + (SceneObjects[i].name) as string + "     -     "+  selectedMaterialname
							
							selectedObj = selectedMaterialMainList[n]
							try(
								selectedMaterialMain = selectedMaterialMainList[n].Material 
								selectedMaterialname = selectedMaterialMainList[n].Material.name
								selectedMaterialF = selectedMaterialMainList[n].Material.frontMtl
								selectedMaterialFname = selectedMaterialMainList[n].Material.frontMtl.name
								if SceneObjects[i].Material.backMtl != undefined do 
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
							)Catch()

							selectedMaterialMain.backMtl = selectedMaterialB 
							selectedMaterialMain.name =   "NewMatAO_"+selectedMaterialname
							SceneObjects[i].Material
							
						)
					)
				)
			)
		)else(

			selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on  
			selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
			selectedMaterial.name =   "NewMatAO_"+selectedMaterialname  --- Change material Name
			SceneObjects[i].Material = selectedMaterial
		)
	)else(append SceneObjects i )
)
--)catch()
---	print( SceneObjects[i].name +"  -  "+  SceneObjects[i].Material.name)