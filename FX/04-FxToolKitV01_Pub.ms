/*
++-----------------++ 	    Hosssam Hassan Sakr ++-----------------++
++-----------------++		FX Tool Kit V 0.1 	++-----------------++
++------------------++ 	Created 6-Mar-2017 	++-----------------++
++------------------++ 	finish 9-Mar-2017	 ++-----------------++
++------------------++ some tools not incloded 	++------------------++
*/
LayerMan()

try (DestroyDialog _FX_Tool_Kit)Catch()

rollout _FX_Tool_Kit "FX Tool Kit v1.0" width:162 height:390
(
	groupBox 'grpFXSceneArrange' "FX Scene Arrange" pos:[2,6] width:155 height:113 align:#left
	button 'btnEnv' "Env" pos:[7,27] width:70 height:20 toolTip:"Env" align:#left
	button 'btn_Assets' "Assets" pos:[81,26] width:70 height:20 toolTip:"FX_Assets" align:#left
	button 'btnFX_Controls' "Controls" pos:[7,49] width:70 height:20 toolTip:"FX Controls" align:#left
	button 'btnFX_Emitters' "Emitters" pos:[81,49] width:70 height:20 toolTip:"FX Emitters" align:#left
	button 'btnFX_Helpers' "Helpers" pos:[7,71] width:70 height:20 toolTip:"FX Helpers" align:#left
	button 'btnFX_Renderable' "Renderable" pos:[82,71] width:70 height:20 toolTip:"FX_Renderable" align:#left
	button 'btnSceneControls' "SceneControls" pos:[7,94] width:70 height:20 toolTip:"SceneControls" align:#left
	button 'btnSceneScaler' "Scene Scaler" pos:[81,95] width:70 height:20 toolTip:"FX Scene Scaler" align:#left
	groupBox 'grp2' "FX color guide" pos:[4,121] width:152 height:85 align:#left
	button 'btn_StaticObj' "StaticObj" pos:[8,137] width:70 height:20 toolTip:"Static Obj" align:#left
	button 'btn_DynObj' "DynObj" pos:[81,137] width:70 height:20 toolTip:"Dyn Obj" align:#left
	button 'btnNoColideObj' "noColideObj" pos:[80,160] width:70 height:20 toolTip:"no Colide Obj" align:#left
	button 'btnGroupObj' "Group Obj" pos:[8,182] width:70 height:20 toolTip:"Group Obj" align:#left
	button 'btnRandomColor' "Random Color" pos:[80,182] width:70 height:20 toolTip:"Random Color" align:#left
	button 'btn_CheckGeo' "Check Geo" pos:[9,229] width:70 height:20 toolTip:"Check Geo" align:#left
	button 'btn_Cap_Holes' "Cap Holes" pos:[82,229] width:70 height:20 toolTip:"Cap Holes" align:#left
	groupBox 'grp4' "Check Asset" pos:[5,210] width:152 height:45 align:#left
	groupBox 'grp7' "FX Sim\Caching" pos:[5,255] width:152 height:71 align:#left
	button 'btn_FumeFX' "Fume FX" pos:[9,274] width:70 height:20 toolTip:"Fume FX Caching" align:#left
	button 'btn_PF_Disk' "PF Disk" pos:[81,274] width:70 height:20 toolTip:"PF Disk Caching" align:#left
	button 'btn_XMesh' "X Mesh" pos:[9,297] width:70 height:20 toolTip:"X Mesh Caching" align:#left
	button 'btn_Krakatoa' "Krakatoa" pos:[82,297] width:70 height:20 toolTip:"Krakatoa Caching" align:#left
	groupBox 'grp8' "FX Rendering" pos:[5,331] width:152 height:46 align:#left
	button 'btn_ILP' "Interactive Light Pass" pos:[12,349] width:138 height:20 toolTip:"Interactive Light Pass" align:#left
	button 'btn_ColideObj' "ColideObj" pos:[8,160] width:70 height:20 toolTip:"ColideObj" align:#left


	on btnEnv pressed  do
	(
	-- *** Create ENV Layer ***
	_NewColor=	(color 52 18 48)
	LayerManWColor "Env" _NewColor
	freeze $
	)
	on btn_Assets pressed  do
	(
		-- *** Create FX_Assets ***
	_NewColor=	(color 52 18 48)
	LayerManWColor "FX_Assets" _NewColor
	)
	on btnFX_Controls pressed  do
	(
		-- *** Create FX_Controls ***
	_NewColor=	(color 233 202 165)
	LayerManWColor "FX_Controls" _NewColor
	)
	on btnFX_Emitters pressed  do
	(
		-- *** Create FX_Emitters ***
	_NewColor=	(color 95 145	140)
	LayerManWColor "FX_Emitters" _NewColor		
	)
	on btnFX_Helpers pressed  do
	(
		-- *** Create FX_Helpers ***
	_NewColor=	(color 85 66 71)
	LayerManWColor "FX_Helpers" _NewColor		
	)
	on btnFX_Renderable pressed  do
	(
		-- *** Create FX_Renderable ***
	_NewColor=(color 205 42	65)
	LayerManWColor "FX_Renderable" _NewColor
	)
	on btnSceneControls pressed  do
	(
		-- *** Create SceneControls ***
	_NewColor= (color 42 205	42)
	LayerManWColor "SceneControls" _NewColor
	)
	
	on btnSceneScaler pressed  do
	(
		-- Link  to dummy
		sceneSelection = $* as Array 
		Scaler =dummy() 
		Scaler.name="_FxAsset_dummyScaler"
		
		for i = 1 to sceneSelection.count do 
		(
				if sceneSelection[i].parent == undefined then sceneSelection[i].parent = Scaler 
		)
	)
	
	on btn_StaticObj pressed  do
	(
		$.wirecolor = (color 255 0 0)
	)
	on btn_DynObj pressed  do
	(
		$.wirecolor = (color 0 255 0)
	)
	on btnNoColideObj pressed  do
	(
		$.wirecolor = (color 0 0 255)
	)
	on btn_ColideObj pressed  do
	$.wirecolor = (color 100 100 100)
	
		on btnRandomColor pressed  do
	$.wirecolor = (color (random 0 255) (random 0 255) (random 0 255))
	on btnGroupObj pressed  do
	(
		actionMan.executeAction 0 "40140"  -- Groups: Group
	)
	on btn_CheckGeo pressed  do
	(
		modPanel.addModToSelection (STL_Check ()) ui:on
		$.modifiers[#STL_Check].Check_Now = 1
	)
	on btn_Cap_Holes pressed  do
		modPanel.addModToSelection (Cap_holes ()) ui:on

	on btn_FumeFX pressed  do
		::filein (DevLocTools + @"Cache\Mod03-FFXRendSimSubmitTool01.ms")
	
	on btn_PF_Disk pressed  do
		::filein  (DevLocTools + @"Cache\MOD03-PFlowDiskCacheTool.ms")
	
	on btn_XMesh pressed  do
		::filein (DevLocTools + @"Cache\MOD3-XMesh.ms")
	
	on btn_Krakatoa pressed  do
		::filein (DevLocTools + @"Cache\MOD03-KrakatoaCacheTool.ms")
	
	on btn_ILP pressed  do
		::filein (DevLocTools + @"Rendering\Mod2_ILPSaveOut_ILP_UI_Final.ms")
)
CreateDialog _FX_Tool_Kit