CMD:olusumyarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");
	if(FactionLimit()) return SendServerMessage(playerid, "Olu�um limiti a��ld�.");

	new name[144], type;
	if(sscanf(params, "ds[144]", type, name))
	{
		SendServerMessage(playerid, "/olusumyarat [tip] [isim]");
		SendClientMessage(playerid, C_GREY1, "0: Sivil | 1: LSPD | 2: LSMD | 3: LSFD | 4: Bas�n | 5: GOV");
	}
	else
	{
		if(type < 0 || type > 5) return SendServerMessage(playerid, "Ge�ersiz tip girdiniz.");

		CreateFaction(name, type);
		SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %s isimle bir olu�um olu�turuldu.", Character[playerid][cNickname], name);
	}
	return true;
}

CMD:olusumduzenle(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");

	new fid, opt[64], extra[124];
	if(sscanf(params, "ds[64]S()[124]", fid, opt, extra))
	{
		SendServerMessage(playerid, "/olusumduzenle [olu�um id] [se�enek] [ekstra]");
		SendClientMessage(playerid, C_GREY1, "isim | tip | girisrutbe | level | levelbonus | silaherisim | uerisim");
	}
	else 
	{
		if(!Faction[fid][fIsValid]) return SendServerMessage(playerid, "Olu�um bulunamad�.");

		if(!strcmp(opt, "isim", true))
		{
			new name[144];
			if(sscanf(extra, "s[144]", name))  return SendServerMessage(playerid, "/olusumduzenle [olu�um id] [isim] [yeni isim(144)]");
			
			format(Faction[fid][fName], 144, "%e", name);
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�um ismi %s olarak g�ncellendi.", Character[playerid][cNickname], fid, Faction[fid][fName]);
		}
		else if(!strcmp(opt, "tip", true))
		{
			new type;
			if(sscanf(extra, "d", type)) return SendServerMessage(playerid, "/olusumduzenle [olu�um id] [tip] [yeni tip]");
			if(type < 0 || type > 5) return SendServerMessage(playerid, "Ge�ersiz tip girdiniz.");

			Faction[fid][fType] = type;
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�um tipi g�ncellendi.", Character[playerid][cNickname], fid);
		}
		else if(!strcmp(opt, "girisrutbe", true))
		{
			new loginrank;
			if(sscanf(extra, "d", loginrank)) return SendServerMessage(playerid, "/olusumduzenle [olu�um id] [girisrutbe] [yeni r�tbe]");
			if(loginrank < 1 || loginrank > 12) return SendServerMessage(playerid, "Ge�ersiz tip girdiniz.");

			Faction[fid][fLoginRank] = loginrank;
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�umun giri� r�tbesi g�ncellendi.", Character[playerid][cNickname], fid);
		}
		else if(!strcmp(opt, "level", true))
		{
			new level;
			if(sscanf(extra, "d", level)) return SendServerMessage(playerid, "/olusumduzenle [olu�um id] [level] [yeni level]");

			Faction[fid][fLevel] = level;
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�umun seviyesi %d olarak g�ncellendi.", Character[playerid][cNickname], fid, level);
		}
		else if(!strcmp(opt, "levelbonus", true))
		{
			new levelbonus;
			if(sscanf(extra, "d", levelbonus)) return SendServerMessage(playerid, "/olusumduzenle [olu�um id] [levelbonus] [yeni bonus]");

			Faction[fid][fLevelBonus] = levelbonus;
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�umun seviye bonusu $%d olarak g�ncellendi.", Character[playerid][cNickname], fid, levelbonus);
		}
		else if(!strcmp(opt, "silaherisim", true))
		{
			new access;
			if(sscanf(extra, "d", access)) return SendServerMessage(playerid, "/olusumduzenle [olu�um id] [silaherisim] [0/1]");

			Faction[fid][fAccessToWeapons] = access;
			RefreshFaction(fid);
			switch(access)
			{
				case 0: SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�umun silah eri�imi kapat�ld�.", Character[playerid][cNickname], fid);
				case 1: SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�umun silah eri�imi a��ld�.", Character[playerid][cNickname], fid);
			}
		}
		else if(!strcmp(opt, "uerisim", true))
		{
			new access;
			if(sscanf(extra, "d", access)) return SendServerMessage(playerid, "/olusumduzenle [olu�um id] [uerisim] [0/1]");

			Faction[fid][fAccessToDrugs] = access;
			RefreshFaction(fid);
			switch(access)
			{
				case 0: SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�umun uyu�turucu eri�imi kapat�ld�.", Character[playerid][cNickname], fid);
				case 1: SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %d numaral� olu�umun uyu�turucu eri�imi a��ld�.", Character[playerid][cNickname], fid);
			}
		}
	}
	return true;
}

CMD:olusumsil(playerid, params[])
{
	if(Character[playerid][cNickname] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");
	new fid;
	if(sscanf(params, "d", fid)) return SendServerMessage(playerid, "/olusumsil [olu�um id]");
	if(!Faction[fid][fIsValid]) return  SendServerMessage(playerid, "Olu�um bulunamad�.");

	DeleteFaction(fid);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan bir olu�um silindi.", Character[playerid][cNickname]);
	return true;
}

CMD:makeleader(playerid, params[])
{
	if(Character[playerid][cNickname] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");
	new targetid, factid;
	if(sscanf(params, "ud", targetid, factid)) return SendServerMessage(playerid, "/makeleader [id/isim] [olu�um id]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");

	if(factid == 0)
	{
		Character[targetid][cFaction] = 0;
		Character[targetid][cFactionRank] = 0;
		SaveCharacterData(targetid);
		SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %s isimli oyuncu %d numaral� olu�uma lider olarak atand�.", Character[playerid][cNickname], GetRPName(targetid), factid);		
	}
	else
	{
		if(!Faction[factid][fIsValid]) return SendServerMessage(playerid, "Olu�um bulunamad�.");
		
		Character[targetid][cFaction] = Faction[factid][fID];
		Character[targetid][cFactionRank] = 1;
		SaveCharacterData(targetid);
		SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan %s isimli oyuncu %d numaral� olu�uma lider olarak atand�.", Character[playerid][cNickname], GetRPName(targetid), factid);
	}
	return true;
}

CMD:kickfaction(playerid, params[])
{
	if(Character[playerid][cNickname] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/kickfaction [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!Character[targetid][cFaction]) return SendServerMessage(playerid, "Ki�i bir olu�uma �ye de�il.");

	Character[targetid][cFaction] = 0;
	SendServerMessage(targetid, "%s taraf�ndan olu�umunuzdan ��kar�ld�n�z.", GetNickname(playerid));
	SendServerMessage(playerid, "%s isimli ki�iyi olu�umundan ��kartt�n�z.", GetRPName(targetid));
	return true;
}