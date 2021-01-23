CMD:factions(playerid, params[])
{
	FactionList(playerid);
	return true;
}
alias:factions("olusumlar")

CMD:fdurum(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Olu�um lideri de�ilsiniz.");

	new factid = GetPlayerFactionID(playerid);
	if(Faction[factid][fID] != Character[playerid][cFaction]) return SendServerMessage(playerid, "Bu olu�uma �ye de�ilsiniz.");

	new dialogstr[512], type[64], accesswep[32], accessdrug[32];
	switch(Faction[factid][fType])
	{
		case 0: type = "Sivil";
		case 1: type = "Kolluk Kuvvetleri";
		case 2: type = "Yard�m Kuvvetleri";
		case 3: type = "Yard�m Kuvvetleri";
		case 4: type = "Bas�n";
		case 5: type = "Devlet";
	}
	switch(Faction[factid][fAccessToWeapons])
	{
		case 0: accesswep = "Hay�r";
		case 1: accesswep = "Evet";
	}
	switch(Faction[factid][fAccessToDrugs])
	{
		case 0: accessdrug = "Hay�r";
		case 1: accessdrug = "Evet";
	}
	format(dialogstr, sizeof(dialogstr), 
		"{F0F2A5}Olu�um Ad�:\t{FFFFFF}%s\n\
		{F0F2A5}Kategori:\t{FFFFFF}%s\n\
		{F0F2A5}Seviye:\t{FFFFFF}%d\n\
		{F0F2A5}Bonus:\t{FFFFFF}$%d\n\
		{F0F2A5}Silah:\t{FFFFFF}%s\n\
		{F0F2A5}Uyu�turucu:\t{FFFFFF}%s\n", 
		Faction[factid][fName], 
		type,
		Faction[factid][fLevel],
		Faction[factid][fLevelBonus],
		accesswep, accessdrug);
	Dialog_Show(playerid, NO_DIALOG, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Olu�um", dialogstr, "Kapat", "");
	return true;
}

CMD:fayril(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");

	new fid = GetPlayerFactionID(playerid);
	SendFactionMessage(Faction[fid][fID], C_FACTION, "* %s olu�umdan ayr�ld�.", GetRPName(playerid));

	Character[playerid][cFaction] = -1;
	SaveCharacterData(playerid);
	SendServerMessage(playerid, "Olu�umdan ayr�ld�n�z.");
	return true;
}

CMD:faction(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");

	new text[144];
	if(sscanf(params, "s[144]", text)) return SendServerMessage(playerid, "/f(action) [mesaj(144)]");
	new fid = GetPlayerFactionID(playerid);
	if(Faction[fid][fChat]) return SendServerMessage(playerid, "Olu�um chat kanal� kapat�lm��.");

	if(strlen(text) > 84)
	{
		SendFactionMessage(Faction[fid][fID], C_FACTION, "(( %s %s: %.84s ))", GetPlayerFactionRankName(playerid), GetRPName(playerid), text);
		SendFactionMessage(Faction[fid][fID], C_FACTION, "(( %s %s: ... %s ))", GetPlayerFactionRankName(playerid), GetRPName(playerid), text[84]);
	}
	else
	{
		SendFactionMessage(Faction[fid][fID], C_FACTION, "(( %s %s: %s ))", GetPlayerFactionRankName(playerid), GetRPName(playerid), text);
	}
	return true;
}
alias:faction("f")

CMD:fdavet(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");
	if((Character[playerid][cFactionRank] != 1) || (Character[playerid][cFactionRank] != 2) || (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Olu�um lideri de�ilsiniz.");

	new targetid, factid = GetPlayerFactionID(playerid);

	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/fdavet [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(Character[targetid][cFaction] != 0) return SendServerMessage(playerid, "Ki�i ba�ka bir olu�umda.");
	if(FactionInviteMode[targetid]) return SendServerMessage(playerid, "Ki�i ba�ka bir davet ekran�nda.");

	SendFactionInvite(playerid, targetid, factid);
	return true;
}

CMD:fcikart(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Olu�um lideri de�ilsiniz.");

	new targetid, factid = GetPlayerFactionID(playerid);
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/fcikart [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(Character[targetid][cFaction] != Character[playerid][cFaction]) return SendServerMessage(playerid, "Ki�i sizin olu�umunuzda de�il.");

	Character[targetid][cFaction] = -1;
	Character[targetid][cFactionRank] = 0;
	SaveCharacterData(targetid);

	SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s olu�umdan ��kart�ld�.", GetRPName(targetid));
	SendServerMessage(targetid, "%s taraf�ndan olu�umdan ��kart�ld�n�z.", GetRPName(playerid));
	return true;
}

CMD:fchat(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Olu�um lideri de�ilsiniz.");
	
	new factid = GetPlayerFactionID(playerid);
	switch(Faction[factid][fChat])
	{
		case 0:
		{
			Faction[factid][fChat] = 1;
			SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s taraf�ndan olu�um chat kanal� kapat�ld�.", GetPlayerFactionRankName(playerid), GetRPName(playerid));
		}
		case 1:
		{
			Faction[factid][fChat] = 0;
			SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s taraf�ndan olu�um chat kanal� a��ld�.", GetPlayerFactionRankName(playerid), GetRPName(playerid));
		}
	}
	return true;
}

CMD:frespawn(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Olu�um lideri de�ilsiniz.");

	new factid = GetPlayerFactionID(playerid);
	RespawnFactionVehicles(factid);
	return true;
}

CMD:frutbe(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Olu�um lideri de�ilsiniz.");

	new targetid, rank, factid = GetPlayerFactionID(playerid);
	if(sscanf(params, "ud", targetid, rank)) return SendServerMessage(playerid, "/frutbe [id/isim] [r�tbe(1-12)]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(Character[targetid][cFaction] != Character[playerid][cFaction]) return SendServerMessage(playerid, "Ki�i sizin olu�umunuzda de�il.");
	if(rank < 1 || rank > 12) return SendServerMessage(playerid, "R�tbe 1'den k���k, 12'den b�y�k olamaz.");
	if(Character[targetid][cFactionRank] >= Character[playerid][cFactionRank]) return SendServerMessage(playerid, "Sizinle e�it ya da sizden daha �st r�tbedeki ki�ilerin r�tbesini de�i�tiremezsiniz.");

	Character[targetid][cFactionRank] = rank;
	SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s taraf�ndan %s isimli ki�inin r�tbesi %s olarak de�i�tirildi.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetRPName(targetid), GetPlayerFactionRankName(targetid));
	return true;
}

CMD:frutbeisim(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Olu�um lideri de�ilsiniz.");

	new rank, newrankname[64], factid = GetPlayerFactionID(playerid);
	if(sscanf(params, "ds[64]", rank, newrankname)) return SendServerMessage(playerid, "/frutbeisim [id/isim] [yeni r�tbe(64)]");
	if(rank < 1 || rank > 12) return SendServerMessage(playerid, "R�tbe 1'den k���k, 12'den b�y�k olamaz.");
	if(strlen(newrankname) < 3 || strlen(newrankname) > 64) return SendServerMessage(playerid, "Ge�ersiz karakter girdiniz.");

	switch(rank)
	{
		case 1: format(Faction[factid][fRank1], 64, "%s", newrankname);
		case 2: format(Faction[factid][fRank2], 64, "%s", newrankname);
		case 3: format(Faction[factid][fRank3], 64, "%s", newrankname);
		case 4: format(Faction[factid][fRank4], 64, "%s", newrankname);
		case 5: format(Faction[factid][fRank5], 64, "%s", newrankname);
		case 6: format(Faction[factid][fRank6], 64, "%s", newrankname);
		case 7: format(Faction[factid][fRank7], 64, "%s", newrankname);
		case 8: format(Faction[factid][fRank8], 64, "%s", newrankname);
		case 9: format(Faction[factid][fRank9], 64, "%s", newrankname);
		case 10: format(Faction[factid][fRank10], 64, "%s", newrankname);
		case 11: format(Faction[factid][fRank11], 64, "%s", newrankname);
		case 12: format(Faction[factid][fRank12], 64, "%s", newrankname);
	}

	SendServerMessage(playerid, "Bir r�tbe g�ncellemesi yapt�n�z.");
	RefreshFaction(factid);
	return true;
}