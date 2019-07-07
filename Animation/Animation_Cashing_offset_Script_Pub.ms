/* 
--------------------------------------------------
--- 	Animation Cashing offset Script	---
--- 	Created By Hossam Hassan			---
---			sniper.hh@gmail.com				---
---	spicial thanks for Allaa ElDin Mokhtar ---
---												---
---			Finished 10-4-2017 				---
---------------------------------------------------

*/

try (DestroyDialog AnimationCashingoffsetScript)Catch ()
ACT =  (@"C:\Users\213\Dropbox\GFX\HiveStudio\Scripts\02-Animation Cashing offset Script\Animation Cashing offset Script Pub.ms")
global Ctrl 
global SelectionArray

global NewSets =#()
global NewSetsArray =#()

NewSets as string
try (
		for i=2 to selectionsets.count do
			(
				NewSets=selectionsets as string
				NewSetstems = (Filterstring NewSets "# ,()") as array
			)
	)catch()
NewSetstems
rollout AnimationCashingoffsetScript "Animation Cashing offset Script V01" width:162 height:315
(
	groupBox 'grp1' "" pos:[4,0] width:154 height:243 align:#left
	groupBox 'grp2' "About" pos:[4,243] width:154 height:65 align:#left
	
	pickButton 'btnPick' "Pick Controller Object" pos:[15,42] width:130 height:25 message:"Controller Picked" toolTip:"Pick Controller Object" align:#left
	button 'btnArray' "Pick Cashed Objects" pos:[15,70] width:130 height:25 message:"" toolTip:"Pick Cashed Objects" align:#left
	button 'btnRandomize' "Randomiz Selection" pos:[15,100] width:130 height:25 align:#left
	button 'btn11' "Cash single Animation" pos:[15,13] width:130 height:25 toolTip:"" align:#left
	button 'GOCahse_Btn' "offset Cahse" pos:[15,188] width:68 height:25 align:#left
	button 'GOKeyCashReset_Btn' "Reset Cash" pos:[85,188] width:68 height:25 align:#left toolTip:"Resst cashs to frame 0"
	button 'GOKey_Btn' "offset Keys" pos:[15,215] width:68 height:25 align:#left
	button 'GOKeyReset_Btn' "Reset Keys" pos:[85,215] width:68 height:25 align:#left toolTip:"Resst keys to frame 0"
	button 'refresh_Btn'"R" pos:[128,135] width:20 height:20 align:#left toolTip:"refresh selectionsets "

	dropDownList 'ddl1' "" pos:[16,135] width:106 height:40 align:#left Items:NewSetstems
	spinner CustomStart "Custom:" pos:[40,165] range:[-100,10000,10] type:#integer
	checkbox 'CustomStartCheck' checked:False pos:[15,165]
	
	label 'lbl1' "Hive Studio" pos:[50,254] width:59 height:20 align:#left
	label 'lbl2' "Hossam Hassan Sakr Allaa ElDin Mokhtar " pos:[33,272] width:106 height:30 align:#left
	
-- 	ASD =  _CustomStart.value
-- 	print ASD	
	on refresh_Btn pressed  do --- refresh statestes liste, 
	(
		try (DestroyDialog AnimationCashingoffsetScript)Catch ()
		::filein ACT
	)
	on btn11 pressed  do --- Apply PCash, and set Path in Max folder Need to adjust to current project cash folder, 
	(
		for i in $ Do 
			(
				modPanel.addModToSelection (Point_Cache ()) ui:on
				DefaultPath= maxfilepath
				DefaultCashPath = DefaultPath + @"CashFolder"
				MakeDir DefaultCashPath
				i.modifiers[#Point_Cache].filename = (DefaultCashPath+@"\" + i.name+ @".pc2")
				i.modifiers[#Point_Cache].playbackType = 1
				i.modifiers[#Point_Cache].loadType = 0
			)
	)
	on btnPick picked obj do 		--Pic Controller Objcets
		(
			Ctrl = obj
			btnPick.text=Ctrl.name
		)
	on btnArray pressed  do		-- select animated objcts group 
		(
			try (
					SelectionArray = $ as array
					for i in (selection as array) do 
					btnArray.text = ($.count) as string +" Objects Picked"
				)
			Catch()
		)
	on btnRandomize pressed  do		-- select rondom objcts group selection
	(
	SelectionArray = #() --will contain random objects from selection
	randomValArray = #(true,false) -- adding objects or not
	if selection.count >= 2 do -- make sure selection is more than two objects
		(
			for i in selection do
				(
					rand = random 1 2
					if randomValArray[rand] then -- If true or false
						(
							append SelectionArray i -- Put the current object in the loop to selection array
						)
				)
			clearselection()
			select SelectionArray
		)
	)	  
		  
	on GOCahse_Btn pressed  do		-- Offset Cashing Objects to start from distance CTRL
	(
		if CustomStartCheck.state == on then
			(--"Check on"
					
				print	 "Check on"
				CustomValStart = CustomStart.value
				print DistanceCtrl
				DistanceCtrl = (((distance Ctrl SelectionArray[i])/100 as integer) + CustomValStart)
				DistanceCtrl as integer
				SelectionArray[i].modifiers[#Point_Cache].playbackType = 1
				SelectionArray[i].modifiers[#Point_Cache].playbackStart = DistanceCtrl
				print ("Animation cashe with custom start on and distace is : " + (SelectionArray[i].name as string) +" - " +   (DistanceCtrl as string))
			)
		else	
			(-- "Check Off"
			for i =1 to SelectionArray.count do 
				(
					DistanceCtrl = (distance Ctrl SelectionArray[i])/100 as integer
					DistanceCtrl as integer
					SelectionArray[i].modifiers[#Point_Cache].playbackType = 1
					SelectionArray[i].modifiers[#Point_Cache].playbackStart = DistanceCtrl
					print ("Animation cashe with custom start off and distace is : " + (SelectionArray[1].name as string) +" - " + (DistanceCtrl as string))
				)
			)
		)
	on GOKey_Btn pressed  do
	(
	if CustomStartCheck.state == on then
		(--"Check on"
			(
				print	finalDistance + (CustomStart)
				finalDistance= (distance Ctrl SelectionArray[i])/100 as integer
				finalDistanceOffset = finalDistance + CustomStart.value
				movekeys SelectionArray[i] finalDistanceOffset
			)
		)
	else	
		(
			for i = 1 to SelectionArray.count by 1 do
				(
					finalDistance= (distance Ctrl SelectionArray[i])/100 as integer
					movekeys SelectionArray[i] finalDistance
				)
		)
	)
	on GOKeyReset_Btn pressed  do
	(-- spinner to rest value
			try ( for i =1 to SelectionArray.count do
					(-- start from 0
						Obj =SelectionArray[i]
						Akey = SelectionArray[i].pos.controller.keys[1]  as string
						OldKey=(filterstring Akey "#Position XYZ key( @ f)")[2] as integer
						moveKeys Obj (OldKey*-1)
					)
				)
			catch()
		)
	
	on GOKeyCashReset_Btn pressed  do
	(-- spinner to rest value
			try ( for i =1 to SelectionArray.count do
					(-- start from 0
						print CustomStart.value
						DistanceCtrl = (CustomStart.value)
						SelectionArray[i].modifiers[#Point_Cache].playbackType = 1
						SelectionArray[i].modifiers[#Point_Cache].playbackStart = 0
						)
				)
			catch()
		)
	on ddl1 selected NewSetsArrays do 
	(
		try (
				select selectionsets[(NewSetsArrays-1)]
				SelectionArray =$
			)
		catch ()
	)
)
CreateDialog AnimationCashingoffsetScript
