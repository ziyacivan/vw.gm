CMD:silahbirak(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	new weaponid, weaponName[24];
	if(sscanf(params, "d", weaponid)) return SendServerMessage(playerid, "/silahbirak [silah id]");
	if(!Weapon[weaponid][wIsValid]) return SendServerMessage(playerid, "Silah bulunamadý.");
	if(Weapon[weaponid][wOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Silah size ait deðil."); 
	if(!ImEquippedWeapon[playerid]) return SendServerMessage(playerid, "Elinizde silah bulunmuyor.");
	if(EquippedWeaponID[playerid] != Weapon[weaponid][wWeaponID]) return SendServerMessage(playerid, "Elinde farklý bir silahý tutuyorsun.");
	PutWeaponDown(playerid, weaponid);
	GetWeaponName(Weapon[weaponid][wWeaponID], weaponName, sizeof(weaponName));
	SendServerMessage(playerid, "%s model silahý yere býraktýnýz.", weaponName);
	return true;
}

CMD:silahsakla(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	new weaponid, weaponName[32];
	if(sscanf(params, "d", weaponid)) return SendServerMessage(playerid, "/silahsakla [silah id]");
	if(!Equipped[weaponid]) return SendServerMessage(playerid, "Bu silah çekilmemiþ.");
	if(!Weapon[weaponid][wIsValid]) return SendServerMessage(playerid, "Silah bulunamadý.");
	if(Weapon[weaponid][wOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Silah size ait deðil.");
	if(!ImEquippedWeapon[playerid]) return SendServerMessage(playerid, "Elinizde silah bulunmuyor.");
	HideWeapon(playerid, weaponid);
	GetWeaponName(Weapon[weaponid][wWeaponID], weaponName, sizeof(weaponName));
	SendServerMessage(playerid, "%s model silahý yerine yerleþtirdiniz.", weaponName);
	return true;
}

CMD:silahcek(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	new weaponid, weaponName[32];
	if(sscanf(params, "d", weaponid)) return SendServerMessage(playerid, "/silahcek [silah id]");
	if(Equipped[weaponid]) return SendServerMessage(playerid, "Bu silah çekilmiþ.");
	if(!Weapon[weaponid][wIsValid]) return SendServerMessage(playerid, "Silah bulunamadý.");
	if(Weapon[weaponid][wOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Silah size ait deðil.");
	if(!Weapon[weaponid][wAmmo]) return SendServerMessage(playerid, "Mermi bulunmuyor.");
	if(EquippedWeapon[playerid] == Weapon[weaponid][wWeaponID]) return SendServerMessage(playerid, "Birbirine benzer silahlarý çekemezsiniz.");
	if(ImEquippedWeapon[playerid]) return SendServerMessage(playerid, "Elinizde silah varken baþka silah çekemezsiniz.");
	if(Smoking[playerid]) return SendServerMessage(playerid, "Elinizde sigara varken silah çekemezsiniz.");
	PutWeaponUp(playerid, weaponid);
	GivePlayerWeapon(playerid, Weapon[weaponid][wWeaponID], Weapon[weaponid][wAmmo]);
	GetWeaponName(Weapon[weaponid][wWeaponID], weaponName, sizeof(weaponName));
	SendServerMessage(playerid, "%s model silahý çektiniz.", weaponName);
	return true;
}

CMD:silahal(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	if(ImEquippedWeapon[playerid]) return SendServerMessage(playerid, "Elinizde silah varken yerden baþka bir silah alamazsýnýz.");
	if(GetPlayerNearbyWeaponID(playerid) == -1) return SendServerMessage(playerid, "Yakýnýnýzda silah bulunmuyor.");
	TakeWeaponFromGround(playerid);
	return true;
}

CMD:silahlarim(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	WeaponList(playerid, playerid);
	return true;
}

CMD:asilahver(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new targetid, weaponid, ammo, query[512], Cache:InsertData;
	if(sscanf(params, "udd", targetid, weaponid, ammo)) return SendServerMessage(playerid, "/asilahver [id/isim] [silah id] [mermi]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	
	switch(weaponid)
	{
		case 0 .. 3: return SendServerMessage(playerid, "Geçersiz silah id girdiniz.");
		case 10 .. 13: return SendServerMessage(playerid, "Geçersiz silah id girdiniz.");
		case 19 .. 21: return SendServerMessage(playerid, "Geçersiz silah id girdiniz.");
		case 26: return SendServerMessage(playerid, "Geçersiz silah id girdiniz.");
		case 35 .. 46: return SendServerMessage(playerid, "Geçersiz silah id girdiniz.");
	}

	mysql_format(conn, query, sizeof(query), "INSERT INTO weapons (Owner, WeaponID, Ammo, On_The_Ground, X, Y, Z, R1, R2, R3, Interior, VW) VALUES (%i, %i, %i, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0)", Character[targetid][cID], weaponid, ammo);
	InsertData = mysql_query(conn, query);

	new wid = Iter_Free(Weapons);

	Weapon[wid][wID] = cache_insert_id();
	Weapon[wid][wIsValid] = true;
	Weapon[wid][wOwner] = Character[targetid][cID];
	Weapon[wid][wWeaponID] = weaponid;
	Weapon[wid][wAmmo] = ammo;
	Weapon[wid][wOnTheGround] = 0;
	Weapon[wid][wPos][0] = 0.0;
	Weapon[wid][wPos][1] = 0.0;
	Weapon[wid][wPos][2] = 0.0;
	Weapon[wid][wRot][0] = 0.0;
	Weapon[wid][wRot][1] = 0.0;
	Weapon[wid][wRot][2] = 0.0;
	Weapon[wid][wInt] = 0;
	Weapon[wid][wVW] = 0;
	Equipped[wid] = false;
	cache_delete(InsertData);

	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %s'e %d model silah verildi.", Character[playerid][cNickname], GetRPName(targetid), weaponid);
	SendServerMessage(targetid, "%s tarafýndan size %d model silah verildi (/silahlarim).", Character[playerid][cNickname], weaponid);
	Iter_Add(Weapons, wid);
	return true;
}

Vinewood:PutWeaponDown(playerid, weaponid)
{
	new Float:myPos[3], int, vw;
	GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
	int = GetPlayerInterior(playerid);
	vw = GetPlayerVirtualWorld(playerid);

	ImEquippedWeapon[playerid] = false;
	Equipped[weaponid] = false;
	EquippedWeapon[playerid] = -1;
	EquippedWeaponID[playerid] = -1;

	Weapon[weaponid][wOwner] = -1;
	Weapon[weaponid][wOnTheGround] = 1;
	Weapon[weaponid][wPos][0] = myPos[0];
	Weapon[weaponid][wPos][1] = myPos[1];
	Weapon[weaponid][wPos][2] = myPos[2];
	Weapon[weaponid][wRot][0] = 90.0;
	Weapon[weaponid][wRot][1] = 0.0;
	Weapon[weaponid][wRot][2] = 0.0;
	Weapon[weaponid][wInt] = int;
	Weapon[weaponid][wVW] = vw;
	Weapon[weaponid][wAmmo] = GetPlayerAmmo(playerid);

	switch(Weapon[weaponid][wWeaponID])
	{
		case 4: Weapon[weaponid][wTempObject] = CreateDynamicObject(335, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 5: Weapon[weaponid][wTempObject] = CreateDynamicObject(336, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 6: Weapon[weaponid][wTempObject] = CreateDynamicObject(337, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 7: Weapon[weaponid][wTempObject] = CreateDynamicObject(338, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 8: Weapon[weaponid][wTempObject] = CreateDynamicObject(339, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 9: Weapon[weaponid][wTempObject] = CreateDynamicObject(341, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 14: Weapon[weaponid][wTempObject] = CreateDynamicObject(325, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 15: Weapon[weaponid][wTempObject] = CreateDynamicObject(326, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 16: Weapon[weaponid][wTempObject] = CreateDynamicObject(342, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 17: Weapon[weaponid][wTempObject] = CreateDynamicObject(343, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 18: Weapon[weaponid][wTempObject] = CreateDynamicObject(344, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 22: Weapon[weaponid][wTempObject] = CreateDynamicObject(346, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 23: Weapon[weaponid][wTempObject] = CreateDynamicObject(347, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 24: Weapon[weaponid][wTempObject] = CreateDynamicObject(348, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 25: Weapon[weaponid][wTempObject] = CreateDynamicObject(349, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 27: Weapon[weaponid][wTempObject] = CreateDynamicObject(351, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 28: Weapon[weaponid][wTempObject] = CreateDynamicObject(352, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 29: Weapon[weaponid][wTempObject] = CreateDynamicObject(353, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 30: Weapon[weaponid][wTempObject] = CreateDynamicObject(355, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 31: Weapon[weaponid][wTempObject] = CreateDynamicObject(356, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 32: Weapon[weaponid][wTempObject] = CreateDynamicObject(372, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 33: Weapon[weaponid][wTempObject] = CreateDynamicObject(357, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
		case 34: Weapon[weaponid][wTempObject] = CreateDynamicObject(358, Weapon[weaponid][wPos][0], Weapon[weaponid][wPos][1], Weapon[weaponid][wPos][2]-0.95, Weapon[weaponid][wRot][0], Weapon[weaponid][wRot][1], Weapon[weaponid][wRot][2], Weapon[weaponid][wVW], Weapon[weaponid][wInt]);
	}
	ResetPlayerWeapons(playerid);
	RefreshWeapon(weaponid);
	return true;
}

Vinewood:TakeWeaponFromGround(playerid)
{
	new weaponid = GetPlayerNearbyWeaponID(playerid), weaponName[32];

	ImEquippedWeapon[playerid] = true;
	Equipped[weaponid] = true;
	EquippedWeapon[playerid] = weaponid;
	EquippedWeaponID[playerid] = Weapon[weaponid][wWeaponID];

	Weapon[weaponid][wOwner] = Character[playerid][cID];
	Weapon[weaponid][wOnTheGround] = 0;
	Weapon[weaponid][wPos][0] = 0.0;
	Weapon[weaponid][wPos][1] = 0.0;
	Weapon[weaponid][wPos][2] = 0.0;
	Weapon[weaponid][wRot][0] = 0.0;
	Weapon[weaponid][wRot][1] = 0.0;
	Weapon[weaponid][wRot][2] = 0.0;
	Weapon[weaponid][wInt] = GetPlayerInterior(playerid);
	Weapon[weaponid][wVW] = GetPlayerVirtualWorld(playerid);

	DestroyDynamicObject(Weapon[weaponid][wTempObject]);
	GivePlayerWeapon(playerid, Weapon[weaponid][wWeaponID], Weapon[weaponid][wAmmo]);

	GetWeaponName(weaponid, weaponName, sizeof(weaponName));
	RefreshWeapon(weaponid);
	SendServerMessage(playerid, "%s model silahý yerden aldýnýz.", weaponName);
	return true;
}

Vinewood:PutWeaponUp(playerid, weaponid)
{
	ImEquippedWeapon[playerid] = true;
	Equipped[weaponid] = true;
	EquippedWeapon[playerid] = weaponid;
	EquippedWeaponID[playerid] = Weapon[weaponid][wWeaponID];
	return true;
}

Vinewood:HideWeapon(playerid, weaponid)
{
	ImEquippedWeapon[playerid] = false;
	Equipped[weaponid] = false;
	EquippedWeapon[playerid] = -1;
	EquippedWeaponID[playerid] = -1;
	Weapon[weaponid][wAmmo] = GetPlayerAmmo(playerid);
	ResetPlayerWeapons(playerid);
	RefreshWeapon(weaponid);
	return true;
}

Vinewood:WeaponList(playerid, targetid)
{
	new count = 0;
	for(new i; i < MAX_WEAPONS; i++)
	{
		if(Weapon[i][wIsValid] && Weapon[i][wOwner] == Character[playerid][cID])
		{
			new weaponName[24], equippedStatus[32];
			switch(Equipped[i])
			{
				case false: equippedStatus = "Çekilmemiþ";
				case true: equippedStatus = "Çekilmiþ";
			}
			GetWeaponName(Weapon[i][wWeaponID], weaponName, sizeof(weaponName));
			SendServerMessage(targetid, "ID: [%d] | Model: [%s] | Mermi: [%d] | Durum: [%s]", i, weaponName, Weapon[i][wAmmo], equippedStatus);
			count++;
		}
	}
	if(count == 0) return SendServerMessage(targetid, "Silah bulunamadý.");
	return true;
}

Vinewood:LoadWeapons()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	Iter_Add(Weapons, 0);

	for(new i; i < rows; i++)
	{
		Weapon[i+1][wIsValid] = true;

		cache_get_value_name_int(i, "id", Weapon[i+1][wID]);
		cache_get_value_name_int(i, "Owner", Weapon[i+1][wOwner]);
		cache_get_value_name_int(i, "WeaponID", Weapon[i+1][wWeaponID]);
		cache_get_value_name_int(i, "Ammo", Weapon[i+1][wAmmo]);
		cache_get_value_name_int(i, "On_The_Ground", Weapon[i+1][wOnTheGround]);
		cache_get_value_name_float(i, "X", Weapon[i+1][wPos][0]);
		cache_get_value_name_float(i, "Y", Weapon[i+1][wPos][1]);
		cache_get_value_name_float(i, "Z", Weapon[i+1][wPos][2]);
		cache_get_value_name_float(i, "R1", Weapon[i+1][wRot][0]);
		cache_get_value_name_float(i, "R2", Weapon[i+1][wRot][1]);
		cache_get_value_name_float(i, "R3", Weapon[i+1][wRot][2]);
		cache_get_value_name_int(i, "Interior", Weapon[i+1][wInt]);
		cache_get_value_name_int(i, "VW", Weapon[i+1][wVW]);

		if(Weapon[i+1][wOnTheGround] && Weapon[i+1][wOwner] == -1)
		{
			switch(Weapon[i+1][wWeaponID])
			{
				case 4: Weapon[i+1][wTempObject] = CreateDynamicObject(335, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 5: Weapon[i+1][wTempObject] = CreateDynamicObject(336, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 6: Weapon[i+1][wTempObject] = CreateDynamicObject(337, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 7: Weapon[i+1][wTempObject] = CreateDynamicObject(338, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 8: Weapon[i+1][wTempObject] = CreateDynamicObject(339, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 9: Weapon[i+1][wTempObject] = CreateDynamicObject(341, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 14: Weapon[i+1][wTempObject] = CreateDynamicObject(325, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 15: Weapon[i+1][wTempObject] = CreateDynamicObject(326, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 16: Weapon[i+1][wTempObject] = CreateDynamicObject(342, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 17: Weapon[i+1][wTempObject] = CreateDynamicObject(343, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 18: Weapon[i+1][wTempObject] = CreateDynamicObject(344, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 22: Weapon[i+1][wTempObject] = CreateDynamicObject(346, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 23: Weapon[i+1][wTempObject] = CreateDynamicObject(347, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 24: Weapon[i+1][wTempObject] = CreateDynamicObject(348, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 25: Weapon[i+1][wTempObject] = CreateDynamicObject(349, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 27: Weapon[i+1][wTempObject] = CreateDynamicObject(351, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 28: Weapon[i+1][wTempObject] = CreateDynamicObject(352, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 29: Weapon[i+1][wTempObject] = CreateDynamicObject(353, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 30: Weapon[i+1][wTempObject] = CreateDynamicObject(355, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 31: Weapon[i+1][wTempObject] = CreateDynamicObject(356, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 32: Weapon[i+1][wTempObject] = CreateDynamicObject(372, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 33: Weapon[i+1][wTempObject] = CreateDynamicObject(357, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
				case 34: Weapon[i+1][wTempObject] = CreateDynamicObject(358, Weapon[i+1][wPos][0], Weapon[i+1][wPos][1], Weapon[i+1][wPos][2]-0.95, Weapon[i+1][wRot][0], Weapon[i+1][wRot][1], Weapon[i+1][wRot][2], Weapon[i+1][wVW], Weapon[i+1][wInt]);
			}
		}
		rowcount++;
		Iter_Add(Weapons, i+1);
	}
	if(rowcount == 0) return printf("VinewoodDB >> Silah bulunamadý.");
	printf("VinewoodDB >> %d adet silah yüklendi.", rowcount);
	return true;
}

Vinewood:DeleteWeapon(wid)
{
	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM weapons WHERE id = '%i'", Weapon[wid][wID]);
	DeleteData = mysql_query(conn, query);
	cache_delete(DeleteData);

	Weapon[wid][wID] = 0;
	Weapon[wid][wIsValid] = false;
	Weapon[wid][wOwner] = 0;
	Weapon[wid][wOnTheGround] = 0;
	Iter_Remove(Weapons, wid);
	return true;
}

Vinewood:RefreshWeapon(wid)
{
	new query[512], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE weapons SET Owner = %i, WeaponID = %i, Ammo = %i, On_The_Ground = %i, X = %.4f, Y = %.4f, Z = %.4f, R1 = %.4f, R2 = %.4f, R3 = %.4f, Interior = %i, VW = %i WHERE id = '%i'",
		Weapon[wid][wOwner],
		Weapon[wid][wWeaponID],
		Weapon[wid][wAmmo],
		Weapon[wid][wOnTheGround],
		Weapon[wid][wPos][0],
		Weapon[wid][wPos][1],
		Weapon[wid][wPos][2],
		Weapon[wid][wRot][0],
		Weapon[wid][wRot][1],
		Weapon[wid][wRot][2],
		Weapon[wid][wInt],
		Weapon[wid][wVW],
	Weapon[wid][wID]); UpdateData = mysql_query(conn, query);
	cache_delete(UpdateData);
	return true;
}

Vinewood:GetPlayerNearbyWeaponID(playerid)
{
	new weaponid = -1;
	for(new i; i < MAX_WEAPONS; i++)
	{
		if(Weapon[i][wIsValid] && IsPlayerInRangeOfPoint(playerid, 3.0, Weapon[i][wPos][0], Weapon[i][wPos][1], Weapon[i][wPos][2]))
			weaponid = i;
	}
	return weaponid;
}