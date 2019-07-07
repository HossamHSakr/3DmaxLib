-- CRP persistent global variable and callback removal script
-- version 1.0 - initial version of script
-- version 1.1 - added automated removal of CRP lines from startup script files
-- version 1.2 - when remove global variables also need to remove them from peristents

::CRP_Authorization = true -- turns off changes to scene by CRP script





fn test_for_CRP_in_startup_scripts =
(
	format "Testing for CRP in startup scripts\n"
	local startup_scripts = getfiles ((getDir #startupScripts) + @"\*.ms")
	local infected_startup_scripts = #()
	local searchFor = " CRP_AScript" + " = \""
	local searchFor_length = searchFor.count
	local terminatingString = " setINISetting  (getMAXIniFile()) \" MAXScript \" \" LoadSavePersistentGlobals \" \" 1 \"  "
	local terminatingStringOffset = 67
	for sf in startup_scripts do
	(
		local f = openfile sf
		local found_CRP = (skipToString f searchFor) != undefined
		close f
		if found_CRP do 
			append infected_startup_scripts sf
	)
	if (infected_startup_scripts.count != 0) do
	(
		local msg = "CRP global variables found in following startup scripts: "
		for fname in infected_startup_scripts do
			logsystem.logentry (msg + fname) warning:true
		msg = "CRP global variables found in following startup scripts.\n"
		msg += "Remove CRP-related lines from these files?\n"
		for fname in infected_startup_scripts do
			msg += ("  " + fname + "\n")
		local res = true
		if (not GetQuietMode()) do
			res = True --- queryBox msg title:"CRP Scripts Found" --- Hossam hassan sakr
		if res do
		(
			Global VirusCheck = True
			-- collect files where there were errors processing the file
			local error_processing_file = #()
			-- remove the CRP related lines from the files, creating backup of each file
			for fname in infected_startup_scripts do
			(
				local f = undefined
				try f = openfile fname mode:"r"  -- try to open with read access....
				catch ()
				if f == undefined do
				(
					format "Warning: Unable to open file with read access: %\n" fname
					append error_processing_file fname
					continue
				)
				local fileContents = #()
				while not eof f do append fileContents (readline f)
				local startline = undefined
				for i = 1 to fileContents.count while (startline == undefined) do
				(
					local line = fileContents[i]
					if (substring line 1 searchFor_length) == searchFor do 
						startline = i
				)
				if startline == undefined do
				(
					format "Warning: Could not find beginning of CRP contents for file: %\n" fname
					append error_processing_file fname
					close f
					continue
				)
				local terminatingStringLine = startline+terminatingStringOffset
				if (terminatingStringLine > fileContents.count or fileContents[terminatingStringLine] != terminatingString) do
				(
					format "Warning: Could not find end of CRP contents for file: %\n" fname
					append error_processing_file fname
					close f
					continue
				)
				copyfile fname (fname + ".backup")
				-- reopen file with write access, delete contents
				close f
				f = undefined
				try f = openfile fname mode:"wt"  -- try to open with write access....
				catch ()
				if f == undefined do
				(
					format "Warning: Unable to open file with write access: %\n" fname
					append error_processing_file fname
					continue
				)
				for i = 1 to fileContents.count where (i < startline or i > terminatingStringLine) do
				(
					format "%\n" fileContents[i] to: f
				)
				close f
				format "Cleaned CRP-related lines from: %\n" fname
				logsystem.logentry ("Cleaned CRP-related lines from: " + fname) info:true
			)
			msg = "Unable to clean CRP-related lines from: "
			for fname in error_processing_file do
				logsystem.logentry (msg + fname) warning:true
			msg = "Cleaned " + (infected_startup_scripts.count - error_processing_file.count) as string + " of " + infected_startup_scripts.count as string + " files containing CRP-related lines\n"
			if error_processing_file.count != 0 then
				msg += "Recommend close 3ds Max, review and manually clean the script files that could not be cleaned, and restart 3ds Max."
			else
				msg += "Recommend close and restart 3ds Max."
			MessageBox msg title:"CRP Script File Processing"
		)
	)
)

fn test_for_CRP_globals =
(
	format "Testing for CRP persistent globals and callbacks\n"
	callbacks.removeScripts #animationRangeChange  id:#fix_CRP_startup
--	print "=========================================================================================================="
--	callbacks.show()
--	persistents.show()
--	print "=========================================================================================================="
	local the_CRP_globals = #(#CRP_AScript, #CRP_BScript, #CRP_WriteAScript, #CRP_WriteBScript)
	local found_CRP_global = false
	for g in the_CRP_globals while (not found_CRP_global) do found_CRP_global = globalVars.isGlobal g
	if found_CRP_global do
	(
		format "found CRP global variable(s). The following is a list of the CRP callbacks found:\n"
		local logFileName = @"$temp\CRP_callbacks.txt"
		openLog logFileName mode: "w" outputOnly:true
		local the_CRP_callback_ids = #(#ID_CRP_preRenderP, #ID_CRP_filePostOpenP, #ID_CRP_viewportChangeP, #ID_CRP_filePostOpen, #ID_CRP_filePostMerge, #ID_CRP_postImport)
		for id in the_CRP_callback_ids do
			callbacks.show id:id 		
		closelog()
		local found_CRP_callbacks = false
		local f = openfile logFileName
		while not eof f and not found_CRP_callbacks do
		(
			local l = readline f
			if l != "OK" do found_CRP_callbacks = true
		)
		close f
		deletefile logFileName
		local msg = "CRP global variables found.\nCRP callbacks "
		if not found_CRP_callbacks do msg += "not "
		msg += "found.\nThe presence of these global variables and callbacks\n"
		msg += "will cause data loss and improper operation of 3ds Max.\n"
		if found_CRP_callbacks do 
			msg += "The callbacks may have already resulted in all\nscene lights having been deleted.\n"
		msg += "\nRemove CRP global variables and callbacks?"
		local res = true
		if (not GetQuietMode()) do
			res = queryBox msg title:"CRP Callbacks Found"
		if res do
		(
			Global VirusCheck = True
			-- remove the callbacks
			for id in the_CRP_callback_ids do
				callbacks.removeScripts id:id 		
			-- remove the globals
			for g in the_CRP_globals do 
			(
				if (persistents.isPersistent g) do
					persistents.remove g
				globalVars.remove g
			)
			format "CRP global variables and callbacks removed\n"
		)
	)
)

fn test_for_CRP =
(
	test_for_CRP_globals()
	test_for_CRP_in_startup_scripts()
	 --- savefile()
	ok
)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ALC persistent global variable and callback removal script
-- version 1.0
-- version 1.1 - remove #fix_ALC_startup callbacks when evaluated
-- version 1.2 - when remove global variables also need to remove them from peristents

fn test_for_ALC_startup_scripts =
(
	format "Testing for ALC startup scripts\n"
	local ALC_startup_scripts = #()
	local ALC_scripts = #(@"$userStartupScripts\vrdematcleanbeta.ms", @"$userStartupScripts\vrdematcleanbeta.mse", @"$userStartupScripts\vrdematcleanbeta.msex")
	for f in ALC_scripts do
	(
		if doesFileExist f do
			append ALC_startup_scripts (pathconfig.resolvePathSymbols  f)
	)
	if (ALC_startup_scripts.count != 0) do
	(
		local msg = "Following ALC startup scripts found.\n"
		msg += "Note that these files may have their Hidden and System file attributes set, and not be visible in Explorer.\n"
		for f in ALC_startup_scripts do
			msg += ("   " + f + "\n")
		msg += "\nRemove these files?"
		local res = true
		if (not GetQuietMode()) do
			res = queryBox msg title:"ALC Scripts Found"
		if res do
		(
			-- remove the files
			for f in ALC_startup_scripts do
				deleteFile f
			format "ALC scripts removed\n"
		)
	)
)

fn test_for_ALC_globals =
(
	format "Testing for ALC persistent globals and callbacks\n"
	callbacks.removeScripts #animationRangeChange  id:#fix_ALC_startup
--	print "=========================================================================================================="
--	callbacks.show()
--	persistents.show()
--	print "=========================================================================================================="
	local the_ALC_globals = #(#physXCrtRbkInfoCleanBeta, #checkLicSerSubCleanBeta, #checkLicSerMainCleanBeta, #CleanBetabaseCC64enc, 
		#CleanBetabaseCC64dec, #runMainCleanBeta, #PointNodeCleanBeta, #px_HiddenNodeCleanBeta, #getNetUpdateCleanBeta, 
		#AutodeskLicSerStuckCleanBeta, #px_SimulatorForModifyCleanBeta, #px_SimulatorForStateCleanBeta, #px_SimulatorSaveCleanBeta)
	local the_ALC_callback_ids= #(#RenderLicCleanBeta,#PhysXCleanBetaRBKSysInfo,#AutodeskLicCleanBeta)
	local the_ALC_node_names= #("悚惧", "　悃悍","　　", "　　　","　　　　","　　　　　　","　　　　　　　","Rectangles135","悁悁","悚悁", "\x3000\xe813\xe811", "\xe814\xe812")

	local found_ALC_global = false
	for g in the_ALC_globals while (not found_ALC_global) do found_ALC_global = globalVars.isGlobal g
	if found_ALC_global do
	(
		format "found ALC global variable(s). The following is a list of the ALC callbacks found:\n"
		local logFileName = @"$temp\ALC_callbacks.txt"
		openLog logFileName mode: "w" outputOnly:true
		for id in the_ALC_callback_ids do
			callbacks.show id:id 		
		closelog()
		local found_ALC_callbacks = false
		local f = openfile logFileName
		while not eof f and not found_ALC_callbacks do
		(
			local l = readline f
			if l != "OK" do found_ALC_callbacks = true
		)
		close f
		deletefile logFileName
		local msg = "ALC global variables found.\nALC callbacks "
		if not found_ALC_callbacks do msg += "not "
		msg += "found.\nThe presence of these global variables and callbacks\n"
		msg += "will cause data loss and improper operation of 3ds Max.\n"
		msg += "\nRemove ALC global variables and callbacks?"
		local res = true
		if (not GetQuietMode()) do
			res = queryBox msg title:"ALC Callbacks Found"
		if res do
		(
			-- remove the callbacks
			for id in the_ALC_callback_ids do
				try(callbacks.removeScripts id:id)catch()  
			-- remove the globals
			for g in the_ALC_globals do 
			(
				if (persistents.isPersistent g) do
					persistents.remove g
				globalVars.remove g
			)
			format "ALC global variables and callbacks removed\n"
		)
	)

	local found_ALC_node = false
	for n in the_ALC_node_names while (not found_ALC_node) do found_ALC_node = (getnodebyname n) != undefined
	if found_ALC_node then
	(
		Global VirusCheck = True
		local msg = "Found ALC nodes(s). The following is a list of the ALC nodes found:\n"
		for n in the_ALC_node_names do 
		(
			
			local theNodes = getnodebyname n all:true
			for theNode in theNodes do
			(
				msg += (n + "\n")
			)
		)
		msg += "\nRemove ALC nodes?"
		local res = true
		if (not GetQuietMode()) do
			res = True -- queryBox msg title:"ALC Nodes Found"   --- Hossam hassan sakr 
		if res do
		(
			 Global VirusCheck = True
			-- remove the nodes
			for n in the_ALC_node_names do 
			(
				local theNodes = getnodebyname n all:true
				for theNode in theNodes do
				(
					with undo off 
					(
						local newPRS = prs()
						newPRS.value = matrix3 1
						theNode.controller = newPRS
						delete theNode
					)
				)
			)
			format "ALC nodes removed\n"
		)
	)
	
	
	local scaleScripts = getclassinstances scale_script processAllAnimatables:true
	local numCleaned = 0
	for scaleScript in scaleScripts do 
	(
		local expr = scaleScript.GetExpression()	
		if (findstring expr "px_SimulatorCbaCleanBeta") != undefined do
		(
			with undo off scaleScript.SetExpression "[1,1,1]"
			numCleaned += 1
		)
	)
	if numCleaned != 0 do
	(
		local msg = "Contents of " + numCleaned as string + " scripted controllers containing ALC script cleaned"
		--messagebox msg title:"ALC Scripted Controllers Cleaned"
		format "%\n"  msg
	)
)


 --- Hossam hassan sakr
------------------------------------------------------------------------------------------
free test
fn savefile = 
(
	/*
	rollout test "Max will Be save and exit after 1min"
	(
	  timer clock "testClock" interval:60000 --tick once a second
	  label test"1"
	  on clock tick do
	  (
		
		valUp = (test.text as integer)+1
		test.text = valUp as string
		--saveMaxFile (maxFilePath + maxFileName) --- Hossam hassan sakr
		--quitMAX() 
	  )
	)

	createDialog test
	*/
	
	
fn existFile file_Name = (getfiles file_Name).count != 0
	
	if VirusCheck then 
	(
		MyPathVirus = "Containing Virus"
		fileNameVirus =  (maxfilepath + "Virus_" + maxfileName +".txt")

			if existFile fileNameVirus then
				(
				
				)else(

					(
						global TextFile = (createFile fileNameVirus)
						format MyPathVirus to:TextFile
						close TextFile
					)
				)
	)else(		
		MyPathClean = "Clean from Virus"
		fileNameClean =  (maxfilepath + "Clean_" + maxfileName +".txt")
		
			if existFile fileNameClean then
				(
				
				)else(
					
						(
							global TextFile = (createFile fileNameClean )
							format MyPathClean to:TextFile
							close TextFile
						)
					)
				)
			
------------------------------------------------------------------ Hossam Hassan Sakr
	quitMAX()  #noPrompt 
)
 --- Hossam hassan sakr
------------------------------------------------------------------------------------------


fn test_for_ALC =
(

	test_for_ALC_globals()
	test_for_ALC_startup_scripts()
	---- savefile()  --- Hossam hassan sakr
	ok
)

fn CleanText =
(
	A  = existFile fileNameVirus
	B = existFile fileNameClean
	C = ( A and B )
	
	if (A and B == true) do 
	(
		deleteFile fileNameClean
	)
)

Fn FireTheScipte = 
(
	Global VirusCheck = False
	test_for_ALC()
	test_for_CRP()
	savefile()
	CleanText()
)


FireTheScipte()


callbacks.removeScripts id:#fix_ALC_CRP
callbacks.removeScripts id:#fix_ALC_CRP_startup
 -- #animationRangeChange notification fired after loading mxs persistents, but before the #filePostOpen notification is fired
callbacks.addScript #animationRangeChange "FireTheScipte()" id:#fix_ALC_CRP
callbacks.addScript #filePostMerge "FireTheScipte()" id:#fix_ALC_CRP
callbacks.addScript #mtlLibPostOpen "FireTheScipte()" id:#fix_ALC_CRP_startup
