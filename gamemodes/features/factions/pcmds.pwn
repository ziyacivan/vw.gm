CMD:factions(playerid, params[])
{
	FactionList(playerid);
	return true;
}
alias:factions("olusumlar")

CMD:fdurum(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Oluþum lideri deðilsiniz.");

	new factid = GetPlayerFactionID(playerid);
	if(Faction[factid][fID] != Character[playerid][cFaction]) return SendServerMessage(playerid, "Bu oluþuma üye deðilsiniz.");

	new dialogstr[512], type[64], accesswep[32], accessdrug[32];
	switch(Faction[factid][fType])
	{
		case 0: type = "Sivil";
		case 1: type = "Kolluk Kuvvetleri";
		case 2: type = "Yardým Kuvvetleri";
		case 3: type = "Yardým Kuvvetleri";
		case 4: type = "Basýn";
		case 5: type = "Devlet";
	}
	switch(Faction[factid][fAccessToWeapons])
	{
		case 0: accesswep = "Hayýr";
		case 1: accesswep = "Evet";
	}
	switch(Faction[factid][fAccessToDrugs])
	{
		case 0: accessdrug = "Hayýr";
		case 1: accessdrug = "Evet";
	}
	format(dialogstr, sizeof(dialogstr), 
		"{F0F2A5}Oluþum Adý:\t{FFFFFF}%s\n\
		{F0F2A5}Kategori:\t{FFFFFF}%s\n\
		{F0F2A5}Seviye:\t{FFFFFF}%d\n\
		{F0F2A5}Bonus:\t{FFFFFF}$%d\n\
		{F0F2A5}Silah:\t{FFFFFF}%s\n\
		{F0F2A5}Uyuþturucu:\t{FFFFFF}%s\n", 
		Faction[factid][fName], 
		type,
		Faction[factid][fLevel],
		Faction[factid][fLevelBonus],
		accesswep, accessdrug);
	Dialog_Show(playerid, NO_DIALOG, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Oluþum", dialogstr, "Kapat", "");
	return true;
}

CMD:fayril(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");

	new fid = GetPlayerFactionID(playerid);
	SendFactionMessage(Faction[fid][fID], C_FACTION, "* %s oluþumdan ayrýldý.", GetRPName(playerid));

	Character[playerid][cFaction] = -1;
	SaveCharacterData(playerid);
	SendServerMessage(playerid, "Oluþumdan ayrýldýnýz.");
	return true;
}

CMD:faction(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");

	new text[144];
	if(sscanf(params, "s[144]", text)) return SendServerMessage(playerid, "/f(action) [mesaj(144)]");
	new fid = GetPlayerFactionID(playerid);
	if(Faction[fid][fChat]) return SendServerMessage(playerid, "Oluþum chat kanalý kapatýlmýþ.");

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
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");
	if((Character[playerid][cFactionRank] != 1) || (Character[playerid][cFactionRank] != 2) || (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Oluþum lideri deðilsiniz.");

	new targetid, factid = GetPlayerFactionID(playerid);

	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/fdavet [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(Character[targetid][cFaction] != 0) return SendServerMessage(playerid, "Kiþi baþka bir oluþumda.");
	if(FactionInviteMode[targetid]) return SendServerMessage(playerid, "Kiþi baþka bir davet ekranýnda.");

	SendFactionInvite(playerid, targetid, factid);
	return true;
}

CMD:fcikart(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Oluþum lideri deðilsiniz.");

	new targetid, factid = GetPlayerFactionID(playerid);
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/fcikart [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(Character[targetid][cFaction] != Character[playerid][cFaction]) return SendServerMessage(playerid, "Kiþi sizin oluþumunuzda deðil.");

	Character[targetid][cFaction] = -1;
	Character[targetid][cFactionRank] = 0;
	SaveCharacterData(targetid);

	SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s oluþumdan çýkartýldý.", GetRPName(targetid));
	SendServerMessage(targetid, "%s tarafýndan oluþumdan çýkartýldýnýz.", GetRPName(playerid));
	return true;
}

CMD:fchat(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Oluþum lideri deðilsiniz.");
	
	new factid = GetPlayerFactionID(playerid);
	switch(Faction[factid][fChat])
	{
		case 0:
		{
			Faction[factid][fChat] = 1;
			SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s tarafýndan oluþum chat kanalý kapatýldý.", GetPlayerFactionRankName(playerid), GetRPName(playerid));
		}
		case 1:
		{
			Faction[factid][fChat] = 0;
			SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s tarafýndan oluþum chat kanalý açýldý.", GetPlayerFactionRankName(playerid), GetRPName(playerid));
		}
	}
	return true;
}

CMD:frespawn(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Oluþum lideri deðilsiniz.");

	new factid = GetPlayerFactionID(playerid);
	RespawnFactionVehicles(factid);
	return true;
}

CMD:frutbe(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Oluþum lideri deðilsiniz.");

	new targetid, rank, factid = GetPlayerFactionID(playerid);
	if(sscanf(params, "ud", targetid, rank)) return SendServerMessage(playerid, "/frutbe [id/isim] [rütbe(1-12)]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(Character[targetid][cFaction] != Character[playerid][cFaction]) return SendServerMessage(playerid, "Kiþi sizin oluþumunuzda deðil.");
	if(rank < 1 || rank > 12) return SendServerMessage(playerid, "Rütbe 1'den küçük, 12'den büyük olamaz.");
	if(Character[targetid][cFactionRank] >= Character[playerid][cFactionRank]) return SendServerMessage(playerid, "Sizinle eþit ya da sizden daha üst rütbedeki kiþilerin rütbesini deðiþtiremezsiniz.");

	Character[targetid][cFactionRank] = rank;
	SendFactionMessage(Faction[factid][fID], C_FACTION, "* %s %s tarafýndan %s isimli kiþinin rütbesi %s olarak deðiþtirildi.", GetPlayerFactionRankName(playerid), GetRPName(playerid), GetRPName(targetid), GetPlayerFactionRankName(targetid));
	return true;
}

CMD:frutbeisim(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");
	if((Character[playerid][cFactionRank] != 1) && (Character[playerid][cFactionRank] != 2) && (Character[playerid][cFactionRank] != 3)) return SendServerMessage(playerid, "Oluþum lideri deðilsiniz.");

	new rank, newrankname[64], factid = GetPlayerFactionID(playerid);
	if(sscanf(params, "ds[64]", rank, newrankname)) return SendServerMessage(playerid, "/frutbeisim [id/isim] [yeni rütbe(64)]");
	if(rank < 1 || rank > 12) return SendServerMessage(playerid, "Rütbe 1'den küçük, 12'den büyük olamaz.");
	if(strlen(newrankname) < 3 || strlen(newrankname) > 64) return SendServerMessage(playerid, "Geçersiz karakter girdiniz.");

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

	SendServerMessage(playerid, "Bir rütbe güncellemesi yaptýnýz.");
	RefreshFaction(factid);
	return true;
}