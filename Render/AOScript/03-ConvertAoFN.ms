/* 
--------------------------------------------------
--- 	AO scene convert  			---
--- 	Created By Hossam Hassan		---
---			sniper.hh@gmail.com				---
----												---
---			Finished 30-5-2017 				---
---------------------------------------------------

*/
global selectedMaterial = ""
global selectedMaterialname = ""
global OStanderdMap = ""

fn StdMtl =
	(
		print "2"
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
			print " Create AO for this one"
			selectedMaterial = VRayLightMtl twoSided:on compensate_exposure:on opacity_multiplyColor:on opacity_texmap:OStanderdMap 
			selectedMaterial.texmap = VRayDirt radius:VRayDirtRadius work_with_transparency:on
			selectedMaterial.name =   "NewMatAO_"+ selectedMaterialname  --- Change material Name
		)
	)

fn VRMtl =
	(
		print "3"
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
		print "3"
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
		print "3"
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
	
print "Lib For VRay scene convert "
print "StdMtl - VRMtl - VRFastSSS2Mtl - VRSkinMtl -  -"