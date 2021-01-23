CMD:binayarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new name[124], type;
	if(sscanf(params, "ds[124]", type, name))
	{
		SendServerMessage(playerid, "/binayarat [tip] [isim]");
		SendServerMessage(playerid, "0: Yok | 1: LSPD | 2: LSMD | 3: LSFD | 4: LSTV | 5: Los Santos Bank");
	}
	else
	{
		if(!BuildingLimit()) return SendServerMessage(playerid, "Bina limiti aþýldý.");
		if(type < 0 || type > 5) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");

		new Float:myPos[3];
		GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);

		CreateBuilding(name, type, myPos[0], myPos[1], myPos[2]);
		SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir bina yaratýldý.", Character[playerid][cNickname]);
	}
	return true;
}

CMD:binasil(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new bid;
	if(sscanf(params, "d", bid)) return SendServerMessage(playerid, "/binasil [bina id]");
	if(!Building[bid][bIsValid]) return SendServerMessage(playerid, "Geçersiz bina id girdiniz.");

	DeleteBuilding(bid);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir bina kaldýrýldý.", Character[playerid][cNickname]);
	return true;
}

CMD:binaduzenle(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new bid, opt[64], extra[124];
	if(sscanf(params, "ds[64]S()[124]", bid, opt, extra))
	{
		SendServerMessage(playerid, "/binaduzenle [bina id] [seçenek] [yeni deðer]");
		SendServerMessage(playerid, "isim | tip | diskapi | ickapi | kilit");
	}
	else
	{
		if(!Building[bid][bIsValid]) return SendServerMessage(playerid, "Geçersiz bina id girdiniz.");

		if(!strcmp(opt, "isim", true))
		{
			new newname[124];
			if(sscanf(extra, "s[124]", newname)) return SendServerMessage(playerid, "/binaduzenle [bina id] [isim] [yeni isim]");

			format(Building[bid][bName], 124, "%s", newname);
			RefreshBuilding(bid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý binanýn bilgileri güncellendi.", Character[playerid][cNickname], bid);
		}
		else if(!strcmp(opt, "tip", true))
		{
			new type;
			if(sscanf(extra, "d", type)) return SendServerMessage(playerid, "/binaduzenle [bina id] [tip] [yeni tip]");
			if(type < 0 || type > 6) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");

			Building[bid][bType] = type;
			RefreshBuilding(bid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý binanýn bilgileri güncellendi.", Character[playerid][cNickname], bid);
		}
		else if(!strcmp(opt, "diskapi", true))
		{
			new Float:myPos[3];
			GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
			Building[bid][bExtDoor][0] = myPos[0];
			Building[bid][bExtDoor][1] = myPos[1];
			Building[bid][bExtDoor][2] = myPos[2];
			RefreshBuilding(bid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý binanýn bilgileri güncellendi.", Character[playerid][cNickname], bid);
		}
		else if(!strcmp(opt, "ickapi", true))
		{
			new Float:myPos[3], int = GetPlayerInterior(playerid), vw = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
			Building[bid][bIntDoor][0] = myPos[0];
			Building[bid][bIntDoor][1] = myPos[1];
			Building[bid][bIntDoor][2] = myPos[2];
			Building[bid][bInt] = int;
			Building[bid][bVW] = vw;
			RefreshBuilding(bid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý binanýn bilgileri güncellendi.", Character[playerid][cNickname], bid);
		}
		else if(!strcmp(opt, "kilit", true))
		{
			switch(Building[bid][bLocked])
			{
				case 0: Building[bid][bLocked] = 1, SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý binanýn bilgileri güncellendi.", Character[playerid][cNickname], bid);
				case 1: Building[bid][bLocked] = 0, SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý binanýn bilgileri güncellendi.", Character[playerid][cNickname], bid);
			}
		}
	}
	return true;
}

CMD:binaid(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(!BuildingOutDoor(playerid)) return SendServerMessage(playerid, "Yakýnýnýzda bina bulunmuyor.");

	SendServerMessage(playerid, "Bina ID: %d", GetPlayerNearbyBuilding(playerid));
	return true;
}

Vinewood:CreateBuilding(name[], type, Float:x, Float:y, Float:z)
{
	new bid = Iter_Free(Buildings), query[512], Cache:InsertData;

	mysql_format(conn, query, sizeof(query), "INSERT INTO buildings (Name, Type, Exterior_Door_X, Exterior_Door_Y, Exterior_Door_Z, Interior_Door_X, Interior_Door_Y, Interior_Door_Z, Interior, VW, Locked) VALUES ('%e', %i, %.4f, %.4f, %.4f, 0.0, 0.0, 0.0, 0, 0, 0)",
		name, type, x, y, z);
	InsertData = mysql_query(conn, query);

	Building[bid][bID] = cache_insert_id();
	Building[bid][bIsValid] = true;
	format(Building[bid][bName], 124, "%s", name);
	Building[bid][bType] = type;
	Building[bid][bExtDoor][0] = x;
	Building[bid][bExtDoor][1] = y;
	Building[bid][bExtDoor][2] = z;
	Building[bid][bIntDoor][0] = 0.0;
	Building[bid][bIntDoor][1] = 0.0;
	Building[bid][bIntDoor][2] = 0.0;
	Building[bid][bInt] = 0;
	Building[bid][bVW] = 0;
	Building[bid][bLocked] = 0;
	Building[bid][bPickup] = CreateDynamicPickup(1239, 1, Building[bid][bExtDoor][0], Building[bid][bExtDoor][1], Building[bid][bExtDoor][2], 0, 0);
	cache_delete(InsertData);
	Iter_Add(Buildings, bid);
	return true;
}

Vinewood:LoadBuildings()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	Iter_Add(Buildings, 0);

	for(new i = 0; i < rows; i++)
	{
		Building[i+1][bIsValid] = true;

		cache_get_value_name_int(i, "id", Building[i+1][bID]);
		cache_get_value_name(i, "Name", Building[i+1][bName], 124);
		cache_get_value_name_int(i, "Type", Building[i+1][bType]);
		cache_get_value_name_float(i, "Exterior_Door_X", Building[i+1][bExtDoor][0]);
		cache_get_value_name_float(i, "Exterior_Door_Y", Building[i+1][bExtDoor][1]);
		cache_get_value_name_float(i, "Exterior_Door_Z", Building[i+1][bExtDoor][2]);
		cache_get_value_name_float(i, "Interior_Door_X", Building[i+1][bIntDoor][0]);
		cache_get_value_name_float(i, "Interior_Door_Y", Building[i+1][bIntDoor][1]);
		cache_get_value_name_float(i, "Interior_Door_Z", Building[i+1][bIntDoor][2]);
		cache_get_value_name_int(i, "Interior", Building[i+1][bInt]);
		cache_get_value_name_int(i, "VW", Building[i+1][bVW]);
		cache_get_value_name_int(i, "Locked", Building[i+1][bLocked]);

		Building[i+1][bPickup] = CreateDynamicPickup(1239, 1, Building[i+1][bExtDoor][0], Building[i+1][bExtDoor][1], Building[i+1][bExtDoor][2], 0, 0);
		rowcount++;
		Iter_Add(Buildings, i+1);
	}
	if(rowcount == 0) return printf("VinewoodDB >> Bina bulunamadý.");
	printf("VinewoodDB >> %d adet bina yüklendi.", rowcount);
	return true;
}

Vinewood:RefreshBuilding(bid)
{
	if(IsValidDynamicPickup(Building[bid][bPickup]))
		DestroyDynamicPickup(Building[bid][bPickup]);

	Building[bid][bPickup] = CreateDynamicPickup(1239, 1, Building[bid][bExtDoor][0], Building[bid][bExtDoor][1], Building[bid][bExtDoor][2], 0, 0);

	new query[512], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE buildings SET Name = '%e', Type = %i, Exterior_Door_X = %.4f, Exterior_Door_Y = %.4f, Exterior_Door_Z = %.4f, Interior_Door_X = %.4f, Interior_Door_Y = %.4f, Interior_Door_Z = %.4f, Interior = %i, VW = %i, Locked = %i WHERE id = '%i'",
		Building[bid][bName],
		Building[bid][bType],
		Building[bid][bExtDoor][0],
		Building[bid][bExtDoor][1],
		Building[bid][bExtDoor][2],
		Building[bid][bIntDoor][0],
		Building[bid][bIntDoor][1],
		Building[bid][bIntDoor][2],
		Building[bid][bInt],
		Building[bid][bVW],
		Building[bid][bLocked],
	Building[bid][bID]); UpdateData = mysql_query(conn, query);
	cache_delete(UpdateData);
	return true;
}

Vinewood:DeleteBuilding(bid)
{
	if(IsValidDynamicPickup(Building[bid][bPickup]))
		DestroyDynamicPickup(Building[bid][bPickup]);

	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM buildings WHERE id = '%i'", Building[bid][bID]);
	DeleteData = mysql_query(conn, query);
	cache_delete(DeleteData);

	Building[bid][bID] = 0;
	Building[bid][bIsValid] = false;
	Iter_Remove(Buildings, bid);
	return true;
}

Vinewood:GetPlayerNearbyBuilding(playerid)
{
	new bid = 0;
	for(new i; i < MAX_BUILDINGS; i++)
	{
		if(Building[i][bIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Building[i][bExtDoor][0], Building[i][bExtDoor][1], Building[i][bExtDoor][2]) || IsPlayerInRangeOfPoint(playerid, 3.0, Building[i][bIntDoor][0], Building[i][bIntDoor][1], Building[i][bIntDoor][2]))
				bid = i;
		}
	}
	return bid;
}

Vinewood:PlayerCloseToBuilding(playerid)
{
	new status = 0;
	for(new i; i < MAX_BUILDINGS; i++)
	{
		if(Building[i][bIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Building[i][bExtDoor][0], Building[i][bExtDoor][1], Building[i][bExtDoor][2]) ||IsPlayerInRangeOfPoint(playerid, 3.0, Building[i][bIntDoor][0], Building[i][bIntDoor][1], Building[i][bIntDoor][2]))
				status = 1;
		}
	}
	return status;
}

Vinewood:BuildingLimit()
{
	new status = 1;
	for(new i; i < MAX_BUILDINGS; i++)
	{
		if(Building[i][bIsValid])
		{
			if(i == MAX_BUILDINGS)
				status = 0;
		}
	}
	return status;
}

Vinewood:BuildingOutDoor(playerid)
{
	new status = 0;
	for(new i = 0; i < MAX_BUILDINGS; i++)
	{
		if(Building[i][bIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Building[i][bExtDoor][0], Building[i][bExtDoor][1], Building[i][bExtDoor][2]))
				status = 1;
		}
	}
	return status;
}

Vinewood:BuildingIntDoor(playerid)
{
	new status = 0;
	for(new i = 0; i < MAX_BUILDINGS; i++)
	{
		if(Building[i][bIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Building[i][bIntDoor][0], Building[i][bIntDoor][1], Building[i][bIntDoor][2]))
				status = 1;
		}
	}
	return status;
}

Vinewood:GetBuildingType(playerid)
{
	new type = 0;
	for(new i = 0; i < MAX_BUILDINGS; i++)
	{
		if(Building[i][bIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 50.0, Building[i][bIntDoor][0], Building[i][bIntDoor][1], Building[i][bIntDoor][2]))
				type = Building[i][bType];
		}
	}
	return type;
}