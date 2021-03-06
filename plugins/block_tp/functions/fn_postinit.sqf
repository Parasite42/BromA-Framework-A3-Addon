if !(hasInterface) exitWith {};

0 spawn {
	waitUntil { !isNil "BrmFmk_blockTP_allow" };

	if (isNil "tp_allowed_units") then { tp_allowed_units = [] };

	if (difficultyOption "thirdPersonView" != 1 || BrmFmk_blockTP_allow == 1 || player in tp_allowed_units) exitWith {};

	addMissionEventHandler ["EachFrame", {
		if (cameraView == "EXTERNAL") then {
			switch (BrmFmk_blockTP_allow) do {
				case 0: { // 3rd Person Disabled
					player switchCamera "INTERNAL";
				};
				case 1: { // 3rd Person Enabled
					removeMissionEventHandler ["EachFrame", _thisEventHandler];
				};
				case 2: { // 3rd Person Drivers/Commanders Only
					private _vehicle = objectParent player;
					if (isNull _vehicle || {player != driver _vehicle && player != commander _vehicle}) then {
						player switchCamera "INTERNAL";
					};
				};
			};
		};
	}];
};
