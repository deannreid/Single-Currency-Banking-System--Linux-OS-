TraderDialogCatList = 12000;
TraderDialogItemList = 12001;
TraderDialogBuyPrice = 12002;
TraderDialogSellPrice = 12003;
TraderDialogBuyBtn = 12004;
TraderDialogSellBtn = 12005;
TraderDialogCurrency = 12006;
TraderCurrentCatIndex = -1;
TraderCatList = -1;
TraderItemList = -1;

TraderDialogLoadItemList = {
	private ["_index","_trader_id","_activatingPlayer","_distance","_objclass","_item_list"];

	TraderItemList = -1;

	_index = _this select 0;

	if (_index < 0 or TraderCurrentCatIndex == _index) exitWith {};

	TraderCurrentCatIndex = _index;

	_trader_id = TraderCatList select _index;
	_activatingPlayer = player;

	lbClear TraderDialogItemList;
	ctrlSetText [TraderDialogBuyPrice, ""];
	ctrlSetText [TraderDialogSellPrice, ""];
	lbAdd [TraderDialogItemList, "Loading precious items..."];

	PVDZE_plr_TradeMenuResult = call compile format["tcacheBuy_%1;",_trader_id];

	if(isNil "PVDZE_plr_TradeMenuResult") then {
		PVDZE_plr_TradeMenu = [_activatingPlayer,_trader_id];
		publicVariableServer  "PVDZE_plr_TradeMenu";
		waitUntil {!isNil "PVDZE_plr_TradeMenuResult"};
	};

	lbClear TraderDialogItemList;
	
	_item_list = [];
	{
		private ["_header", "_item", "_name", "_type", "_textPart", "_qty", "_buy", "_bqty", "_bname", "_btype", "_btextCurrency", "_sell", "_sqty", "_sname", "_stype", "_stextCurrency", "_order", "_order", "_afile", "_File", "_count", "_bag", "_bagclass", "_index", "_image"];
		_header = _x select 0;
		_item = _x select 1;
		_name = _item select 0;
		_type = _item select 1;

		switch (true) do {
			case (_type == 1): {
				_type = "CfgMagazines";
			}; 
			case (_type == 2): {
				_type = "CfgVehicles";
			}; 
			case (_type == 3): {
				_type = "CfgWeapons";
			};
		};

		_textPart = getText(configFile >> _type >> _name >> "displayName");
		_qty = _x select 2;
		_buy = _x select 3;
		_bqty = _buy select 0;
		_bname = _buy select 1;
		_btype = _buy select 2;

		switch(true)do{ 
			case (_btype == 1): { 
				_btype = "CfgMagazines";
			}; 
			case (_btype == 2): { 
				_btype = "CfgVehicles";
			}; 
			case (_btype == 3): { 
				_btype = "CfgWeapons";
			}; 
		}; 

		_btextCurrency = "Coins";
		_sell = _x select 4;
		_sqty = _sell select 0;
		_sname = _sell select 1;
		_stype = _sell select 2;

		switch(true)do{ 
			case (_stype == 1): { 
				_stype = "CfgMagazines";
			}; 
			case (_stype == 2): { 
				_stype = "CfgVehicles";
			}; 
			case (_stype == 3): { 
				_stype = "CfgWeapons";
			}; 
		}; 

		_stextCurrency = "Coins";
		_order = _x select 5; //
		_afile = _x select 7;
		_File = "Scripts\Gold_Coin_system\Trading_Stuff\" + _afile + ".sqf";
		_count = 0;

		if(_type == "CfgVehicles") then {
			if (_afile == "trade_backpacks") then {
				_bag = unitBackpack player;
				_bagclass = typeOf _bag;
				if(_name == _bagclass) then {
					_count = 1;
				};
			} else {
				if (isClass(configFile >> "CfgVehicles" >> _name)) then {
					_distance = dayz_sellDistance_vehicle;
					if (_name isKindOf "Air") then {
						_distance = dayz_sellDistance_air;
					};
					if (_name isKindOf "Ship") then {
						_distance = dayz_sellDistance_boat;
					};
					_count = {(typeOf _x) == _name} count (nearestObjects [player, [_name], _distance]);
				};
			};
		};

		if(_type == "CfgMagazines") then {
			_count = {_x == _name} count magazines player;
		};

		if(_type == "CfgWeapons") then {
			_count = {_x == _name} count weapons player;
		};

		_index = lbAdd [TraderDialogItemList, format["%1 (%2)", _textPart, _name]];

		if (_count > 0) then {
			lbSetColor [TraderDialogItemList, _index, [0, 1, 0, 1]];
		};

		_image = getText(configFile >> _type >> _name >> "picture");

		lbSetPicture [TraderDialogItemList, _index, _image];

		_item_list set [count _item_list, [
			_name,
			_textPart,
			_bqty,
			_bname,
			_btextCurrency,
			_sqty,
			_sname,
			_stextCurrency,
			_header,
			_File
		]];
	} forEach PVDZE_plr_TradeMenuResult;
	TraderItemList = _item_list;
};

TraderDialogShowPrices = {

	private ["_index", "_item"];

	_index = _this select 0;

	if (_index < 0) exitWith {};

	while {count TraderItemList < 1} do { sleep 1; };

	_item = TraderItemList select _index;
	_qty = {_x == (_item select 3)} count magazines player;

	ctrlSetText [TraderDialogBuyPrice, format["%1 %2", _item select 2, _item select 4]];
	ctrlEnable [TraderDialogBuyBtn, true];
	ctrlSetText [TraderDialogSellPrice, format["%1 %2", _item select 5, _item select 7]];
};

TraderDialogBuy = {

	private ["_index", "_item", "_data"];

	_index = _this select 0;

	if (_index < 0) exitWith {
		cutText [(localize "str_epoch_player_6"), "PLAIN DOWN"];
	};

	_item = TraderItemList select _index;

	if(_item select 9 == "Scripts\Gold_Coin_system\Trading_Stuff\trade_items.sqf")then{

	_data = [_item select 0, _item select 1, _item select 2, _item select 8];
	_data execVM "Scripts\Gold_Coin_system\Trading_Stuff\trade_items_buy.sqf";
	
	} else {

	_data = [_item select 0, _item select 3, 1, _item select 2, "buy", _item select 4, _item select 1, _item select 8];

	[0, player, '', _data] execVM (_item select 9);
	
	};
	TraderItemList = -1;
};

TraderDialogSell = {

	private ["_index", "_item", "_data"];

	_index = _this select 0;

	if (_index < 0) exitWith {
		cutText [(localize "str_epoch_player_6"), "PLAIN DOWN"];
	};

	_item = TraderItemList select _index;

	if(_item select 9 == "Scripts\Gold_Coin_system\Trading_Stuff\trade_items.sqf")then{

	_data = [_item select 0, _item select 1, _item select 5, _item select 8];
	_data execVM "Scripts\Gold_Coin_system\Trading_Stuff\trade_items_sell.sqf";

	} else {
	
	_data = [_item select 6, _item select 0, _item select 5, 1, "sell", _item select 1, _item select 7, _item select 8];

	[0, player, '', _data] execVM (_item select 9);
	};
	TraderItemList = -1;
};