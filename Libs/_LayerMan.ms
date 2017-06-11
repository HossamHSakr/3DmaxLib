/* 
--------------------------------------------------
--- 			Screen Captuer				---
--- 	Created By Hossam Hassan			---
---			sniper.hh@gmail.com				---
---			fb.com\HossamH.sakr\	 		---
---												---
---				Finished 5-6-2017 			---
---------------------------------------------------

*/

Fn LayerMan _LayerName  = 
(
	LayerName = (_LayerName as string)
	if layerManager.getLayerFromName (LayerName) == undefined then
	theLayer = LayerManager.newLayerFromName (LayerName)
	Else theLayer = LayerManager.GetLayerFromName (LayerName)
	NewColor = (color (random 0 255) (random 0 255) (random 0 255))
	theLayer.wirecolor = NewColor
	$.wirecolor = NewColor
	for i in ( selection as array) do	( theLayer.addnode i )
)

Fn LayerManWColor _LayerName  _NewColor = 
(
	LayerName = (_LayerName as string)
	if layerManager.getLayerFromName (LayerName) == undefined then
	theLayer = LayerManager.newLayerFromName (LayerName)
	Else theLayer = LayerManager.GetLayerFromName (LayerName)
	NewColor = _NewColor
	theLayer.wirecolor = NewColor
	$.wirecolor = NewColor
	for i in ( selection as array) do	( theLayer.addnode i )
)
