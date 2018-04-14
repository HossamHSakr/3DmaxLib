/*
++-----------------++ Hosssam Hassan Sakr   ++-----------------++
++-----------------++ (+20) 100 7765 835  ++-----------------++
++-----------------++ sniper.hh@gmail.com   ++-----------------++
++-----------------++ Layer_Explorer_3ds_Max_Issue_V01    ++-----------------++
++-----------------++ Created 13-april-2018 ++-----------------++
++-----------------++ finish 13-april-2018  ++-----------------++

try (DestroyDialog LayerErr )catch()
rollout LayerErr "Layer Explorer IssueV01" width:162 height:185
(
	groupBox 'grp1' "Show layer by:" pos:[6,4] width:147 height:93 align:#left
	label 'info' "Info...Hotfix for unavaliable layers in scene explorer.		Hossam Hassan Sakr		(+202) 0100 7765 835		sniper.hh@gmail.com" pos:[9,104] width:144 height:70 align:#left
	button '_Object' "Selected Object" pos:[19,26] width:113 height:27 toolTip:"select one object" align:#left
	button '_All' "All Objects" pos:[19,61] width:113 height:27 align:#left
	on _Object pressed  do
	(
	LayerName = ($.layer.Name )as string
		if layerManager.getLayerFromName (LayerName) == undefined then
		theLayer = LayerManager.newLayerFromName (LayerName)
		Else theLayer = LayerManager.GetLayerFromName (LayerName)
		
		for i in selection do i.layer.select true
		obj = selection as array
		for i =1 to obj.count do	
			( 
			theLayer.addnode obj[i] 
			append Main obj[i]
			)
			theLayer.ishidden = true
		)
	on _All pressed  do
	(
	Main = $* as array 
	Temp = #()
	TempLayer=#()
	TempLayerName=#()
	
	for i =1 to Main.count do 
	(
		TempLayerName = Main[i].layer.Name 
		Test = appendifunique TempLayer  TempLayerName
		if Test == true do 
			(
			append Temp Main[i] 
			)
	)
		
	for i =1 to temp.count do 
		(
			LayerName = (temp[i].layer.Name )as string
			if layerManager.getLayerFromName (LayerName) == undefined then
			theLayer = LayerManager.newLayerFromName (LayerName)
			Else theLayer = LayerManager.GetLayerFromName (LayerName)
			select temp[i]
			for i in selection do i.layer.select true
			obj = selection as array
			for i =1 to obj.count do	
				( 
				theLayer.addnode obj[i] 
				append Main obj[i]
				)
				theLayer.ishidden = true
		)
	)
)
CreateDialog LayerErr
