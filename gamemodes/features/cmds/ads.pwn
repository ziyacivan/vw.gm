CMD:reklam(playerid, params[])
{
	//if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Reklam vermek için telefona sahip olmalýsýnýz.");

	new adtext[124];
	if(sscanf(params, "s[124]", adtext)) return SendServerMessage(playerid, "/reklam [metin(124)]");
	if(Character[playerid][cLevel] < 4) return SendServerMessage(playerid, "Seviyeniz minimum 4 olmalýdýr.");
	if(strlen(adtext) <= 5 || strlen(adtext) > 124) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");
	if(Character[playerid][cMoney] < 100) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

	SetPVarString(playerid, "ADSText", adtext);

	Dialog_Show(playerid, CHOOSE_AD_PHONE, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Reklam", "{FFFFFF}Lütfen reklamda kullanmak istediðiniz telefonun idsini girin:", "Seç", "Kapat");
	return true;
}

CMD:isreklam(playerid, params[])
{
	if(!BusinessOutDoor(playerid)) return SendServerMessage(playerid, "Bir iþyerinin kapýsýnda olmalýsýnýz.");

	new bsid = GetPlayerNearbyBusiness(playerid);
	if(Business[bsid][bsOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu iþyeri size ait deðil.");

	new adstext[144];
	if(sscanf(params, "s[144]", adstext)) return SendServerMessage(playerid, "/isreklam [metin(144)]");
	if(strlen(adstext) < 1 || strlen(adstext) > 144) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");
	if(Character[playerid][cMoney] < 850) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

	if(strlen(adstext) > 84)
	{
		SendAllMessage(C_NEWS, "** [ÝÞLETME | %s] %.84s", Business[bsid][bsName], adstext);
		SendAllMessage(C_NEWS, "** [ÝÞLETME | %s] ... %s", Business[bsid][bsName], adstext[84]);
		SendAllMessage(C_GREY1, "[!] Ýþletme haritada iþaretlendi (ESC>Harita)");
	}
	else 
	{
		SendAllMessage(C_NEWS, "** [ÝÞLETME | %s] %s", Business[bsid][bsName], adstext);
		SendAllMessage(C_GREY1, "[!] Ýþletme haritada iþaretlendi (ESC>Harita)");
	}

	foreach(new i : Player)
	{
		if(IsPlayerConnected(i) && LoggedIn[i])
		{
			new bsIcon = randomEx(0, 99);
			Business[bsid][bsMapIcon] = bsIcon;
			SetPlayerMapIcon(i, Business[bsid][bsMapIcon], Business[bsid][bsExtDoor][0], Business[bsid][bsExtDoor][1], Business[bsid][bsExtDoor][2], 19, 0, MAPICON_GLOBAL);
			SetTimerEx("DeleteMapIcon", 50000, false, "ii", i, bsid);
		}
	}
	return true;
}

Vinewood:DeleteMapIcon(playerid, bsid)
{
	RemovePlayerMapIcon(playerid, Business[bsid][bsMapIcon]);
	return true;
}

// dialogs
Dialog:CHOOSE_AD_PHONE(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	//if(!IsOwnerPhone(playerid, strval(inputtext))) return SendServerMessage(playerid, "Bu telefon size ait deðil!");

	new adstext[124];
	GetPVarString(playerid, "ADSText", adstext, sizeof(adstext));

//	SendAllMessage(C_NEWS, "[REKLAM] %s | %s (%d)", adstext, GetRPName(playerid), Phone[strval(inputtext)][phNumber]);

	GiveMoney(playerid, -100);
	SaveCharacterData(playerid);
	return true;
}
