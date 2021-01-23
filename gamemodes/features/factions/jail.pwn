CMD:tnoktasi(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	
	new choice[24];
	if(sscanf(params, "s[24]", choice)) return SendServerMessage(playerid, "/tnoktasi [ÝÞLEM] (Ýþlemler: olustur, sil, duzenle)");

	if(!strcmp(choice, "olustur", true))
	{
		new Float: X, Float: Y, Float: Z;
		GetPlayerPos(playerid, X, Y, Z);
		CreateArrestPoint(playerid, X, Y, Z);
		SendServerMessage(playerid, "Tutuklama noktasý oluþturdun.");
	}
	else if(!strcmp(choice, "sil", true, 3))
	{
		new id;
		if(sscanf(params, "s[24]d", choice, id)) return SendServerMessage(playerid, "/tnoktasi sil [ID]");
		DestroyArrestPoint(playerid, id);
		SendServerMessage(playerid, "Tutuklama noktasýný sildin.");
	}
	else if(!strcmp(choice, "duzenle", true, 5))
	{
		new id;
		if(sscanf(params, "s[24]d", choice, id)) return SendServerMessage(playerid, "/tnoktasi duzenle [ID]");

		new Float: X, Float: Y, Float: Z;
		GetPlayerPos(playerid, X, Y, Z);
		UpdateArrestPoint(playerid, id, X, Y, Z);
		SendServerMessage(playerid, "Tutuklama noktasýný düzenledin.");
	}
	else return SendServerMessage(playerid, "Hatalý iþlem girdin.");

	return true;
}

CMD:jail(playerid, params[])
{
    if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
    
    new choice[24];
    if(sscanf(params, "s[24]", choice)) return SendServerMessage(playerid, "/jail [ÝÞLEM] (Ýþlemler: olustur, sil");

	if(!strcmp(choice, "olustur", true))
	{
		new Float: X, Float: Y, Float: Z;
		GetPlayerPos(playerid, X, Y, Z);
		CreateJail(playerid, X, Y, Z);
		SendServerMessage(playerid, "Hapishane noktasý oluþturdun.");
	}
	else if(!strcmp(choice, "sil", true, 3))
	{
		new id;
		if(sscanf(params, "s[24]d", choice, id)) return SendServerMessage(playerid, "/tnoktasi sil [ID]");
		DestroyJail(playerid, id);
		SendServerMessage(playerid, "Hapishane noktasýný sildin.");
	}
    else return SendServerMessage(playerid, "Hatalý iþlem girdin.");

    return true;
}

CMD:tutukla(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	if(!ClosestArrestPoint(playerid)) return SendServerMessage(playerid, "Herhangi bir tutuklama noktasýna yakýn deðilsin.");
	
	new target, time, reason[64], str[128];

	if(sscanf(params, "dds[64]", target, time, reason)) return SendServerMessage(playerid, "/tutukla [ID] [DAKIKA] [SEBEP]");
	if(time < 1 || time > 500) return SendServerMessage(playerid, "Hapis süresi(dakika) 1 - 500 arasý olmalýdýr.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Oyuncu oyunda deðil.");
	if(GetClosestPlayer(playerid) == INVALID_PLAYER_ID) return SendServerMessage(playerid, "Herhangi bir oyuncuya yakýn deðilsin."); 
	if(!Cuffed[GetClosestPlayer(target)]) return SendServerMessage(playerid, "Yakýn olduðun kiþi kelepçeli deðil.");

	PutInJail(target, time);

	foreach(new i : Player) {
		if(IsPlayerOfficer(i)) {
			format(str, 128, "DoC: %s isimli kiþi %s sebebiyle %s tarafýndan tutuklandý.", GetRPName(target), reason, GetRPName(playerid));
			SendClientMessage(i, C_ADMIN, str);
		}
	}
	return 1;
}

CMD:hapistencikar(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_DOC || GetFactionType(playerid) != FACTION_POLICE) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	if(!ClosestArrestPoint(playerid)) return SendServerMessage(playerid, "Herhangi bir tutuklama noktasýna yakýn deðilsin.");

	new target, reason[64], str[128];

	if(sscanf(params, "ds[64]", target, reason)) return SendServerMessage(playerid, "/hapistencikar [ID] [SEBEP]");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Oyuncu oyunda deðil.");
	if(Character[target][cJail] == 0) return SendServerMessage(playerid, "Oyuncu hapisde deðil.");

	SetPVarInt(target, "DoC", 1);

	SetPVarFloat(target, "OUT_X", ArrestPoint[ClosestArrestPoint(playerid)][POS][0]);
	SetPVarFloat(target, "OUT_Y", ArrestPoint[ClosestArrestPoint(playerid)][POS][1]);
	SetPVarFloat(target, "OUT_Z", ArrestPoint[ClosestArrestPoint(playerid)][POS][2]);

	PutOutOfJail(target);

	foreach(new i : Player) {
		if(IsPlayerOfficer(i)) {
			format(str, 128, "DoC: %s isimli kiþi %s sebebiyle %s serbest býrakýldý.", GetRPName(target), reason, GetRPName(playerid));
			SendClientMessage(i, C_ADMIN, str);
		}
	}
	return true;
}

CMD:hapis(playerid, params[])
{
	if(Character[playerid][cJail])
	{
		new text[32];
		format(text, 32, "%d", Character[playerid][cJailTimeLeft]);
		GameTextForPlayer(playerid, text, 3000, 1);
	}
	return true;
}

Vinewood:LoadJails()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	Iter_Add(Jails, 0);

	for(new i; i < rows; i++)
	{
		Jail[i+1][IsValid] = true;

		cache_get_value_name_int(i, "id", Jail[i+1][ID]);
		cache_get_value_name_float(i, "X", Jail[i+1][POS][0]);
		cache_get_value_name_float(i, "Y", Jail[i+1][POS][1]);
		cache_get_value_name_float(i, "Z", Jail[i+1][POS][2]);
		cache_get_value_name_int(i, "virtualWorld", Jail[i+1][VirtualWorld]);
		cache_get_value_name_int(i, "interior", Jail[i+1][Interior]);

		rowcount++;
		Iter_Add(Jails, i+1);
	}
	if(rowcount == 0) return printf("VinewoodDB >> Hapishane bulunamadý.");
	printf("VinewoodDB >> %d hapishane noktasý yüklendi.", rowcount);
	return true;
}

Vinewood:PutInJail(target, time)
{
	new SecondsLeft = (time * 60), num;

	foreach(new i : Jails) {
		num = random(sizeof(Jail));
		if(Jail[num][IsValid]) { break; }
	}

	RemovePlayerAttachedObject(target, 8);
	SetPlayerSpecialAction(target, SPECIAL_ACTION_NONE);

    Character[target][cOldSkin] = Character[target][cSkin];
	Character[target][cSkin] = (Character[target][cSex]) ? PRISONER_SKIN_1 : PRISONER_SKIN_2;
    SetPlayerSkin(target, Character[target][cSkin]);

	SetPlayerInterior(target, Jail[num][Interior]);
	SetPlayerVirtualWorld(target, Jail[num][VirtualWorld]);
	Character[target][cInt] = Jail[num][Interior];
	Character[target][cVW] = Jail[num][VirtualWorld];

	SetPlayerPos(target, Jail[num][POS][0], Jail[num][POS][1], Jail[num][POS][2]);
	Character[target][cPos][0] = Jail[num][POS][0];
	Character[target][cPos][1] = Jail[num][POS][1];
	Character[target][cPos][2] = Jail[num][POS][2];

	Character[target][cCuffed] = 0;
	Cuffed[target] = 0;

	Character[target][cJail] = 1;
	Character[target][cJailTimeLeft] = SecondsLeft;

	Character[target][cJailTimer] = SetTimerEx("JailTimer", 1000, true, "d", target);
	return true;
}

Vinewood:PutOutOfJail(playerid)
{
	SendServerMessage(playerid, "Artýk özgürsün.");
	Character[playerid][cSkin] = Character[playerid][cOldSkin];
	Character[playerid][cJail] = 0;
	SetPlayerSkin(playerid, Character[playerid][cSkin]);
    KillTimer(Character[playerid][cJailTimer]);

	if(GetPVarInt(playerid, "DoC") == 1)
	{
		SetPlayerPos(playerid, GetPVarFloat(playerid, "OUT_X"), GetPVarFloat(playerid, "OUT_Y"), GetPVarFloat(playerid, "OUT_Z"));
		SetPVarInt(playerid, "DoC", 0);
	}
	else SetPlayerPos(playerid, JAIL_OUT_X, JAIL_OUT_Y, JAIL_OUT_Z);
    return true;
}

Vinewood:CreateJail(playerid, Float: x, Float: y, Float: z)
{
	if(Iter_Count(Jails) >= MAX_JAILS) return SendServerMessage(playerid, "Sunucuda çok fazla hapishane var. Daha fazla oluþturulamaz.");
	
	new id = Iter_Free(Jails), query[128], Cache: InsertData;

	mysql_format(conn, query, sizeof(query), "INSERT INTO jails(X, Y, Z, virtualWorld, interior) VALUES(%.4f, %.4f, %.4f, %d, %d)",
		x,
		y,
		z,
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid)
	);
	InsertData = mysql_query(conn, query);

	Jail[id][ID] = cache_insert_id();
	Jail[id][POS][0] = x;
	Jail[id][POS][1] = y;
	Jail[id][POS][2] = z;
	Jail[id][VirtualWorld] = GetPlayerVirtualWorld(playerid);
	Jail[id][Interior] = GetPlayerInterior(playerid);
	Jail[id][IsValid] = true;

	Iter_Add(Jails, id);
	cache_delete(InsertData);
	return true;
}

Vinewood:DestroyJail(playerid, id)
{
	if(!Jail[id][IsValid]) return SendServerMessage(playerid, "Geçersiz hapishane.");

	new query[64*2], Cache: DeleteCache;

	mysql_format(conn, query, sizeof(query), "DELETE FROM jails WHERE id = %d", ArrestPoint[id][ID]);
	DeleteCache = mysql_query(conn, query);

	Jail[id][ID] = -1;
	Jail[id][POS][0] = 0.0;
	Jail[id][POS][1] = 0.0;
	Jail[id][POS][2] = 0.0;
	Jail[id][VirtualWorld] = -1;
	Jail[id][Interior] = -1;
	Jail[id][IsValid] = false;

	Iter_Remove(Jails, id);
	cache_delete(DeleteCache);
	return true;
}

Vinewood:LoadArrestPoints()
{
	new rows, fields, rowcount = 0, LabelText[64];
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	Iter_Add(ArrestPoints, 0);

	for(new i; i < rows; i++)
	{
		ArrestPoint[i+1][IsValid] = true;

		cache_get_value_name_int(i, "id", ArrestPoint[i+1][ID]);
		cache_get_value_name_float(i, "X", ArrestPoint[i+1][POS][0]);
		cache_get_value_name_float(i, "Y", ArrestPoint[i+1][POS][1]);
		cache_get_value_name_float(i, "Z", ArrestPoint[i+1][POS][2]);
		cache_get_value_name_int(i, "virtualWorld", ArrestPoint[i+1][VirtualWorld]);
		cache_get_value_name_int(i, "interior", ArrestPoint[i+1][Interior]);

		format(LabelText, sizeof(LabelText), "Tutuklama Noktasý: %d (/tutukla - /hapistencikar)", i+1);

		ArrestPoint[i+1][Pickup] = CreateDynamicPickup(ARREST_POINT_PICKUP, 1, ArrestPoint[i+1][POS][0], ArrestPoint[i+1][POS][1], ArrestPoint[i+1][POS][2], ArrestPoint[i+1][VirtualWorld], ArrestPoint[i+1][Interior], -1, STREAMER_PICKUP_SD, -1, 0);
		ArrestPoint[i+1][TextLabel] = CreateDynamic3DTextLabel(LabelText, -1, ArrestPoint[i+1][POS][0], ArrestPoint[i+1][POS][1], ArrestPoint[i+1][POS][2], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ArrestPoint[i+1][VirtualWorld], ArrestPoint[i+1][Interior], -1, 20.0, -1, 0);

		rowcount++;
		Iter_Add(ArrestPoints, i+1);
	}
	if(rowcount == 0) return printf("VinewoodDB >> Tutuklama noktasý bulunamadý.");
	printf("VinewoodDB >> %d tutuklama noktasý yüklendi.", rowcount);
	return true;
}

Vinewood:CreateArrestPoint(playerid, Float: x, Float: y, Float: z)
{
	if(Iter_Count(ArrestPoints) >= MAX_ARREST_POINTS) return SendServerMessage(playerid, "Sunucuda çok fazla tutuklama noktasý var. Daha fazla oluþturulamaz.");
	
	new id = Iter_Free(ArrestPoints), query[128], Cache: InsertData, LabelText[64];

	mysql_format(conn, query, sizeof(query), "INSERT INTO arrestpoints(X, Y, Z, virtualWorld, interior) VALUES(%.4f, %.4f, %.4f, %d, %d)",
		x,
		y,
		z,
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid)
	);
	InsertData = mysql_query(conn, query);

	format(LabelText, sizeof(LabelText), "Tutuklama Noktasý: %d (/tutukla - /hapistencikar)", id);

	ArrestPoint[id][ID] = cache_insert_id();
	ArrestPoint[id][POS][0] = x;
	ArrestPoint[id][POS][1] = y;
	ArrestPoint[id][POS][2] = z;
	ArrestPoint[id][VirtualWorld] = GetPlayerVirtualWorld(playerid);
	ArrestPoint[id][Interior] = GetPlayerInterior(playerid);
	ArrestPoint[id][Pickup] = CreateDynamicPickup(ARREST_POINT_PICKUP, 1, ArrestPoint[id][POS][0], ArrestPoint[id][POS][1], ArrestPoint[id][POS][2], ArrestPoint[id][VirtualWorld], ArrestPoint[id][Interior], -1, STREAMER_PICKUP_SD, -1, 0);
	ArrestPoint[id][TextLabel] = CreateDynamic3DTextLabel(LabelText, -1, ArrestPoint[id][POS][0], ArrestPoint[id][POS][1], ArrestPoint[id][POS][2], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ArrestPoint[id][VirtualWorld], ArrestPoint[id][Interior], -1, 20.0, -1, 0);
	ArrestPoint[id][IsValid] = true;

	Iter_Add(ArrestPoints, id);
	cache_delete(InsertData);
	return true;
}

Vinewood:DestroyArrestPoint(playerid, id)
{
	if(!ArrestPoint[id][IsValid]) return SendServerMessage(playerid, "Geçersiz tutuklama noktasý.");

	new query[64*2], Cache: DeleteCache;

	mysql_format(conn, query, sizeof(query), "DELETE FROM arrestpoints WHERE id = %d", ArrestPoint[id][ID]);
	DeleteCache = mysql_query(conn, query);

	ArrestPoint[id][ID] = -1;
	ArrestPoint[id][POS][0] = 0.0;
	ArrestPoint[id][POS][1] = 0.0;
	ArrestPoint[id][POS][2] = 0.0;
	ArrestPoint[id][VirtualWorld] = -1;
	ArrestPoint[id][Interior] = -1;
	ArrestPoint[id][IsValid] = false;

	DestroyDynamicPickup(ArrestPoint[id][Pickup]);
	DestroyDynamic3DTextLabel(ArrestPoint[id][TextLabel]);
	Iter_Remove(ArrestPoints, id);
	cache_delete(DeleteCache);
	return true;
}

Vinewood:UpdateArrestPoint(playerid, id, Float: X, Float: Y, Float: Z) 
{
	DestroyArrestPoint(playerid, id);
	CreateArrestPoint(playerid, X, Y, Z);
	return true;
}

Vinewood:ClosestArrestPoint(playerid)
{
	new id = 0;
	foreach(new i : ArrestPoints) {
		if(ArrestPoint[i][IsValid]) {
			if(IsPlayerInRangeOfPoint(playerid, 5.0, ArrestPoint[i][POS][0], ArrestPoint[i][POS][1], ArrestPoint[i][POS][2])) {
				id = i;
				break;
			}
		}
	}
	return id;
}

Vinewood:GetClosestPlayer(playerid)
{
	new id = -1, Float: X, Float: Y, Float: Z;
	GetPlayerPos(playerid, X, Y, Z);
	foreach(new i : Player) {
		if(IsPlayerInRangeOfPoint(i, 5.0, X, Y, Z)) {
			if(IsPlayerConnected(i)) {
				id = i;
				break;
			}
		}
	}
	return id;
}

Vinewood:JailTimer(playerid)
{
    Character[playerid][cJailTimeLeft]--;
    if(Character[playerid][cJailTimeLeft] == 0)
    {
        PutOutOfJail(playerid);
    }
    return true;
}

Vinewood:TaserTimer(playerid)
{
	TogglePlayerControllable(playerid, true);
	return true;
}