Vinewood:CheckCharacter(playerid)
{
	new query[128], Cache:CheckData;
	mysql_format(conn, query, sizeof(query), "SELECT id FROM characters WHERE Nickname = '%e' LIMIT 1", GetName(playerid));
	CheckData = mysql_query(conn, query);

	if(cache_num_rows() != 0)
	{
		Dialog_Show(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "Vinewood Roleplay", "Merhaba, Vinewood Roleplay'e hoþgeldiniz.\nAltta yer alan kutucuða þifrenizi girerek giriþ yapýn:", "Giriþ", "Çýkýþ");
	}
	else
	{
		SendClientMessageEx(playerid, C_VINEWOOD, "Merhaba %s! Ne yazýk ki Vinewood Roleplay veritabanýnda karakteriniz bulunamadý.", GetName(playerid));
		SendClientMessageEx(playerid, C_VINEWOOD, "Eðer bir hata olduðunu düþünüyorsan ya da baþvuru göndermek isterseniz web sitemizi ziyaret edin.");
		SendClientMessageEx(playerid, C_VINEWOOD, "Baðlantý adresi: www.vw-rp.com");
		KickEx(playerid);
	}
	cache_delete(CheckData);
	return true;
}

Vinewood:SaveCharacterData(playerid)
{
	if(LoggedIn[playerid] == false) return false;
	Character[playerid][cInt] = GetPlayerInterior(playerid);
	Character[playerid][cVW] = GetPlayerVirtualWorld(playerid);
	GetPlayerHealth(playerid, Character[playerid][cHP]);
	GetPlayerArmour(playerid, Character[playerid][cArmour]);
	GetPlayerPos(playerid, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2]);
	GetPlayerFacingAngle(playerid, Character[playerid][cPos][3]);
	Character[playerid][cSkin] = GetPlayerSkin(playerid);

	if(Boombox[playerid])
	{
		new id = -1;

		foreach(new i : Boomboxes) {
			if(BoomboxData[i][Owner] == playerid) {
				id = i;
				break;
			}
		}

		if(id != -1) 
		{
			foreach(new i : Player) {
				if(IsPlayerInRangeOfPoint(i, BOOMBOX_RANGE, BoomboxData[id][POS][0], BoomboxData[id][POS][1], BoomboxData[id][POS][2])) {
					StopAudioStreamForPlayer(playerid);
				}
			}

			BoomboxData[id][URL] = EOS;
			BoomboxData[id][Owner] = INVALID_PLAYER_ID;
			BoomboxData[id][POS][0] = 0;
			BoomboxData[id][POS][1] = 0;
			BoomboxData[id][POS][2] = 0;
			Boombox[playerid] = 0;

			DestroyDynamic3DTextLabel(BoomboxData[id][Label]);
			DestroyDynamicArea(BoomboxData[id][Circle]);
			DestroyDynamicObject(BoomboxData[id][Object]);

			Iter_Remove(Boomboxes, id);
		}
	}

	new query[1024];
	mysql_format(conn, query, sizeof(query), "UPDATE characters SET Admin = %i, Nickname = '%e', Character_Name = '%e', Password = '%e', Created = %i, Age = %i, Sex = %i, SkinColor = %i, Origin = %i, Skin = %i, Interior = %i, VW = %i, HP = %.4f, Armour = %.4f, X = %.4f, Y = %.4f, Z = %.4f, A = %.4f, Money = %i, Level = %i, Hour = %i, Minute = %i, Identity = %i WHERE id = '%i'",
		Character[playerid][cAdmin],
		Character[playerid][cNickname],
		Character[playerid][cName],
		Character[playerid][cPassword],
		Character[playerid][cCreated],
		Character[playerid][cAge],
		Character[playerid][cSex],
		Character[playerid][cSkinColor],
		Character[playerid][cOrigin],
		Character[playerid][cSkin],
		Character[playerid][cInt],
		Character[playerid][cVW],
		Character[playerid][cHP],
		Character[playerid][cArmour],
		Character[playerid][cPos][0],
		Character[playerid][cPos][1],
		Character[playerid][cPos][2],
		Character[playerid][cPos][3],
		Character[playerid][cMoney],
		Character[playerid][cLevel],
		Character[playerid][cHour],
		Character[playerid][cMinute],
		Character[playerid][cIdentity],
	Character[playerid][cID]); mysql_query(conn, query, false);

	mysql_format(conn, query, sizeof(query), "UPDATE characters SET Ban = %i, Warn = %i, Tenant_House_ID = %i, Tenant_Price = %i, Bank_Account_No = %i, Bank_Cash = %i, Bank_Saving = %i, Faction = %i, FactionRank = %i, Cuffed = %i, Jail = %d, JailTimeLeft = %d, OldSkin = %d, Cigaratte = %i, Lighter = %i, Boombox = %i, Toolkit = %i, Bat = %i, Flower = %i WHERE id = '%i'", 
		Character[playerid][cBan],
		Character[playerid][cWarn],
		Character[playerid][cTenantHouseID],
		Character[playerid][cTenantPrice],
		Character[playerid][cBankAccountNo],
		Character[playerid][cBankCash],
		Character[playerid][cBankSaving],
		Character[playerid][cFaction],
		Character[playerid][cFactionRank],
		Character[playerid][cCuffed],
		Character[playerid][cJail],
		Character[playerid][cJailTimeLeft],
		Character[playerid][cOldSkin],
		Character[playerid][cCigaratte],
		Character[playerid][cLighter],
		Character[playerid][cBoombox],
		Character[playerid][cToolkit],
		HaveBat[playerid],
		HaveFlower[playerid],
	Character[playerid][cID]); mysql_query(conn, query, false);

	mysql_format(conn, query, sizeof(query), "UPDATE characters SET IsDead = %d, KillerPlayer = %d, KillerWeapon = %d, KilledAt = '%e', DeathSecondsLeft = %d WHERE id = %d",
		Character[playerid][cIsDead],
		Character[playerid][cKillerPlayer],
		Character[playerid][cKillerWeapon],
		Character[playerid][cKilledAt],
		Character[playerid][cDeathSecondsLeft],
	Character[playerid][cID]); mysql_query(conn, query, false);

	mysql_format(conn, query, sizeof(query), "UPDATE characters SET SkeletonKey = %i, Phone = %i, PhoneNumber = %i, AccSlot1 = %i, AccSlot2 = %i, AccSlot3 = %i, AccSlot4 = %i, AccSlot5 = %i, AccSlot6 = %i, AccSlot7 = %i, AccSlot8 = %i, AccSlot9 = %i, AccSlot10 = %i WHERE id = '%i'",
		Character[playerid][cSkeletonKey],
		Character[playerid][cPhone],
		Character[playerid][cPhoneNumber],
		Character[playerid][cAcc][0],
		Character[playerid][cAcc][1],
		Character[playerid][cAcc][2],
		Character[playerid][cAcc][3],
		Character[playerid][cAcc][4],
		Character[playerid][cAcc][5],
		Character[playerid][cAcc][6],
		Character[playerid][cAcc][7],
		Character[playerid][cAcc][8],
		Character[playerid][cAcc][9],
	Character[playerid][cID]); mysql_query(conn, query, false);
	return true;
}

Vinewood:LoadCharacterData(playerid)
{
	new query[1024], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM characters WHERE id = %d LIMIT 1", Character[playerid][cID]);
	GetData = mysql_query(conn, query);

	if(cache_num_rows())
	{
		LoggedIn[playerid] = true;
		cache_get_value_name_int(0, "id", Character[playerid][cID]);
		cache_get_value_name_int(0, "Admin", Character[playerid][cAdmin]);
		cache_get_value_name(0, "Nickname", Character[playerid][cNickname], 124);
		cache_get_value_name(0, "Character_Name", Character[playerid][cName], 124);
		cache_get_value_name(0, "Password", Character[playerid][cPassword], 124);
		cache_get_value_name_int(0, "Created", Character[playerid][cCreated]);
		cache_get_value_name_int(0, "Age", Character[playerid][cAge]);
		cache_get_value_name_int(0, "Sex", Character[playerid][cSex]);
		cache_get_value_name_int(0, "SkinColor", Character[playerid][cSkinColor]);
		cache_get_value_name_int(0, "Origin", Character[playerid][cOrigin]);
		cache_get_value_name_int(0, "Skin", Character[playerid][cSkin]);
		cache_get_value_name_int(0, "Interior", Character[playerid][cInt]);
		cache_get_value_name_int(0, "VW", Character[playerid][cVW]);
		cache_get_value_name_float(0, "HP", Character[playerid][cHP]);
		cache_get_value_name_float(0, "Armour", Character[playerid][cArmour]);
		cache_get_value_name_float(0, "X", Character[playerid][cPos][0]);
		cache_get_value_name_float(0, "Y", Character[playerid][cPos][1]);
		cache_get_value_name_float(0, "Z", Character[playerid][cPos][2]);
		cache_get_value_name_float(0, "A", Character[playerid][cPos][3]);
		cache_get_value_name_int(0, "Money", Character[playerid][cMoney]);
		cache_get_value_name_int(0, "Level", Character[playerid][cLevel]);
		cache_get_value_name_int(0, "Hour", Character[playerid][cHour]);
		cache_get_value_name_int(0, "Minute", Character[playerid][cMinute]);
		cache_get_value_name_int(0, "Identity", Character[playerid][cIdentity]);
		cache_get_value_name_int(0, "Ban", Character[playerid][cBan]);
		cache_get_value_name_int(0, "Warn", Character[playerid][cWarn]);
		cache_get_value_name_int(0, "Tenant_House_ID", Character[playerid][cTenantHouseID]);
		cache_get_value_name_int(0, "Tenant_Price", Character[playerid][cTenantPrice]);
		cache_get_value_name_int(0, "Bank_Account_No", Character[playerid][cBankAccountNo]);
		cache_get_value_name_int(0, "Bank_Cash", Character[playerid][cBankCash]);
		cache_get_value_name_int(0, "Bank_Saving", Character[playerid][cBankSaving]);
		cache_get_value_name_int(0, "Faction", Character[playerid][cFaction]);
		cache_get_value_name_int(0, "FactionRank", Character[playerid][cFactionRank]);
		cache_get_value_name_int(0, "Cuffed", Character[playerid][cCuffed]);
		cache_get_value_name_int(0, "Jail", Character[playerid][cJail]);
		cache_get_value_name_int(0, "JailTimeLeft", Character[playerid][cJailTimeLeft]);
		cache_get_value_name_int(0, "OldSkin", Character[playerid][cOldSkin]);
		cache_get_value_name_int(0, "Cigaratte", Character[playerid][cCigaratte]);
		cache_get_value_name_int(0, "Lighter", Character[playerid][cLighter]);
		cache_get_value_name_int(0, "Boombox", Character[playerid][cBoombox]);
		cache_get_value_name_int(0, "Toolkit", Character[playerid][cToolkit]);
		cache_get_value_name_int(0, "SkeletonKey", Character[playerid][cSkeletonKey]);
		cache_get_value_name_int(0, "Bat", HaveBat[playerid]);
		cache_get_value_name_int(0, "Flower", HaveFlower[playerid]);
		cache_get_value_name_int(0, "IsDead", Character[playerid][cIsDead]);
		cache_get_value_name_int(0, "KillerPlayer", Character[playerid][cKillerPlayer]);
		cache_get_value_name_int(0, "KillerWeapon", Character[playerid][cKillerWeapon]);
		cache_get_value_name(0, "KilledAt", Character[playerid][cKilledAt], 64);
		cache_get_value_name_int(0, "DeathSecondsLeft", Character[playerid][cDeathSecondsLeft]);
		cache_get_value_name_int(0, "Phone", Character[playerid][cPhone]);
		cache_get_value_name_int(0, "PhoneNumber", Character[playerid][cPhoneNumber]);
		cache_get_value_name_int(0, "AccSlot1", Character[playerid][cAcc][0]);
		cache_get_value_name_int(0, "AccSlot2", Character[playerid][cAcc][1]);
		cache_get_value_name_int(0, "AccSlot3", Character[playerid][cAcc][2]);
		cache_get_value_name_int(0, "AccSlot4", Character[playerid][cAcc][3]);
		cache_get_value_name_int(0, "AccSlot5", Character[playerid][cAcc][4]);
		cache_get_value_name_int(0, "AccSlot6", Character[playerid][cAcc][5]);
		cache_get_value_name_int(0, "AccSlot7", Character[playerid][cAcc][6]);
		cache_get_value_name_int(0, "AccSlot8", Character[playerid][cAcc][7]);
		cache_get_value_name_int(0, "AccSlot9", Character[playerid][cAcc][8]);
		cache_get_value_name_int(0, "AccSlot10", Character[playerid][cAcc][9]);

		if(Character[playerid][cBan] == 1)
		{
			SendClientMessageEx(playerid, C_ADMIN, "Merhaba %s, veritabanýmýzdan karakteriniz yasaklanmýþtýr.", GetName(playerid));
			SendClientMessageEx(playerid, C_ADMIN, "Eðer bir hata olduðunu düþünüyorsanýz ya da ban affý talebi için web sitemizi ziyaret edin.");
			SendClientMessageEx(playerid, C_ADMIN, "Baðlantý adresi: www.vw-rp.com");
			KickEx(playerid);
			return true;
		}

		if(!Character[playerid][cIdentity])
		{
			new newidentity = randomEx(111111, 999999);
			Character[playerid][cIdentity] = newidentity;
		}

		if(!Character[playerid][cBankAccountNo])
		{
			new newbankno = randomEx(1111111, 9999999);
			Character[playerid][cBankAccountNo] = newbankno;
		}

		if(!Character[playerid][cCreated])
		{
			Dialog_Show(playerid, D_CREATE1, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay", "{FFFFFF}Karakterinizi henüz yaratmadýnýz, bu nedenle karakter yaratma ekranýna yönlendiriliyorsunuz.", "Devam Et", "Çýkýþ");
			return true;
		}

		if(Character[playerid][cJail] == 1)
		{
			PutInJail(playerid, Character[playerid][cJailTimeLeft]);
			Character[playerid][cJailTimer] = SetTimerEx("JailTimer", 1000, true, "d", playerid);
		}

		if(Character[playerid][cCuffed])
		{
			Cuffed[playerid] = 1;
	        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
	        SetPlayerAttachedObject(playerid, 8, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
		}

		SetCharacterFirstSpawn(playerid);
	}
	cache_delete(GetData);
	return true;
}

Vinewood:ResetCharacterData(playerid)
{
	LoggedIn[playerid] = false;
	ResetPlayerWeapons(playerid);
	
	PassWarn[playerid] = 0;
	PMBlock[playerid] = false;
	Awork[playerid] = false;
	Muted[playerid] = false;
	SpecMode[playerid] = false;
	SpecModeInt[playerid] = 0;
	SpecModeVW[playerid] = 0;
	OnAnim[playerid] = false;
	OfferMode[playerid] = false;
	OfferBusinessID[playerid] = 0;
	OfferBusinessPrice[playerid] = 0;
	OfferHouseID[playerid] = 0;
	OfferHousePrice[playerid] = 0;
	OfferOwnerID[playerid] = -1;
	OfferRentPrice[playerid] = 0;
	OfferVehicleID[playerid] = 0;
	OfferVehiclePrice[playerid] = 0;
	EquippedWeapon[playerid] = 0;
	EquippedWeaponID[playerid] = -1;
	ImEquippedWeapon[playerid] = false;
	CallTimer[playerid] = 0;
	UsageVehiclePark[playerid] = 0;
	IsCreatingFurniture[playerid] = 0;
	CreatingFurniture[playerid] = 0;
	FactionInviteID[playerid] = 0;
	FactionInviteMode[playerid] = false;
	TakeTaser[playerid] = 0;
	Cuffed[playerid] = 0;
	TakeBarricade[playerid] = 0;
	Gallery_FirstColor[playerid] = -1;
	Gallery_SecondColor[playerid] = -1;
	TakeBeanbag[playerid] = 0;
	HaveMask[playerid] = 0;
	UseMask[playerid] = 0;
	HaveBat[playerid] = 0;
	UseBat[playerid] = 0;
	HaveFlower[playerid] = 0;
	UseFlower[playerid] = 0;
	Boombox[playerid] = 0;
	FDWork[playerid] = 0;
	InCall[playerid] = 0;
	InCall_Line[playerid] = 0;
	Smoking[playerid] = 0;
	IsSendSearchOffer[playerid] = -1;
	SearchOfferSender[playerid] = -1;
	EditingCategory[playerid] = 0;

	Character[playerid][cAdmin] = 0;
	Character[playerid][cCreated] = 0;
	Character[playerid][cAge] = 0;
	Character[playerid][cSex] = 0;
	Character[playerid][cSkinColor] = 0;
	Character[playerid][cOrigin] = 0;
	Character[playerid][cSkin] = 1;
	Character[playerid][cInt] = 0;
	Character[playerid][cVW] = 0;
	Character[playerid][cHP] = 100.0;
	Character[playerid][cArmour] = 0;
	Character[playerid][cPos][0] = 0.0;
	Character[playerid][cPos][1] = 0.0;
	Character[playerid][cPos][2] = 0.0;
	Character[playerid][cPos][3] = 0.0;
	Character[playerid][cMoney] = 0;
	Character[playerid][cLevel] = 1;
	Character[playerid][cHour] = 0;
	Character[playerid][cMinute] = 0;
	Character[playerid][cSecond] = 0;
	Character[playerid][cIdentity] = 0;
	Character[playerid][cBan] = 0;
	Character[playerid][cWarn] = 0;
	Character[playerid][cAsked] = false;
	Character[playerid][cReported] = false;
	Character[playerid][cTenantHouseID] = -1;
	Character[playerid][cTenantPrice] = 0;
	Character[playerid][cBankAccountNo] = 0;
	Character[playerid][cBankCash] = 0;
	Character[playerid][cBankSaving] = 0;
	Character[playerid][cFaction] = 0;
	Character[playerid][cFactionRank] = 0;
	Character[playerid][cCuffed] = 0;
	Character[playerid][cJail] = 0;
	Character[playerid][cJailTimer] = 0;
	Character[playerid][cJailTimeLeft] = 0;
	Character[playerid][cOldSkin] = 1;
	Character[playerid][cTaserTimer] = 0;
	Character[playerid][cCigaratte] = 0;
	Character[playerid][cLighter] = 0;
	Character[playerid][cPhone] = 0;
	Character[playerid][cPhoneNumber] = 0;
	Character[playerid][cBoombox] = 0;
	Character[playerid][cToolkit] = 0;
	Character[playerid][cSkeletonKey] = 0;
	Character[playerid][cPhone] = 0;
	Character[playerid][cPhoneNumber] = 0;
	Character[playerid][cAcc][0] = 0;
	Character[playerid][cAcc][1] = 0;
	Character[playerid][cAcc][2] = 0;
	Character[playerid][cAcc][3] = 0;
	Character[playerid][cAcc][4] = 0;
	Character[playerid][cAcc][5] = 0;
	Character[playerid][cAcc][6] = 0;
	Character[playerid][cAcc][7] = 0;
	Character[playerid][cAcc][8] = 0;
	Character[playerid][cAcc][9] = 0;
	return true;
}

Vinewood:SetCharacterFirstSpawn(playerid)
{
	SetPlayerName(playerid, Character[playerid][cName]);

	if(PDWork[playerid])
    {
    	SetPlayerColor(playerid, C_FACTION);
    	GivePlayerWeapon(playerid, 3, 1); // nightstick
		GivePlayerWeapon(playerid, 24, 9999); /// deagle
		GivePlayerWeapon(playerid, 41, 9999);
    }
    else
    {
    	SetPlayerColor(playerid, C_WHITE);
    	ResetPlayerWeapons(playerid);
    }

    if(FDWork[playerid])
    {
    	SetPlayerColor(playerid, C_FIREDEPARTMENT);
    }
    else
    {
    	SetPlayerColor(playerid, C_WHITE);
    }
	
	TogglePlayerSpectating(playerid, false);

	ResetPlayerMoney(playerid); GivePlayerMoney(playerid, Character[playerid][cMoney]);
	SetPlayerHealth(playerid, Character[playerid][cHP]);
	SetPlayerArmour(playerid, Character[playerid][cArmour]);
	SetPlayerInterior(playerid, Character[playerid][cInt]);
	SetPlayerVirtualWorld(playerid, Character[playerid][cVW]);
	SetSpawnInfo(playerid, NO_TEAM, Character[playerid][cSkin], Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2], Character[playerid][cPos][3], 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	return true;
}

Dialog:D_LOGIN(playerid, response, listitem, inputtext[])
{
	if(!response) return KickEx(playerid);

	new query[128], Cache:CheckData;
	mysql_format(conn, query, sizeof(query), "SELECT id FROM characters WHERE Nickname = '%e' AND Password = sha1('%e') LIMIT 1", GetName(playerid), inputtext);
	CheckData = mysql_query(conn, query);

	if(cache_num_rows() == 0)
	{
		if(PassWarn[playerid] == 3) return SendClientMessageEx(playerid, C_VINEWOOD, "Þifre deneme sýnýrýný aþmanýz sebebiyle sunucudan atýldýnýz. (%d/3)", PassWarn[playerid]), KickEx(playerid);
		PassWarn[playerid]++;
		SendClientMessageEx(playerid, C_VINEWOOD, "Hatalý þifre girdiniz, lütfen tekrar deneyin. (%d/3)", PassWarn[playerid]);
		Dialog_Show(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "Vinewood Roleplay", "{FFFFFF}Merhaba, Vinewood Roleplay'e hoþgeldiniz.\n{FFFFFF}Altta yer alan kutucuða þifrenizi girerek giriþ yapýn:", "Giriþ", "Çýkýþ");
	}
	else
	{
		SendClientMessageEx(playerid, C_VINEWOOD, "Los Santos'a tekrar hoþgeldiniz %s!", GetRPName(playerid));
		SendClientMessageEx(playerid, C_VINEWOOD, "Karakteriniz yükleniyor, lütfen bekleyin.");

		cache_get_value_name_int(0, "id", Character[playerid][cID]);
		LoadCharacterData(playerid);
	}
	cache_delete(CheckData);
	return true;
}

Dialog:D_CREATE1(playerid, response, listitem, inputtext[])
{
	if(!response) return KickEx(playerid);

	Dialog_Show(playerid, D_CREATE2, DIALOG_STYLE_INPUT, "Vinewood Roleplay", "{FFFFFF}Lütfen karakteriniz için bir yaþ seçin (18-75):", "Devam Et", "Geri");
	return true;
}

Dialog:D_CREATE2(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_CREATE1, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay", "{FFFFFF}Karakterinizi henüz yaratmadýnýz, bu nedenle karakter yaratma ekranýna yönlendiriliyorsunuz.", "Devam Et", "Çýkýþ");
	if(strval(inputtext) < 18 || strval(inputtext) > 75) return SendServerMessage(playerid, "Hatalý yaþ formatý! (18-75)"), Dialog_Show(playerid, D_CREATE2, DIALOG_STYLE_INPUT, "Vinewood Roleplay", "{FFFFFF}Lütfen karakteriniz için bir yaþ seçin (18-75):", "Devam Et", "Geri");

	Character[playerid][cAge] = strval(inputtext);
	SendServerMessage(playerid, "Karakterinizin yaþýný %d olarak belirlediniz.", Character[playerid][cAge]);
	Dialog_Show(playerid, D_CREATE3, DIALOG_STYLE_LIST, "Vinewood Roleplay", "{FFFFFF}Erkek\n{FFFFFF}Kadýn", "Devam Et", "Geri");
	return true;
}

Dialog:D_CREATE3(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_CREATE2, DIALOG_STYLE_INPUT, "Vinewood Roleplay", "{FFFFFF}Lütfen karakteriniz için bir yaþ seçin (18-75):", "Devam Et", "Geri");

	switch(listitem)
	{
		case 0: Character[playerid][cSex] = 1, SendServerMessage(playerid, "Karakterinizin cinsiyetini erkek olarak belirlediniz.");
		case 1: Character[playerid][cSex] = 2, SendServerMessage(playerid, "Karakterinizin cinsiyetini kadýn olarak belirlediniz.");
	}

	Dialog_Show(playerid, D_CREATE4, DIALOG_STYLE_LIST, "Vinewood Roleplay", "{FFFFFF}Beyaz\n{FFFFFF}Siyahi", "Devam Et", "Geri");
	return true;
}

Dialog:D_CREATE4(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_CREATE3, DIALOG_STYLE_LIST, "Vinewood Roleplay", "{FFFFFF}Erkek\n{FFFFFF}Kadýn", "Devam Et", "Geri");

	switch(listitem)
	{
		case 0: Character[playerid][cSkinColor] = 1, SendServerMessage(playerid, "Karakterinizin ten rengini beyaz olarak belirlediniz.");
		case 1: Character[playerid][cSkinColor] = 2, SendServerMessage(playerid, "Karakterinizin ten rengini siyahi olarak belirlediniz.");
	}

	new countries2[sizeof(Countries) * 15];
	for(new i; i < sizeof(Countries); i++)
	{
		format(countries2, sizeof(countries2), "%s%s\n", countries2, Countries[i]);
	}
	Dialog_Show(playerid, D_CREATE5, DIALOG_STYLE_LIST, "Vinewood Roleplay", countries2, "Devam Et", "Geri");
	return true;
}

Dialog:D_CREATE5(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_CREATE4, DIALOG_STYLE_LIST, "Vinewood Roleplay", "{FFFFFF}Beyaz\n{FFFFFF}Siyahi", "Devam Et", "Geri");

	Character[playerid][cOrigin] = listitem;
	SendServerMessage(playerid, "Karakterinizin kökenini %s olarak belirlediniz.", Countries[listitem]);
	
	SendServerMessage(playerid, "Karakterinizi baþarýlý bir þekilde yarattýnýz.");
	if(Character[playerid][cSex] == 1 && Character[playerid][cSkinColor] == 1) Character[playerid][cSkin] = 23;
	else if(Character[playerid][cSex] == 1 && Character[playerid][cSkinColor] == 2) Character[playerid][cSkin] = 7;
	else if(Character[playerid][cSex] == 2 && Character[playerid][cSkinColor] == 1) Character[playerid][cSkin] = 56;
	else if(Character[playerid][cSex] == 2 && Character[playerid][cSkinColor] == 2) Character[playerid][cSkin] = 195;

	Character[playerid][cCreated] = 1;
	Character[playerid][cFaction] = -1;

	SetCharacterFirstSpawn(playerid);
	return true;
}