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
LibPath = @"D:\FXTDT\DevFxTDT\MXS\Libs\" -- change this path to your Liberary directory

fn LibList = 
	(
	LibListItems = Getfiles (LibPath + "*")
	for i =1 to LibListItems.count Do 
		( 
			::filein (LibListItems[i])
		)
	)
	
	
	print "**Note** LibList()  -  FN Lib for Difine Lib Pathes "
