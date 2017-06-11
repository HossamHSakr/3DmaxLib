/* 
--------------------------------------------------
--- 			Screen Captuer				---
--- 	Created By Allaa ElDin Mokhtar	---
---		Modfied By Hossam Hassan Sakr	---
---			sniper.hh@gmail.com				---
---			fb.com\HossamH.sakr\	 		---
---												---
---				Finished 5-6-2017 			---
---------------------------------------------------

*/
fn _RandomSelection  = 
(
	
	SelectionArray = #() as array --will contain random objects from selection
	
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

Print "**Note** _RandomSelection() - "