CMD:aracliste(playerid)
{
	VehicleList(playerid);
	return true;
}

CMD:aracolusum(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araç içerisinde olmalýsýnýz.");
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir oluþuma üye deðilsiniz.");

	new vehid = GetPlayerVehicleID(playerid);
	if(Vehicle[vehid][vOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Araç size ait deðil.");

	if(!Vehicle[vehid][vFaction])
	{
		new fid = GetPlayerFactionID(playerid);
		Vehicle[vehid][vFaction] = Faction[fid][fID];
		RefreshVehicle(vehid);
		SendServerMessage(playerid, "%s model aracýnýza oluþum kullaným yetkisi verdiniz.", ReturnVehicleModelName(Vehicle[vehid][vModel]));
	}
	else
	{
		Vehicle[vehid][vFaction] = 0;
		RefreshVehicle(vehid);
		SendServerMessage(playerid, "%s model aracýnýzý oluþumdan çýkarttýnýz.", ReturnVehicleModelName(Vehicle[vehid][vModel]));
	}
	return true;
}

CMD:aracdurum(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araç içerisinde olmalýsýnýz.");

	new vehid = GetPlayerVehicleID(playerid);
	if((Vehicle[vehid][vFaction]) == 1 && (Vehicle[vehid][vFaction] == 2) && (Vehicle[vehid][vFaction] == 3) && (Vehicle[vehid][vFaction] == 4) && (Vehicle[vehid][vFaction] == 5))
		return SendServerMessage(playerid, "Bu araçta bu komut kullanýlamaz.");

	if(Vehicle[vehid][vOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Araç size ait deðil.");

	SendClientMessageEx(playerid, C_GREY1, "Motor Ömrü: [%.2f] | Akü Ömrü: [%.2f] | Araç KM: [%d]", Vehicle[vehid][vEngineLife], Vehicle[vehid][vBatteryLife], Vehicle[vehid][vKM]);
	SendClientMessageEx(playerid, C_GREY1, "Renk 1: [%d] | Renk 2: [%d] | Plaka: [%s]", Vehicle[vehid][vColor1], Vehicle[vehid][vColor2], Vehicle[vehid][vPlate]);
	SendClientMessageEx(playerid, C_GREY1, "Kilit Seviyesi: [%d] | Alarm Seviyesi: [%d]", Vehicle[vehid][vLockLevel], Vehicle[vehid][vAlarmLevel]);
	return true;
}

CMD:aracparkkontrol(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araç içerisinde olmalýsýnýz.");

	switch(VehicleParkAreaControl(playerid))
	{
		case 0: GameTextForPlayer(playerid, "~w~PARK ~g~EDILEBILIR", 3000, 4);
		case 1: GameTextForPlayer(playerid, "~w~PARK ~r~EDILEMEZ", 3000, 4);
	}
	return true;
}

CMD:aracparksatinal(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araç içerisinde olmalýsýnýz.");
	if(VehicleParkAreaControl(playerid) == 1) return SendServerMessage(playerid, "Bu alana park edemezsiniz.");
	if(Character[playerid][cMoney] < 2500) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

	new vehid = GetPlayerVehicleID(playerid), Float:vehPos[4];
	if((Vehicle[vehid][vFaction]) == 1 && (Vehicle[vehid][vFaction] == 2) && (Vehicle[vehid][vFaction] == 3) && (Vehicle[vehid][vFaction] == 4) && (Vehicle[vehid][vFaction] == 5))
		return SendServerMessage(playerid, "Bu araçta bu komut kullanýlamaz.");

	if(Vehicle[vehid][vOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Araç size ait deðil.");

	GetVehiclePos(vehid, vehPos[0], vehPos[1], vehPos[2]);
	GetVehicleZAngle(vehid, vehPos[3]);
	GiveMoney(playerid, -2500);

	Vehicle[vehid][vPos][0] = vehPos[0];
	Vehicle[vehid][vPos][1] = vehPos[1];
	Vehicle[vehid][vPos][2] = vehPos[2];
	Vehicle[vehid][vPos][3] = vehPos[3];
	RefreshVehicle(vehid);

	GameTextForPlayer(playerid, "~w~PARK YERI ~g~SATIN ALINDI", 3000, 4);
	return true;
}

CMD:aracpark(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araç içerisinde olmalýsýnýz.");
	new vehid = GetPlayerVehicleID(playerid);
	if((Vehicle[vehid][vFaction]) == 1 && (Vehicle[vehid][vFaction] == 2) && (Vehicle[vehid][vFaction] == 3) && (Vehicle[vehid][vFaction] == 4) && (Vehicle[vehid][vFaction] == 5))
		return SendServerMessage(playerid, "Bu araçta bu komut kullanýlamaz.");

	if(Vehicle[vehid][vOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Araç size ait deðil.");

	SendClientMessage(playerid, C_GREY1, "Aracýnýzý haritada iþaretlenen noktada park edebilirsiniz.");
	UsageVehiclePark[playerid] = SetPlayerCheckpoint(playerid, Vehicle[vehid][vPos][0], Vehicle[vehid][vPos][1], Vehicle[vehid][vPos][2], 5.0);
	for(new i; i < 3; i++) VehicleParkPos[playerid][i] = Vehicle[vehid][vPos][i];
	return true;
}

CMD:aracgetir(playerid, params[])
{
	new vehid;
	if(sscanf(params, "d", vehid)) return SendServerMessage(playerid, "/aracgetir [id]");
	if(!Vehicle[vehid][vIsValid]) return SendServerMessage(playerid, "Araç bulunamadý.");
	if((Vehicle[vehid][vFaction]) == 1 && (Vehicle[vehid][vFaction] == 2) && (Vehicle[vehid][vFaction] == 3) && (Vehicle[vehid][vFaction] == 4) && (Vehicle[vehid][vFaction] == 5))
		return SendServerMessage(playerid, "Bu araçta bu komut kullanýlamaz.");

	if(Vehicle[vehid][vOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Araç size ait deðil.");
	if(!Vehicle[vehid][vPark]) return SendServerMessage(playerid, "Araç getirilmiþ.");

	Vehicle[vehid][vPark] = 0;
	SetVehicleVirtualWorld(vehid, 0);
	RefreshVehicle(vehid);
	SendServerMessage(playerid, "%s model aracýnýzý getirdiniz.", GetVehicleName(vehid));
	return true;
}

CMD:arackilit(playerid, params[])
{
	new vehid = GetNearestVehicleToPlayer(playerid, 3.0);
	if((Vehicle[vehid][vOwner] != Character[playerid][cID]) && (Vehicle[vehid][vFaction] != Character[playerid][cFaction])) return SendServerMessage(playerid, "Araç size ait deðil.");

	switch(Doors[vehid])
	{
		case false: Doors[vehid] = true, SwitchVehicleDoors(vehid, true), GameTextForPlayer(playerid, "~r~KILITLENDI", 3000, 4);
		case true: Doors[vehid] = false, SwitchVehicleDoors(vehid, false), GameTextForPlayer(playerid, "~g~KILIT ACILDI", 3000, 4);
	}
	return true;
}

CMD:aracfar(playerid, params[])
{
	new vehid = GetNearestVehicleToPlayer(playerid, 3.0);
	if((Vehicle[vehid][vOwner] != Character[playerid][cID]) && (Vehicle[vehid][vFaction] != Character[playerid][cFaction])) return SendServerMessage(playerid, "Araç size ait deðil.");

	switch(Lights[vehid])
	{
		case false: Lights[vehid] = true, SwitchVehicleLight(vehid, true), GameTextForPlayer(playerid, "~w~FARLAR ~g~ACILDI", 3000, 4);
		case true: Lights[vehid] = false, SwitchVehicleLight(vehid, false), GameTextForPlayer(playerid, "~w~FARLAR ~r~KAPANDI", 3000, 4);
	}
	return true;
}

CMD:arackaput(playerid, params[])
{
	new vehid = GetNearestVehicleToPlayer(playerid, 3.0);
	if((Vehicle[vehid][vOwner] != Character[playerid][cID]) && (Vehicle[vehid][vFaction] != Character[playerid][cFaction])) return SendServerMessage(playerid, "Araç size ait deðil.");

	switch(Bonnet[vehid])
	{
		case false: Bonnet[vehid] = true, SwitchVehicleBonnet(vehid, true), GameTextForPlayer(playerid, "~w~KAPUT ~g~ACILDI", 3000, 4);
		case true: Bonnet[vehid] = false, SwitchVehicleBonnet(vehid, false), GameTextForPlayer(playerid, "~w~KAPUT ~r~KAPANDI", 3000, 4);
	}
	return true;
}

CMD:aracbagaj(playerid, params[])
{
	new vehid = GetNearestVehicleToPlayer(playerid, 3.0);
	if((Vehicle[vehid][vOwner] != Character[playerid][cID]) && (Vehicle[vehid][vFaction] != Character[playerid][cFaction])) return SendServerMessage(playerid, "Araç size ait deðil.");

	switch(Boot[vehid])
	{
		case false: Boot[vehid] = true, SwitchVehicleBoot(vehid, true), GameTextForPlayer(playerid, "~w~BAGAJ ~g~ACILDI", 3000, 4);
		case true: Boot[vehid] = false, SwitchVehicleBoot(vehid, false), GameTextForPlayer(playerid, "~w~BAGAJ ~r~KAPANDI", 3000, 4);
	}
	return true;
}

CMD:motor(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araç içerisinde olmalýsýnýz.");
	
	new vehid = GetPlayerVehicleID(playerid);

	if(!Vehicle[vehid][vFuel]) return SendServerMessage(playerid, "Yakýt bulunamadý.");
	if(Vehicle[vehid][vAccident]) return SendServerMessage(playerid, "Araç aðýr hasarlý olduðu için çalýþtýrýlamaz.");
	
	if(Vehicle[vehid][vOwner] == Character[playerid][cID] || Vehicle[vehid][vFaction] == Character[playerid][cFaction])
	{
		switch(Engine[vehid])
		{
			case false: GameTextForPlayer(playerid, "~w~MOTOR ~g~CALISTIRILDI", 3000, 4), SwitchVehicleEngine(vehid, true), Engine[vehid] = true, SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s anahtarý kontaða takar ve %s model aracýn motorunu çalýþtýrýr.", GetRPName(playerid), GetVehicleName(vehid));
			case true: GameTextForPlayer(playerid, "~w~MOTOR ~r~KAPATILDI", 3000, 4), SwitchVehicleEngine(vehid, false), Engine[vehid] = false, SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s anahtarý çevirir ve %s model aracýn motorunu kapatýr.", GetRPName(playerid), GetVehicleName(vehid));
		}
	}
	else SendServerMessage(playerid, "Araç size ait deðil.");
	return true;
}

CMD:aracsat(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araçta deðilsiniz.");
	new vehid = GetPlayerVehicleID(playerid);
	if((Vehicle[vehid][vFaction]) == 1 && (Vehicle[vehid][vFaction] == 2) && (Vehicle[vehid][vFaction] == 3) && (Vehicle[vehid][vFaction] == 4) && (Vehicle[vehid][vFaction] == 5))
		return SendServerMessage(playerid, "Bu araçta bu komut kullanýlamaz.");

	if(Vehicle[vehid][vOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Araç size ait deðil.");

	new targetid, price;
	if(sscanf(params, "ud", targetid, price)) return SendServerMessage(playerid, "/aracsat [id/isim] [fiyat]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(OfferMode[playerid]) return SendServerMessage(playerid, "Teklif modundasýnýz.");
	if(OfferMode[targetid]) return SendServerMessage(playerid, "Karþýdaki kiþi teklif modunda.");
	if(targetid == playerid) return SendServerMessage(playerid, "Kendinize satýþ yapamazsýnýz.");
	if(!IsPlayerNearPlayer(playerid, targetid, 3.0)) return SendServerMessage(playerid, "Kiþi size yakýn deðil.");

	new totalprice = Vehicle[vehid][vPrice] / 2;
	if(price <= totalprice) return SendServerMessage(playerid, "Aracýnýzý minimum deðerinin yarýsý fiyatýna satabilirsiniz.");
	if(price > Character[targetid][cMoney]) return SendServerMessage(playerid, "Kiþinin yeterli parasý bulunmamaktadýr.");

	OfferMode[targetid] = true;
	OfferMode[playerid] = true;
	OfferOwnerID[targetid] = playerid;
	OfferVehicleID[targetid] = vehid;
	OfferVehiclePrice[targetid] = price;
	SendServerMessage(playerid, "%s isimli kiþiye %s model aracýn $%d ücretle satýþ teklifini gönderdiniz.", GetRPName(targetid), GetVehicleName(vehid), price);
	new dialogstr[144];
	format(dialogstr, sizeof(dialogstr), "{FFFFFF}%s isimli kiþiden %s model araç için $%d ücretle satýþ teklifi aldýnýz.\n{FFFFFF}Teklifi onaylýyor musunuz?", GetRPName(playerid), GetVehicleName(vehid), price);
	Dialog_Show(targetid, VEHICLE_OFFER, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Teklif", dialogstr, "Onayla", "Reddet");
	return true;
}

Dialog:VEHICLE_OFFER(playerid, response, listitem, inputtext[])
{
	new ownerid = OfferOwnerID[playerid];
	new vehid = OfferVehicleID[playerid];
	new price = OfferVehiclePrice[playerid];
	if(!response)
	{
		SendServerMessage(ownerid, "%s tarafýndan teklifiniz reddedildi.", GetRPName(playerid));
	}
	else
	{
		SendServerMessage(ownerid, "%s tarafýndan teklifiniz kabul edildi.", GetRPName(playerid));

		Vehicle[vehid][vOwner] = Character[playerid][cID];
		SwitchVehicleEngine(vehid, false), Engine[vehid] = false;

		GiveMoney(playerid, -price);
		GiveMoney(ownerid, price);

		SendServerMessage(playerid, "%s tarafýndan $%d ücretle teklif edilen %s model aracý satýn aldýnýz.", GetRPName(ownerid), price, GetVehicleName(vehid));
	
		RefreshVehicle(vehid);

		OfferVehicleID[playerid] = -1;
		OfferVehiclePrice[playerid] = 0;
	}

	OfferMode[playerid] = false;
	OfferMode[ownerid] = false;
	return true;
}

CMD:galeriid(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	SendServerMessage(playerid, "%d numaralý galeridesiniz.", GetPlayerNearbyGalleryID(playerid));
	return true;
}

CMD:galeriduzenle(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new gid, opt[64], ext[124];
	if(sscanf(params, "ds[64]S()[124]", gid, opt, ext))
	{
		SendServerMessage(playerid, "/galeriduzenle [galeri id] [seçenek] [yeni deðer]");
		SendClientMessage(playerid, C_GREY1, "isim - konum - aracspawnpos");
	}
	else
	{
		if(!Gallery[gid][gIsValid]) return SendServerMessage(playerid, "Geçersiz galeri id girdiniz.");

		if(!strcmp(opt, "isim", true))
		{
			new name[32];
			if(sscanf(ext, "s[32]", name)) return SendServerMessage(playerid, "/galeriduzenle [galeri id] [isim] [yeni isim(32)]");
			if(strlen(name) < 0 || strlen(name) > 32) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");

			format(Gallery[gid][gName], 32, "%s", name);
			RefreshGallery(gid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý galerinin ismi %s olarak deðiþtirildi.", GetNickname(playerid), gid, Gallery[gid][gName]);
		}
		else if(!strcmp(opt, "konum", true))
		{
			new Float:pos[3];
			GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
			Gallery[gid][gPos][0] = pos[0];
			Gallery[gid][gPos][1] = pos[1];
			Gallery[gid][gPos][2] = pos[2];
			RefreshGallery(gid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý galerinin konumu deðiþtirildi. (%s)", GetNickname(playerid), gid, GetLocation(pos[0], pos[1], pos[2]));
		}
		else if(!strcmp(opt, "aracspawnpos", true))
		{
			new Float:pos[3];
			GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
			Gallery[gid][gSpawnPos][0] = pos[0];
			Gallery[gid][gSpawnPos][1] = pos[1];
			Gallery[gid][gSpawnPos][2] = pos[2];
			RefreshGallery(gid);
			SendAdminMessage(C_ADMIN, "AdmWarn. %s tarafýndan, %d numaralý galerinin araç spawn konumu deðiþtirildi. (%s)", GetNickname(playerid), gid, GetLocation(pos[0], pos[1], pos[2]));
		}
	}
	return true;
}

CMD:galerisil(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	
	new gid;
	if(sscanf(params, "d", gid)) return SendServerMessage(playerid, "/galerisil [galeri id]");
	if(!Gallery[gid][gIsValid]) return SendServerMessage(playerid, "Galeri bulunamadý.");

	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %d numaralý galeri silindi.", GetNickname(playerid), gid);
	DeleteGallery(gid);
	return true;
}

CMD:galeriyarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new gname[32];
	if(sscanf(params, "s[32]", gname)) return SendServerMessage(playerid, "/galeriyarat [isim(32)]");
	if(strlen(gname) < 0 || strlen(gname) > 32) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");
	if(Iter_Count(Gallerys) >= MAX_GALLERYS) return SendServerMessage(playerid, "Galeri limiti aþýldý.");

	new Float:pos[3], query[256], Cache:InsertData;
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

	new qname[32];
	format(qname, 32, "%s", gname);
	mysql_format(conn, query, sizeof(query), "INSERT INTO gallerys (Name, X, Y, Z, SX, SY, SZ) VALUES ('%e', %.4f, %.4f, %.4f, 0.0, 0.0, 0.0)", qname, pos[0], pos[1], pos[2]);
	InsertData = mysql_query(conn, query);

	new gid = Iter_Free(Gallerys);
	Gallery[gid][gID] = cache_insert_id();
	Gallery[gid][gIsValid] = true;
	format(Gallery[gid][gName], 32, "%s", gname);
	Gallery[gid][gPos][0] = pos[0];
	Gallery[gid][gPos][1] = pos[1];
	Gallery[gid][gPos][2] = pos[2];
	Gallery[gid][gPickup] = CreateDynamicPickup(1239, 1, Gallery[gid][gPos][0], Gallery[gid][gPos][1], Gallery[gid][gPos][2], 0, 0);
	Iter_Add(Gallerys, gid);
	cache_delete(InsertData);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý galeri yaratýldý.", GetNickname(playerid), gid);
	return true;
}

CMD:galeri(playerid, params[])
{
	if(!GetPlayerNearbyGallery(playerid)) return SendServerMessage(playerid, "Galeride deðilsiniz.");

	Dialog_Show(playerid, GALLERY_COLOR1, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Galeri", "{FFFFFF}Aracýnýzýn 1. rengini seçin:", "Devam", "Kapat");
	return true;
}

Dialog:GALLERY_COLOR1(playerid, response, listitem, inputtext[])
{
	if(!response) return true;
	if(strval(inputtext) < 128 || strval(inputtext) > 255) return SendServerMessage(playerid, "Geçersiz renk girdiniz."), Dialog_Show(playerid, GALLERY_COLOR1, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Galeri", "{FFFFFF}Aracýnýzýn 1. rengini seçin:", "Devam", "Kapat");

	Gallery_FirstColor[playerid] = strval(inputtext);
	Dialog_Show(playerid, GALLERY_COLOR2, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Galeri", "{FFFFFF}Aracýnýzýn 2. rengini seçin:", "Devam", "<<");
	return true;
}

Dialog:GALLERY_COLOR2(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, GALLERY_COLOR1, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Galeri", "{FFFFFF}Aracýnýzýn 1. rengini seçin:", "Devam", "Kapat");
	if(strval(inputtext) < 128 || strval(inputtext) > 255) return SendServerMessage(playerid, "Geçersiz renk girdiniz."), Dialog_Show(playerid, GALLERY_COLOR2, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Galeri", "{FFFFFF}Aracýnýzýn 2. rengini seçin:", "Devam", "<<");
	
	Gallery_SecondColor[playerid] = strval(inputtext);

	static string[sizeof(VEHICLE_GALLERY) * 64]; 
	for(new i; i < sizeof(VEHICLE_GALLERY); i++){
		format(string, sizeof(string), "%s%i\t~w~Fiyat: ~g~$~w~%d\n", string, VEHICLE_GALLERY[i][GALLERY_VEHICLE_MODEL], VEHICLE_GALLERY[i][GALLERY_VEHICLE_PRICE]);
	}
	ShowPlayerDialog(playerid, S_DIALOG_GALLERY, DIALOG_STYLE_PREVIEW_MODEL, "Galeri", string, "Devam", "<<");
	return true;
}

// ADMÝN KOMUTLARI
CMD:aracyarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWDEVELOPER) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new modelid, col1, col2;
	if(sscanf(params, "ddd", modelid, col1, col2)) return SendServerMessage(playerid, "/aracyarat [model id] [renk 1] [renk 2]");
	if(modelid < 400 || modelid > 611) return SendServerMessage(playerid, "Geçersiz model girdiniz.");

	CreateVehicleEx(playerid, modelid, col1, col2);
	return true;
}

CMD:aracsil(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWDEVELOPER) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new vehid;
	if(sscanf(params, "d", vehid)) return SendServerMessage(playerid, "/aracsil [araç id]");
	if(!Vehicle[vehid][vIsValid]) return SendServerMessage(playerid, "Araç bulunamadý!");

	DeleteVehicle(vehid);
	return true;
}

// FONKSÝYONLAR
Vinewood:CreateVehicleEx(playerid, modelid, col1, col2)
{
	new Float:x, Float:y, Float:z;
	new plate[32], plateno;
	new vehid;
	new query[1024], Cache:InsertData;

	GetPlayerPos(playerid, x, y, z);
	plateno = randomEx(1111, 9999);
	format(plate, 32, "LS %d", plateno);

	vehid = AddStaticVehicleEx(modelid, x, y, z, 90.0, col1, col2, -1, 0);
	SetVehicleColor(vehid, col1, col2);
	SetVehicleNumberPlate(vehid, plate);
	SetVehicleHealth(vehid, 1000);
	
	SwitchVehicleEngine(vehid, false);
	Engine[vehid] = false;

	mysql_format(conn, query, sizeof(query), "INSERT INTO vehicles (Model, X, Y, Z, A, Color1, Color2, Plate) VALUES (%i, %.4f, %.4f, %.4f, 90.0, %i, %i, '%e')",
		modelid, x, y, z, col1, col2, plate);
	InsertData = mysql_query(conn, query);

	Vehicle[vehid][vIsValid] = true;
	Vehicle[vehid][vVehicleID] = vehid;
	Vehicle[vehid][vID] = cache_insert_id();
	Vehicle[vehid][vOwner] = -1;
	Vehicle[vehid][vFaction] = 0;
	Vehicle[vehid][vModel] = modelid;
	Vehicle[vehid][vPos][0] = x;
	Vehicle[vehid][vPos][1] = y;
	Vehicle[vehid][vPos][2] = z;
	Vehicle[vehid][vPos][3] = 90.0;
	Vehicle[vehid][vColor1] = col1;
	Vehicle[vehid][vColor2] = col2;
	Vehicle[vehid][vType] = 1;
	Vehicle[vehid][vPrice] = 0;
	format(Vehicle[vehid][vPlate], 32, "%s", plate);
	Vehicle[vehid][vKM] = 0;
	Vehicle[vehid][vHealth] = 1000;
	Vehicle[vehid][vFuel] = 100;
	Vehicle[vehid][vPark] = 0;
	Vehicle[vehid][vAccident] = 0;
	Vehicle[vehid][vEngineLife] = 100.0;
	Vehicle[vehid][vBatteryLife] = 100.0;
	Vehicle[vehid][vLockLevel] = 0;
	Vehicle[vehid][vAlarmLevel] = 0;
	Vehicle[vehid][vComp_Spoiler] = 0;
	Vehicle[vehid][vComp_Hood] = 0;
	Vehicle[vehid][vComp_Roof] = 0;
	Vehicle[vehid][vComp_SideSkirt] = 0;
	Vehicle[vehid][vComp_Lamps] = 0;
	Vehicle[vehid][vComp_Nitro] = 0;
	Vehicle[vehid][vComp_Exhaust] = 0;
	Vehicle[vehid][vComp_Wheels] = 0;
	Vehicle[vehid][vComp_Stereo] = 0;
	Vehicle[vehid][vComp_Hydraulics] = 0;
	Vehicle[vehid][vComp_FrontBumper] = 0;
	Vehicle[vehid][vComp_RearBumper] = 0;
	Vehicle[vehid][vComp_VentRight] = 0;
	Vehicle[vehid][vComp_VentLeft] = 0;
	SendServerMessage(playerid, "%s model araç yaratýldý.", GetVehicleModelName(modelid));
	cache_delete(InsertData);

	RefreshVehicle(vehid);
	return true; 
}

Vinewood:LoadGallerys()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	for(new i; i < rows; i++)
	{
		Gallery[i+1][gIsValid] = true;

		cache_get_value_name_int(i, "id", Gallery[i+1][gID]);
		cache_get_value_name(i, "Name", Gallery[i+1][gName], 32);
		cache_get_value_name_float(i, "X", Gallery[i+1][gPos][0]);
		cache_get_value_name_float(i, "Y", Gallery[i+1][gPos][1]);
		cache_get_value_name_float(i, "Z", Gallery[i+1][gPos][2]);
		cache_get_value_name_float(i, "SX", Gallery[i+1][gSpawnPos][0]);
		cache_get_value_name_float(i, "SY", Gallery[i+1][gSpawnPos][1]);
		cache_get_value_name_float(i, "SZ", Gallery[i+1][gSpawnPos][2]);

		Gallery[i+1][gPickup] = CreateDynamicPickup(1239, 1, Gallery[i+1][gPos][0], Gallery[i+1][gPos][1], Gallery[i+1][gPos][2], 0, 0);
		rowcount++;
		Iter_Add(Gallerys, i+1);
	}
	if(rowcount == 0) return printf("VinewoodDB >> Galeri bulunamadý.");
	printf("VinewoodDB >> %d galeri yüklendi.", rowcount);
	return true;
}

Vinewood:RefreshGallery(gid)
{
	if(IsValidDynamicPickup(Gallery[gid][gPickup]))
		DestroyDynamicPickup(Gallery[gid][gPickup]);

	Gallery[gid][gPickup] = CreateDynamicPickup(1239, 1, Gallery[gid][gPos][0], Gallery[gid][gPos][1], Gallery[gid][gPos][2], 0, 0);

	new query[512], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE gallerys SET Name = '%e', X = %.4f, Y = %.4f, Z = %.4f, SX = %.4f, SY = %.4f, SZ = %.4f WHERE id = '%i'", 
		Gallery[gid][gName], 
		Gallery[gid][gPos][0], 
		Gallery[gid][gPos][1], 
		Gallery[gid][gPos][2], 
		Gallery[gid][gSpawnPos][0], 
		Gallery[gid][gSpawnPos][1], 
		Gallery[gid][gSpawnPos][2], 
	Gallery[gid][gID]);
	UpdateData = mysql_query(conn, query);
	cache_delete(UpdateData);
	return true;
}

Vinewood:DeleteGallery(gid)
{
	if(IsValidDynamicPickup(Gallery[gid][gPickup]))
		DestroyDynamicPickup(Gallery[gid][gPickup]);

	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM gallerys WHERE id = '%i'", Gallery[gid][gID]);
	DeleteData = mysql_query(conn, query);

	Gallery[gid][gID] = 0;
	Gallery[gid][gIsValid] = false;
	Iter_Remove(Gallerys, gid);
	cache_delete(DeleteData);
	return true;
}

Vinewood:GetPlayerNearbyGallery(playerid)
{
	new status = 0;
	for(new i; i < MAX_GALLERYS; i++)
	{
		if(Gallery[i][gIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, Gallery[i][gPos][0], Gallery[i][gPos][1], Gallery[i][gPos][2]))
				status = 1;
		}
	}
	return status;
}

Vinewood:GetPlayerNearbyGalleryID(playerid)
{
	new gid = 0;
	for(new i; i < MAX_GALLERYS; i++)
	{
		if(Gallery[i][gIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, Gallery[i][gPos][0], Gallery[i][gPos][1], Gallery[i][gPos][2]))
				gid = i;
		}
	}
	return gid;
}

Vinewood:VehicleParkAreaControl(playerid)
{
	new status = 0;
	for(new i; i < MAX_VEHICLES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, Vehicle[i][vPos][0], Vehicle[i][vPos][1], Vehicle[i][vPos][2]))
			status = 1;
	}
	return status;
}

Vinewood:VehicleList(playerid)
{
	new count = 0;
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(Vehicle[i][vIsValid])
		{
			if(Vehicle[i][vOwner] == Character[playerid][cID])
			{
				new Float:pos[3];
				GetVehiclePos(i, pos[0], pos[1], pos[2]);
				SendClientMessageEx(playerid, C_GREY1, "(%s) Araç ID: [%d] | Model: [%s] | Deðer: [$%d] | Plaka: [%s] | KM: [%d] | Yakýt: [%dLT]", GetLocation(pos[0], pos[1], pos[2]), i, ReturnVehicleModelName(Vehicle[i][vModel]), Vehicle[i][vPrice], Vehicle[i][vPlate], Vehicle[i][vKM], Vehicle[i][vFuel]);
				count++;
			}
		}
	}
	if(count == 0) return SendServerMessage(playerid, "Araç bulunamadý.");
	return true;
}

Vinewood:LoadVehicles()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	for(new i; i < rows; i++)
	{
		Vehicle[i+1][vIsValid] = true;

		cache_get_value_name_int(i, "id", Vehicle[i+1][vID]);
		cache_get_value_name_int(i, "Owner", Vehicle[i+1][vOwner]);
		cache_get_value_name_int(i, "Faction", Vehicle[i+1][vFaction]);
		cache_get_value_name_int(i, "Model", Vehicle[i+1][vModel]);
		cache_get_value_name_float(i, "X", Vehicle[i+1][vPos][0]);
		cache_get_value_name_float(i, "Y", Vehicle[i+1][vPos][1]);
		cache_get_value_name_float(i, "Z", Vehicle[i+1][vPos][2]);
		cache_get_value_name_float(i, "A", Vehicle[i+1][vPos][3]);
		cache_get_value_name_int(i, "Color1", Vehicle[i+1][vColor1]);
		cache_get_value_name_int(i, "Color2", Vehicle[i+1][vColor2]);
		cache_get_value_name_int(i, "Type", Vehicle[i+1][vType]);
		cache_get_value_name_int(i, "Price", Vehicle[i+1][vPrice]);
		cache_get_value_name(i, "Plate", Vehicle[i+1][vPlate], 256);
		cache_get_value_name_int(i, "KM", Vehicle[i+1][vKM]);
		cache_get_value_name_float(i, "Health", Vehicle[i+1][vHealth]);
		cache_get_value_name_int(i, "Fuel", Vehicle[i+1][vFuel]);
		cache_get_value_name_int(i, "Park", Vehicle[i+1][vPark]);
		cache_get_value_name_int(i, "Accident", Vehicle[i+1][vAccident]);
		cache_get_value_name_float(i, "EngineLife", Vehicle[i+1][vEngineLife]);
		cache_get_value_name_float(i, "BatteryLife", Vehicle[i+1][vBatteryLife]);
		cache_get_value_name_int(i, "LockLevel", Vehicle[i+1][vLockLevel]);
		cache_get_value_name_int(i, "AlarmLevel", Vehicle[i+1][vAlarmLevel]);
		cache_get_value_name_int(i, "Spoiler", Vehicle[i+1][vComp_Spoiler]);
		cache_get_value_name_int(i, "Hood", Vehicle[i+1][vComp_Hood]);
		cache_get_value_name_int(i, "Roof", Vehicle[i+1][vComp_Roof]);
		cache_get_value_name_int(i, "SideSkirt", Vehicle[i+1][vComp_SideSkirt]);
		cache_get_value_name_int(i, "Lamps", Vehicle[i+1][vComp_Lamps]);
		cache_get_value_name_int(i, "Nitro", Vehicle[i+1][vComp_Nitro]);
		cache_get_value_name_int(i, "Exhaust", Vehicle[i+1][vComp_Exhaust]);
		cache_get_value_name_int(i, "Wheels", Vehicle[i+1][vComp_Wheels]);
		cache_get_value_name_int(i, "Stereo", Vehicle[i+1][vComp_Stereo]);
		cache_get_value_name_int(i, "Hydraulics", Vehicle[i+1][vComp_Hydraulics]);
		cache_get_value_name_int(i, "FrontBumper", Vehicle[i+1][vComp_FrontBumper]);
		cache_get_value_name_int(i, "RearBumper", Vehicle[i+1][vComp_RearBumper]);
		cache_get_value_name_int(i, "VentRight", Vehicle[i+1][vComp_VentRight]);
		cache_get_value_name_int(i, "VentLeft", Vehicle[i+1][vComp_VentLeft]);

		Vehicle[i+1][vVehicleID] = AddStaticVehicleEx(Vehicle[i+1][vModel], Vehicle[i+1][vPos][0], Vehicle[i+1][vPos][1], Vehicle[i+1][vPos][2], Vehicle[i+1][vPos][3], Vehicle[i+1][vColor1], Vehicle[i+1][vColor2], -1, 0);
		SetVehicleColor(Vehicle[i+1][vVehicleID], Vehicle[i+1][vColor1], Vehicle[i+1][vColor2]);
		SetVehicleNumberPlate(Vehicle[i+1][vVehicleID], Vehicle[i+1][vPlate]);
		SetVehicleHealth(Vehicle[i+1][vVehicleID], Vehicle[i+1][vHealth]);
		SwitchVehicleEngine(Vehicle[i+1][vVehicleID], false), Engine[i] = false;
		
		if(Vehicle[i+1][vPark])
		{
			SetVehicleVirtualWorld(Vehicle[i+1][vVehicleID], 2);
		}

		if(Vehicle[i+1][vAccident])
		{
			SetVehicleHealth(Vehicle[i+1][vVehicleID], 350);
		}
		rowcount++;
	}
	if(rowcount == 0) return printf("VinewoodDB >> Araç bulunamadý.");
	printf("VinewoodDB >> %d adet araç yüklendi.", rowcount);
	return true;
}

Vinewood:RefreshVehicle(vid)
{
	new query[512], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE vehicles SET Owner = %i, Faction = %i, Model = %i, X = %.4f, Y = %.4f, Z = %.4f, A = %.4f, Color1 = %i, Color2 = %i, Type = %i, Price = %i, Plate = '%e', KM = %i, Health = %.4f, Fuel = %i, Park = %i, Accident = %i, EngineLife = %.2f, BatteryLife = %.2f, LockLevel = %i, AlarmLevel = %i WHERE id = '%i'",
		Vehicle[vid][vOwner],
		Vehicle[vid][vFaction],
		Vehicle[vid][vModel],
		Vehicle[vid][vPos][0],
		Vehicle[vid][vPos][1],
		Vehicle[vid][vPos][2],
		Vehicle[vid][vPos][3],
		Vehicle[vid][vColor1],
		Vehicle[vid][vColor2],
		Vehicle[vid][vType],
		Vehicle[vid][vPrice],
		Vehicle[vid][vPlate],
		Vehicle[vid][vKM],
		Vehicle[vid][vHealth],
		Vehicle[vid][vFuel],
		Vehicle[vid][vPark],
		Vehicle[vid][vAccident],
		Vehicle[vid][vEngineLife],
		Vehicle[vid][vBatteryLife],
		Vehicle[vid][vLockLevel],
		Vehicle[vid][vAlarmLevel],
	Vehicle[vid][vID]); UpdateData = mysql_query(conn, query);

	mysql_format(conn, query, sizeof(query), "UPDATE vehicles SET Spoiler = %i, Hood = %i, Roof = %i, SideSkirt = %i, Lamps = %i, Nitro = %i, Exhaust = %i, Wheels = %i, Stereo = %i, Hydraulics = %i, FrontBumper = %i, RearBumper = %i, VentRight = %i, VentLeft = %i WHERE id = '%i'",
		Vehicle[vid][vComp_Spoiler],
		Vehicle[vid][vComp_Hood],
		Vehicle[vid][vComp_Roof],
		Vehicle[vid][vComp_SideSkirt],
		Vehicle[vid][vComp_Lamps],
		Vehicle[vid][vComp_Nitro],
		Vehicle[vid][vComp_Exhaust],
		Vehicle[vid][vComp_Wheels],
		Vehicle[vid][vComp_Stereo],
		Vehicle[vid][vComp_Hydraulics],
		Vehicle[vid][vComp_FrontBumper],
		Vehicle[vid][vComp_RearBumper],
		Vehicle[vid][vComp_VentRight],
		Vehicle[vid][vComp_VentLeft],
	Vehicle[vid][vID]); UpdateData = mysql_query(conn, query);
	cache_delete(UpdateData);
	return true;
}

Vinewood:DeleteVehicle(vid)
{
	DestroyVehicle(vid);

	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM vehicles WHERE id = '%i'", Vehicle[vid][vID]);
	DeleteData = mysql_query(conn, query);

	Vehicle[vid][vID] = 0;
	Vehicle[vid][vIsValid] = false;
	cache_delete(DeleteData);
	return true;
}

stock GetVehicleOwnerName(ownerid)
{
	new query[124], Cache:GetData, ownername[144];
	mysql_format(conn, query, sizeof(query), "SELECT * FROM characters WHERE id = '%i'", ownerid);
	GetData = mysql_query(conn, query);

	if(cache_num_rows())
	{
		cache_get_value_name(0, "Character_Name", ownername, 144);
	}
	cache_delete(GetData);
	return ownername;
}

ReturnVehicleModelName(model)
{
	new
	    name[32] = "Yok";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

Vinewood:IsNotModification(vehicleid)
{
    if(GetVehicleModel(vehicleid) == 403 || GetVehicleModel(vehicleid) == 406 ||  GetVehicleModel(vehicleid) == 407 ||  GetVehicleModel(vehicleid) == 408 || GetVehicleModel(vehicleid) == 414 || GetVehicleModel(vehicleid) == 416 || GetVehicleModel(vehicleid) == 417 || GetVehicleModel(vehicleid) == 423 ||
    GetVehicleModel(vehicleid) == 425 || GetVehicleModel(vehicleid) == 427 || GetVehicleModel(vehicleid) == 428 || GetVehicleModel(vehicleid) == 430 || GetVehicleModel(vehicleid) == 431 || GetVehicleModel(vehicleid) == 432 || GetVehicleModel(vehicleid) == 433 || GetVehicleModel(vehicleid) == 434 ||
    GetVehicleModel(vehicleid) == 435 || GetVehicleModel(vehicleid) == 437 || GetVehicleModel(vehicleid) == 443 || GetVehicleModel(vehicleid) == 444 || GetVehicleModel(vehicleid) == 446 || GetVehicleModel(vehicleid) == 447 || GetVehicleModel(vehicleid) == 448 || GetVehicleModel(vehicleid) == 449 ||
    GetVehicleModel(vehicleid) == 450 || GetVehicleModel(vehicleid) == 452 || GetVehicleModel(vehicleid) == 453 || GetVehicleModel(vehicleid) == 454 || GetVehicleModel(vehicleid) == 455 || GetVehicleModel(vehicleid) == 456 || GetVehicleModel(vehicleid) == 457 || GetVehicleModel(vehicleid) == 459 ||
    GetVehicleModel(vehicleid) == 460 || GetVehicleModel(vehicleid) == 461 || GetVehicleModel(vehicleid) == 462 || GetVehicleModel(vehicleid) == 463 || GetVehicleModel(vehicleid) == 464 || GetVehicleModel(vehicleid) == 465 || GetVehicleModel(vehicleid) == 468 || GetVehicleModel(vehicleid) == 469 ||
    GetVehicleModel(vehicleid) == 470 || GetVehicleModel(vehicleid) == 471 || GetVehicleModel(vehicleid) == 472 || GetVehicleModel(vehicleid) == 473 || GetVehicleModel(vehicleid) == 476 || GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 484 || GetVehicleModel(vehicleid) == 489 ||
    GetVehicleModel(vehicleid) == 486 || GetVehicleModel(vehicleid) == 487 || GetVehicleModel(vehicleid) == 488 || GetVehicleModel(vehicleid) == 493 || GetVehicleModel(vehicleid) == 494 || GetVehicleModel(vehicleid) == 495 || GetVehicleModel(vehicleid) == 497 || GetVehicleModel(vehicleid) == 498 ||
    GetVehicleModel(vehicleid) == 499 || GetVehicleModel(vehicleid) == 501 || GetVehicleModel(vehicleid) == 502 || GetVehicleModel(vehicleid) == 503 || GetVehicleModel(vehicleid) == 504 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 511 ||
    GetVehicleModel(vehicleid) == 512 || GetVehicleModel(vehicleid) == 513 || GetVehicleModel(vehicleid) == 514 || GetVehicleModel(vehicleid) == 515 || GetVehicleModel(vehicleid) == 519 || GetVehicleModel(vehicleid) == 520 || GetVehicleModel(vehicleid) == 521 || GetVehicleModel(vehicleid) == 522 ||
    GetVehicleModel(vehicleid) == 523 || GetVehicleModel(vehicleid) == 524 || GetVehicleModel(vehicleid) == 525 || GetVehicleModel(vehicleid) == 528 || GetVehicleModel(vehicleid) == 530 || GetVehicleModel(vehicleid) == 531 || GetVehicleModel(vehicleid) == 532 || GetVehicleModel(vehicleid) == 537 ||
    GetVehicleModel(vehicleid) == 538 || GetVehicleModel(vehicleid) == 539 || GetVehicleModel(vehicleid) == 544 || GetVehicleModel(vehicleid) == 548 || GetVehicleModel(vehicleid) == 552 || GetVehicleModel(vehicleid) == 553 || GetVehicleModel(vehicleid) == 556 || GetVehicleModel(vehicleid) == 557 ||
    GetVehicleModel(vehicleid) == 563 || GetVehicleModel(vehicleid) == 564 || GetVehicleModel(vehicleid) == 568 || GetVehicleModel(vehicleid) == 569 || GetVehicleModel(vehicleid) == 570 || GetVehicleModel(vehicleid) == 571 || GetVehicleModel(vehicleid) == 572 || GetVehicleModel(vehicleid) == 573 ||
    GetVehicleModel(vehicleid) == 574 || GetVehicleModel(vehicleid) == 577 || GetVehicleModel(vehicleid) == 578 || GetVehicleModel(vehicleid) == 581 || GetVehicleModel(vehicleid) == 582 || GetVehicleModel(vehicleid) == 583 || GetVehicleModel(vehicleid) == 584 || GetVehicleModel(vehicleid) == 586)
    {
        return 1;
    }
    if(GetVehicleModel(vehicleid) == 588 || GetVehicleModel(vehicleid) == 590 || GetVehicleModel(vehicleid) == 591 || GetVehicleModel(vehicleid) == 592 || GetVehicleModel(vehicleid) == 593 || GetVehicleModel(vehicleid) == 594 || GetVehicleModel(vehicleid) == 595 || GetVehicleModel(vehicleid) == 596 ||
    GetVehicleModel(vehicleid) == 597 || GetVehicleModel(vehicleid) == 598 || GetVehicleModel(vehicleid) == 599 || GetVehicleModel(vehicleid) == 601 || GetVehicleModel(vehicleid) >= 604)
    {
        return 1;
    }
    return 0;
}

stock IsComponentidCompatible(modelid, componentid)
{
    if(componentid == 1025 || componentid == 1073 || componentid == 1074 || componentid == 1075 || componentid == 1076 ||
         componentid == 1077 || componentid == 1078 || componentid == 1079 || componentid == 1080 || componentid == 1081 ||
         componentid == 1082 || componentid == 1083 || componentid == 1084 || componentid == 1085 || componentid == 1096 ||
         componentid == 1097 || componentid == 1098 || componentid == 1087 || componentid == 1086)
         return true;

    switch (modelid)
    {
        case 400: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 401: return (componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 114 || componentid == 1020 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 402: return (componentid == 1009 || componentid == 1009 || componentid == 1010);
        case 404: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 405: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1023 || componentid == 1000);
        case 409: return (componentid == 1009);
        case 410: return (componentid == 1019 || componentid == 1021 || componentid == 1020 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 411: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 412: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 415: return (componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 418: return (componentid == 1020 || componentid == 1021 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016);
        case 419: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 420: return (componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1003);
        case 421: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1016 || componentid == 1000);
        case 422: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007);
        case 426: return (componentid == 1005 || componentid == 1004 || componentid == 1021 || componentid == 1019 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003);
        case 429: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 436: return (componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1019 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 438: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 439: return (componentid == 1003 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1017 || componentid == 1007 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1013);
        case 442: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 445: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 451: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 458: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 466: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 467: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 474: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 475: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 477: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007);
        case 478: return (componentid == 1005 || componentid == 1004 || componentid == 1012 || componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 479: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 480: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 489: return (componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1016 || componentid == 1000);
        case 491: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 492: return (componentid == 1005 || componentid == 1004 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1016 || componentid == 1000);
        case 496: return (componentid == 1006 || componentid == 1017 || componentid == 1007 || componentid == 1011 || componentid == 1019 || componentid == 1023 || componentid == 1001 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1003 || componentid == 1002 || componentid == 1142 || componentid == 1143 || componentid == 1020);
        case 500: return (componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1013 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 506: return (componentid == 1009);
        case 507: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 516: return (componentid == 1004 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1015 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 517: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 518: return (componentid == 1005 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 526: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 527: return (componentid == 1021 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1014 || componentid == 1015 || componentid == 1017 || componentid == 1007);
        case 529: return (componentid == 1012 || componentid == 1011 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 533: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 534: return (componentid == 1126 || componentid == 1127 || componentid == 1179 || componentid == 1185 || componentid == 1100 || componentid == 1123 || componentid == 1125 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1180 || componentid == 1178 || componentid == 1101 || componentid == 1122 || componentid == 1124 || componentid == 1106);
        case 535: return (componentid == 1109 || componentid == 1110 || componentid == 1113 || componentid == 1114 || componentid == 1115 || componentid == 1116 || componentid == 1117 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1120 || componentid == 1118 || componentid == 1121 || componentid == 1119);
        case 536: return (componentid == 1104 || componentid == 1105 || componentid == 1182 || componentid == 1181 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1184 || componentid == 1183 || componentid == 1128 || componentid == 1103 || componentid == 1107 || componentid == 1108);
        case 540: return (componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 541: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 542: return (componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1014 || componentid == 1015);
        case 545: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 546: return (componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 547: return (componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1016 || componentid == 1003 || componentid == 1000);
        case 549: return (componentid == 1012 || componentid == 1011 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 550: return (componentid == 1005 || componentid == 1004 || componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003);
        case 551: return (componentid == 1005 || componentid == 1020 || componentid == 1021 || componentid == 1019 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1002 || componentid == 1023 || componentid == 1016 || componentid == 1003);
        case 555: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 558: return (componentid == 1092 || componentid == 1089 || componentid == 1166 || componentid == 1165 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1168 || componentid == 1167 || componentid == 1088 || componentid == 1091 || componentid == 1164 || componentid == 1163 || componentid == 1094 || componentid == 1090 || componentid == 1095 || componentid == 1093);
        case 559: return (componentid == 1065 || componentid == 1066 || componentid == 1160 || componentid == 1173 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1159 || componentid == 1161 || componentid == 1162 || componentid == 1158 || componentid == 1067 || componentid == 1068 || componentid == 1071 || componentid == 1069 || componentid == 1072 || componentid == 1070 || componentid == 1009);
        case 560: return (componentid == 1028 || componentid == 1029 || componentid == 1169 || componentid == 1170 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1141 || componentid == 1140 || componentid == 1032 || componentid == 1033 || componentid == 1138 || componentid == 1139 || componentid == 1027 || componentid == 1026 || componentid == 1030 || componentid == 1031);
        case 561: return (componentid == 1064 || componentid == 1059 || componentid == 1155 || componentid == 1157 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1154 || componentid == 1156 || componentid == 1055 || componentid == 1061 || componentid == 1058 || componentid == 1060 || componentid == 1062 || componentid == 1056 || componentid == 1063 || componentid == 1057);
        case 562: return (componentid == 1034 || componentid == 1037 || componentid == 1171 || componentid == 1172 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1149 || componentid == 1148 || componentid == 1038 || componentid == 1035 || componentid == 1147 || componentid == 1146 || componentid == 1040 || componentid == 1036 || componentid == 1041 || componentid == 1039);
        case 565: return (componentid == 1046 || componentid == 1045 || componentid == 1153 || componentid == 1152 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1150 || componentid == 1151 || componentid == 1054 || componentid == 1053 || componentid == 1049 || componentid == 1050 || componentid == 1051 || componentid == 1047 || componentid == 1052 || componentid == 1048);
        case 566: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 567: return (componentid == 1129 || componentid == 1132 || componentid == 1189 || componentid == 1188 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1187 || componentid == 1186 || componentid == 1130 || componentid == 1131 || componentid == 1102 || componentid == 1133);
        case 575: return (componentid == 1044 || componentid == 1043 || componentid == 1174 || componentid == 1175 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1176 || componentid == 1177 || componentid == 1099 || componentid == 1042);
        case 576: return (componentid == 1136 || componentid == 1135 || componentid == 1191 || componentid == 1190 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1192 || componentid == 1193 || componentid == 1137 || componentid == 1134);
        case 579: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 580: return (componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
        case 585: return (componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1003 || componentid == 1017 || componentid == 1007);
        case 587: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 589: return (componentid == 1005 || componentid == 1004 || componentid == 1144 || componentid == 1145 || componentid == 1020 || componentid == 1018 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1024 || componentid == 1013 || componentid == 1006 || componentid == 1016 || componentid == 1000 || componentid == 1017 || componentid == 1007);
        case 600: return (componentid == 1005 || componentid == 1004 || componentid == 1020 || componentid == 1022 || componentid == 1018 || componentid == 1013 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1017 || componentid == 1007);
        case 602: return (componentid == 1008 || componentid == 1009 || componentid == 1010);
        case 603: return (componentid == 1144 || componentid == 1145 || componentid == 1142 || componentid == 1143 || componentid == 1020 || componentid == 1019 || componentid == 1018 || componentid == 1024 || componentid == 1008 || componentid == 1009 || componentid == 1010 || componentid == 1006 || componentid == 1001 || componentid == 1023 || componentid == 1017 || componentid == 1007);
    }
    return false;
}