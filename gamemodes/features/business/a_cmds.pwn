CMD:isyeriyarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(Iter_Count(Business) >= MAX_BUSINESS) return SendServerMessage(playerid, "Ýþyeri limiti aþýldý.");

	new bname[124], type;
	if(sscanf(params, "ds[124]", type, bname))
	{
		SendServerMessage(playerid, "/isyeriyarat [tip] [isim]");
		SendClientMessage(playerid, C_GREY1, "Tipler >>");
		SendClientMessage(playerid, C_GREY1, "1: Market, 2: Ýçki Dükkaný, 3: Pawn Shop, 4: Restaurant, 5: Bar/Gece Kulübü");
		SendClientMessage(playerid, C_GREY1, "6: Tamirhane, 7: Spor Salonu, 8: Kumarhane, 9: Silah Dükkaný, 10: Kýyafet Dükkaný");
	}
	else
	{
		if(strlen(bname) <= 0 || strlen(bname) > 124) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");
		if(type < 1 || type > 10) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");

		new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

		new query[1024], Cache:InsertData;
		mysql_format(conn, query, sizeof(query), "INSERT INTO business (Owner, Name, Type, ExtX, ExtY, ExtZ, IntX, IntY, IntZ, Interior, VW, Locked) VALUES (-1, '%e', %i, %.4f, %.4f, %.4f, 0.0, 0.0, 0.0, 0, 0, 0)",
			bname, type, pos[0], pos[1], pos[2]);
		InsertData = mysql_query(conn, query);

		new bsid = Iter_Free(Business);
		Business[bsid][bsID] = cache_insert_id();
		Business[bsid][bsIsValid] = true;
		Business[bsid][bsOwner] = -1;
		format(Business[bsid][bsName], 124, "%s", bname);
		Business[bsid][bsType] = type;
		Business[bsid][bsExtDoor][0] = pos[0];
		Business[bsid][bsExtDoor][1] = pos[1];
		Business[bsid][bsExtDoor][2] = pos[2];
		Business[bsid][bsIntDoor][0] = 0.0;
		Business[bsid][bsIntDoor][1] = 0.0;
		Business[bsid][bsIntDoor][2] = 0.0;
		Business[bsid][bsInt] = 0;
		Business[bsid][bsVW] = 0;
		Business[bsid][bsLocked] = 0;

		Business[bsid][bsPickup] = CreateDynamicPickup(1272, 1, Business[bsid][bsExtDoor][0], Business[bsid][bsExtDoor][1], Business[bsid][bsExtDoor][2], 0, 0);
		cache_delete(InsertData);
		Iter_Add(Business, bsid);
	}
	return true;
}

CMD:isyeriduzenle(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new bsid, opt[64], ext[124];
	if(sscanf(params, "ds[64]S()[124]", bsid, opt, ext))
	{
		SendServerMessage(playerid, "/isyeriduzenle [iþyeri id] [seçim] [yeni deðer]");
		SendClientMessage(playerid, C_GREY1, "sahip | isim | tip | diskapi | ickapi | kilit | kasa");
	}
	else
	{
		if(!Business[bsid][bsIsValid]) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");

		if(!strcmp(opt, "sahip", true))
		{
			new newowner;
			if(sscanf(ext, "u", newowner)) return SendServerMessage(playerid, "/isyeriduzenle [iþyeri id] [sahip] [id/isim]");
			if(!LoggedIn[newowner]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
			if(!IsPlayerConnected(newowner)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

			Business[bsid][bsOwner] = Character[newowner][cID];
			RefreshBusiness(bsid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletmenin sahibi deðiþtirildi.", GetNickname(playerid), bsid);
		}
		else if(!strcmp(opt, "isim", true))
		{
			new newname[124];
			if(sscanf(ext, "s[124]", newname)) return SendServerMessage(playerid, "/isyeriduzenle [iþyeri id] [isim] [yeni isim(124)]");
			if(strlen(newname) <= 0 || strlen(newname) > 124) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");

			format(Business[bsid][bsName], 124, "%s", newname);
			RefreshBusiness(bsid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletmenin ismi deðiþtirildi.", GetNickname(playerid), bsid);
		}
		else if(!strcmp(opt, "tip", true))
		{
			new newtype;
			if(sscanf(ext, "d", newtype))
			{
				SendServerMessage(playerid, "/isyeriduzenle [iþyeri id] [tip] [yeni tip]");
				SendClientMessage(playerid, C_GREY1, "Tipler >>");
				SendClientMessage(playerid, C_GREY1, "1: Market, 2: Ýþçi Dükkaný, 3: Pawn Shop, 4: Restaurant, 5: Bar/Gece Kulübü");
				SendClientMessage(playerid, C_GREY1, "6: Tamirhane, 7: Spor Salonu, 8: Kumarhane, 9: Silah Dükkaný, 10: Kýyafet Dükkaný");
			}
			else
			{
				if(newtype < 1 || newtype > 10) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");

				Business[bsid][bsType] = newtype;
				RefreshBusiness(bsid);
				SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletmenin tipi deðiþtirildi.", GetNickname(playerid), bsid);
			}	
		}
		else if(!strcmp(opt, "diskapi", true))
		{
			new Float:pos[3];
			GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

			Business[bsid][bsExtDoor][0] = pos[0];
			Business[bsid][bsExtDoor][1] = pos[1];
			Business[bsid][bsExtDoor][2] = pos[2];
			RefreshBusiness(bsid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletmenin konumu deðiþtirildi (%s).", GetNickname(playerid), bsid, GetLocation(pos[0], pos[1], pos[2]));
		}
		else if(!strcmp(opt, "ickapi", true))
		{
			new Float:pos[3], int = GetPlayerInterior(playerid), vw = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

			Business[bsid][bsIntDoor][0] = pos[0];
			Business[bsid][bsIntDoor][1] = pos[1];
			Business[bsid][bsIntDoor][2] = pos[2];
			Business[bsid][bsInt] = int;
			Business[bsid][bsVW] = vw;
			RefreshBusiness(bsid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletmenin iç kapý konumu deðiþtirildi.", GetNickname(playerid), bsid);
		}
		else if(!strcmp(opt, "kilit", true))
		{
			switch(Business[bsid][bsLocked])
			{
				case 0:
				{
					Business[bsid][bsLocked] = 1;
					SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletmenin kapýlarý kilitlendi.", GetNickname(playerid), bsid);
				}
				case 1:
				{
					Business[bsid][bsLocked] = 0;
					SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletmenin kilitleri açýldý.", GetNickname(playerid), bsid);
				}
			}
		}
		else if(!strcmp(opt, "kasa", true))
		{
			new amount;
			if(sscanf(ext, "d", amount)) return SendServerMessage(playerid, "/isyeriduzenle [iþyeri id] [kasa] [yeni deðer]");

			Business[bsid][bsSafe] = amount;
			RefreshBusiness(bsid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletmenin kasa deðeri $%d olarak deðiþtirildi.", GetNickname(playerid), bsid, amount);
		}
	}
	return true;
}

CMD:isyerisil(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new bsid;
	if(sscanf(params, "d", bsid)) return SendServerMessage(playerid, "/isyerisil [iþyeri id]");
	if(!Business[bsid][bsIsValid]) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");

	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý iþletme silindi.", GetNickname(playerid), bsid);
	DeleteBusiness(bsid);
	return true;
}

CMD:isyeriid(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");

	SendServerMessage(playerid, "%d numaralý iþyerindesiniz.", GetBusinessID(playerid));
	return true;
}

CMD:gitisyeri(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new bsid;
	if(sscanf(params, "d", bsid)) return SendServerMessage(playerid, "/gitisyeri [iþyeri id]");
	if(!Business[bsid][bsIsValid]) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");

	SetPlayerPos(playerid, Business[bsid][bsExtDoor][0], Business[bsid][bsExtDoor][1], Business[bsid][bsExtDoor][2]);
	return true;
}