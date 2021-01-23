CMD:aractamir(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new vehid;
	if(sscanf(params, "d", vehid)) return SendServerMessage(playerid, "/aractamir [araç id]");
	if(!Vehicle[vehid][vIsValid]) return SendServerMessage(playerid, "Araç bulunamadý.");

	Vehicle[vehid][vHealth] = 1000;
	RepairVehicle(vehid);
	RefreshVehicle(vehid);
	SendServerMessage(playerid, "%d numaralý aracý tamir ettiniz.", vehid);
	return true;
}

CMD:gotols(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
	SendServerMessage(playerid, "Los Santos'a ýþýnlandýnýz.");
	return true;
}

CMD:gotolv(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
	SendServerMessage(playerid, "Las Venturas'a ýþýnlandýnýz.");
	return true;
}

CMD:gotosf(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	SetPlayerPos(playerid, -1417.0,-295.8,14.1);
	SendServerMessage(playerid, "San Fierro'ya ýþýnlandýnýz.");
	return true;
}

CMD:sendtols(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/sendtols [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	SetPlayerPos(targetid, 1529.6,-1691.2,13.3);
	SendServerMessage(targetid, "%s tarafýndan Los Santos'a gönderildiniz.", GetNickname(playerid));
	SendServerMessage(playerid, "%s isimli kiþiyi Los Santos'a gönderdiniz.", GetRPName(targetid));
	return true;
}

CMD:sendtosend(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new targetid, targetid2;
	if(sscanf(params, "uu", targetid, targetid2)) return SendServerMessage(playerid, "/sendtosend [birinci id/isim] [ikinci id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!LoggedIn[targetid2]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid2)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	new Float:x, Float:y, Float:z, int, vw;

	int = GetPlayerInterior(targetid2);
	vw = GetPlayerVirtualWorld(targetid2);
	GetPlayerPos(targetid2, x, y, z);

	SetPlayerPos(targetid, x, y, z);
	SetPlayerInterior(targetid, int);
	SetPlayerVirtualWorld(targetid, vw);

	SendServerMessage(targetid, "%s tarafýndan, %s isimli kiþinin yanýna gönderildiniz.", GetNickname(playerid), GetRPName(targetid2));
	SendServerMessage(playerid, "%s isimli kiþiyi %s isimli kiþinin yanýna gönderdiniz.", GetRPName(targetid), GetRPName(targetid2));
	return true;
}

CMD:getcar(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new vehid, Float:x, Float:y, Float:z, myVW;
	if(sscanf(params, "d", vehid)) return SendServerMessage(playerid, "/getcar [araç id]");
	if(!Vehicle[vehid][vIsValid]) return SendServerMessage(playerid, "Araç bulunamadý!");

	GetPlayerPos(playerid, x, y, z);
	myVW = GetPlayerVirtualWorld(playerid);
	SetVehiclePos(vehid, x, y, z);
	SetVehicleVirtualWorld(vehid, myVW);

	SendServerMessage(playerid, "%d numaralý aracý yanýnýza çektiniz.", vehid);
	return true;
}

CMD:gotocar(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new vehid, Float:x, Float:y, Float:z, vehVW;
	if(sscanf(params, "d", vehid)) return SendServerMessage(playerid, "/gotocar [araç id]");
	if(!Vehicle[vehid][vIsValid]) return SendServerMessage(playerid, "Araç bulunamadý!");

	GetVehiclePos(vehid, x, y, z);
	vehVW = GetVehicleVirtualWorld(vehid);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerVirtualWorld(playerid, vehVW);

	SendServerMessage(playerid, "%d numaralý araca ýþýnlandýnýz.", vehid);
	return true;
}

CMD:setskin(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new targetid, skinid;
	if(sscanf(params, "ud", targetid, skinid)) return SendServerMessage(playerid, "/setskin [id/isim] [skin deðeri]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	SetPlayerSkin(targetid, skinid);
	Character[targetid][cSkin] = skinid;
	SaveCharacterData(targetid);

	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %s isimli kiþinin skin deðeri güncellendi.", GetNickname(playerid), GetRPName(playerid));
	return true;
}

CMD:setarmour(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new targetid, Float:newamount;
	if(sscanf(params, "uf", targetid, newamount)) return SendServerMessage(playerid, "/setarmor [id/isim] [zýrh deðeri]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	SetPlayerArmour(targetid, newamount);
	Character[targetid][cArmour] = newamount;
	SaveCharacterData(targetid);

	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %s isimli kiþinin zýrh deðeri güncellendi.", GetNickname(playerid), GetRPName(targetid));
	return true;
}

CMD:sethp(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new targetid, Float:newamount;
	if(sscanf(params, "uf", targetid, newamount)) return SendServerMessage(playerid, "/sethp [id/isim] [can deðeri]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	SetPlayerHealth(targetid, newamount);
	Character[targetid][cHP] = newamount;
	SaveCharacterData(targetid);

	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, %s isimli kiþinin can deðeri güncellendi.", GetNickname(playerid), GetRPName(targetid));
	return true;
}

CMD:revive(playerid, params[])
{
	/*if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/revive [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!Death[targetid]) return SendServerMessage(playerid, "Kiþi ölü deðil.");

	Death[targetid] = 0;
	DeathMeter[targetid] = 0;
	TogglePlayerControllable(targetid, true);
	KillTimer(DeathTimer[targetid]);
	DestroyDynamic3DTextLabel(DeathText[targetid]);
	ClearAnimations(targetid);
	SendServerMessage(targetid, "%s tarafýndan canlandýrýldýnýz.", Character[playerid][cNickname]);
	SendServerMessage(playerid, "%s isimli oyuncuyu canlandýrdýnýz.", GetRPName(targetid));*/
	return true;
}

CMD:gotopos(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new Float:x, Float:y, Float:z;
	if(sscanf(params, "fff", x, y, z)) return SendServerMessage(playerid, "/gotopos [x] [y] [z]");

	SetPlayerPos(playerid, x, y, z);
	return true;
}

CMD:a(playerid, params[])
{
	new str[124];
	if(sscanf(params, "s[124]", str)) return SendServerMessage(playerid, "/a [mesaj(124)]");
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new s;
	s = Character[playerid][cAdmin];
	if(s > 1 && s < 7)
	{
		s = s - 1;
	}
	SendAdminMessage(C_ADMIN, "{FFFF15}[%i] %s: %s", s, Character[playerid][cNickname], str);
	return true;
}

CMD:ban(playerid, params[])
{
	new target, reason[32];
	if(Character[playerid][cAdmin] < VWGAMEADMIN3) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(sscanf(params, "us[32]", target, reason)) return SendServerMessage(playerid, "/ban [id/isim] [sebep]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(strlen(reason) < 1 || strlen(reason) > 32) return SendServerMessage(playerid, "Geçersiz karakter girdiniz (1-32max.)");

	SendAllMessage(C_ADMIN, "AdmCmd: %s tarafýndan %s isimli kiþi ''%s'' sebebiyle sunucudan yasaklandý.", Character[playerid][cNickname], GetRPName(target), reason);
	BanServer(target);
	return true;
}

CMD:kick(playerid, params[])
{
	new target, reason[32];
	if(Character[playerid][cAdmin] < VWGAMEADMIN3) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(sscanf(params, "us[32]", target, reason)) return SendServerMessage(playerid, "/kick [id/isim] [sebep]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(strlen(reason) < 1 || strlen(reason) > 32) return SendServerMessage(playerid, "Geçersiz karakter girdiniz (1-32max.)");

	SendAllMessage(C_ADMIN, "AdmCmd: %s tarafýndan %s isimli kiþi ''%s'' sebebiyle sunucudan atýldý.", Character[playerid][cNickname], GetRPName(target), reason);
	SaveCharacterData(target);
	KickEx(target);
	return true;
}

CMD:goto(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, targetint, targetvw, Float:targetPos[4];
	if(sscanf(params, "u", target)) return SendServerMessage(playerid, "/goto [id/isim]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	new veh, seat;

	if(IsPlayerInAnyVehicle(playerid))
	{
		veh = GetPlayerVehicleID(playerid);
		seat = GetPlayerVehicleSeat(playerid);
	}

	targetint = GetPlayerInterior(target);
	targetvw = GetPlayerVirtualWorld(target);
	GetPlayerPos(target, targetPos[0], targetPos[1], targetPos[2]);
	GetPlayerFacingAngle(target, targetPos[3]);

	if(IsPlayerInAnyVehicle(playerid))
	{
		SetVehiclePos(veh, targetPos[0], targetPos[1], targetPos[2]);
		PutPlayerInVehicle(playerid, veh, seat);
	}

	SetPlayerInterior(playerid, targetint);
	SetPlayerVirtualWorld(playerid, targetvw);
	SetPlayerPos(playerid, targetPos[0], targetPos[1]+1, targetPos[2]);
	SetPlayerFacingAngle(playerid, targetPos[3]);

	SendServerMessage(playerid, "%s isimli oyuncunun yanýna ýþýnlandýnýz.", GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici yanýnýza ýþýnlandý.", Character[playerid][cNickname]);
	return true;
}

CMD:gethere(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, myint, myvw, Float:myPos[4];
	if(sscanf(params, "u", target)) return SendServerMessage(playerid, "/gethere [id/isim]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	myint = GetPlayerInterior(playerid);
	myvw = GetPlayerVirtualWorld(playerid);
	GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
	GetPlayerFacingAngle(playerid, myPos[3]);

	SetPlayerInterior(target, myint);
	SetPlayerVirtualWorld(target, myvw);
	SetPlayerPos(target, myPos[0], myPos[1]+1, myPos[2]);
	SetPlayerFacingAngle(target, myPos[3]);

	SendServerMessage(playerid, "%s isimli oyuncuyu yanýnýza çektiniz.", GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici sizi yanýna çekti.", Character[playerid][cNickname]);
	return true;
}

CMD:uyari(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN3) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, reason[32];
	if(sscanf(params, "us[32]", target, reason)) return SendServerMessage(playerid, "/uyari [id/isim] [sebep(32)]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	Character[target][cWarn]++;
	SendAllMessage(C_ADMIN, "AdmCmd: %s tarafýndan %s isimli kiþiye ''%s'' sebebiyle uyarý verildi. (%d/3)", Character[playerid][cNickname], GetRPName(target), reason, Character[target][cWarn]);
	
	if(Character[target][cWarn] == 3)
	{
		SendAllMessage(C_ADMIN, "AdmCmd: %s isimli kiþi uyarý hakkýný doldurmasý sebebiyle sunucudan yasaklandý.", GetRPName(target));
		SaveCharacterData(target);
		BanServer(target);
	}
	return true;
}

CMD:uyarisil(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN3) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, reason[32];
	if(sscanf(params, "us[32]", target, reason)) return SendServerMessage(playerid, "/uyarisil [id/isim] [sebep(32)]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	Character[target][cWarn]--;
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %s isimli kiþinin ''%s'' sebeple bir uyarý puaný silindi.", Character[playerid][cNickname], GetRPName(target), reason);
	SendServerMessage(target, "%s isimli yönetici tarafýndan bir uyarý puanýnýz silindi.", Character[playerid][cNickname]);
	return true;
}

CMD:mute(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target;
	if(sscanf(params, "u", target)) return SendServerMessage(playerid, "/mute [id/isim]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(Muted[target] == true) return SendServerMessage(playerid, "Kiþi susturulmuþ halde.");

	Muted[target] = true;
	SendServerMessage(playerid, "%s isimli kiþiyi susturdunuz.", GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici tarafýndan susturuldunuz.", Character[playerid][cNickname]);
	return true;
}

CMD:unmute(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target;
	if(sscanf(params, "u", target)) return SendServerMessage(playerid, "/unmute [id/isim]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(Muted[target] == false) return SendServerMessage(playerid, "Kiþi susturulmamýþ.");

	Muted[target] = false;
	SendServerMessage(playerid, "%s isimli kiþinin susturmasýný açtýnýz.", GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici tarafýndan susturmanýz açýldý.", Character[playerid][cNickname]);
	return true;
}

CMD:setint(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, int;
	if(sscanf(params, "ud", target, int)) return SendServerMessage(playerid, "/setint [id/isim] [int id]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	SetPlayerInterior(target, int);

	SendServerMessage(playerid, "%s isimli kiþinin interiorunu deðiþtirdiniz.", GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici tarafýndan interiorunuz deðiþtirildi.", Character[target][cNickname]);
	return true;
}

CMD:setvw(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, vw;
	if(sscanf(params, "ud", target, vw)) return SendServerMessage(playerid, "/setvw [id/isim] [vw id]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	SetPlayerVirtualWorld(target, vw);

	SendServerMessage(playerid, "%s isimli kiþinin worldunu deðiþtirdiniz.", GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici tarafýndan worldunuz deðiþtirildi.", Character[playerid][cNickname]);
	return true;
}

CMD:spec(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, targetint, targetvw;
	if(sscanf(params, "u", target)) return SendServerMessage(playerid, "/spec [id/isim]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(target == playerid) return SendServerMessage(playerid, "Kendini izleyemezsin.");

	GetPlayerPos(playerid, SpecModePos[playerid][0], SpecModePos[playerid][1], SpecModePos[playerid][2]);
	GetPlayerFacingAngle(playerid, SpecModePos[playerid][3]);
	SpecModeInt[playerid] = GetPlayerInterior(playerid);
	SpecModeVW[playerid] = GetPlayerVirtualWorld(playerid);
	targetint = GetPlayerInterior(target);
	targetvw = GetPlayerVirtualWorld(target);
	SetPlayerInterior(playerid, targetint);
	SetPlayerVirtualWorld(playerid, targetvw);
	TogglePlayerSpectating(playerid, true);
	PlayerSpectatePlayer(playerid, target);
	SpecMode[playerid] = true;

	if(Character[target][cAdmin] >= VWDEVELOPER) SendServerMessage(target, "%s adlý yönetici þu anda sizi izliyor.", Character[playerid][cNickname]);

	SendServerMessage(playerid, "%s isimli kiþiyi izlemeye baþladýnýz.", GetRPName(target));
	return true;
}

CMD:specoff(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(!SpecMode[playerid]) return SendServerMessage(playerid, "Ýzleme modunda deðilsiniz.");

	SetPlayerPos(playerid, SpecModePos[playerid][0], SpecModePos[playerid][1], SpecModePos[playerid][2]);
	SetPlayerFacingAngle(playerid, SpecModePos[playerid][3]);
	SetPlayerInterior(playerid, SpecModeInt[playerid]);
	SetPlayerVirtualWorld(playerid, SpecModeVW[playerid]);
	TogglePlayerSpectating(playerid, false);
	SpecMode[playerid] = false;

	SendServerMessage(playerid, "Ýzleme modundan çýktýnýz.");
	return true;
}

CMD:freeze(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target;
	if(sscanf(params, "u", target)) return SendServerMessage(playerid, "/freeze [id/isim]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	TogglePlayerControllable(target, false);
	SendServerMessage(playerid, "%s isimli oyuncuyu dondurdunuz.", GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici tarafýndan donduruldunuz.", Character[playerid][cNickname]);
	return true;
}

CMD:unfreeze(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target;
	if(sscanf(params, "u", target)) return SendServerMessage(playerid, "/unfreeze [id/isim]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	TogglePlayerControllable(target, true);
	SendServerMessage(playerid, "%s isimli oyuncuyu çözdünüz.", GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici tarafýndan çözüldünüz.", Character[playerid][cNickname]);
	return true;
}
alias:unfreeze("uf")

CMD:awork(playerid, params[])
{
	if(!Character[playerid][cAdmin]) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	if(Character[playerid][cAdmin] == 1)
	{
		switch(Awork[playerid])
		{
			case false: 
			{
				Awork[playerid] = true;
				SendServerMessage(playerid, "Müsait duruma geçtiniz.");
				SetPlayerColor(playerid, 0x800000FF);
				SetPlayerName(playerid, Character[playerid][cNickname]);
			}
			case true: 
			{
				Awork[playerid] = false; 
				SendServerMessage(playerid, "Meþgul duruma geçtiniz.");
				SetPlayerColor(playerid, C_WHITE);
				SetPlayerName(playerid, Character[playerid][cName]);
			}
		}
	}
	else if(Character[playerid][cAdmin] > 1)
	{
		switch(Awork[playerid])
		{
			case false: 
			{
				Awork[playerid] = true;
				SendServerMessage(playerid, "Müsait duruma geçtiniz.");
				SetPlayerColor(playerid, 0x62869DFF);
				SetPlayerName(playerid, Character[playerid][cNickname]);
			}
			case true: 
			{
				Awork[playerid] = false; 
				SendServerMessage(playerid, "Meþgul duruma geçtiniz.");
				SetPlayerColor(playerid, C_WHITE);
				SetPlayerName(playerid, Character[playerid][cName]);
			}
		}
	}
	return true;
}

CMD:checkstats(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN3) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target;
	if(sscanf(params, "u", target)) return SendServerMessage(playerid, "/checkstats [id/isim]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	ShowStats(target, playerid);
	return true;
}

CMD:makeadmin(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, adminlevel;
	if(sscanf(params, "ud", target, adminlevel)) return SendServerMessage(playerid, "/makeadmin [id/isim] [admin level(1-7)]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(adminlevel < 1 || adminlevel > 7) return SendServerMessage(playerid, "Geçersiz seviye girdiniz.");

	Character[target][cAdmin] = adminlevel;
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %s isimli kiþi %d seviye yönetici yapýldý.", Character[playerid][cNickname], GetRPName(target), adminlevel);
	return true;
}

CMD:givemoney(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, amount;
	if(sscanf(params, "ud", target, amount)) return SendServerMessage(playerid, "/givemoney [id/isim] [miktar]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	GiveMoney(target, amount);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %s isimli kiþiye $%d miktar para verildi.", Character[playerid][cNickname], GetRPName(target), amount);
	return true;
}

CMD:setmoney(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, amount;
	if(sscanf(params, "ud", target, amount)) return SendServerMessage(playerid, "/setmoney [id/isim] [miktar]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	Character[playerid][cMoney] = amount;
	ResetPlayerMoney(target);
	GiveMoney(target, Character[playerid][cMoney]);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %s isimli kiþinin parasý $%d olarak ayarlandý.", Character[playerid][cNickname], GetRPName(target), amount);
	return true;
}

CMD:setname(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWDEVELOPER) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, newname[124];
	if(sscanf(params, "us[124]", target, newname)) return SendServerMessage(playerid, "/setname [id/isim] [yeni isim(124)]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	format(Character[target][cName], 124, "%s", newname);
	SetPlayerName(target, Character[target][cName]);
	SendServerMessage(playerid, "Bir oyuncunun ismini deðiþtirdiniz.");
	SendServerMessage(target, "%s tarafýndan isminiz deðiþtirildi.", Character[playerid][cNickname]);
	return true;
}

CMD:setlevel(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWDEVELOPER) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new target, newlevel;
	if(sscanf(params, "ud", target, newlevel)) return SendServerMessage(playerid, "/setlevel [id/isim] [yeni seviye]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	Character[target][cLevel] = newlevel;
	SetPlayerScore(target, Character[target][cLevel]);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %s isimli kiþinin seviyesi deðiþtirildi.", Character[playerid][cNickname], GetRPName(target));
	SendServerMessage(target, "%s isimli yönetici tarafýndan seviyeniz deðiþtirildi.", Character[playerid][cNickname]);
	return true;
}

CMD:savealldata(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWDEVELOPER) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	foreach(new i : Player) if(IsPlayerConnected(i))
    {
        OnPlayerDisconnect(i, 1);
        SaveCharacterData(i);
    }

    foreach(new i : Houses) if(House[i][hIsValid])
    {
        RefreshHouse(i);
    }

    foreach(new i : Weapons) if(Weapon[i][wIsValid])
    {
        RefreshWeapon(i);
    }

    foreach(new i : Buildings) if(Building[i][bIsValid])
    {
        RefreshBuilding(i);
    }

    for(new i; i < MAX_VEHICLES; i++) if(Vehicle[i][vIsValid])
    {
        RefreshVehicle(i);
    }

    foreach(new i : Factions) if(Faction[i][fIsValid])
    {
        RefreshFaction(i);
    }

    foreach(new i : Furnitures) if(Furniture[i][fIsValid])
    {
        RefreshFurniture(i);
    }

    foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid])
    {
        RefreshFurnitureCategory(i);
    }

    foreach(new i : FurnitureItems) if(FurnitureItem[i][iIsValid])
    {
        RefreshFurnitureItem(i);
    }

	SendAllMessage(C_ADMIN, "AdmWarn: %s tarafýndan sunucunun tüm verileri kaydedildi.", Character[playerid][cNickname]);
	return true;
}

CMD:gitev(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new houseid;
	if(sscanf(params, "d", houseid)) return SendServerMessage(playerid, "/gitev [ev id]");
	if(!House[houseid][hIsValid]) return SendServerMessage(playerid, "Ev bulunamadý.");

	SetPlayerPos(playerid, House[houseid][hExtDoor][0], House[houseid][hExtDoor][1], House[houseid][hExtDoor][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	return true;
}

CMD:gitarac(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new vehid;
	if(sscanf(params, "d", vehid)) return SendServerMessage(playerid, "/gitarac [arac id]");
	if(!Vehicle[vehid][vIsValid]) return SendServerMessage(playerid, "Araç bulunamadý.");

	new Float:getVehPos[3], getVehVW;
	GetVehiclePos(vehid, getVehPos[0], getVehPos[1], getVehPos[2]);
	getVehVW = GetVehicleVirtualWorld(vehid);
	SetPlayerPos(playerid, getVehPos[0], getVehPos[1], getVehPos[2]);
	SetPlayerVirtualWorld(playerid, getVehVW);

	SendServerMessage(playerid, "%d numaralý araca gittiniz.", vehid);
	return true;
}

CMD:getirarac(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new vehid;
	if(sscanf(params, "d", vehid)) return SendServerMessage(playerid, "/gitarac [arac id]");
	if(!Vehicle[vehid][vIsValid]) return SendServerMessage(playerid, "Araç bulunamadý.");

	new Float:myPos[3], myVW = GetPlayerVirtualWorld(playerid);
	GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
	SetVehiclePos(vehid, myPos[0], myPos[1]+0.5, myPos[2]);
	SetVehicleVirtualWorld(vehid, myVW);

	SendServerMessage(playerid, "%d numaralý aracý çektiniz.", vehid);
	return true;
}

CMD:gitbina(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN1) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new bid;
	if(sscanf(params, "d", bid)) return SendServerMessage(playerid, "/gitbina [bina id]");
	if(!Building[bid][bIsValid]) return SendServerMessage(playerid, "Bina bulunamadý.");

	SetPlayerPos(playerid, Building[bid][bExtDoor][0], Building[bid][bExtDoor][1], Building[bid][bExtDoor][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);

	SendServerMessage(playerid, "%d numaralý binaya gittiniz.", bid);
	return true;
}

CMD:aracduzenle(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWDEVELOPER) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");

	new vehid, opt[64], extra[124];
	if(sscanf(params, "ds[64]S()[124]", vehid, opt, extra))
	{
		SendServerMessage(playerid, "/aracduzenle [araç id] [seçenek] [yeni deðer]");
		SendClientMessage(playerid, C_GREY1, "sahip | olusum | olusumiptal | renk1 | renk2 | tip | deger | plaka");
		SendClientMessage(playerid, C_GREY1, "km | benzin | agirhasar | motoromru | akuomru | olusumiptal | kilitseviye | alarmseviye");
	}
	else
	{
		if(!Vehicle[vehid][vIsValid]) return SendServerMessage(playerid, "Araç bulunamadý.");

		if(!strcmp(opt, "sahip", true))
		{
			new targetid;
			if(sscanf(extra, "u", targetid)) return SendServerMessage(playerid, "/aracduzenle [araç id] [sahip] [id/isim]");
			if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
			if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");

			Vehicle[vehid][vOwner] = Character[targetid][cID];
			RefreshVehicle(vehid);
			SaveCharacterData(targetid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn sahibi %s olarak deðiþtirildi.", Character[playerid][cNickname], vehid, GetRPName(targetid));
		}
		else if(!strcmp(opt, "olusum", true))
		{
			new factid;
			if(sscanf(extra, "d", factid)) return SendServerMessage(playerid, "/aracduzenle [araç id] [olusum] [oluþum id]");
			if(!Faction[factid][fIsValid]) return SendServerMessage(playerid, "Oluþum bulunamadý.");

			Vehicle[vehid][vFaction] = Faction[factid][fID];
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn oluþumu %s olarak deðiþtirildi.", Character[playerid][cNickname], vehid, Faction[factid][fName]);
		}
		else if(!strcmp(opt, "renk1", true))
		{
			new color1;
			if(sscanf(extra, "d", color1)) return SendServerMessage(playerid, "/aracduzenle [araç id] [renk1] [renk kodu]");

			Vehicle[vehid][vColor1] = color1;
			SetVehicleColor(vehid, Vehicle[vehid][vColor1], Vehicle[vehid][vColor2]);
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn birincil rengi deðiþtirildi.", Character[playerid][cNickname], vehid);
		}
		else if(!strcmp(opt, "renk2", true))
		{
			new color2;
			if(sscanf(extra, "d", color2)) return SendServerMessage(playerid, "/aracduzenle [araç id] [renk2] [renk kodu]");

			Vehicle[vehid][vColor2] = color2;
			SetVehicleColor(vehid, Vehicle[vehid][vColor1], Vehicle[vehid][vColor2]);
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn ikincil rengi deðiþtirildi.", Character[playerid][cNickname], vehid);
		}
		else if(!strcmp(opt, "tip", true))
		{
			new type;
			if(sscanf(extra, "d", type))
			{
				SendServerMessage(playerid, "/aracduzenle [araç id] [tip] [yeni tip]");
				SendClientMessage(playerid, C_GREY1, "1: Standart | 2: Kiralýk");
			}
			else
			{
				if(type < 1 || type > 2) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");
				if(Vehicle[vehid][vFaction]) return SendServerMessage(playerid, "Bu araç bir oluþum aracý.");
				if(Vehicle[vehid][vOwner]) return SendServerMessage(playerid, "Bu araç bir baþkasýna ait.");

				Vehicle[vehid][vType] = type;
				RefreshVehicle(vehid);
				SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn tipi güncellendi.", Character[playerid][cNickname], vehid);
			}
		}
		else if(!strcmp(opt, "deger", true))
		{
			new amount;
			if(sscanf(extra, "d", amount)) return SendServerMessage(playerid, "/aracduzenle [araç id] [deger] [yeni deðer]");

			Vehicle[vehid][vPrice] = amount;
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn deðeri $%d olarak güncellendi.", Character[playerid][cNickname], vehid, amount);
		}
		else if(!strcmp(opt, "plaka", true))
		{
			new plate[32];
			if(sscanf(extra, "s[32]", plate)) return SendServerMessage(playerid, "/aracduzenle [araç id] [plaka] [yeni plaka(32)]");

			format(Vehicle[vehid][vPlate], 32, "%s", plate);
			SetVehicleNumberPlate(vehid, Vehicle[vehid][vPlate]);
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn plakasý %s olarak güncellendi.", Character[playerid][cNickname], vehid, Vehicle[vehid][vPlate]);
		}
		else if(!strcmp(opt, "km", true))
		{
			new km;
			if(sscanf(extra, "d", km)) return SendServerMessage(playerid, "/aracduzenle [araç id] [km] [yeni km]");
			if(km < 0) return SendServerMessage(playerid, "Deðer 0dan düþük olamaz.");

			Vehicle[vehid][vKM] = km;
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn kilometresi %d olarak güncellendi.", Character[playerid][cNickname], vehid, Vehicle[vehid][vKM]);
		}
		else if(!strcmp(opt, "benzin", true))
		{
			new fuel;
			if(sscanf(extra, "d", fuel)) return SendServerMessage(playerid, "/aracduzenle [araç id] [benzin] [yakýt]");
			if(fuel < 0) return SendServerMessage(playerid, "Deðer 0dan düþük olamaz.");

			Vehicle[vehid][vFuel] = fuel;
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn benzin deðeri %d olarak güncellendi.", Character[playerid][cNickname], vehid, fuel);
		}
		else if(!strcmp(opt, "agirhasar", true))
		{
			new status;
			if(sscanf(extra, "d", status)) return SendServerMessage(playerid, "/aracduzenle [araç id] [agirhasar] [durum]");

			Vehicle[vehid][vAccident] = status;
			switch(status)
			{
				case 0: 
				{
					RepairVehicle(vehid), SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn aðýr hasarý tamir edildi.", Character[playerid][cNickname], vehid);
					Vehicle[vehid][vAccident] = 0;
					Vehicle[vehid][vHealth] = 1000;
					RefreshVehicle(vehid);
				}
				case 1: 
				{
					SwitchVehicleEngine(vehid, false), Engine[vehid] = false;
					SwitchVehicleDoors(vehid, false), Doors[vehid] = false;
					SwitchVehicleLight(vehid, false), Lights[vehid] = false;
					SwitchVehicleBonnet(vehid, false), Bonnet[vehid] = false;
					SwitchVehicleBoot(vehid, false), Boot[vehid] = false;
					Vehicle[vehid][vAccident] = 1;
					Vehicle[vehid][vHealth] = 350;
					Vehicle[vehid][vEngineLife] -= 25.0;
					Vehicle[vehid][vBatteryLife] -= 25.0;
					SetVehicleHealth(vehid, 350);
					RefreshVehicle(vehid);
					SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý araç aðýr hasarlý hale getirildi.", Character[playerid][cNickname], vehid);
				}
			}
		}
		else if(!strcmp(opt, "motoromru", true))
		{
			new amount;
			if(sscanf(extra, "d", amount)) return SendServerMessage(playerid, "/aracduzenle [araç id] [motoromru] [yeni deðer(100.0)]");

			Vehicle[vehid][vEngineLife] = amount;
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn motor ömrü %.2f olarak güncellendi.", Character[playerid][cNickname], vehid, Vehicle[vehid][vEngineLife]);
		}
		else if(!strcmp(opt, "akuomru", true))
		{
			new amount;
			if(sscanf(extra, "d", amount)) return SendServerMessage(playerid, "/aracduzenle [araç id] [akuomru] [yeni deðer(100.0)]");

			Vehicle[vehid][vBatteryLife] = amount;
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn akü ömrü %.2f olarak güncellendi.", Character[playerid][cNickname], vehid, Vehicle[vehid][vBatteryLife]);
		}
		else if(!strcmp(opt, "olusumiptal", true))
		{
			Vehicle[vehid][vFaction] = 0;
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý araç oluþumdan çýkartýldý.", Character[playerid][cNickname], vehid);
		}
		else if(!strcmp(opt, "kilitseviye", true))
		{
			new level;
			if(sscanf(extra, "d", level)) return SendServerMessage(playerid, "/aracduzenle [araç id] [kilitseviye] [yeni deðer]");

			Vehicle[vehid][vLockLevel] = level;
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn kilit seviyesi %d olarak deðiþtirildi.", GetNickname(playerid), vehid, level);
		}
		else if(!strcmp(opt, "alarmseviye", true))
		{
			new level;
			if(sscanf(extra, "d", level)) return SendServerMessage(playerid, "/aracduzenle [araç id] [alarmseviye] [yeni deðer]");

			Vehicle[vehid][vAlarmLevel] = level;
			RefreshVehicle(vehid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan %d numaralý aracýn alarm seviyesi %d olarak deðiþtirildi.", GetNickname(playerid), vehid, level);
		}
	}
	return true;
}