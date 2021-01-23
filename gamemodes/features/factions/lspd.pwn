CMD:sivilkiyafet(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(GetBuildingType(playerid) != 1) return SendServerMessage(playerid, "LSPD HQ'da de�ilsiniz.");

	SetPlayerSkin(playerid, Character[playerid][cSkin]);
	return true;
}

CMD:pdkiyafet(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(GetBuildingType(playerid) != 1) return SendServerMessage(playerid, "LSPD HQ'da de�ilsiniz.");

	switch(Character[playerid][cSex])
	{
		case 0: return true;
		case 1:
		{
			static string[sizeof(LSPD_MALE) * 16];

			if(string[0] == EOS) {
				for(new i; i < sizeof(LSPD_MALE); i++)
				{
					format(string, sizeof string, "%s%i\n", string, LSPD_MALE[i][PD_SKIN_MODEL]);
				}
			}
			return ShowPlayerDialog(playerid, S_DIALOG_MALEPD, DIALOG_STYLE_PREVIEW_MODEL, "LSPD - Erkek", string, "Sec", "Kapat");
		}
		case 2:
		{
			static string[sizeof(LSPD_FEMALE) * 16];

			if(string[0] == EOS) {
				for(new i; i < sizeof(LSPD_FEMALE); i++)
				{
					format(string, sizeof string, "%s%i\n", string, LSPD_FEMALE[i][PD_SKIN_MODEL]);
				}
			}
			return ShowPlayerDialog(playerid, S_DIALOG_FEMALEPD, DIALOG_STYLE_PREVIEW_MODEL, "LSPD - Erkek", string, "Sec", "Kapat");
		}
	}
	return true;
}

CMD:pdisbasi(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(GetBuildingType(playerid) != 1) return SendServerMessage(playerid, "LSPD HQ'da de�ilsiniz.");
	
	new factid = GetPlayerFactionID(playerid);
	switch(PDWork[playerid])
	{
		case 0:
		{
			PDWork[playerid] = 1;
			SetPlayerColor(playerid, C_FACTION);
			SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s i�ba��na ge�ti.", GetPlayerFactionRankName(playerid), GetRPName(playerid));

			GivePlayerWeapon(playerid, 3, 1); // nightstick
			GivePlayerWeapon(playerid, 24, 9999); // deagle
			GivePlayerWeapon(playerid, 41, 9999);
		}
		case 1:
		{
			PDWork[playerid] = 0;
			SetPlayerColor(playerid, C_WHITE);
			SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s i�ba��ndan ��kt�.", GetPlayerFactionRankName(playerid), GetRPName(playerid));
			ResetPlayerWeapons(playerid);
		}
	}
	return true;
}

CMD:sicilkontrol(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	new targetname[144];
	if(sscanf(params, "s[144]", targetname)) return SendServerMessage(playerid, "/sicilkontrol [John_Doe]");

	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM registry_records WHERE Name = '%e'", targetname);
	GetData = mysql_query(conn, query);

	new rows, fields;
	cache_get_row_count(rows);
	cache_get_field_count(fields);
	new mdc_cname[144], mdc_reason[144], mdc_officer[144], mdc_date[144], mdc_regno;
	SendClientMessageEx(playerid, C_ADMIN, "%s isimli ki�inin sicil kayd�:", targetname);
	if(cache_num_rows())
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(0, "Registry_No", mdc_regno);
			cache_get_value_name(0, "Name", mdc_cname, 144);
			cache_get_value_name(0, "Reason", mdc_reason, 144);
			cache_get_value_name(0, "Officer", mdc_officer, 144);
			cache_get_value_name(0, "Date", mdc_date, 144);

			SendClientMessageEx(playerid, C_GREY1, "Sicil No: [%d] | �sim: [%s] | Su�: [%s] | Ekleyen Memur: [%s] | Tarih: [%s]", mdc_regno, mdc_cname, mdc_reason, mdc_officer, mdc_date);
		}
	}
	else 
	{
		SendClientMessageEx(playerid, C_GREY1, "Kay�t bulunamad�.");
	}
	cache_delete(GetData);
	return true;
}

CMD:siren(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Ara� i�erisinde olmal�s�n�z.");
	new vehid = GetPlayerVehicleID(playerid);
	if(Vehicle[vehid][vFaction] != 1) return SendServerMessage(playerid, "LSPD arac�nda olmal�s�n�z.");

	switch(Siren[vehid])
	{
		case 0:
		{ 
			if(Vehicle[vehid][vModel] == 402 || Vehicle[vehid][vModel] == 415 || Vehicle[vehid][vModel] == 421 || Vehicle[vehid][vModel] == 426 || Vehicle[vehid][vModel] == 482 || Vehicle[vehid][vModel] == 490 || Vehicle[vehid][vModel] == 541 || Vehicle[vehid][vModel] == 560 || Vehicle[vehid][vModel] == 579)
			{
				Siren[vehid] = 1;
				GetPlayerPos(playerid, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2]);

				SirenObject[vehid] = CreateDynamicObject(18646, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2], 0.0, 0, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
				switch(Vehicle[vehid][vModel])
				{
					case 402: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.50, -0.30, 0.815, 0.0, 0.1, 0.0);
					case 415: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.43, -0.15, 0.665, 0.0, 0.1, 0.0);
					case 421: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.45, 0.20, 0.75, 0.0, 0.1, 0.0);
					case 426: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.60, -0.20, 0.880, 0.0, 0.1, 0.0);
					case 482: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.55, 0.7, 0.980, 0.0, 0.1, 0.0);
					case 490: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.55, 0.7, 1.13, 0.0, 0.1, 0.0);
					case 541: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.43, 0.0, 0.680, 0.0, 0.1, 0.0);
					case 560: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.60, 0.25, 0.880, 0.0, 0.1, 0.0);
					case 579: AttachDynamicObjectToVehicle(SirenObject[vehid], vehid, -0.55, 0.10, 1.28, 0.0, 0.1, 0.0);
				}
			}
			else SendServerMessage(playerid, "Bu araca siren koyamazs�n�z.");
		}
		case 1:
		{
			if(Vehicle[vehid][vModel] == 402 || Vehicle[vehid][vModel] == 415 || Vehicle[vehid][vModel] == 421 || Vehicle[vehid][vModel] == 426 || Vehicle[vehid][vModel] == 482 || Vehicle[vehid][vModel] == 490 || Vehicle[vehid][vModel] == 541 || Vehicle[vehid][vModel] == 560 || Vehicle[vehid][vModel] == 579)
			{
				Siren[vehid] = 0;
				SendServerMessage(playerid, "Polis sirenini kald�rd�n�z.");
				DestroyDynamicObject(SirenObject[vehid]);
			}
			else SendServerMessage(playerid, "Bu ara�tan siren kald�ramazs�n�z.");
		}
	}
	return true;
}

CMD:taser(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!PDWork[playerid]) return SendServerMessage(playerid, "Bu komut i�in i�ba��nda olmal�s�n�z.");

	switch(TakeTaser[playerid])
	{
		case 0:
		{
			TakeTaser[playerid] = 1;
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s elini te�hizat kemerine g�t�r�r ve taseri kavrar.", GetRPName(playerid));
			GivePlayerWeapon(playerid, 23, 10);
		}
		case 1:
		{
			ResetPlayerWeapons(playerid);

			GivePlayerWeapon(playerid, 3, 1);
			GivePlayerWeapon(playerid, 24, 9999);
			GivePlayerWeapon(playerid, 41, 9999);

			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s taseri te�hizat kemerine g�t�r�r ve yerine koyar.", GetRPName(playerid));
			TakeTaser[playerid] = 0;
		}
	}
	return true;
}

CMD:beanbag(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!PDWork[playerid]) return SendServerMessage(playerid, "Bu komut i�in i�ba��nda olmal�s�n�z.");

	switch(TakeBeanbag[playerid])
	{
		case 0:
		{
			TakeBeanbag[playerid] = 1;
			GivePlayerWeapon(playerid, 25, 9999);
		}
		case 1:
		{
			TakeBeanbag[playerid] = 0;
			ResetPlayerWeapons(playerid);

			GivePlayerWeapon(playerid, 3, 1);
			GivePlayerWeapon(playerid, 24, 9999);
			GivePlayerWeapon(playerid, 41, 9999);
		}
	}
	return true;
}

CMD:cezakes(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!PDWork[playerid]) return SendServerMessage(playerid, "Bu komut i�in i�ba��nda olmal�s�n�z.");
	new factid = GetPlayerFactionID(playerid);

	new targetid, amount, reason[64];
	if(sscanf(params, "uds[64]", targetid, amount, reason)) return SendServerMessage(playerid, "/cezakes [id/isim] [miktar] [sebep]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendServerMessage(playerid, "Ki�i yak�n�n�zda de�il.");
	if(amount <= 0) return SendServerMessage(playerid, "Ge�ersiz miktar girdiniz.");
	if(strlen(reason) < 1 || strlen(reason) > 64) return SendServerMessage(playerid, "Ge�ersiz karakter girdiniz.");
	if(targetid == playerid) return SendServerMessage(playerid, "Kendinize ceza kesemezsiniz.");

	new ticketIDEx = randomEx(111111, 999999);
	new year, month, day, hour, minute, second, ticketDate2[64];
	getdate(year, month, day);
	gettime(hour, minute, second);
	format(ticketDate2, 64, "%d/%d/%d - %d:%d:%d", day, month, year, hour, minute, second);

	new query[512], Cache:InsertData;
	mysql_format(conn, query, sizeof(query), "INSERT INTO penalty_tickets (ticketOwner, ticketID, ticketReason, ticketAmount, ticketDate, ticketOfficer) VALUES (%i, %i, '%e', %i, '%e', '%e')",
		Character[targetid][cID],
		ticketIDEx,
		reason,
		amount,
		ticketDate2,
		GetRPName(playerid));
	InsertData = mysql_query(conn, query);

	Penalty[targetid][ticketOwner] = Character[targetid][cID];
	Penalty[targetid][ticketID] = ticketIDEx;
	format(Penalty[targetid][ticketReason], 64, "%s", reason);
	Penalty[targetid][ticketAmount] = amount;
	format(Penalty[targetid][ticketDate], 64, "%s", ticketDate2);
	format(Penalty[targetid][ticketOfficer], 144, "%s", GetRPName(playerid));

	SendServerMessage(targetid, "%s isimli polis memuru taraf�ndan %s sebebiyle $%d tutar�nda taraf�n�za ceza yaz�ld� (/cezalarim).", GetRPName(playerid), reason, amount);
	SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s taraf�ndan %s isimli ki�iye %s sebebiyle $%d tutar�nda ceza kesildi.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetRPName(targetid), reason, amount);
	cache_delete(InsertData);
	return true;
}

CMD:kelepce(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!PDWork[playerid]) return SendServerMessage(playerid, "Bu komut i�in i�ba��nda olmal�s�n�z.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/kelepce [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendServerMessage(playerid, "Ki�i yak�n�n�zda de�il.");
	if(targetid == playerid) return SendServerMessage(playerid, "Kendini kelep�eleyemezsin.");

	switch(Cuffed[targetid])
	{
		case 0:
		{
			SetPlayerSpecialAction(targetid, SPECIAL_ACTION_CUFFED);
			SetPlayerAttachedObject(targetid, 8, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s, %s isimli ki�iyi kelep�eler.", GetRPName(playerid), GetRPName(targetid));
			Cuffed[targetid] = 1;
		}
		case 1:
		{
			RemovePlayerAttachedObject(targetid, 8);
			SetPlayerSpecialAction(targetid, SPECIAL_ACTION_NONE);
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s, %s isimli ki�inin kelep�esini ��zer.", GetRPName(playerid), GetRPName(targetid));
			Cuffed[targetid] = 0;
		}
	}
	return true;
}

CMD:rozetgoster(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!PDWork[playerid]) return SendServerMessage(playerid, "Bu komut i�in i�ba��nda olmal�s�n�z.");

	new targetid;
	if(sscanf(params, "u", targetid))  return SendServerMessage(playerid, "/rozetgoster [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerNearPlayer(playerid, targetid, 3.0)) return SendServerMessage(playerid, "Ki�i yak�n�n�zda de�il.");
	if(playerid == targetid) return SendServerMessage(playerid, "Kendinize rozet g�steremezsiniz.");

	SendClientMessage(targetid, -1, "{2D962D}__________________[ROZET]__________________");
	SendClientMessageEx(targetid, C_GREY1, "�sim: %s - R�tbe: %s", GetRPName(playerid), GetPlayerFactionRankName(playerid));
	SendClientMessageEx(playerid, C_GREY1, "%s isimli ki�iye rozetinizi g�sterdiniz.", GetRPName(targetid));
	SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s rozetini ��kar�r ve %s isimli ki�iye g�sterir.", GetRPName(playerid), GetRPName(targetid));
	return true;
}

CMD:megafon(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!PDWork[playerid]) return SendServerMessage(playerid, "Bu komut i�in i�ba��nda olmal�s�n�z.");

	new mtext[144];
	if(sscanf(params, "s[144]", mtext)) return SendServerMessage(playerid, "/(m)egafon [metin(144)]");

	if(strlen(mtext) > 84)
	{
		SendNearbyMessage(playerid, 60.0, 0xFFFF00AA, "[ %s:o< %.84s ]", GetRPName(playerid), mtext);
		SendNearbyMessage(playerid, 60.0, 0xFFFF00AA, "[ %s:o< ... %s ]", GetRPName(playerid), mtext[84]);
	}
	else
	{
		SendNearbyMessage(playerid, 60.0, 0xFFFF00AA, "[ %s:o< %s ]", GetRPName(playerid), mtext);
	}
	return true;
}
alias:megafon("m")

CMD:departman(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid))
	{
		new dtext[144];
		if(sscanf(params, "s[144]", dtext)) return SendServerMessage(playerid, "/(d)epartman [metin(144)]");

		foreach(new i : Factions)
		{
			if(Faction[i][fID] == 1 || Faction[i][fID] == 2 || Faction[i][fID] == 3)
			{
				if(Character[playerid][cFaction] == 0) break;
				
				switch(Character[playerid][cFaction])
				{
					case 1:
					{
						SendFactionMessageEx(FACTION_POLICE, 0xFF8282FF, "** [LSPD] %s %s: %s", GetPlayerFactionRankName(playerid), GetRPName(playerid), dtext);
					}
					case 2:
					{
						SendFactionMessageEx(FACTION_MEDIC, 0xFF8282FF, "** [LSMD] %s %s: %s", GetPlayerFactionRankName(playerid), GetRPName(playerid), dtext);
					}
					case 3:
					{
						SendFactionMessageEx(FACTION_FD, 0xFF8282FF, "** [LSFD] %s %s: %s", GetPlayerFactionRankName(playerid), GetRPName(playerid), dtext);
					}
				}
			}
		}
	}
	else SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	return true;
}
alias:departman("d")

CMD:radio(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid))
	{
		new radiotext[144];
		if(sscanf(params, "s[144]", radiotext)) return SendServerMessage(playerid, "/(r)adio [metin(144)]");

		switch(GetFactionType(playerid))
		{
			case FACTION_POLICE:
			{
				if(strlen(radiotext) > 84)
				{
					SendFactionMessageEx(FACTION_POLICE, 0xF0F2A5FF, "[CH: 911, S: %i] %s: %.84s", GetFactionType(playerid), GetRPName(playerid), radiotext);
					SendFactionMessageEx(FACTION_POLICE, 0xF0F2A5FF, "[CH: 911, S: %i] %s: ... %s", GetFactionType(playerid), GetRPName(playerid), radiotext[84]);
				}
				else
				{
					SendFactionMessageEx(FACTION_POLICE, 0xF0F2A5FF, "[CH: 911, S: %i] %s: %s", GetFactionType(playerid), GetRPName(playerid), radiotext);
				}
			}
			case FACTION_MEDIC:
			{
				if(strlen(radiotext) > 84)
				{
					SendFactionMessageEx(FACTION_MEDIC, 0xF0F2A5FF, "[CH: 911, S: %i] %s: %.84s", GetFactionType(playerid), GetRPName(playerid), radiotext);
					SendFactionMessageEx(FACTION_MEDIC, 0xF0F2A5FF, "[CH: 911, S: %i] %s: ... %s", GetFactionType(playerid), GetRPName(playerid), radiotext[84]);
				}
				else
				{
					SendFactionMessageEx(FACTION_MEDIC, 0xF0F2A5FF, "[CH: 911, S: %i] %s: %s", GetFactionType(playerid), GetRPName(playerid), radiotext);
				}
			}
			case FACTION_FD:
			{
				if(strlen(radiotext) > 84)
				{
					SendFactionMessageEx(FACTION_FD, 0xF0F2A5FF, "[CH: 911, S: %i] %s: %.84s", GetFactionType(playerid), GetRPName(playerid), radiotext);
					SendFactionMessageEx(FACTION_FD, 0xF0F2A5FF, "[CH: 911, S: %i] %s: ... %s", GetFactionType(playerid), GetRPName(playerid), radiotext[84]);
				}
				else
				{
					SendFactionMessageEx(FACTION_FD, 0xF0F2A5FF, "[CH: 911, S: %i] %s: %s", GetFactionType(playerid), GetRPName(playerid), radiotext);
				}
			}
		}
	} else SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	return true;
}
alias:radio("r")

CMD:y(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid))
	{
		new ytext[144];
		if(sscanf(params, "s[144]", ytext)) return SendServerMessage(playerid, "/(y) [metin(144)]");

		switch(GetFactionType(playerid))
		{
			case FACTION_POLICE:
			{
				SendFactionMessage(FACTION_POLICE, 0xF0F2A5FF, "** [CH: 911, S: %i] %s: %s", GetFactionType(playerid), GetRPName(playerid), ytext);
			}
			case FACTION_MEDIC:
			{
				SendFactionMessage(FACTION_MEDIC, 0xF0F2A5FF, "** [CH: 911, S: %i] %s: %s", GetFactionType(playerid), GetRPName(playerid), ytext);
			}
			case FACTION_FD:
			{
				SendFactionMessage(FACTION_FD, 0xF0F2A5FF, "** [CH: 911, S: %i] %s: %s", GetFactionType(playerid), GetRPName(playerid), ytext);
			}
		}
	}
	else SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	return true;
}

CMD:operator(playerid, params[])
{
	if(IsPlayerOfficer(playerid) || IsPlayerMedicalOfficer(playerid) || IsPlayerFireOfficer(playerid))
	{
		new text[144];
		if(sscanf(params, "s[144]", text)) return SendServerMessage(playerid, "/operator [metin(144)]");

		switch(GetFactionType(playerid))
		{
			case FACTION_POLICE:
			{
				if(strlen(text) > 84)
				{
					SendFactionMessageEx(FACTION_POLICE, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: %.84s", GetFactionType(playerid), text);
					SendFactionMessageEx(FACTION_POLICE, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: ... %s", GetFactionType(playerid), text[84]);
				}
				else
				{
					SendFactionMessageEx(FACTION_POLICE, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: %s", GetFactionType(playerid), text);
				}
			}
			case FACTION_MEDIC:
			{
				if(strlen(text) > 84)
				{
					SendFactionMessageEx(FACTION_MEDIC, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: %.84s", GetFactionType(playerid), text);
					SendFactionMessageEx(FACTION_MEDIC, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: ... %s", GetFactionType(playerid), text[84]);
				}
				else
				{
					SendFactionMessageEx(FACTION_MEDIC, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: %s", GetFactionType(playerid), text);
				}
			}
			case FACTION_FD:
			{
				if(strlen(text) > 84)
				{
					SendFactionMessageEx(FACTION_FD, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: %.84s", GetFactionType(playerid), text);
					SendFactionMessageEx(FACTION_FD, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: ... %s", GetFactionType(playerid), text[84]);
				}
				else
				{
					SendFactionMessageEx(FACTION_FD, 0xF0F2A5FF, "** [CH: 911, S: %i] Operat�r: %s", GetFactionType(playerid), text);
				}
			}
		}
	}
	else SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	return true;
}

CMD:mliste(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	
	SendClientMessage(playerid, -1, "{33AA33}__________________[MEGAFON KEYBINDS]__________________");
	SendClientMessage(playerid, C_GREY1, "/m1 ** Teslim ol, etraf�n sar�ld�! (Give up, you're surrounded!)");
	SendClientMessage(playerid, C_GREY1, "/m2 ** Hey sen! Dur polis! (Hey you, police. Stop!)");
	SendClientMessage(playerid, C_GREY1, "/m3 ** Los Santos Polis Departman�, oldu�un yerde kal! (This is LSPD, stay where you're)");
	SendClientMessage(playerid, C_GREY1, "/m4 ** Oldu�un yerde kal, yoksa ate� a�aca��z! (Freeze, or we'll open fire!)");
	SendClientMessage(playerid, C_GREY1, "/m5 ** Polis KIPIRDAMA! (Police, don't move!)");
	SendClientMessage(playerid, C_GREY1, "/m6 ** Ellerin ba��n�n �st�nde kalacak �ekilde ara�tan in! (Get outta the car with your hands in the air!)");
	SendClientMessage(playerid, C_GREY1, "/m7 ** LSPD Kenara �eki-.. sen deli misin?! Hepimizi �ld�r�yordun!");
	return true;
}

CMD:m1(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SendNearbyMessage(playerid, 30.0, C_WHITE, "%s (ba��rarak): Teslim ol, etraf�n sar�ld�!", GetRPName(playerid));
	PlaySoundEx(9605, pos[0], pos[1], pos[2], 30);
	return true;
}

CMD:m2(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SendNearbyMessage(playerid, 30.0, C_WHITE, "%s (ba��rarak): Hey sen! Dur polis!", GetRPName(playerid));
	PlaySoundEx(10200, pos[0], pos[1], pos[2], 30);
	return true;
}

CMD:m3(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SendNearbyMessage(playerid, 30.0, 0xFFFF00AA, "[ %s %s:o< Los Santos Polis Departman�, oldu�un yerde kal!]", GetPlayerFactionRankName(playerid), GetRPName(playerid));
	PlaySoundEx(15800, pos[0], pos[1], pos[2], 30);
	return true;
}

CMD:m4(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SendNearbyMessage(playerid, 30.0, C_WHITE, "%s (ba��rarak): Oldu�un yerde kal, yoksa ate� a�aca��z!", GetRPName(playerid));
	PlaySoundEx(15801, pos[0], pos[1], pos[2], 30);
	return true;
}

CMD:m5(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SendNearbyMessage(playerid, 30.0, C_WHITE, "%s (ba��rarak): Polis KIPIRDAMA!", GetRPName(playerid));
	PlaySoundEx(34402, pos[0], pos[1], pos[2], 30);
	return true;
}

CMD:m6(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SendNearbyMessage(playerid, 30.0, C_WHITE, "%s (ba��rarak): Ellerin ba��n�n �st�nde kalacak �ekilde ara�tan in!", GetRPName(playerid));
	PlaySoundEx(34403, pos[0], pos[1], pos[2], 30);
	return true;
}

CMD:m7(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SendNearbyMessage(playerid, 30.0, 0xFFFF00AA, "[ %s %s:o< LSPD Kenara �eki-.. sen deli misin?! Hepimizi �ld�r�yordun!]", GetPlayerFactionRankName(playerid), GetRPName(playerid));
	PlaySoundEx(34403, pos[0], pos[1], pos[2], 30);
	return true;
}

CMD:barikat(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	Dialog_Show(playerid, LSPD_BARRICADE, DIALOG_STYLE_LIST, "Vinewood Roleplay - LSPD", "Barikat Ekle\nAktif Barikatlar", "Se�", "Kapat");
	return true;
}

Dialog:LSPD_BARRICADE(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			Dialog_Show(playerid, LSPD_BARRICADE_CATEGORY, DIALOG_STYLE_LIST, "Vinewood Roleplay - LSPD", "K���k Bariyer\nTrafik Levhas�\nMedium Bariyer\nViraj Levhas�\nB�y�k Kap�\nKap�\nYol Bariyeri ( Sol )\nYol Bariyeri ( Sa� )\nB�y�k Bariyer\nB�y�k �iviler\nKoni\nPolis �eriti\nKasis", "Se�", "Kapat");
		}
		case 1:
		{
			new str[256], totalstr[1024];
			new count;
			for(new i = 0; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated])
				{
					count++;
					format(str, sizeof(str), "%s {C3C4C6}[%s - %s]\n", Barricade[i][bType], GetRPName(Barricade[i][bOwner]), GetLocation(Barricade[i][BARX], Barricade[i][BARY], Barricade[i][BARZ]));
					strcat(totalstr, str);
				}
			}
			if(count == 0)
			{
				SendServerMessage(playerid, "Kurulmu� bir barikat bulunmuyor.");
			}
			else
			{
				Dialog_Show(playerid, LSPD_BARRICADE_LIST, DIALOG_STYLE_LIST, "Vinewood Roleplay - LSPD", totalstr, "Tamam", "Kapat");
			}
		}
	}
	return true;
}

Dialog:LSPD_BARRICADE_CATEGORY(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(1228, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "K���k Bariyer");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "K���k Bariyer kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde k���k bariyer kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 1:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(1282, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Trafik Levhas�");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Trafik Levhas� kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde trafik levhas� kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 2:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(1424, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Medium Bariyer");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Medium Bariyer kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde medium bariyer kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 3:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(1425, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Viraj Levhas�");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Viraj Levhas� kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde viraj levhas� kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 4:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(7657, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "B�y�k Kap�");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "B�y�k Kap� kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde b�y�k kap� kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 5:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(8674, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Kap�");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Kap� kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde kap� kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 6:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(978, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Yol Bariyeri Sol");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Yol Bariyeri Sol kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde yol bariyeri sol kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 7:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(979, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Yol Bariyeri Sa�");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Yol Bariyeri Sa� kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde yol bariyeri sa� kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 8:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(981, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			format(Barricade[TakeBarricade[playerid]][bType], 24, "B�y�k Bariyer");
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			Barricade[TakeBarricade[playerid]][bCreated] = 1;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "B�y�k Bariyer kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde b�y�k bariyer kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 9:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			new Float:plocxx, Float:plocyy, Float:ploczz, Float:plocaa;
			GetPlayerPos(playerid, plocxx, plocyy, ploczz);
			GetPlayerFacingAngle(playerid, plocaa);
			CreateStrip(playerid, Float:XXX, Float:YYY, Float:ZZZ, Float:plocaa);
			SendServerMessage(playerid, "B�y�k �iviler kuruldu, objenin konumunu de�i�tirebilirsiniz.");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde b�y�k �ivi kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 10:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i = 0; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(1238, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Koni kuruldu, objenin konumunu de�i�tirebilirsiniz.");
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Koni");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde koni kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 11:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i = 0; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(19834, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Polis �eridi kuruldu, objenin konumunu de�i�tirebilirsiniz.");
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Polis �eridi");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde polis �eridi kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
		case 12:
		{
			new Float:XXX, Float:YYY, Float:ZZZ;
			GetPlayerPos(playerid, XXX, YYY, ZZZ);
			YYY += 5;
			for(new i = 0; i < MAX_BARRICADE; i++)
			{
				if(Barricade[i][bCreated] == 0)
				{
					TakeBarricade[playerid] = i;
					break;
				}
			}
			Barricade[TakeBarricade[playerid]][bObject] = CreateDynamicObject(19425, XXX, YYY, ZZZ, 0.0, 0.0, 96.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			Barricade[TakeBarricade[playerid]][bOwner] = playerid;
			Barricade[TakeBarricade[playerid]][BARX] = XXX;
			Barricade[TakeBarricade[playerid]][BARY] = YYY;
			Barricade[TakeBarricade[playerid]][BARZ] = ZZZ;
			EditDynamicObject(playerid, Barricade[TakeBarricade[playerid]][bObject]);
			SendServerMessage(playerid, "Kasis kuruldu, objenin konumunu de�i�tirebilirsiniz.");
			format(Barricade[TakeBarricade[playerid]][bType], 24, "Kasis");

			new Float:X2, Float:Y2, Float:Z2;
			GetPlayerPos(playerid, X2, Y2, Z2);
			SendFactionMessageEx(FACTION_POLICE, C_FACTION, "* HQ Duyuru: %s %s, %s b�lgesinde kasis kurdu.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetLocation(X2, Y2, Z2));
		}
	}
	return true;
}

CMD:ybarikatkaldir(playerid, params[])
{
	if(!IsPlayerOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	for(new i = 0; i < MAX_BARRICADE; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, Barricade[i][BARX], Barricade[i][BARY], Barricade[i][BARZ]))
		{
			Barricade[i][bCreated] = 0;
			Barricade[i][BARX] = 0.0;
			Barricade[i][BARY] = 0.0;
			Barricade[i][BARZ] = 0.0;
			DestroyDynamicObject(Barricade[i][bObject]);
			SendServerMessage(playerid, "Yak�n�n�zda kurulmu� olan barikat� kald�rd�n�z.");
			break;
		}
	}
	return true;
}