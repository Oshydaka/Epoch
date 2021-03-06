/*
	AUTHOR: IT07 (Original was made by BIS)

	DESCRIPTION:
	if installed in a mission file, any player joinging the mission
	will see credits on their screen as configured below. Players have the ability to skip credits by using the scroll menu action which is available until the credits are done showing.

	PARAMS: None.

	NOTES:
	this script concept was 1st released by IT07 for ArmA 2, then a guy called "Gr8" copy-pasted the concept and published it for ArmA 3 without permission.
*/

///////  CONFIGURATION  ///////
_onScreenTime = 7; // Amount of seconds each credit should show. DEFAULT: 7
_waitFor = 2; // Amount of seconds to wait before playing can see and move ingame. DEFAULT: 1
// The line below is used for configuring what will be shown as credits. Be careful with the brackets!
_credits =
[
["Welcome to",["Epoch Vault"]],
["BEWARE | ATTENTION",["The server is restarting every two hours for now","Le serveur reboot toutes les deux heures pour le moment","We are waiting for Bohemia to fix there shit","On attend la prochaine mise à jour de Bohemia pour fixer les problèmes"]],
["Admins",["Youri Litovski","Benji","le serpent mexicain","Sentinel"]],
["Server Mod",["Ethan Hawx","Tom Mason"]],
["TeamSpeak",["ts.epochvault.ovh"]],
["Rules",["No base camping","No bambi kill","No kill in trader city","No troll","No cheat","(open your map for full rules)"]],
["Server scripts",["Status Bar","SEM","Dayz Style Heli Crash","Ear Plug","High Vehicles Spawn","Much more"]],
["Our donators",["DeathTwizy","Mark Evans","Mickael Ulrich"]],
["Special thanks",["Epoch Team"]]
];
_titleColor = "#01DF01"; // Color of credit title in HTML format. Link: http://html-color-codes.info/
_subColor = "#FFF"; // Same as above
//////////////////////////////////////
///  Do not change anything below  ///

_creditsFnc =
{
	_onScreenTime = _this select 0;
	_waitFor = _this select 1;
	_credits = _this select 2;
	_titleColor = _this select 3;
	_subColor = _this select 4;

	uiSleep _waitFor;
	{
		_selectTitle = _x select 0;
		_selectSubs = _x select 1;
		_all = format ["<t size='1' color='%1' align='right'>%2<br /></t>", _titleColor, _selectTitle];
		_all = _all + format["<t size='0.8' color='%1' align='right'>", _subColor];
		{
			_all = _all + format ["%1<br />", _x]
		} forEach _selectSubs;
		_all = _all + "</t>";
		_onScreenTime + (((count _selectSubs) - 1) * 0.5);
		[
			_all,
			[safezoneX + safezoneW - 1,0.8],	//DEFAULT: 0.5,0.35
			[safezoneY + safezoneH - 1,1], 	//DEFAULT: 0.8,0.7
			_onScreenTime,
			0.5
		] call BIS_fnc_dynamicText;
		uiSleep 0.5;
	} forEach _credits;
};

waitUntil { !isNull(findDisplay 46); (speed player) != 0 };

_playCredits = [_onScreenTime, _waitFor, _credits, _titleColor, _subColor] spawn _creditsFnc;
//_skip = player addAction ["Skip credits...",{terminate (_this select 3); player removeAction (_this select 2)}, _playCredits, -1, false, true];
waitUntil { uiSleep 0.5; scriptDone _playCredits };
//player removeAction _skip;