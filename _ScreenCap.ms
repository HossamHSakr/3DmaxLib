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

fn ScreenCap _FilePath _FileName _ViewX _ViewY= 
(
FilePath = _FilePath
FileName = _FileName 
ViewX = _ViewX -- view_size.x Dynamic
ViewY =	_ViewY --View_size.y Dynamic

MAKEDIR FilePath
ScreenCap = FilePath + FileName

View_size= GetViewSize()
ScreenCapOut = Bitmap ViewX ViewY filename:ScreenCap
viewDib = GW.GetViewPortDib()

Copy ViewDib ScreenCapOut
Save ScreenCapOut
Close ScreenCapOut

)

Print "**Note** ScreenCap >> _FilePath _FileName _ViewX _ViewY"
--ScreenCap @"d:\Temp\"  "screencap1.jpg"
