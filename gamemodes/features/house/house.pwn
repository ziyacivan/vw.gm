CMD:evanahtar(playerid, params[])
{
	if(!PlayerCloseToHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");

	new targetid, houseid = GetPlayerNearbyHouse(playerid);
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/evanahtar [id/isim]");
	if(House[houseid][hOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu ev size ait deðil.");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerNearPlayer(playerid, targetid, 3.0)) return SendServerMessage(playerid, "Kiþi yakýnýnýzda deðil.");
	if(targetid == playerid) return SendServerMessage(playerid, "Kendinize anahtar veremezsiniz.");

	GiveHouseKey(playerid, targetid, houseid);
	return true;
}

CMD:evlerim(playerid)
{
	HouseList(playerid);
	return true;
}

CMD:evkilit(playerid, params[])
{
	if(!PlayerCloseToHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");

	new houseid = GetPlayerNearbyHouse(playerid);
	if((House[houseid][hOwner] != Character[playerid][cID]) && (House[houseid][hTenant] != Character[playerid][cID]) && (House[houseid][hKeyOwner] != Character[playerid][cID])) return SendServerMessage(playerid, "Bu ev size ait deðil.");
	
	switch(House[houseid][hLocked])
	{
		case 0: House[houseid][hLocked] = 1, SendServerMessage(playerid, "Evi kilitlediniz.");
		case 1: House[houseid][hLocked] = 0, SendServerMessage(playerid, "Evin kilidini açtýnýz.");
	}
	return true;
}

CMD:evsatinal(playerid, params[])
{
	if(!PlayerCloseToHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");

	new houseid = GetPlayerNearbyHouse(playerid);
	if(House[houseid][hOwner] != -1) return SendServerMessage(playerid, "Bu ev satýlýk deðil.");
	if(Character[playerid][cMoney] < House[houseid][hPrice]) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
	if(OfferMode[playerid]) return SendServerMessage(playerid, "Teklif modunda ev satýn alamazsýnýz.");

	House[houseid][hOwner] = Character[playerid][cID];
	RefreshHouse(houseid);
	GiveMoney(playerid, -1*House[houseid][hPrice]);
	SendServerMessage(playerid, "%d kapý numarasý olan evi satýn aldýnýz.", House[houseid][hDoorNumber]);
	return true;
}

CMD:evisistemesat(playerid, params[])
{
	if(!PlayerCloseToHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");

	new houseid = GetPlayerNearbyHouse(playerid);
	if(House[houseid][hOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu ev size ait deðil.");
	if(OfferMode[playerid]) return SendServerMessage(playerid, "Teklif modunda satýþ yapamazsýnýz.");

	new totalprice = House[houseid][hPrice] / 2;
	GiveMoney(playerid, totalprice);
	House[houseid][hOwner] = -1;
	House[houseid][hLocked] = 0;
	House[houseid][hKeyOwner] = -1;
	RefreshHouse(houseid);
	SendServerMessage(playerid, "%d kapý numarasý olan evinizi sattýnýz.", House[houseid][hDoorNumber]);
	return true;
}

CMD:evsat(playerid, params[])
{
	new targetid, price;
	if(sscanf(params, "ud", targetid, price)) return SendServerMessage(playerid, "/evsat [id/isim] [ücret]");
	if(!PlayerCloseToHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");
	new houseid = GetPlayerNearbyHouse(playerid);
	if(House[houseid][hOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu ev size ait deðil.");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerNearPlayer(playerid, targetid, 3.0)) return SendServerMessage(playerid, "Kiþi yakýnýnýzda deðil.");
	if(price <= 0) return SendServerMessage(playerid, "Satmak istediðiniz ücret minimum $1 olmalýdýr.");
	if(price > Character[targetid][cMoney]) return SendServerMessage(playerid, "Kiþinin yeterli parasý bulunmamaktadýr.");
	if(OfferMode[playerid]) return SendServerMessage(playerid, "Teklif modunda satýþ yapamazsýnýz.");
	if(OfferMode[targetid]) return SendServerMessage(playerid, "Kiþi teklif modunda.");
	if(playerid == targetid) return SendServerMessage(playerid, "Evinizi kendinize satamazsýnýz.");

	OfferHouseID[targetid] = houseid;
	OfferHousePrice[targetid] = price;
	OfferMode[targetid] = true;
	OfferOwnerID[targetid] = playerid;
	OfferMode[playerid] = true;

	SendHouseOffer(playerid, targetid, price, houseid);
	SendServerMessage(playerid, "%d kapý numaralý evinizi, %s isimli kiþiye $%d ücretle satmayý teklif ettiniz.", House[houseid][hDoorNumber], GetRPName(targetid), price);
	return true;
}

CMD:evkiraiptal(playerid, params[])
{
	if(!PlayerCloseToHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");

	new houseid = GetPlayerNearbyHouse(playerid);
	if(House[houseid][hOwner] == Character[playerid][cID] || House[houseid][hTenant] == Character[playerid][cID])
	{
		Character[playerid][cTenantHouseID] = -1;
		Character[playerid][cTenantPrice] = 0;
		House[houseid][hTenant] = 0;
		RefreshHouse(houseid);
		SendServerMessage(playerid, "%d kapý numaralý evin kira kontratýný iptal ettiniz.", House[houseid][hDoorNumber]);
	}
	else SendServerMessage(playerid, "Bu ev size ait deðil veya kiracý deðilsiniz.");
	return true;
}

CMD:evkirala(playerid, params[])
{
	if(!PlayerCloseToHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");

	new targetid, price, houseid = GetPlayerNearbyHouse(playerid);
	if(sscanf(params, "ud", targetid, price)) return SendServerMessage(playerid, "/evkirala [id/isim] [ücret]");
	if(House[houseid][hOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu ev size ait deðil.");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerNearPlayer(playerid, targetid, 3.0)) return SendServerMessage(playerid, "Kiþi yakýnýnýzda deðil.");
	if(price <= 0 || price > 5000) return SendServerMessage(playerid, "Minimum $0, maksimum $5000 kira ücreti belirleyebilirsiniz.");
	if(price > Character[targetid][cMoney]) return SendServerMessage(playerid, "Kiþinin yeterli parasý bulunmamaktadýr.");
	if(targetid == playerid) return SendServerMessage(playerid, "Evinizi kendinize kiralayamazsýnýz.");

	OfferHouseID[targetid] = houseid;
	OfferRentPrice[targetid] = price;
	OfferMode[targetid] = true;
	OfferOwnerID[targetid] = playerid;
	OfferMode[playerid] = true;

	SendHouseRentOffer(playerid, targetid, price, houseid);
	SendServerMessage(playerid, "%d kapý numaralý evinizi, %s isimli kiþiye $%d ücretle kiralamayý teklif ettiniz.", House[houseid][hDoorNumber], GetRPName(targetid), price);
	return true;
}

CMD:evid(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(!PlayerCloseToHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");

	SendServerMessage(playerid, "%d numaralý evdesiniz.", GetPlayerNearbyHouse(playerid));
	return true;
}

CMD:evyarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new price;
	if(sscanf(params, "d", price)) return SendServerMessage(playerid, "/evyarat [ücret]");
	if(price <= 0) return SendServerMessage(playerid,  "Ev ücreti minimum $1 olmalýdýr.");

	new Float:createPos[3];
	GetPlayerPos(playerid, createPos[0], createPos[1], createPos[2]);
	CreateHouse(playerid, price, createPos[0], createPos[1], createPos[2]);
	return true;
}

CMD:evsil(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new houseid;
	if(sscanf(params, "d", houseid)) return SendServerMessage(playerid, "/evsil [ev id]");
	if(!House[houseid][hIsValid]) return SendServerMessage(playerid, "Geçersiz id girdiniz.");

	DeleteHouse(playerid, houseid);
	return true;
}

CMD:evduzenle(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new houseid, opt[64], ext[124];
	if(sscanf(params, "ds[64]S()[124]", houseid, opt, ext))
	{
		SendClientMessage(playerid, C_GREY1, "/evduzenle [ev id] [seçenek]");
		SendClientMessage(playerid, C_GREY1, "sahip | kapino | ucret | giris | cikis | int | vw | kilit");
	}
	else
	{
		if(!House[houseid][hIsValid]) return SendServerMessage(playerid, "Geçersiz id girdiniz.");

		if(!strcmp(opt, "sahip", true))
		{
			new newowner;
			if(sscanf(ext, "u", newowner)) return SendServerMessage(playerid, "/evduzenle [ev id] [sahip] [id/isim]");
			if(!LoggedIn[newowner]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
			if(!IsPlayerConnected(newowner)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

			House[houseid][hOwner] = Character[newowner][cID];
			RefreshHouse(houseid);

			SendAdminMessage(C_ADMIN, "AdmWarn: %s isimli yönetici %d numaralý evin sahibini deðiþtirdi.", Character[playerid][cNickname], House[houseid][hDoorNumber]);
		}
		else if(!strcmp(opt, "kapino", true))
		{
			new doornumber;
			if(sscanf(ext, "d", doornumber)) return SendServerMessage(playerid, "/evduzenle [ev id] [kapino] [yeni numara]");
			if(doornumber < 111 || doornumber > 999) return SendServerMessage(playerid, "Kapý numarasý 3 haneli olmalýdýr.");

			House[houseid][hDoorNumber] = doornumber;
			RefreshHouse(houseid);
		}
		else if(!strcmp(opt, "ucret", true))
		{
			new newprice;
			if(sscanf(ext, "d", newprice)) return SendServerMessage(playerid, "/evduzenle [ev id] [ucret] [yeni ücret]");
			if(newprice <= 0) return SendServerMessage(playerid, "Evin ücreti minimum $1 olmalýdýr.");

			House[houseid][hPrice] = newprice;
			RefreshHouse(houseid);
		}
		else if(!strcmp(opt, "giris", true))
		{
			new Float:myPos[3];
			GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
			House[houseid][hExtDoor][0] = myPos[0];
			House[houseid][hExtDoor][1] = myPos[1];
			House[houseid][hExtDoor][2] = myPos[2];
			RefreshHouse(houseid);
		}
		else if(!strcmp(opt, "cikis", true))
		{
			new Float:myPos[3], myInt = GetPlayerInterior(playerid), myVW = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
			House[houseid][hIntDoor][0] = myPos[0];
			House[houseid][hIntDoor][1] = myPos[1];
			House[houseid][hIntDoor][2] = myPos[2];
			House[houseid][hInt] = myInt;
			House[houseid][hVW] = myVW;
			RefreshHouse(houseid);
		}
		else if(!strcmp(opt, "int", true))
		{
			new newint;
			if(sscanf(ext, "d", newint)) return SendServerMessage(playerid, "/evduzenle [ev id] [int] [yeni int]");
			if(newint < 0) return SendServerMessage(playerid, "Interior deðeri 0'dan düþük olamaz.");

			House[houseid][hInt] = newint;
			RefreshHouse(houseid);
		}
		else if(!strcmp(opt, "vw", true))
		{
			new newvw;
			if(sscanf(ext, "d", newvw)) return SendServerMessage(playerid, "/evduzenle [ev id] [vw] [yeni vw]");
			if(newvw < 0) return SendServerMessage(playerid, "Virtualworld deðeri 0'dan düþük olamaz.");

			House[houseid][hVW] = newvw;
			RefreshHouse(houseid);
		}
		else if(!strcmp(opt, "kilit", true))
		{
			new locked;
			if(sscanf(ext, "d", locked)) return SendServerMessage(playerid, "/evduzenle [ev id] [kilit] [1 ise kilitli  0 ise kapý açýk]");
			if(locked < 0 || locked > 1) return SendServerMessage(playerid, "Deðer 1 veya 0 olmalýdýr.");

			House[houseid][hLocked] = locked;
			RefreshHouse(houseid);
		}
	}
	return true;
}

Dialog:HOUSE_RENT_OFFER(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		new targetid = OfferOwnerID[playerid];
		SendServerMessage(targetid, "%s isimli kiþi teklifinizi reddetti.", GetRPName(playerid));
		SendServerMessage(playerid, "Teklifi reddettiniz.");

		OfferHouseID[playerid] = -1;
		OfferRentPrice[playerid] = 0;
		OfferMode[playerid] = false;
		OfferOwnerID[playerid] = -1;
		OfferMode[targetid] = false;
	}
	else
	{
		new houseid = OfferHouseID[playerid], price = OfferRentPrice[playerid], owner = OfferOwnerID[playerid];

		GiveMoney(playerid, -price);
		GiveMoney(owner, price);

		House[houseid][hTenant] = Character[playerid][cID];
		Character[playerid][cTenantHouseID] = House[houseid][hID];
		Character[playerid][cTenantPrice] = price;
		RefreshHouse(houseid);

		OfferHouseID[playerid] = -1;
		OfferHousePrice[playerid] = 0;
		OfferMode[playerid] = false;
		OfferOwnerID[playerid] = -1;
		OfferMode[owner] = false;

		SendServerMessage(playerid, "%d numaralý evi $%d ücretle kiraladýnýz.", House[houseid][hDoorNumber], price);
		SendServerMessage(owner, "%d numaralý evi $%d ücretle %s isimli kiþiye kiraladýnýz.", House[houseid][hDoorNumber], price);
	}
	return true;
}

Dialog:HOUSE_OFFER(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		new targetid = OfferOwnerID[playerid];
		SendServerMessage(targetid, "%s isimli kiþi teklifinizi reddetti.", GetRPName(playerid));
		SendServerMessage(playerid, "Teklifi reddettiniz.");

		OfferHouseID[playerid] = -1;
		OfferHousePrice[playerid] = 0;
		OfferMode[playerid] = false;
		OfferOwnerID[playerid] = -1;
		OfferMode[targetid] = false;
	}
	else
	{
		new houseid = OfferHouseID[playerid], price = OfferHousePrice[playerid], oldowner = OfferOwnerID[playerid];

		GiveMoney(playerid, -price);
		GiveMoney(oldowner, price);

		House[houseid][hOwner] = Character[playerid][cID];
		House[houseid][hLocked] = 0;
		RefreshHouse(houseid);

		OfferHouseID[playerid] = -1;
		OfferHousePrice[playerid] = 0;
		OfferMode[playerid] = false;
		OfferOwnerID[playerid] = -1;
		OfferMode[oldowner] = false;

		SendServerMessage(playerid, "%d numaralý evi $%d ücretle satýn aldýnýz.", House[houseid][hDoorNumber], price);
		SendServerMessage(oldowner, "%d numaralý evi $%d ücretle %s isimli kiþiye sattýnýz.", House[houseid][hDoorNumber], price, GetRPName(playerid));
	}
	return true;
}

Vinewood:GetHouseIDbyDBID(dbid)
{
	new status = -1;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(House[i][hID] == dbid)
		{
			status = i;
		}
	}
	return status;
}

Vinewood:GiveHouseKey(playerid, targetid, houseid)
{
	House[houseid][hKeyOwner] = Character[targetid][cID];
	SendServerMessage(playerid, "%s isimli kiþiye evinizin anahtarýný verdiniz.", GetRPName(targetid));
	SendServerMessage(targetid, "%s isimli kiþi size evinin anahtarýný verdi.", GetRPName(playerid));
	return true;
}

Vinewood:HouseList(playerid)
{
	new count = 0;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(House[i][hOwner] == Character[playerid][cID])
		{
			SendClientMessageEx(playerid, -1, "{F0F2A5}__________________[www.vw-rp.com]__________________");
			SendClientMessageEx(playerid, C_GREY1, "Ev ID: [%d] | Kapý Numarasý: [%d] | Ücret: [$%d]", i, House[i][hDoorNumber], House[i][hPrice]);
			count++;
		}
		else if(House[i][hTenant] == Character[playerid][cID])
		{
			SendClientMessageEx(playerid, C_GREY1, "Ev ID: [%d] | Kapý Numarasý: [%d] | Kira Ücreti: [%d]", i, House[i][hDoorNumber], Character[playerid][cTenantPrice]);
		}
	}
	if(count == 0) return SendServerMessage(playerid, "Eviniz bulunmamaktadýr.");
	return true;
}

Vinewood:SendHouseRentOffer(playerid, targetid, price, houseid)
{
	new str[512];
	format(str, sizeof(str), "{FFFFFF}%s isimli kiþiden, %d kapý numaralý evi {268126}$%d {FFFFFF}ücretle kiralama teklifi aldýnýz.\n{FFFFFF}Teklifi onaylýyor musunuz?", GetRPName(playerid), House[houseid][hDoorNumber], price);
	Dialog_Show(targetid, HOUSE_RENT_OFFER, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Teklif", str, "Onayla", "Reddet");
	return true;
}

Vinewood:SendHouseOffer(playerid, targetid, price, houseid)
{
	new str[512];
	format(str, sizeof(str), "{FFFFFF}%s isimli kiþiden, %d kapý numaralý evi {268126}$%d {FFFFFF}ücretle satýþ teklifi aldýnýz.\n{FFFFFF}Teklifi onaylýyor musunuz?", GetRPName(playerid), House[houseid][hDoorNumber], price);
	Dialog_Show(targetid, HOUSE_OFFER, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Teklif", str, "Onayla", "Reddet");
	return true;
}

Vinewood:DeleteHouse(playerid, houseid)
{
	if(IsValidDynamicCP(House[houseid][hCheckpoint]))
		DestroyDynamicCP(House[houseid][hCheckpoint]);

	new query[128], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM houses WHERE id = '%i'", House[houseid][hID]);
	DeleteData = mysql_query(conn, query);
	cache_delete(DeleteData);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s isimli yönetici %d numaralý evi sildi.", Character[playerid][cNickname], houseid);

	House[houseid][hID] = 0;
	House[houseid][hIsValid] = false;
	House[houseid][hOwner] = -1;
	House[houseid][hTenant] = -1;
	Iter_Remove(Houses, houseid);
	return true;
}

Vinewood:CreateHouse(playerid, price, Float:x, Float:y, Float:z)
{
	new houseid = Iter_Free(Houses), query[512], doornumber = randomEx(111,999), Cache:InsertData;
	mysql_format(conn, query, sizeof(query), "INSERT INTO houses (Owner, Door_Number, Price, Exterior_Door_X, Exterior_Door_Y, Exterior_Door_Z, Interior_Door_X, Interior_Door_Y, Interior_Door_Z, Interior, VW, Locked) VALUES (-1, %i, %i, %.4f, %.4f, %.4f, 0.0, 0.0, 0.0, 0, 0, 0)", doornumber, price, x, y, z);
	InsertData = mysql_query(conn, query);

	House[houseid][hIsValid] = true;
	House[houseid][hID] = cache_insert_id();
	House[houseid][hOwner] = -1;
	House[houseid][hDoorNumber] = doornumber;
	House[houseid][hPrice] = price;
	House[houseid][hExtDoor][0] = x;
	House[houseid][hExtDoor][1] = y;
	House[houseid][hExtDoor][2] = z;
	House[houseid][hIntDoor][0] = 0.0;
	House[houseid][hIntDoor][1] = 0.0;
	House[houseid][hIntDoor][2] = 0.0;
	House[houseid][hInt] = 0;
	House[houseid][hVW] = 0;
	House[houseid][hLocked] = 0;
	House[houseid][hKeyOwner] = -1;
	House[houseid][hTenant] = -1;
	House[houseid][hCheckpoint] = CreateDynamicCP(House[houseid][hExtDoor][0], House[houseid][hExtDoor][1], House[houseid][hExtDoor][2], 1, 0, 0);
	House[houseid][hPlayersInside] = 0;

	foreach(new i : Player) if(IsPlayerConnected(i))
		TogglePlayerDynamicCP(i, House[houseid][hCheckpoint], false);

	SendAdminMessage(C_ADMIN, "AdmWarn: %s isimli yönetici %d numaralý evi $%d ücretle yarattý.", Character[playerid][cNickname], houseid, price);
	cache_delete(InsertData);
	Iter_Add(Houses, houseid);
	return true;
}

Vinewood:GetHouseIDFromInt(playerid)
{
	new houseid;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 30.0, House[i][hIntDoor][0], House[i][hIntDoor][1], House[i][hIntDoor][2]))
		{
			houseid = i;
		}
	}
	return houseid;
}

Vinewood:PlayerCloseToHouse(playerid)
{
	new status = 0;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, House[i][hExtDoor][0], House[i][hExtDoor][1], House[i][hExtDoor][2]) || IsPlayerInRangeOfPoint(playerid, 3.0, House[i][hIntDoor][0], House[i][hIntDoor][1], House[i][hIntDoor][2]))
		{
			status = 1;
		}
	}
	return status;
}

Vinewood:GetPlayerNearbyHouse(playerid)
{
	new houseid;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, House[i][hExtDoor][0], House[i][hExtDoor][1], House[i][hExtDoor][2]) || IsPlayerInRangeOfPoint(playerid, 3.0, House[i][hIntDoor][0], House[i][hIntDoor][1], House[i][hIntDoor][2]))
			houseid = i;
	}
	return houseid;
}

Vinewood:HouseOutDoor(playerid)
{
	new status = 0;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, House[i][hExtDoor][0], House[i][hExtDoor][1], House[i][hExtDoor][2]))
			status = 1;
	}
	return status;
}

Vinewood:HouseIntDoor(playerid)
{
	new status = 0;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, House[i][hIntDoor][0], House[i][hIntDoor][1], House[i][hIntDoor][2]))
			status = 1;
	}
	return status;
}

Vinewood:HouseLimit()
{
	new houselimit = 0;
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(i == MAX_HOUSES)
			houselimit = 1;
	}
	return houselimit;
}

Vinewood:LoadHouses()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	Iter_Add(Houses, 0);

	for(new i = 0; i < rows; i++)
	{
		House[i+1][hIsValid] = true;

		cache_get_value_name_int(i, "id", House[i+1][hID]);
		cache_get_value_name_int(i, "Owner", House[i+1][hOwner]);
		cache_get_value_name_int(i, "Door_Number", House[i+1][hDoorNumber]);
		cache_get_value_name_int(i, "Price", House[i+1][hPrice]);
		cache_get_value_name_float(i, "Exterior_Door_X", House[i+1][hExtDoor][0]);
		cache_get_value_name_float(i, "Exterior_Door_Y", House[i+1][hExtDoor][1]);
		cache_get_value_name_float(i, "Exterior_Door_Z", House[i+1][hExtDoor][2]);
		cache_get_value_name_float(i, "Interior_Door_X", House[i+1][hIntDoor][0]);
		cache_get_value_name_float(i, "Interior_Door_Y", House[i+1][hIntDoor][1]);
		cache_get_value_name_float(i, "Interior_Door_Z", House[i+1][hIntDoor][2]);
		cache_get_value_name_int(i, "Interior", House[i+1][hInt]);
		cache_get_value_name_int(i, "VW", House[i+1][hVW]);
		cache_get_value_name_int(i, "Locked", House[i+1][hLocked]);
		cache_get_value_name_int(i, "Key_Owner", House[i+1][hKeyOwner]);
		cache_get_value_name_int(i, "Level", House[i+1][hLevel]);
		cache_get_value_name_int(i, "Tenant", House[i+1][hTenant]);

		House[i+1][hPlayersInside] = 0;

		House[i+1][hCheckpoint] = CreateDynamicCP(House[i+1][hExtDoor][0], House[i+1][hExtDoor][1], House[i+1][hExtDoor][2], 1, 0, 0);
		rowcount++;
		Iter_Add(Houses, i+1);
	}

	if(rowcount) return printf("VinewoodDB >> %d adet ev yüklendi.", rowcount);
	printf("VinewoodDB >> Veritabanýnda ev bulunmuyor.");
	return true;
}

Vinewood:RefreshHouse(houseid)
{
	if(!House[houseid][hIsValid]) return true;

	if(IsValidDynamicCP(House[houseid][hCheckpoint]))
		DestroyDynamicCP(House[houseid][hCheckpoint]);

	House[houseid][hCheckpoint] = CreateDynamicCP(House[houseid][hExtDoor][0], House[houseid][hExtDoor][1], House[houseid][hExtDoor][2], 1, 0, 0);

	new query[1024], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE houses SET Owner = %i, Door_Number = %i, Price = %i, Exterior_Door_X = %.4f, Exterior_Door_Y = %.4f, Exterior_Door_Z = %.4f, Interior_Door_X = %.4f, Interior_Door_Y = %.4f, Interior_Door_Z = %.4f, Interior = %i, VW = %i, Locked = %i, Key_Owner = %i, Level = %i, Tenant = %i WHERE id = '%i'",
		House[houseid][hOwner],
		House[houseid][hDoorNumber],
		House[houseid][hPrice],
		House[houseid][hExtDoor][0],
		House[houseid][hExtDoor][1],
		House[houseid][hExtDoor][2],
		House[houseid][hIntDoor][0],
		House[houseid][hIntDoor][1],
		House[houseid][hIntDoor][2],
		House[houseid][hInt],
		House[houseid][hVW],
		House[houseid][hLocked],
		House[houseid][hKeyOwner],
		House[houseid][hLevel],
		House[houseid][hTenant],
	House[houseid][hID]); UpdateData = mysql_query(conn, query);
	cache_delete(UpdateData);

	//SendAdminMessage(C_ADMIN, "AdmWarn: %s isimli yönetici %d numaralý evin bilgilerini güncelledi.", Character[playerid][cNickname], houseid);
	return true;
}

Vinewood:GetNearestHouse(playerid)
{
	new house = 0;
	foreach(new i : Houses) if(House[i][hIsValid]) {
		if(IsPlayerInRangeOfPoint(playerid, 10.0, House[i][hExtDoor][0], House[i][hExtDoor][1], House[i][hExtDoor][2])) {
			house = i;
			break;
		}
	}
	return house;
}

stock GetHouseOwnerName(ownerid)
{
	new ownername[144], query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM characters WHERE id = '%i'", ownerid);
	GetData = mysql_query(conn, query);

	if(cache_num_rows())
	{
		cache_get_value_name(0, "Character_Name", ownername, 144);
	}
	cache_delete(GetData);
	return ownername;
}