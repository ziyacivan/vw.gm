CMD:isyeriyarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");
	if(Iter_Count(Business) >= MAX_BUSINESS) return SendServerMessage(playerid, "��yeri limiti a��ld�.");

	new bname[124], type;
	if(sscanf(params, "ds[124]", type, bname))
	{
		SendServerMessage(playerid, "/isyeriyarat [tip] [isim]");
		SendClientMessage(playerid, C_GREY1, "Tipler >>");
		SendClientMessage(playerid, C_GREY1, "1: Market, 2: ��ki D�kkan�, 3: Pawn Shop, 4: Restaurant, 5: Bar/Gece Kul�b�");
		SendClientMessage(playerid, C_GREY1, "6: Tamirhane, 7: Spor Salonu, 8: Kumarhane, 9: Silah D�kkan�, 10: K�yafet D�kkan�");
	}
	else
	{
		if(strlen(bname) <= 0 || strlen(bname) > 124) return SendServerMessage(playerid, "Ge�ersiz karakter say�s� girdiniz.");
		if(type < 1 || type > 10) return SendServerMessage(playerid, "Ge�ersiz tip girdiniz.");

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
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");

	new bsid, opt[64], ext[124];
	if(sscanf(params, "ds[64]S()[124]", bsid, opt, ext))
	{
		SendServerMessage(playerid, "/isyeriduzenle [i�yeri id] [se�im] [yeni de�er]");
		SendClientMessage(playerid, C_GREY1, "sahip | isim | tip | diskapi | ickapi | kilit | kasa");
	}
	else
	{
		if(!Business[bsid][bsIsValid]) return SendServerMessage(playerid, "��yeri bulunamad�.");

		if(!strcmp(opt, "sahip", true))
		{
			new newowner;
			if(sscanf(ext, "u", newowner)) return SendServerMessage(playerid, "/isyeriduzenle [i�yeri id] [sahip] [id/isim]");
			if(!LoggedIn[newowner]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
			if(!IsPlayerConnected(newowner)) return SendServerMessage(playerid, "Ki�i bulunamad�.");

			Business[bsid][bsOwner] = Character[newowner][cID];
			RefreshBusiness(bsid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letmenin sahibi de�i�tirildi.", GetNickname(playerid), bsid);
		}
		else if(!strcmp(opt, "isim", true))
		{
			new newname[124];
			if(sscanf(ext, "s[124]", newname)) return SendServerMessage(playerid, "/isyeriduzenle [i�yeri id] [isim] [yeni isim(124)]");
			if(strlen(newname) <= 0 || strlen(newname) > 124) return SendServerMessage(playerid, "Ge�ersiz karakter say�s� girdiniz.");

			format(Business[bsid][bsName], 124, "%s", newname);
			RefreshBusiness(bsid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letmenin ismi de�i�tirildi.", GetNickname(playerid), bsid);
		}
		else if(!strcmp(opt, "tip", true))
		{
			new newtype;
			if(sscanf(ext, "d", newtype))
			{
				SendServerMessage(playerid, "/isyeriduzenle [i�yeri id] [tip] [yeni tip]");
				SendClientMessage(playerid, C_GREY1, "Tipler >>");
				SendClientMessage(playerid, C_GREY1, "1: Market, 2: ���i D�kkan�, 3: Pawn Shop, 4: Restaurant, 5: Bar/Gece Kul�b�");
				SendClientMessage(playerid, C_GREY1, "6: Tamirhane, 7: Spor Salonu, 8: Kumarhane, 9: Silah D�kkan�, 10: K�yafet D�kkan�");
			}
			else
			{
				if(newtype < 1 || newtype > 10) return SendServerMessage(playerid, "Ge�ersiz tip girdiniz.");

				Business[bsid][bsType] = newtype;
				RefreshBusiness(bsid);
				SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letmenin tipi de�i�tirildi.", GetNickname(playerid), bsid);
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
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letmenin konumu de�i�tirildi (%s).", GetNickname(playerid), bsid, GetLocation(pos[0], pos[1], pos[2]));
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
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letmenin i� kap� konumu de�i�tirildi.", GetNickname(playerid), bsid);
		}
		else if(!strcmp(opt, "kilit", true))
		{
			switch(Business[bsid][bsLocked])
			{
				case 0:
				{
					Business[bsid][bsLocked] = 1;
					SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letmenin kap�lar� kilitlendi.", GetNickname(playerid), bsid);
				}
				case 1:
				{
					Business[bsid][bsLocked] = 0;
					SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letmenin kilitleri a��ld�.", GetNickname(playerid), bsid);
				}
			}
		}
		else if(!strcmp(opt, "kasa", true))
		{
			new amount;
			if(sscanf(ext, "d", amount)) return SendServerMessage(playerid, "/isyeriduzenle [i�yeri id] [kasa] [yeni de�er]");

			Business[bsid][bsSafe] = amount;
			RefreshBusiness(bsid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letmenin kasa de�eri $%d olarak de�i�tirildi.", GetNickname(playerid), bsid, amount);
		}
	}
	return true;
}

CMD:isyerisil(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");

	new bsid;
	if(sscanf(params, "d", bsid)) return SendServerMessage(playerid, "/isyerisil [i�yeri id]");
	if(!Business[bsid][bsIsValid]) return SendServerMessage(playerid, "��yeri bulunamad�.");

	SendAdminMessage(C_ADMIN, "AdmWarn: %s taraf�ndan, %d numaral� i�letme silindi.", GetNickname(playerid), bsid);
	DeleteBusiness(bsid);
	return true;
}

CMD:isyeriid(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "��yeri bulunamad�.");

	SendServerMessage(playerid, "%d numaral� i�yerindesiniz.", GetBusinessID(playerid));
	return true;
}

CMD:gitisyeri(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");

	new bsid;
	if(sscanf(params, "d", bsid)) return SendServerMessage(playerid, "/gitisyeri [i�yeri id]");
	if(!Business[bsid][bsIsValid]) return SendServerMessage(playerid, "��yeri bulunamad�.");

	SetPlayerPos(playerid, Business[bsid][bsExtDoor][0], Business[bsid][bsExtDoor][1], Business[bsid][bsExtDoor][2]);
	return true;
}