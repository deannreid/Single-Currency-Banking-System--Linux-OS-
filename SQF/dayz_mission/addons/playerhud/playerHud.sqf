disableSerialization;

// player setVariable["AsReMixhud", true];//Variable Show/Hide HUD Support for control player hud

AsReMixhud_Control = true; // player getVariable["AsReMixhud",true];


while {true} do
{
    1000 cutRsc ["AsReMixhud","PLAIN"];
    _wpui = uiNameSpace getVariable "AsReMixhud";
    _vitals = _wpui displayCtrl 4900;
	
	_thePlayer = player;
	
	AsReMixhud_zombieKills 	= _thePlayer getVariable["zombieKills",0];
	AsReMixhud_headshots 		= _thePlayer getVariable["headShots",0];
	AsReMixhud_killsH 		= _thePlayer getVariable["humanKills",0];
	_cashMoney 		= _thePlayer getVariable["cashMoney",0];
    _bankMoney 		=  _thePlayer getVariable["bankMoney",0];
	AsReMixhud_killsB 		= _thePlayer getVariable["banditKills",0];
	AsReMixhud_humanity 		= _thePlayer getVariable["humanity",0];
	AsReMixhud_zombies 		= "";
	AsReMixhud_zombiesAlive   = "";
	AsReMixhud_blood			=  "";
	AsReMixhud_pid			= "";
	AsReMixhud_puid			= "";
    AsReMixhud_hmnicon 		= "";
	AsReMixhud_svrname		= "servertitle";

	_stime = 0;
	if(serverTime > 36000)then{_stime = time;}else{_stime = serverTime;};
	_hours = (_stime/60/60);
	_hours = toArray (str _hours);
	_hours resize 1;
	_hours = toString _hours;
	_hours = compile _hours;
	_hours = call  _hours;
	_minutes = floor(_stime/60);
	_minutes2 = ((_minutes - (_hours*60)) min 60) max 0;if (_minutes2 < 10) then {_minutes2 = format ['0%1',_minutes2];};
    	
	_vitals ctrlSetStructuredText parseText format ["
		<t size='0.9'> %2 %5 </t><img size='0.8' align='right' image='custom\playerhud\icons\As_humanity.paa'/>  <br/> 
		<t size='0.9'> %3 </t><img size='0.8' align='right' image='custom\playerhud\icons\dollars.paa'/>   <br/>
		<t size='0.9'> %13 </t><img size='0.8' align='right' image='custom\playerhud\icons\equip_safe_CA.paa'/>   <br/>
		<t size='0.9'> %10 </t><img size='0.8' align='right' image='custom\playerhud\icons\As_killh.paa'/>  <br/> 
		<t size='0.9'> %9 </t><img size='0.8' align='right' image='custom\playerhud\icons\As_killb.paa'/>  <br/>
		<t size='0.9'> %4 </t><img size='0.8' align='right' image='custom\playerhud\icons\As_zkill.paa'/>  <br/>	
	<t size='0.8' align='right'>%11h %12min UPTIME</t><br/>",
	AsReMixhud_blood,   //1
	AsReMixhud_humanity,//2
	[_cashMoney] call BIS_fnc_numberText,//3
	AsReMixhud_zombiekills,//4
	AsReMixhud_hmnicon,//5
	name player,//6
	AsReMixhud_zombiesAlive,//7
	AsReMixhud_zombies,//8
	AsReMixhud_killsB,//9
	AsReMixhud_killsH,//10
	_hours,//11
	_minutes2,//12
	[_bankMoney] call BIS_fnc_numberText,//13
	];
	_vitals ctrlCommit 0;
        
    sleep 2;
};
