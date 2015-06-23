//============================================
// cmEarplugs Script
// written by computermancer
// superfunserver.com
//switch technique inspired by mgm
//============================================

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 					CONFIG : 		CHOOSE YOUR BEHAVIOR

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//DO YOU WANT EARPLUGS HOTKEY TO WORK? 
// if you are using EPAH you should disable for peace of mind.
cmEarplugsKeyPressEnabled = false;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// HOTKEY CONFIGURATION FOR: TOGGLE EARPLUG IN/OUT VIA KEYPRESS FUNCTION
// List of Available Hotkey Options
//	To use	INSERT					as your hotkey, please choose:		1		in the variable below
//	To use	NumPadMultiply		as your hotkey, please choose:		2		in the variable below
//	To use	NumPadDivide			as your hotkey, please choose:		3		in the variable below
//	To use	F4							as your hotkey, please choose:		4		in the variable below
//	To use	F5							as your hotkey, please choose:		5		in the variable below
cmEarplugs_myHotkeyChoice = 4;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//					CHOOSE INSERT & REMOVE BEHAVIOR	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FIRST NUMBER : Choose how LONG it takes  until sound is REDUCED
// SECOND NUMBER:" Choose how LOUD the sound is when it is REDUCED
cmManMuteSound = {1 fadeSound 0.25;};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FIRST NUMBER : Choose how LONG it takes  until sound RETURNS
//SECOND NUMBER:" Choose how LOUD the sound is when it is done RETUNRNING
cmManReturnSound = {1 fadeSound 1;};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CHOOSE YOUR INSERT MESSAGE:
cmManMuteMessage = {
hint "You have inserted your earplugs.";
systemchat "You have inserted your earplugs.";
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CHOOSE YOUR REMOVE MESSAGE:
cmManReturnSoundMsg = {
hint "You have removed your earplugs.";
systemchat "You have removed your earplugs.";
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CHOOSE IF YOU WANT AUTOINSERT & AUTOREMOVE OF EARPLUGS:
InsertAutoEarplugs=false;
RemoveAutoEarplugs=false;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//					CHOOSE AUTO-INSERT & REMOVE BEHAVIOR

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FIRST NUMBER : Choose how LONG it takes  until sound is REDUCED
// SECOND NUMBER:" CHoose how LOUD the sound is when it is REDUCED
cmMuteSound = {5 fadeSound 0.25;};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FIRST NUMBER : Choose how LONG it takes  until sound RETURNS
//SECOND NUMBER:" CHoose how LOUD the sound is when it is done RETUNRNING
cmReturnSound = {10 fadeSound 1;};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CHOOSE YOUR AUTO-INSERT MESSAGE
cmMuteMessage = {
hint "Earplugs have been auto-inserted...";
systemchat "Earplugs have been auto-inserted...";
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CHOOSE YOUR AUTO-REMOVE MESSAGE
cmReturnSoundMsg = {
hint "Earplugs have been auto-removed.";
systemchat "Earplugs have been auto-removed.";
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//					END CONFIGURABLES
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



















//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

EP_req_1 = {

	private ["_cm_trigger2"];
	_cm_trigger2 = vehicle player != player;
	_cm_trigger2
	
};



cm_EP_LOOP = {


	while {true} do {
	
		waitUntil {uisleep 0.5; vehicle player != player};
		
			_cm_whatImInATM = vehicle player;
			inCaseofDeath = _cm_whatImInATM;
			if (InsertAutoEarplugs) then {
				if (earplugsout) then { 
					[] call cmMuteSound;
					[] call cmMuteMessage;
					earplugsout=false;
				};
			};

			//_cm_whatImInATM addEventHandler ["GetOut", {[_this] call cmGetOut}];
			
			if (isNil {_cm_whatImInATM getVariable "HasEarplugMenu"}) then {_cm_whatImInATM setVariable["HasEarplugMenu", "hasNoMenu"];};
			
			_checkington = (_cm_whatImInATM getVariable "HasEarplugMenu");
			if (_checkington == "hasNoMenu") then {
				_null = _cm_whatImInATM addaction ["<img image='addons\cmEarplugs\earplugs.paa' /><t color=""#38eeff""> Earplugs</t>","[] call cm_Earplugs_FUNc","",0,false,false,"","[] call EP_req_1"];							
				_cm_whatImInATM setVariable ["HasEarplugMenu","hasMenu"];
				systemChat "Earplugs menu has been added.";
			};
			
		waitUntil {uisleep 0.5; vehicle player == player}; 
		
			//_feedME = _this select 0;
			//_fedTrueName = _feedME select 0;
			theOneTrueName = _cm_whatImInATM;
			theOneTrueName setVariable ["HasEarplugMenu","hasMenu"];
			if (RemoveAutoEarplugs) then {
			if (!earplugsout) then { 
				[] call cmReturnSound;
				[] call cmReturnSoundMsg;
				earplugsout=true;
			
				};
			};

	};
	
};


cm_Earplugs_FUNc = {

	if (earplugsout) then {
		[] call cmManMuteMessage;
		[] call cmManMuteSound;
		earplugsout=false;
	} else {
		[] call cmManReturnSoundMsg;
		[] call cmManReturnSound;	
		earplugsout=true;
	};
	

	
};


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// DO NOT CHANGE THE VALUES BELOW
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

cmEarplugs_hotkeyDIKCodeNumberINSERT 						= 210;
cmEarplugs_hotkeyDIKCodeNumberNUMPADMULTIPLY 	= 55;
cmEarplugs_hotkeyDIKCodeNumberNUMPADDIVIDE 			= 181;
cmEarplugs_hotkeyDIKCodeNumberF4									= 62;
cmEarplugs_hotkeyDIKCodeNumberF5									= 63;

switch cmEarplugs_myHotkeyChoice do {
	case 1:		{ cmEarplugs_hotkeyDIKCodeNumber = cmEarplugs_hotkeyDIKCodeNumberINSERT};
	case 2:		{ cmEarplugs_hotkeyDIKCodeNumber = cmEarplugs_hotkeyDIKCodeNumberNUMPADMULTIPLY};
	case 3:		{ cmEarplugs_hotkeyDIKCodeNumber = cmEarplugs_hotkeyDIKCodeNumberNUMPADDIVIDE};
	case 4:		{ cmEarplugs_hotkeyDIKCodeNumber = cmEarplugs_hotkeyDIKCodeNumberF4};
	case 5:		{ cmEarplugs_hotkeyDIKCodeNumber = cmEarplugs_hotkeyDIKCodeNumberF5};
	case 0;
	default		{ cmEarplugs_hotkeyDIKCodeNumber = cmEarplugs_hotkeyDIKCodeNumberINSERT};
};
publicVariable	"cmEarplugs_hotkeyDIKCodeNumber";


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//END ALL
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


