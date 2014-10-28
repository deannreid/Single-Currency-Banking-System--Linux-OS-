startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

dayZ_instance = 11;
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

player setVariable ["BIS_noCoreConversations", true];

enableRadio false;
enableSentences false;

//--------------------------------------------------------------------//
//------------------------DayZ Epoch Config---------------------------//
//--------------------------------------------------------------------//

//Map & Player Spawn Variables
spawnShoremode = 1; 				// Default: 1 (on shore)
spawnArea= 1500; 					// Default: 1500
dayz_paraSpawn = false;				// Default: false
dayz_fullMoonNights = true;			// Default: false
dayz_MapArea = 14000;				// Default: 10000

//Do Not Edit - Chernarus Specific
dayz_minpos = -1; 					// Do Not Edit - Chernarus Specific
dayz_maxpos = 16000;				// Do Not Edit - Chernarus Specific

//Idk what these do...
//DZE_DiagFpsSlow = true;
//DZE_DiagVerbose = false;
//DZE_DiagFpsFast = false;

//Item Spawn Variables
MaxHeliCrashes= 5; 					// Default: 5
MaxVehicleLimit = 20; 				// Default: 50
MaxDynamicDebris = 0; 				// Default: 100
MaxMineVeins = 20;					// Default: 50
MaxAmmoBoxes = 10;					// Default: 3

//Zombie Variables
dayz_maxZeds = 500;					// Default: 500
dayz_maxLocalZombies = 30; 			// Default: 15 
dayz_maxGlobalZombiesInit = 15;		// Default: 15
dayz_maxGlobalZombiesIncrease = 5;	// Default: 5	
dayz_zedsAttackVehicles = true;		// Default: true

//Animal Variables
dayz_maxAnimals = 8; 				// Default: 8
dayz_tameDogs = false;				// Default: false

//Trader Variables
dayz_sellDistance_vehicle = 10;		// Default: 10
dayz_sellDistance_boat = 30;		// Default: 30
dayz_sellDistance_air = 40;			// Default: 40
DZE_ConfigTrader = true;

//Player Variables
DZE_R3F_WEIGHT = false;				// Default: true
DZE_FriendlySaving = true;			// Default: true
DZE_PlayerZed = true;				// Default: true
DZE_BackpackGuard = true;			// Default: true
DZE_SelfTransfuse = true;			// Default: false
DZE_selfTransfuse_Values = [7000, 15, 120];	// Default: [12000, 15, 300]; = [blood amount, infection chance, cool-down (seconds)]

//Name Tags
DZE_ForceNameTags = false;			// Default: false
DZE_ForceNameTagsOff = false;		// Default: false
DZE_ForceNameTagsInTrader = true;	// Default: false
DZE_HumanityTargetDistance = 25;	// Default: 25

//Death Messages
DZE_DeathMsgGlobal = false;			// Default: false
DZE_DeathMsgSide = true;			// Default: false
DZE_DeathMsgTitleText = false;		// Default: false

//Vehicles Variables
DZE_AllowForceSave = false;			// Default: false
DZE_AllowCargoCheck = false;		// Default: false
DZE_HeliLift = true;				// Default: true
DZE_HaloJump = true;				// Default: true
DZE_AntiWallLimit = 3;				// Default: 3
DynamicVehicleDamageLow = 0; 		// Default: 0
DynamicVehicleDamageHigh = 100; 	// Default: 100

//Build Variables
DZE_GodModeBase = false;			// Default: false
DZE_BuildingLimit = 1000;			// Default: 150
DZE_requireplot = 1;				// Default: 1
DZE_PlotPole = [30,45];				// Default: [30,45] = [x,y]
DZE_BuildOnRoads = false; 			// Default: false

DZE_AsReMix_PLAYER_HUD = true;

//--------------------------------------------------------------------//
//--------------------------------------------------------------------//
//--------------------------------------------------------------------//

EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"],["any","any","any","any",15,"supply_drop"]];

call compile preprocessFileLineNumbers "Scripts\Variables\Variables.sqf";
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "Scripts\Server_Compile\compiles.sqf";
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "Scripts\Server_Traders\server_traders.sqf";
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if (isServer) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\dynamic_vehicle.sqf";
	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\mission.sqf";
	_serverMonitor = [] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	0 fadeSound 0;
	
	waitUntil {!isNil "dayz_loadScreenMsg"};
	
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	
	
	if (DZE_AsReMix_PLAYER_HUD) then {
		execVM "Scripts\Player_Hud\playerHud.sqf"
    };
	
};

// Single Currency
execVM "Scripts\Gold_Coin_system\init.sqf";
execVM "Scripts\Gold_Coin_system\Bank_Markers\addbankmarkers.sqf";
execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";

#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"