#include <a_samp>
#include <a_mysql>
#include <crashdetect>
#include <easyDialog>
#include <foreach>
#include <Pawn.CMD>
#include <Pawn.Regex>
#include <sscanf2>
#include <streamer>
#include <memory>
#include <MemoryPluginVersion>
#include <EVF>
#include <youtube_stream>

#include "defines.pwn"
#include "variables.pwn"
#include "functions.pwn"
#include "features/login/functions.pwn"
#include "features/cmds/general.pwn"
#include "features/cmds/admin.pwn"
#include "features/cmds/boombox.pwn"
#include "features/cmds/ads.pwn"
#include "features/challange/challange-system.pwn"
#include "features/ptoadmin/asks.pwn"
#include "features/ptoadmin/reports.pwn"
#include "features/animation/anims.pwn"
#include "features/animation/cmds.pwn"
#include "features/house/house.pwn"
#include "features/death/injury.pwn"
#include "features/death/damage.pwn"
#include "features/weapons/weapon.pwn"
#include "features/buildings/buildings.pwn"
#include "features/bank/lsbank.pwn"
#include "features/vehicles/vehicle.pwn"
#include "features/factions/sql.pwn"
#include "features/factions/functions.pwn"
#include "features/factions/acmds.pwn"
#include "features/factions/pcmds.pwn"
#include "features/factions/lspd.pwn"
#include "features/factions/jail.pwn"
#include "features/factions/lsfd.pwn"
#include "features/factions/news.pwn"
#include "features/mdc/cmds.pwn"
#include "features/furniture/furniture.pwn"
#include "features/furniture/dialog.pwn"
#include "features/business/functions.pwn"
#include "features/business/sql.pwn"
#include "features/business/a_cmds.pwn"
#include "features/business/player_cmds.pwn"
#include "features/business/dialogs.pwn"
#include "features/graffiti/graffiti.pwn"
#include "features/phones/cmds.pwn"
#include "features/vehicles/gasoline.pwn"
#include "features/accessories/functions.pwn"
#include "features/accessories/dialogs.pwn"
#include "features/accessories/cmds.pwn"

main() {}

public OnGameModeInit()
{
	SetServerSettings();
	SetDatabaseSettings();

	SetTimer("MainTimer", 1000, true);

	printf("\n\n------------[YÜKLEMELER]------------");
    mysql_tquery(conn, "SELECT * FROM `houses`", "LoadHouses");
    mysql_tquery(conn, "SELECT * FROM `weapons`", "LoadWeapons");
    mysql_tquery(conn, "SELECT * FROM `buildings`", "LoadBuildings");
    mysql_tquery(conn, "SELECT * FROM `vehicles`", "LoadVehicles");
    mysql_tquery(conn, "SELECT * FROM `gallerys`", "LoadGallerys");
    mysql_tquery(conn, "SELECT * FROM `factions`", "LoadFactions");
	mysql_tquery(conn, "SELECT * FROM `arrestpoints`", "LoadArrestPoints");
	mysql_tquery(conn, "SELECT * FROM `jails`", "LoadJails");
	mysql_tquery(conn, "SELECT * FROM `business`", "LoadBusiness");
	mysql_tquery(conn, "SELECT * FROM `graffities`", "LoadGraffities");
	mysql_tquery(conn, "SELECT * FROM `furnitures`", "LoadFurnitures");
	mysql_tquery(conn, "SELECT * FROM `furniture_categories`", "LoadFurnitureCategories");
	mysql_tquery(conn, "SELECT * FROM `furniture_items`", "LoadFurnitureItems");
	mysql_tquery(conn, "SELECT * FROM `gasolines`", "LoadGasolines");

	LoadDirections();

    for(new i = 0; i < MAX_BARRICADE; i++)
    {
        Barricade[i][bCreated] = 0;
    }
	return true;
}

public OnGameModeExit()
{
	ShutdownServer();
	return true;
}

public OnPlayerConnect(playerid)
{
	LoadAnimations(playerid);
	SetPlayerColor(playerid, C_WHITE);

	// geçici wvunder
	IsEditingObject[playerid] = 0;
	ChallangeData[playerid][cChallange] = 0;
	ChallangeData[playerid][cLeft] = 0;
	ChallangeData[playerid][cTrue] = 0;
	ChallangeData[playerid][cFalse] = 0;

	ResetCharacterData(playerid);

	for(new i; i < MAX_HOUSES; i++)
	{
		if(House[i][hIsValid])
		{
			TogglePlayerDynamicCP(playerid, House[i][hCheckpoint], false);
		}
	}
	return true;
}

public OnPlayerRequestClass(playerid, classid)
{
	CheckCharacter(playerid);
	TogglePlayerSpectating(playerid, true);
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(IsEditingObject[playerid])
	{
		new query[128];
		DestroyDynamicObject(Graffiti[EditingGraffiti[playerid]][gObject]);
		mysql_format(conn, query, sizeof(query), "DELETE FROM graffities WHERE id = '%i'", Graffiti[EditingGraffiti[playerid]][gID]);
		mysql_query(conn, query, false);
		Iter_Remove(Graffities, EditingObject[playerid]);
	}

	SaveCharacterData(playerid);
	HideWeapon(playerid, EquippedWeapon[playerid]);

	for(new i = 0; i < MAX_BARRICADE; i++)
    {
		if(Barricade[i][bOwner] == playerid) 
		{
            Barricade[i][bCreated] = 0;
            DestroyDynamicObject(Barricade[i][bObject]);
        }
    }
	return true;
}

public OnPlayerText(playerid, const text[])
{
	if(!LoggedIn[playerid])
	{
		SendServerMessage(playerid, "Önce giriþ yapmalýsýnýz.");
	}
	else if(Muted[playerid])
	{
		SendServerMessage(playerid, "Susturulmuþken konuþamazsýnýz.");
	}
	else if(Character[playerid][cCallActive])
	{
		new partnerid = Character[playerid][cCallPartner], phonenoex = 0, phonenameex[124], phonesex[12];
		switch(Character[playerid][cSex])
		{
			case 0: phonesex = "Bilinmiyor";
			case 1: phonesex = "E";
			case 2: phonesex = "K";
		}
		for(new i = 0; i < MAX_DIRECTORY; i++)
		{
			if(Character[playerid][cPhoneNumber] == Directory[partnerid][i][dNumber])
			{
				phonenoex++;
				format(phonenameex, 124, Directory[partnerid][i][dName]);
			}
		}
		if(!phonenoex)
		{
			SendClientMessageEx(partnerid, C_PM, "(Telefon-%s) %d: %s", phonesex, Character[playerid][cPhoneNumber], text);
			SendNearbyMessage(playerid, 20.0, C_WHITE, "(telefon) %s: %s", GetRPName(playerid), text);
		}
		else if(phonenoex != 0)
		{
			SendClientMessageEx(partnerid, C_PM, "(Telefon-%s) %s: %s", phonesex, phonenameex, text);
			SendNearbyMessage(playerid, 20.0, C_WHITE, "(telefon) %s: %s", GetRPName(playerid), text);
		}
	}
	else
	{
		switch(Character[playerid][cIsDead])
		{
			case 0:
			{
				if(strlen(text) > 84)
				{
					SendNearbyMessage(playerid, 20.0, C_WHITE, "%s: %.84s", GetRPName(playerid), text);
					SendNearbyMessage(playerid, 20.0, C_WHITE, "%s: ... %s", GetRPName(playerid), text[84]);
				}
				else
				{
					SendNearbyMessage(playerid, 20.0, C_WHITE, "%s: %s", GetRPName(playerid), text);
				}
			}
			case 1:
			{
				if(strlen(text) > 84) 
				{
					SendNearbyMessage(playerid, 20.0, C_WHITE, "%s (yaralý): %.84s", GetRPName(playerid), text);
					SendNearbyMessage(playerid, 20.0, C_WHITE, "%s (yaralý): ... %s", GetRPName(playerid), text[84]);
				}
				else 
				{
					SendNearbyMessage(playerid, 20.0, C_WHITE, "%s (yaralý): %s", GetRPName(playerid), text);
				}
			}
		}
	}
	return false;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerSkin(playerid, Character[playerid][cSkin]);

	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL,998);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL_SILENCED,999);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,999);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_SHOTGUN,999);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_SAWNOFF_SHOTGUN,998);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_SPAS12_SHOTGUN,999);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,998);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,999);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_AK47,999);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_M4,999);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_SNIPERRIFLE,999);

	if(Character[playerid][cIsDead]) 
	{
		KillPlayer(playerid, Character[playerid][cKillerPlayer], Character[playerid][cKillerWeapon]);
		SetPlayerPos(playerid, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2]);
		for(new i; i < 5; i++) ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.0, 1, 1, 1, 0, 0);
	}

	return true;
}

public OnPlayerDeath(playerid)
{
	GetPlayerPos(playerid, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2]);
	return false;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	AddNewDamage(GetRPName(issuerid), playerid, weaponid, amount, bodypart);
	GetPlayerHealth(playerid, Character[playerid][cHP]);

    if(Character[playerid][cHP] - amount < 15.0)
    {
        new KillerPlayer, KillerWeapon;

        if(issuerid != INVALID_PLAYER_ID) KillerPlayer = Character[issuerid][cID], KillerWeapon = EquippedWeaponID[issuerid];
        else KillerPlayer = 0, KillerWeapon = 0;

        GetPlayerPos(playerid, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2]);
        KillPlayer(playerid, KillerPlayer, KillerWeapon);
    }
	return true;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    if(TakeTaser[playerid] && weaponid == 23) 
	{
		GetPlayerPos(damagedid, Character[damagedid][cPos][0], Character[damagedid][cPos][1], Character[damagedid][cPos][2]);
		GivePlayerHealth(playerid, amount);

		if(IsPlayerInRangeOfPoint(playerid, 10.0, Character[damagedid][cPos][0], Character[damagedid][cPos][1], Character[damagedid][cPos][2]) < 10.0) 
		{
			ApplyAnimationEx(damagedid, "CRACK", "crckidle3", 4.0, 1, 1, 1, 0, 0);
			GameTextForPlayer(damagedid, "taser etkisindesin", 3000, 5);
			TogglePlayerControllable(damagedid, false);
			HasShotTB[playerid] = 1;
			TogglePlayerControllable(playerid, false);
			GivePlayerHealth(damagedid, 1 * amount);
			Character[damagedid][cTaserTimer] = SetTimerEx("TaserTimer", 5000, 0, "d", damagedid);
		}
	}

	if(TakeBeanbag[playerid] && weaponid == 25) 
	{
		GetPlayerPos(damagedid, Character[damagedid][cPos][0], Character[damagedid][cPos][1], Character[damagedid][cPos][2]);
		GivePlayerHealth(playerid, amount);
		
		if(IsPlayerInRangeOfPoint(playerid, 10.0, Character[damagedid][cPos][0], Character[damagedid][cPos][1], Character[damagedid][cPos][2]) < 10.0) 
		{
			ApplyAnimationEx(damagedid, "CRACK", "crckidle3", 4.0, 1, 1, 1, 0, 0);
			GameTextForPlayer(damagedid, "plastik mermi isabet etti", 3000, 5);
			TogglePlayerControllable(damagedid, false);
			HasShotTB[playerid] = 1;
			TogglePlayerControllable(playerid, false);
			GivePlayerHealth(damagedid, 1 * amount);
			Character[damagedid][cTaserTimer] = SetTimerEx("TaserTimer", 5000, 0, "d", damagedid);
		}
	}
	return true;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_JUMP))
	{
		if(OnAnim[playerid])
		{
			ClearAnimations(playerid);
			OnAnim[playerid] = false;
		}
	}
	
	if(PRESSED(KEY_NO))
	{
		if(Smoking[playerid])
		{
			SendServerMessage(playerid, "Sigarayý attýnýz.");
			Smoking[playerid] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
	return true;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return true;
}

public OnPlayerCommandReceived(playerid, const cmd[], const params[], flags)
{
	return true;
}

public OnPlayerCommandPerformed(playerid, const cmd[], const params[], result, flags)
{
	if(!LoggedIn[playerid]) return SendServerMessage(playerid, "Önce giriþ yapmalýsýnýz.");
	if(result == -1) return SendServerMessage(playerid, "Hatalý komut girdiniz.");
	return true;
}

public OnPlayerUpdate(playerid)
{
	if(PlayerCloseToHouse(playerid))
	{
		new houseid = GetPlayerNearbyHouse(playerid);
		TogglePlayerDynamicCP(playerid, House[houseid][hCheckpoint], true);
		PlayerHouseCheckpoint[playerid] = houseid;
	}
	else
	{
		new houseid = PlayerHouseCheckpoint[playerid];
		TogglePlayerDynamicCP(playerid, House[houseid][hCheckpoint], false);
	}

	if(IsPlayerInAnyVehicle(playerid))
		if(Cuffed[playerid] || Character[playerid][cIsDead])
			RemovePlayerFromVehicle(playerid);

	if(ChallangeData[playerid][cChallange])
	{
		new Keys, ud, lr;

    	GetPlayerKeys(playerid, Keys, ud, lr);

		switch(ud)
		{
			case KEY_UP:
			{
				new id = ChallangeData[playerid][cKey];

				if(id == 0)
				{
					SetPVarInt(playerid, "clicked", 1);
					TextDrawHideForPlayer(playerid, KeyTextDraws[id]);
					TextDrawColor(KeyTextDraws[id], 0x4FEB5BFF);
					TextDrawShowForPlayer(playerid, KeyTextDraws[id]);
					ChallangeData[playerid][cTrue]++;
					SetTimerEx("RefreshChallange", 500, false, "d", playerid);
				}
				else
				{
					ChallangeData[playerid][cFalse]++;
					TextDrawHideForPlayer(playerid, KeyTextDraws[id]);
					TextDrawColor(KeyTextDraws[id], 0xEB4F4FFF);
					TextDrawShowForPlayer(playerid, KeyTextDraws[id]);
					SetTimerEx("RefreshChallange", 500, false, "d", playerid);
				}
			}
			case KEY_DOWN:
			{
				new id = ChallangeData[playerid][cKey];

				if(id == 1)
				{
					SetPVarInt(playerid, "clicked", 1);
					TextDrawHideForPlayer(playerid, KeyTextDraws[id]);
					TextDrawColor(KeyTextDraws[id], 0x4FEB5BFF);
					TextDrawShowForPlayer(playerid, KeyTextDraws[id]);
					ChallangeData[playerid][cTrue]++;
					SetTimerEx("RefreshChallange", 500, false, "d", playerid);
				}
				else
				{
					ChallangeData[playerid][cFalse]++;
					TextDrawHideForPlayer(playerid, KeyTextDraws[id]);
					TextDrawColor(KeyTextDraws[id], 0xEB4F4FFF);
					TextDrawShowForPlayer(playerid, KeyTextDraws[id]);
					SetTimerEx("RefreshChallange", 500, false, "d", playerid);
				}
			}
		}

		switch(lr)
		{
			case KEY_LEFT:
			{
				new id = ChallangeData[playerid][cKey];

				if(id == 2)
				{
					SetPVarInt(playerid, "clicked", 1);
					TextDrawHideForPlayer(playerid, KeyTextDraws[id]);
					TextDrawColor(KeyTextDraws[id], 0x4FEB5BFF);
					TextDrawShowForPlayer(playerid, KeyTextDraws[id]);
					ChallangeData[playerid][cTrue]++;
					SetTimerEx("RefreshChallange", 500, false, "d", playerid);
				}
				else
				{
					ChallangeData[playerid][cFalse]++;
					TextDrawHideForPlayer(playerid, KeyTextDraws[id]);
					TextDrawColor(KeyTextDraws[id], 0xEB4F4FFF);
					TextDrawShowForPlayer(playerid, KeyTextDraws[id]);
					SetTimerEx("RefreshChallange", 500, false, "d", playerid);
				}
			}
			case KEY_RIGHT:
			{
				new id = ChallangeData[playerid][cKey];

				if(id == 3)
				{
					SetPVarInt(playerid, "clicked", 1);
					TextDrawHideForPlayer(playerid, KeyTextDraws[id]);
					TextDrawColor(KeyTextDraws[id], 0x4FEB5BFF);
					TextDrawShowForPlayer(playerid, KeyTextDraws[id]);
					ChallangeData[playerid][cTrue]++;
					SetTimerEx("RefreshChallange", 500, false, "d", playerid);
				}
				else
				{
					ChallangeData[playerid][cFalse]++;
					TextDrawHideForPlayer(playerid, KeyTextDraws[id]);
					TextDrawColor(KeyTextDraws[id], 0xEB4F4FFF);
					TextDrawShowForPlayer(playerid, KeyTextDraws[id]);
					SetTimerEx("RefreshChallange", 500, false, "d", playerid);
				}
			}
		}
	}

	if(IsEditingObject[playerid])
	{
		new Keys, ud, lr;

    	GetPlayerKeys(playerid, Keys, ud, lr);

		if(ud == KEY_FIRE)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, Graffiti[EditingGraffiti[playerid]][gPOS][0], Graffiti[EditingGraffiti[playerid]][gPOS][1], Graffiti[EditingGraffiti[playerid]][gPOS][2]))
			{
				SprayTimes[playerid]++;
				if(SprayTimes[playerid] == 10)
				{
					SetDynamicObjectPos(Graffiti[EditingGraffiti[playerid]][gObject], Graffiti[EditingGraffiti[playerid]][gPOS][0], Graffiti[EditingGraffiti[playerid]][gPOS][1], Graffiti[EditingGraffiti[playerid]][gPOS][2]);
					SetDynamicObjectRot(Graffiti[EditingGraffiti[playerid]][gObject], Graffiti[EditingGraffiti[playerid]][gROT][0], Graffiti[EditingGraffiti[playerid]][gROT][1], Graffiti[EditingGraffiti[playerid]][gROT][2]);
						
					IsEditingObject[playerid] = 0;
					EditingObject[playerid] = -1;
					EditingGraffiti[playerid] = 0;
					SprayTimes[playerid] = 0;
				}
			}
		}
	}
	return true;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(PlayerCloseToHouse(playerid))
	{
		new houseid = GetPlayerNearbyHouse(playerid);
		if(House[houseid][hCheckpoint])
		{
			SendServerMessage(playerid, "{268126}Kapý numarasý %d olan evin önünde duruyorsunuz. (%s)", House[houseid][hDoorNumber], GetLocation(House[houseid][hExtDoor][0], House[houseid][hExtDoor][1], House[houseid][hExtDoor][2]));
			if(House[houseid][hOwner] == -1)
				SendServerMessage(playerid, "{268126}Bu ev $%d fiyatla satýlýk!", House[houseid][hPrice]);
		}
	}
	return true;
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	foreach(new i : Houses) if(House[i][hIsValid])
	{
		TogglePlayerDynamicCP(playerid, House[i][hCheckpoint], false);
	}
	return true;
}


public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	if(IsEditingFurniture[playerid])
	{
		new obj = 0;
		
		foreach(new i : Furnitures) if(Furniture[i][fIsValid]) {
			if(Furniture[i][fObject] == objectid) {
				obj = Furniture[i][fObject];
			}
		}

		if(obj != 0)
		{
			EditDynamicObject(playerid, obj);
		}
	}

	if(IsDeletingFurniture[playerid])
	{
		new obj = 0;

		foreach(new i : Furnitures) if(Furniture[i][fIsValid]) {
			if(Furniture[i][fObject] == objectid) {
				obj = i;
			}
		}

		if(obj != 0)
		{
			DestroyFurniture(playerid, obj);
		}
	}
	return true;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(IsEditingObject[playerid] && EditingObject[playerid] == objectid)
    {
		if(!response) return DestroyGraffiti(playerid, EditingGraffiti[playerid]); 

        Graffiti[EditingGraffiti[playerid]][gPOS][0] = x;
        Graffiti[EditingGraffiti[playerid]][gPOS][1] = y;
        Graffiti[EditingGraffiti[playerid]][gPOS][2] = z;

        Graffiti[EditingGraffiti[playerid]][gROT][0] = rx;
        Graffiti[EditingGraffiti[playerid]][gROT][1] = ry;
        Graffiti[EditingGraffiti[playerid]][gROT][2] = rz;

        SetDynamicObjectPos(objectid, 0, 0, 0);
        SetDynamicObjectRot(objectid, 0, 0, 0);

        SprayTimes[playerid] = 0;
    }
	if(IsCreatingFurniture[playerid])
	{
		if(!response) return DestroyFurniture(playerid, CreatingFurniture[playerid]);

		Furniture[CreatingFurniture[playerid]][fPOS][0] = x;
        Furniture[CreatingFurniture[playerid]][fPOS][1] = y;
        Furniture[CreatingFurniture[playerid]][fPOS][2] = z;

        Furniture[CreatingFurniture[playerid]][fROT][0] = rx;
        Furniture[CreatingFurniture[playerid]][fROT][1] = ry;
        Furniture[CreatingFurniture[playerid]][fROT][2] = rz;

        SetDynamicObjectPos(objectid, x, y, z);
        SetDynamicObjectRot(objectid, rx, ry, rz);
	}
	return true;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	new bid = GetPlayerNearbyBuilding(playerid), bstr[124];
	if(pickupid == Building[bid][bPickup])
	{
		format(bstr, sizeof(bstr), "%s", Building[bid][bName]);
		GameTextForPlayer(playerid, bstr, 2000, 3);
	}
	new gid = GetPlayerNearbyGalleryID(playerid), gstr[32];
	if(pickupid == Gallery[gid][gPickup])
	{
		format(gstr, sizeof(gstr), "%s", Gallery[gid][gName]);
		GameTextForPlayer(playerid, gstr, 2000, 3);
	}
	new bsid = GetPlayerNearbyBusiness(playerid);
	if(pickupid == Business[bsid][bsPickup])
	{
		if(Business[bsid][bsOwner] == -1)
		{
			new bsstr[124];
			format(bsstr, sizeof(bsstr), "~w~%s - ~g~$%d!!!", Business[bsid][bsName], Business[bsid][bsPrice]);
			GameTextForPlayer(playerid, bsstr, 2000, 3);
		}
		else
		{
			new bsstr[124];
			format(bsstr, sizeof(bsstr), "~w~%s", Business[bsid][bsName]);
			GameTextForPlayer(playerid, bsstr, 2000, 3);
		}
	}
	return true;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(UsageVehiclePark[playerid] && IsPlayerInRangeOfPoint(playerid, 5.0, VehicleParkPos[playerid][0], VehicleParkPos[playerid][1], VehicleParkPos[playerid][2]))
	{
		GameTextForPlayer(playerid, "~w~PARK YERINIZI ~g~BULDUNUZ", 2000, 4);
		
		new vehid = GetPlayerVehicleID(playerid);

		SwitchVehicleEngine(vehid, false), Engine[vehid] = false;
		Vehicle[vehid][vPark] = 1;
		RemovePlayerFromVehicle(playerid);
		SetVehicleVirtualWorld(vehid, 2);
		DisablePlayerCheckpoint(playerid);
		UsageVehiclePark[playerid] = 0;
		RefreshVehicle(vehid);
	}
	return true;
}

public OnVehicleHealthChange(vehicleid,Float:newhealth,Float:oldhealth)
{
	new driverid = GetVehicleDriver(vehicleid);
	if(IsPlayerInAnyVehicle(driverid))
	{
		if(newhealth < 350.0)
		{
			SendServerMessage(driverid, "Motor kötü halde hasar aldý.");
			SendServerMessage(driverid, "Aktif mekanik servisini arayarak yol yardým talebinde bulunabilirsiniz.");
			SwitchVehicleEngine(vehicleid, false), Engine[vehicleid] = false;
			SwitchVehicleDoors(vehicleid, false), Doors[vehicleid] = false;
			SwitchVehicleLight(vehicleid, false), Lights[vehicleid] = false;
			SwitchVehicleBonnet(vehicleid, false), Bonnet[vehicleid] = false;
			SwitchVehicleBoot(vehicleid, false), Boot[vehicleid] = false;
			Vehicle[vehicleid][vAccident] = 1;
			Vehicle[vehicleid][vHealth] = 350;
			Vehicle[vehicleid][vEngineLife] -= 25.0;
			Vehicle[vehicleid][vBatteryLife] -= 25.0;
			SetVehicleHealth(vehicleid, 350);
			RefreshVehicle(vehicleid);
		}
	}
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		//speedometer göster
	}
	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
		//speedometer kapat
	}
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, const inputtext[])
{
	if(dialogid == S_DIALOG_GALLERY)
	{
		if(!response) return Dialog_Show(playerid, GALLERY_COLOR2, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Galeri", "{FFFFFF}Aracýnýzýn 2. rengini seçin:", "Devam", "<<");
		if(VEHICLE_GALLERY[listitem][GALLERY_VEHICLE_PRICE] > Character[playerid][cMoney]) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

		new gid = GetPlayerNearbyGalleryID(playerid);
		new vehid = AddStaticVehicleEx(VEHICLE_GALLERY[listitem][GALLERY_VEHICLE_MODEL], Gallery[gid][gSpawnPos][0], Gallery[gid][gSpawnPos][1], Gallery[gid][gSpawnPos][2], 90.0, Gallery_FirstColor[playerid], Gallery_SecondColor[playerid], -1, 0);
		new plate[32], plateno = randomEx(1111, 9999);
		format(plate, 32, "LS %d", plateno);
		SetVehicleColor(vehid, Gallery_FirstColor[playerid], Gallery_SecondColor[playerid]);
		SetVehicleNumberPlate(vehid, plate);
		SetVehicleHealth(vehid, 1000);
		SwitchVehicleEngine(vehid, false), Engine[vehid] = false;

		new query[1024], Cache:InsertData;
		mysql_format(conn, query, sizeof(query), "INSERT INTO vehicles (Owner, Faction, Model, X, Y, Z, A, Color1, Color2, Type, Price, Plate, KM, Health, Fuel, Park, Accident, EngineLife, BatteryLife, LockLevel, AlarmLevel) VALUES (%i, -1, %i, %.4f, %.4f, %.4f, 90.0, %i, %i, 1, %i, '%e', 0, 1000, 100, 0, 0, 100.0, 100.0, 0, 0)",
		Character[playerid][cID], 
		VEHICLE_GALLERY[listitem][GALLERY_VEHICLE_MODEL], 
		Gallery[gid][gSpawnPos][0], 
		Gallery[gid][gSpawnPos][1],
		Gallery[gid][gSpawnPos][2], 
		Gallery_FirstColor[playerid], 
		Gallery_SecondColor[playerid], 
		VEHICLE_GALLERY[listitem][GALLERY_VEHICLE_PRICE], plate); 
		InsertData = mysql_query(conn, query);

		Vehicle[vehid][vIsValid] = true;
		Vehicle[vehid][vVehicleID] = vehid;
		Vehicle[vehid][vID] = cache_insert_id();
		Vehicle[vehid][vOwner] = Character[playerid][cID];
		Vehicle[vehid][vFaction] = 0;
		Vehicle[vehid][vModel] = VEHICLE_GALLERY[listitem][GALLERY_VEHICLE_MODEL];
		Vehicle[vehid][vPos][0] = Gallery[gid][gSpawnPos][0];
		Vehicle[vehid][vPos][1] = Gallery[gid][gSpawnPos][1];
		Vehicle[vehid][vPos][2] = Gallery[gid][gSpawnPos][2];
		Vehicle[vehid][vPos][3] = 90.0;
		Vehicle[vehid][vColor1] = Gallery_FirstColor[playerid];
		Vehicle[vehid][vColor2] = Gallery_SecondColor[playerid];
		Vehicle[vehid][vType] = 1;
		Vehicle[vehid][vPrice] = VEHICLE_GALLERY[listitem][GALLERY_VEHICLE_PRICE];
		format(Vehicle[vehid][vPlate], 32, "%s", plate);
		Vehicle[vehid][vKM] = 0;
		Vehicle[vehid][vHealth] = 1000;
		Vehicle[vehid][vFuel] = 100;
		Vehicle[vehid][vPark] = 0;
		Vehicle[vehid][vAccident] = 0;
		Vehicle[vehid][vEngineLife] = 100.0;
		Vehicle[vehid][vBatteryLife] = 100.0;
		Vehicle[vehid][vLockLevel] = 0;
		Vehicle[vehid][vAlarmLevel] = 0;
		SendServerMessage(playerid, "$%d ücret ödeyerek %s model aracý satýn aldýnýz.", Vehicle[vehid][vPrice], GetVehicleName(vehid));
		cache_delete(InsertData);

		GiveMoney(playerid, -VEHICLE_GALLERY[listitem][GALLERY_VEHICLE_PRICE]);
		RefreshVehicle(vehid);
		SaveCharacterData(playerid);
	}
	if(dialogid == S_DIALOG_MALEPD)
	{
		if(!response) return true;

		SetPlayerSkin(playerid, LSPD_MALE[listitem][PD_SKIN_MODEL]);
	}
	if(dialogid == S_DIALOG_FEMALEPD)
	{
		if(!response) return true;

		SetPlayerSkin(playerid, LSPD_FEMALE[listitem][PD_SKIN_MODEL]);
	}
	if(dialogid == S_DIALOG_FURNITURE)
	{
		if(!response) return true;
		
		new tempStr[10], id, rand;
		format(tempStr, 10, "%s", inputtext);
		id = strval(tempStr);
		rand = randomEx(100, 200);
		
		GiveMoney(playerid, -1 * rand);
		CreateNewFurniture(playerid, PlayerHouse[playerid], id);
	}
	if(dialogid == BUY_BLACK_MALE)
	{
		if(!response) return true;

		if(Character[playerid][cMoney] < 50) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

		Character[playerid][cSkin] = SHOP_BLACK_MALE[listitem][CLOTHES_MODEL];
		SetPlayerSkin(playerid, SHOP_BLACK_MALE[listitem][CLOTHES_MODEL]);

		new bsid = GetBusinessIDFromInt(playerid);
		Business[bsid][bsSafe] += 50;

		SendServerMessage(playerid, "$50 karþýlýðýnda bir kýyafet satýn aldýnýz.");
	}
	if(dialogid == BUY_WHITE_MALE)
	{
		if(!response) return true;

		if(Character[playerid][cMoney] < 50) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

		Character[playerid][cSkin] = SHOP_WHITE_MALE[listitem][CLOTHES_MODEL];
		SetPlayerSkin(playerid, SHOP_WHITE_MALE[listitem][CLOTHES_MODEL]);

		new bsid = GetBusinessIDFromInt(playerid);
		Business[bsid][bsSafe] += 50;

		SendServerMessage(playerid, "$50 karþýlýðýnda bir kýyafet satýn aldýnýz.");
	}
	if(dialogid == BUY_WHITE_FEMALE)
	{
		if(!response) return true;

		if(Character[playerid][cMoney] < 50) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

		Character[playerid][cSkin] = SHOP_WHITE_FEMALE[listitem][CLOTHES_MODEL];
		SetPlayerSkin(playerid, SHOP_WHITE_FEMALE[listitem][CLOTHES_MODEL]);

		new bsid = GetBusinessIDFromInt(playerid);
		Business[bsid][bsSafe] += 50;

		SendServerMessage(playerid, "$50 karþýlýðýnda bir kýyafet satýn aldýnýz.");
	}
	if(dialogid == BUY_BLACK_FEMALE)
	{
		if(!response) return true;

		if(Character[playerid][cMoney] < 50) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

		Character[playerid][cSkin] = SHOP_BLACK_FEMALE[listitem][CLOTHES_MODEL];
		SetPlayerSkin(playerid, SHOP_BLACK_FEMALE[listitem][CLOTHES_MODEL]);

		new bsid = GetBusinessIDFromInt(playerid);
		Business[bsid][bsSafe] += 50;

		SendServerMessage(playerid, "$50 karþýlýðýnda bir kýyafet satýn aldýnýz.");
	}
	if(dialogid == BUY_A_ACC)
	{
		if(!response) return true;

		SetPVarInt(playerid, "SelectedACCID", ACCS[listitem][ACCS_MODEL]);
		Dialog_Show(playerid, DIALOG_BONES, DIALOG_STYLE_LIST, "Vinewood Roleplay - Bölge", "Omurga\nKafa\nSol üst kol\nSað üst kol\nSol el\nSað el\nSol uyluk\nSað uyluk\nSol ayak\nSað ayak\nSað baldýr\nSol baldýr\nSol ön kol\nSað ön kol\nSol omuz\nSað omuz\nBoyun\nÇene", "Seç", "Kapat");
	}
	return true;
}

public OnPlayerFinishedChallange(playerid, challange, success)
{
	TogglePlayerControllable(playerid, true);
	ChallangeData[playerid][cChallange] = false;

	for(new i; i < 4; i++) {
		TextDrawHideForPlayer(playerid, KeyTextDraws[i]);
	}

	switch(ChallangeData[playerid][cType])
	{
		case CHALLANGE_TOOLKIT:
		{
			Character[playerid][cToolkit] = 0;

			if(!success) return SendServerMessage(playerid, "Baþarýsýz oldun.");

			SetVehicleHealth(GetPVarInt(playerid, "FixingCar"), DAMAGED_VEHICLE_HEALTH + 1);
			SwitchVehicleEngine(GetPVarInt(playerid, "FixingCar"), true);
			SendServerMessage(playerid, "Aracý tamir ettiniz.");
			DeletePVar(playerid, "FixingCar");
		}
		case CHALLANGE_HOUSE_KEY:
		{
			Character[playerid][cSkeletonKey] = 0;

			if(!success) return SendServerMessage(playerid, "Baþarýsýz oldun.");

			House[GetPVarInt(playerid, "BreakingHouseKey")][hLocked] = 0;
			SendServerMessage(playerid, "Kilit açýldý.");
			DeletePVar(playerid, "BreakingHouseKey");
		}
		case CHALLANGE_VEH_KEY:
		{
			Character[playerid][cSkeletonKey] = 0;

			if(!success) return SendServerMessage(playerid, "Baþarýsýz oldun.");

			Doors[GetPVarInt(playerid, "BreakingVehicleDoors")] = false;
			SwitchVehicleDoors(GetPVarInt(playerid, "BreakingVehicleDoors"), false);
			SendServerMessage(playerid, "Kilit açýldý.");
			DeletePVar(playerid, "BreakingVehicleDoors");
		}
		case CHALLANGE_FIXING_CAR:
		{
			if(!success) return SendServerMessage(playerid, "Baþarýsýz oldun.");

			new vehid = GetPVarInt(playerid, "FixingGarageCarID");
			RepairVehicle(vehid);
			Vehicle[vehid][vHealth] = 1000.0;
			RefreshVehicle(vehid);

			SendServerMessage(playerid, "Araç tamir edildi.");
			DeletePVar(playerid, "FixingGarageCarID");
		}
	}
	return true;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	if(response)
	{
		new Float:aox, Float:aoy, Float:aoz, Float:aorx, Float:aory, Float:aorz, Float:aosx, Float:aosy, Float:aosz;

		aox = fOffsetX;
		aoy = fOffsetY;
		aoz = fOffsetZ;
		aorx = fRotX;
		aory = fRotY;
		aorz = fRotZ;
		aosx = fScaleX;
		aosy = fScaleY;
		aosz = fScaleZ;

		new query[1024], Cache:InsertData;
		mysql_format(conn, query, sizeof(query), "INSERT INTO accessories (Owner, Slot, Model, Bone, fOffSetX, fOffSetY, fOffSetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ, MaterialColor1, MaterialColor2) VALUES (%i, %i, %i, %i, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, 0, 0)",
				Character[playerid][cID],
				index,
				modelid,
				boneid,
				aox, aoy, aoz, aorx, aory, aorz, aosx, aosy, aosz);
		InsertData = mysql_query(conn, query);

		SendServerMessage(playerid, "%d numaralý slottaki aksesuarýnýz kaydedildi.", index);
		SendServerMessage(playerid, "Aksesuarýnýzý kullanmaya baþlamak için /aksesuar komutunu kullanabilirsiniz.");
		//SendServerMessage(playerid, "%.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f", aox, aoy, aoz, aorx, aory, aorz, aosx, aosy, aosz);
		RemovePlayerAttachedObject(playerid, index);
		cache_delete(InsertData);
	}
	return true;
}