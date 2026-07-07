-- Codigrate Themes for Rhino — double-click theme picker (no Terminal needed).
-- Lives next to apply-rhino-theme.py in the rhino-themes folder.

set themeNames to {"Aurora Borealis  ·  dark", "Roraima  ·  dark", "Sequoia  ·  dark", "Miami  ·  dark", "Paris  ·  dark", "Tokyo  ·  dark", "Autumn  ·  light", "Everest  ·  light", "Sakura  ·  light", "Istanbul  ·  light", "Rio de Janeiro  ·  light", "Tallinn  ·  light", "↩  Restore original colours"}
set themeKeys to {"aurora-borealis", "roraima", "sequoia", "miami", "paris", "tokyo", "autumn", "everest", "sakura", "istanbul", "rio-de-janeiro", "tallinn", "--restore"}

set appFolder to do shell script "dirname " & quoted form of (POSIX path of (path to me))

set chosen to choose from list themeNames with title "Codigrate Themes for Rhino" with prompt "Pick a theme to apply. Rhino will close and reopen." OK button name "Apply" cancel button name "Cancel"
if chosen is false then return
set chosenName to item 1 of chosen
repeat with i from 1 to count of themeNames
	if item i of themeNames is chosenName then
		set themeKey to item i of themeKeys
		exit repeat
	end if
end repeat

tell application "System Events" to set rhinoRunning to (exists (process "Rhinoceros"))
if rhinoRunning then
	try
		tell application id "com.mcneel.rhinoceros.8" to quit
	end try
	repeat 40 times
		tell application "System Events" to set stillUp to (exists (process "Rhinoceros"))
		if not stillUp then exit repeat
		delay 0.5
	end repeat
end if

try
	do shell script "cd " & quoted form of appFolder & " && /usr/bin/python3 apply-rhino-theme.py " & themeKey
on error errMsg
	display dialog "Could not apply the theme:" & return & return & errMsg buttons {"OK"} default button "OK" with icon stop
	return
end try

tell application id "com.mcneel.rhinoceros.8" to activate
