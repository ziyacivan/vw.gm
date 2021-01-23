CMD:olusumyarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(FactionLimit()) return SendServerMessage(playerid, "Oluþum limiti aþýldý.");

	new name[144], type;
	if(sscanf(params, "ds[144]", type, name))
	{
		SendServerMessage(playerid, "/olusumyarat [tip] [isim]");
		SendClientMessage(playerid, C_GREY1, "0: Sivil | 1: LSPD | 2: LSMD | 3: LSFD | 4: Basýn | 5: GOV");
	}
	else
	{
		if(type < 0 || type > 5) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");

		CreateFaction(name, type);
		SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %s isimle bir oluþum oluþturuldu.", Character[playerid][cNickname], name);
	}
	return true;
}

CMD:olusumduzenle(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new fid, opt[64], extra[124];
	if(sscanf(params, "ds[64]S()[124]", fid, opt, extra))
	{
		SendServerMessage(playerid, "/olusumduzenle [oluþum id] [seçenek] [ekstra]");
		SendClientMessage(playerid, C_GREY1, "isim | tip | girisrutbe | level | levelbonus | silaherisim | uerisim");
	}
	else 
	{
		if(!Faction[fid][fIsValid]) return SendServerMessage(playerid, "Oluþum bulunamadý.");

		if(!strcmp(opt, "isim", true))
		{
			new name[144];
			if(sscanf(extra, "s[144]", name))  return SendServerMessage(playerid, "/olusumduzenle [oluþum id] [isim] [yeni isim(144)]");
			
			format(Faction[fid][fName], 144, "%e", name);
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþum ismi %s olarak güncellendi.", Character[playerid][cNickname], fid, Faction[fid][fName]);
		}
		else if(!strcmp(opt, "tip", true))
		{
			new type;
			if(sscanf(extra, "d", type)) return SendServerMessage(playerid, "/olusumduzenle [oluþum id] [tip] [yeni tip]");
			if(type < 0 || type > 5) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");

			Faction[fid][fType] = type;
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþum tipi güncellendi.", Character[playerid][cNickname], fid);
		}
		else if(!strcmp(opt, "girisrutbe", true))
		{
			new loginrank;
			if(sscanf(extra, "d", loginrank)) return SendServerMessage(playerid, "/olusumduzenle [oluþum id] [girisrutbe] [yeni rütbe]");
			if(loginrank < 1 || loginrank > 12) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");

			Faction[fid][fLoginRank] = loginrank;
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþumun giriþ rütbesi güncellendi.", Character[playerid][cNickname], fid);
		}
		else if(!strcmp(opt, "level", true))
		{
			new level;
			if(sscanf(extra, "d", level)) return SendServerMessage(playerid, "/olusumduzenle [oluþum id] [level] [yeni level]");

			Faction[fid][fLevel] = level;
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþumun seviyesi %d olarak güncellendi.", Character[playerid][cNickname], fid, level);
		}
		else if(!strcmp(opt, "levelbonus", true))
		{
			new levelbonus;
			if(sscanf(extra, "d", levelbonus)) return SendServerMessage(playerid, "/olusumduzenle [oluþum id] [levelbonus] [yeni bonus]");

			Faction[fid][fLevelBonus] = levelbonus;
			RefreshFaction(fid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþumun seviye bonusu $%d olarak güncellendi.", Character[playerid][cNickname], fid, levelbonus);
		}
		else if(!strcmp(opt, "silaherisim", true))
		{
			new access;
			if(sscanf(extra, "d", access)) return SendServerMessage(playerid, "/olusumduzenle [oluþum id] [silaherisim] [0/1]");

			Faction[fid][fAccessToWeapons] = access;
			RefreshFaction(fid);
			switch(access)
			{
				case 0: SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþumun silah eriþimi kapatýldý.", Character[playerid][cNickname], fid);
				case 1: SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþumun silah eriþimi açýldý.", Character[playerid][cNickname], fid);
			}
		}
		else if(!strcmp(opt, "uerisim", true))
		{
			new access;
			if(sscanf(extra, "d", access)) return SendServerMessage(playerid, "/olusumduzenle [oluþum id] [uerisim] [0/1]");

			Faction[fid][fAccessToDrugs] = access;
			RefreshFaction(fid);
			switch(access)
			{
				case 0: SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþumun uyuþturucu eriþimi kapatýldý.", Character[playerid][cNickname], fid);
				case 1: SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý oluþumun uyuþturucu eriþimi açýldý.", Character[playerid][cNickname], fid);
			}
		}
	}
	return true;
}

CMD:olusumsil(playerid, params[])
{
	if(Character[playerid][cNickname] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new fid;
	if(sscanf(params, "d", fid)) return SendServerMessage(playerid, "/olusumsil [oluþum id]");
	if(!Faction[fid][fIsValid]) return  SendServerMessage(playerid, "Oluþum bulunamadý.");

	DeleteFaction(fid);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir oluþum silindi.", Character[playerid][cNickname]);
	return true;
}

CMD:makeleader(playerid, params[])
{
	if(Character[playerid][cNickname] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new targetid, factid;
	if(sscanf(params, "ud", targetid, factid)) return SendServerMessage(playerid, "/makeleader [id/isim] [oluþum id]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	if(factid == 0)
	{
		Character[targetid][cFaction] = 0;
		Character[targetid][cFactionRank] = 0;
		SaveCharacterData(targetid);
		SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %s isimli oyuncu %d numaralý oluþuma lider olarak atandý.", Character[playerid][cNickname], GetRPName(targetid), factid);		
	}
	else
	{
		if(!Faction[factid][fIsValid]) return SendServerMessage(playerid, "Oluþum bulunamadý.");
		
		Character[targetid][cFaction] = Faction[factid][fID];
		Character[targetid][cFactionRank] = 1;
		SaveCharacterData(targetid);
		SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %s isimli oyuncu %d numaralý oluþuma lider olarak atandý.", Character[playerid][cNickname], GetRPName(targetid), factid);
	}
	return true;
}

CMD:kickfaction(playerid, params[])
{
	if(Character[playerid][cNickname] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/kickfaction [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!Character[targetid][cFaction]) return SendServerMessage(playerid, "Kiþi bir oluþuma üye deðil.");

	Character[targetid][cFaction] = 0;
	SendServerMessage(targetid, "%s tarafýndan oluþumunuzdan çýkarýldýnýz.", GetNickname(playerid));
	SendServerMessage(playerid, "%s isimli kiþiyi oluþumundan çýkarttýnýz.", GetRPName(targetid));
	return true;
}