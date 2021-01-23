CMD:yardim(playerid, params[])
{
	SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[www.vw-rp.com]__________________");
	SendClientMessageEx(playerid, C_GREY1, "Chat: /me, /do, /ame, /ado, /sme, /sdo, /pm, /pmdurum, /b, /w, /l, /s");
	SendClientMessageEx(playerid, C_GREY1, "Genel: /admins, /testers, /paraver, /karakter, /id, /sorusor, /soruiptal");
	SendClientMessageEx(playerid, C_GREY1, "Genel: /animler, /giris, /cikis, /motor, /olusumlar, /cezalarim, /konum");
	SendClientMessageEx(playerid, C_GREY1, "Genel: /maske, /sopa, /cicek, /boombox, /sigara, /reklam, /isreklam");
	SendClientMessageEx(playerid, C_GREY1, "Diðer: /evyardim, /silahyardim, /aracyardim, /olusumyardim, /telefonyardim");
	SendClientMessageEx(playerid, C_GREY1, "Diðer: /isyeriyardim, /aksesuaryardim");
	if(Character[playerid][cAdmin] > 0)
		SendClientMessageEx(playerid, C_GREY1, "Admin/Tester: /ahelp");
	return true;
}

CMD:konum(playerid, params[])
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SendClientMessageEx(playerid, C_GREY1, "Konum: %s", GetLocation(pos[0], pos[1], pos[2]));
	return true;
}

CMD:aksesuaryardim(playerid)
{
	SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[www.vw-rp.com]__________________");
	SendClientMessageEx(playerid, C_GREY1, "/aksesuar, /aksesuarcikart, /aksesuarduzenle, /aksesuarsil");
	return true;
}

CMD:telefonyardim(playerid)
{
	SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[www.vw-rp.com]__________________");
	SendClientMessageEx(playerid, C_GREY1, "/telefon, /cagrikabul, /cagrikapat, /cagrireddet, /cagriiptal, /ara, /rehberekle, /sms");
	return true;
}

CMD:isyeriyardim(playerid, params[])
{
	SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[www.vw-rp.com]__________________");
	SendClientMessageEx(playerid, C_GREY1, "/isyeriliste, /isyerikontrol, /personelal, /isyerisatinal, /isyerisistemesat");
	return true;
}

CMD:olusumyardim(playerid, params[])
{
	new factid = GetPlayerFactionID(playerid);
	SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[www.vw-rp.com]__________________");
	SendClientMessageEx(playerid, C_GREY1, "/fdurum, /f(action), /fdavet, /fcikart, /frespawn, /frutbe, /frutbeisim");
	switch(Faction[factid][fType])
	{
		case 1:
		{
			SendClientMessage(playerid, C_GREY1, "/pdisbasi, /mdc, /sicilkontrol, /siren, /taser, /cezakes, /kelepce");
			SendClientMessage(playerid, C_GREY1, "/rozetgoster, /(m)egafon, /(d)epartman, /(r)adio, /(y)akintelsiz, /operator");
			SendClientMessage(playerid, C_GREY1, "/mliste, /barikat, /ybarikatkaldir, /pdkiyafet, /sivilkiyafet");
		}
		case 3:
		{
			SendClientMessage(playerid, C_GREY1, "/fsisbasi, /(m)egafon, /(d)epartman, /(r)adio, /(y)akintelsiz, /operator");
			SendClientMessage(playerid, C_GREY1, "/fdkiyafet, /sivilkiyafet");
		}
		case 4:
		{
			SendClientMessage(playerid, C_GREY1, "/haber, /canliyayin, /yayindavetet, /yayindancikart, /davetkabul, /davetreddet");
		}
	}
	return true;
}

CMD:aracyardim(playerid, params[])
{
	SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[www.vw-rp.com]__________________");
	SendClientMessageEx(playerid, C_GREY1, "/galeri, /aracliste, /aracparkkontrol, /aracparksatinal($2500), /aracpark, /aracgetir");
	SendClientMessageEx(playerid, C_GREY1, "/arackilit, /aracfar, /arackaput, /aracbagaj, /aracsat, /aracdurum, /aracolusum");
	return true;
}

CMD:evyardim(playerid, params[])
{
	SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[www.vw-rp.com]__________________");
	SendClientMessageEx(playerid, C_GREY1, "/evsatinal, /evsat, /evisistemesat, /evkilit, /evlerim, /evanahtar");
	SendClientMessageEx(playerid, C_GREY1, "/evkirala, /evkiraiptal");
	SendClientMessageEx(playerid, C_GREY1, "UYARI: Sisteme satýlan evler, evin deðerinin yarý fiyatýna satýlýr.");
	return true;
}

CMD:silahyardim(playerid, params[])
{
	SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[www.vw-rp.com]__________________");
	SendClientMessageEx(playerid, C_GREY1, "/silahlarim, /silahcek, /silahsakla, /silahbirak, /silahal");
	return true;
}

CMD:giris(playerid, params[])
{
	if(HouseOutDoor(playerid))
	{
		new houseid = GetPlayerNearbyHouse(playerid);
		if(House[houseid][hLocked]) return SendServerMessage(playerid, "Kapý kilitli.");

		PlayerHouse[playerid] = houseid;
		InHouse[playerid] = 1;

		House[houseid][hPlayersInside]++;
		if(House[houseid][hPlayersInside] == 1) CreateHouseFurnitures(houseid);

		SetPlayerInterior(playerid, House[houseid][hInt]);
		SetPlayerVirtualWorld(playerid, House[houseid][hVW]);
		SetPlayerPos(playerid, House[houseid][hIntDoor][0], House[houseid][hIntDoor][1], House[houseid][hIntDoor][2]);
	}
	else if(BuildingOutDoor(playerid))
	{
		new bid = GetPlayerNearbyBuilding(playerid);
		if(Building[bid][bLocked]) return SendServerMessage(playerid, "Kapý kilitli.");

		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, Building[bid][bIntDoor][0], Building[bid][bIntDoor][1], Building[bid][bIntDoor][2]);
	}
	else if(BusinessOutDoor(playerid))
	{
		new bsid = GetPlayerNearbyBusiness(playerid);
		if(Business[bsid][bsLocked]) return SendServerMessage(playerid, "Kapý kilitli.");

		Character[playerid][cInsideBusiness] = 1;
		SetPlayerInterior(playerid, Business[bsid][bsInt]);
		SetPlayerVirtualWorld(playerid, Business[bsid][bsVW]);
		SetPlayerPos(playerid, Business[bsid][bsIntDoor][0], Business[bsid][bsIntDoor][1], Business[bsid][bsIntDoor][2]);
	}
	return true;
}

CMD:cikis(playerid, params[])
{
	if(HouseIntDoor(playerid))
	{
		new houseid = GetPlayerNearbyHouse(playerid);
		if(House[houseid][hLocked]) return SendServerMessage(playerid, "Kapý kilitli.");

		PlayerHouse[playerid] = 0;
		InHouse[playerid] = 0;

		House[houseid][hPlayersInside]--;
		if(House[houseid][hPlayersInside] == 0) HideHouseFurnitures(houseid);

		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, House[houseid][hExtDoor][0], House[houseid][hExtDoor][1], House[houseid][hExtDoor][2]);
	}
	else if(BuildingIntDoor(playerid))
	{
		new bid = GetPlayerNearbyBuilding(playerid);
		if(Building[bid][bLocked]) return SendServerMessage(playerid, "Kapý kilitli.");

		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, Building[bid][bExtDoor][0], Building[bid][bExtDoor][1], Building[bid][bExtDoor][2]);
	}
	else if(BusinessIntDoor(playerid))
	{
		new bsid = GetPlayerNearbyBusiness(playerid);
		if(Business[bsid][bsLocked]) return SendServerMessage(playerid, "Kapý kilitli.");

		Character[playerid][cInsideBusiness] = 0;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, Business[bsid][bsExtDoor][0], Business[bsid][bsExtDoor][1], Business[bsid][bsExtDoor][2]);
	}
	return true;
}

CMD:me(playerid, params[])
{
	new str[124];
	if(sscanf(params, "s[124]", str)) return SendServerMessage(playerid, "/me [emote(124)]");

	if(strlen(str) > 84)
	{
		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s %.84s", GetRPName(playerid), str);
		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s ... %s", GetRPName(playerid), str[84]);
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s %s", GetRPName(playerid), str);
	}
	return true;
}

CMD:do(playerid, params[])
{
	new str[124];
	if(sscanf(params, "s[124]", str)) return SendServerMessage(playerid, "/do [emote(124)]");

	if(strlen(str) > 84)
	{
		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %.84s (( %s ))", str[84], GetRPName(playerid));
		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* ... %s (( %s ))", str, GetRPName(playerid));
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s (( %s ))", str, GetRPName(playerid));
	}
	return true;
}

CMD:ame(playerid, params[])
{
	new str[124];
	if(sscanf(params, "s[124]", str)) return SendServerMessage(playerid, "/ame [emote(124)]");

	format(str, sizeof(str), "* >> %s %s", GetRPName(playerid), str);
	SetPlayerChatBubble(playerid, str, C_EMOTE, 20.0, 5000);
	SendClientMessage(playerid, C_EMOTE, str);
	return true;
}

CMD:ado(playerid, params[])
{
	new str[124];
	if(sscanf(params, "s[124]", str)) return SendServerMessage(playerid, "/ado [emote(124)]");

	format(str, sizeof(str), "* >> %s (( %s ))", str, GetRPName(playerid));
	SetPlayerChatBubble(playerid, str, C_EMOTE, 20.0, 5000);
	SendClientMessage(playerid, C_EMOTE, str);
	return true;
}

CMD:sme(playerid, params[])
{
	new str[124], time;
	if(sscanf(params, "ds[124]", time, str)) return SendServerMessage(playerid, "/sme [süre(saniye)] [emote(124)]");
	if(time < 0 || time > 60) return SendServerMessage(playerid, "Emote süresi 0-60 saniye arasýnda olmalýdýr.");

	new totaltime = time * 1000;
	format(str, sizeof(str), "* >> %s %s", GetRPName(playerid), str);
	SetPlayerChatBubble(playerid, str, C_EMOTE, 20.0, totaltime);
	SendClientMessage(playerid, C_EMOTE, str);
	return true;
}

CMD:sdo(playerid, params[])
{
	new str[124], time;
	if(sscanf(params, "ds[124]", time, str)) return SendServerMessage(playerid, "/sdo [süre(saniye)] [emote(124)]");
	if(time < 0 || time > 60) return SendServerMessage(playerid, "Emote süresi 0-60 saniye arasýnda olmalýdýr.");

	new totaltime = time * 1000;
	format(str, sizeof(str), "* >> %s (( %s ))", str, GetRPName(playerid));
	SetPlayerChatBubble(playerid, str, C_EMOTE, 20.0, totaltime);
	SendClientMessage(playerid, C_EMOTE, str);
	return true;
}

CMD:pm(playerid, params[])
{
	new target, str[124];
	if(sscanf(params, "us[124]", target, str)) return SendServerMessage(playerid, "/pm [id/isim] [mesaj(124)]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(PMBlock[target]) return SendServerMessage(playerid, "Kiþinin özel mesaj kanalý kapalý.");
	if(playerid == target) return SendServerMessage(playerid, "Kendine PM atamazsýn.");

	SendClientMessageEx(playerid, C_YELLOW, "[>> PM] %s(%d): %s", GetRPName(target), target, str);
	SendClientMessageEx(target, C_PM, "[<< PM] %s(%d): %s", GetRPName(playerid), playerid, str);
	return true;
}

CMD:pmdurum(playerid, params[])
{
	switch(PMBlock[playerid])
	{
		case false: PMBlock[playerid] = true, SendServerMessage(playerid, "Özel mesaj kanalýný kapattýnýz.");
		case true: PMBlock[playerid] = false, SendServerMessage(playerid, "Özel mesaj kanalýný açtýnýz.");
	}
	return true;
}

CMD:admins(playerid, params[])
{
	SendClientMessage(playerid, C_GREY1, "Aktif Yöneticiler:");
	new s;
	foreach(new i : Player)
	{
		s = Character[i][cAdmin];
		if(s > 1 && s < 7)
		{
			s = s - 1;
		}
		if(Character[i][cAdmin] > 1)
		{
			if(Awork[i] == true)
			{
				SendClientMessageEx(playerid, C_DGREEN, "(Level: %d) %s (%s) - Ýþ Baþý: Evet", s, Character[i][cNickname], GetName(i));
			}
			else
			{
				SendClientMessageEx(playerid, C_GREY1, "(Level: %d) %s (%s) - Ýþ Baþý: Hayýr", s, Character[i][cNickname], GetName(i));
			}
		}
	}
	return true;
}

CMD:testers(playerid, params[])
{
	SendClientMessage(playerid, C_GREY1, "Aktif Tester Ekibi Üyeleri:");
	foreach(new i : Player)
	{
		if(Character[i][cAdmin] == 1)
		{
			if(Awork[i] == true)
			{
				SendClientMessageEx(playerid, C_DGREEN, "%s (ID: %i) - Twork: Evet", GetRPName(i), i);
			}
			else
			{
				SendClientMessageEx(playerid, C_GREY1, "%s (ID: %i) - Twork: Hayýr", GetRPName(i), i);
			}
		}
	}
	return true;
}

CMD:b(playerid, params[])
{
	new str[124];
	if(sscanf(params, "s[124]", str)) return SendServerMessage(playerid, "/b [mesaj(124)]");

	if(Character[playerid][cAdmin] == 1)
	{
		if(strlen(str) > 84)
		{
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] {800000}%s: {AFAFAF}%.84s ))", Character[playerid][cNickname], str);
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] {800000}%s: {AFAFAF}... %s ))", Character[playerid][cNickname], str[84]);
		}
		else
		{
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] {800000}%s: {AFAFAF}%s ))", Character[playerid][cNickname], str);
		}
	}
	else if(Character[playerid][cAdmin] > 1)
	{
		if(strlen(str) > 84)
		{
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] {62869D}%s: {AFAFAF}%.84s ))", Character[playerid][cNickname], str);
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] {62869D}%s: {AFAFAF}... %s ))", Character[playerid][cNickname], str[84]);
		}
		else
		{
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] {62869D}%s: {AFAFAF}%s ))", Character[playerid][cNickname], str);
		}
	}
	else
	{
		if(strlen(str) > 84)
		{
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] %s: %.84s ))", GetRPName(playerid), str);
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] %s: ... %s ))", GetRPName(playerid), str[84]);
		}
		else
		{
			SendNearbyMessage(playerid, 20.0, C_GREY1, "(( [OOC] %s: %s ))", GetRPName(playerid), str);
		}
	}
	return true;
}

CMD:whisper(playerid, params[])
{
	if(Muted[playerid]) return SendServerMessage(playerid, "Susturulmuþken konuþamazsýnýz.");
	new target, str[124];
	if(sscanf(params, "us[124]", target, str)) return SendServerMessage(playerid, "/(w)hisper [id/isim] [mesaj(124)]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerNearPlayer(playerid, target, 3.0)) return SendServerMessage(playerid, "Kiþi yakýnýnýzda deðil.");
	if(playerid == target) return SendServerMessage(playerid, "Kendine fýsýldayamazsýn.");

	if(strlen(str) > 84)
	{
		SendClientMessageEx(target, C_YELLOW, "%s (fýsýldayarak): %.84s", GetRPName(playerid), str);
		SendClientMessageEx(target, C_YELLOW, "%s (fýsýldayarak): ... %s", GetRPName(playerid), str[84]);

		SendClientMessageEx(playerid, C_YELLOW, "%s (fýsýldayarak): %.84s", GetRPName(playerid), str);
		SendClientMessageEx(playerid, C_YELLOW, "%s (fýsýldayarak): ... %s", GetRPName(playerid), str[84]);

		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s, %s'e yaklaþarak, kulaðýna fýsýldar.", GetRPName(playerid), GetRPName(target));
	}
	else
	{
		SendClientMessageEx(target, C_YELLOW, "%s (fýsýldayarak): %s", GetRPName(playerid), str);

		SendClientMessageEx(playerid, C_YELLOW, "%s (fýsýldayarak): %s", GetRPName(playerid), str);
		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s, %s'e yaklaþarak, kulaðýna fýsýldar.", GetRPName(playerid), GetRPName(target));
	}
	return true;
}
alias:whisper("w")

CMD:low(playerid, params[])
{
	if(Muted[playerid]) return SendServerMessage(playerid, "Susturulmuþken konuþamazsýnýz.");
	new str[124];
	if(sscanf(params, "s[124]", str)) return SendServerMessage(playerid, "/(l)ow [mesaj(124)]");

	if(strlen(str) > 84)
	{
		SendNearbyMessage(playerid, 5.0, C_GREY1, "%s (sessizce): %.84s", GetRPName(playerid), str);
		SendNearbyMessage(playerid, 5.0, C_GREY1, "%s (sessizce): ... %s", GetRPName(playerid), str[84]);
	}
	else
	{
		SendNearbyMessage(playerid, 5.0, C_GREY1, "%s (sessizce): %s", GetRPName(playerid), str);
	}
	return true;
}
alias:low("c", "l")

CMD:shout(playerid, params[])
{
	if(Muted[playerid]) return SendServerMessage(playerid, "Susturulmuþken konuþamazsýnýz.");
	new str[124];
	if(sscanf(params, "s[124]", str)) return SendServerMessage(playerid, "/(s)hout [mesaj(124)]");

	if(strlen(str) > 84)
	{
		SendNearbyMessage(playerid, 30.0, C_WHITE, "%s (baðýrarak): %.84s", GetRPName(playerid), str);
		SendNearbyMessage(playerid, 30.0, C_WHITE, "%s (baðýrarak): ... %s", GetRPName(playerid), str[84]);
	}
	else
	{
		SendNearbyMessage(playerid, 30.0, C_WHITE, "%s (baðýrarak): %s", GetRPName(playerid), str);
	}

	if(GetNearestHouse(playerid))
	{
		new sex[12];

		foreach(new i : Player) {
			if(IsPlayerInRangeOfPoint(i, 10.0, House[i][hIntDoor][0], House[i][hIntDoor][1], House[i][hIntDoor][2])) {
				switch(Character[playerid][cSex])
				{
					case 0: sex = "Bilinmiyor";
					case 1: sex = "E";
					case 2: sex = "K";
				}
				SendClientMessageEx(i, C_WHITE, "(Evin dýþarýsý) [%s]: %s", sex, str);
			}
		}
	}
	else if(InHouse[playerid])
	{
		new sex[12];

		foreach(new i : Player) {
			if(IsPlayerInRangeOfPoint(i, 10.0, House[i][hExtDoor][0], House[i][hExtDoor][1], House[i][hExtDoor][2])) {
				switch(Character[playerid][cSex])
				{
					case 0: sex = "Bilinmiyor";
					case 1: sex = "E";
					case 2: sex = "K";
				}
				SendClientMessageEx(i, C_WHITE, "(Evin içerisi) [%s]: %s", sex, str);
			}
		}
	}

	return true;
}
alias:shout("s")

CMD:id(playerid, params[])
{
	new targetname[124];
	if(sscanf(params, "s[124]", targetname)) return SendServerMessage(playerid, "/id [karakter_adý]");

	foreach(new i : Player) if(IsPlayerConnected(i))
	{
		if(!strcmp(GetName(i), targetname, true, 3))
		{
			SendClientMessageEx(playerid, C_GREY1, "%s - (ID: %i)", GetRPName(i), i);
		}
	}
	return true;
}

CMD:paraver(playerid, params[])
{
	new target, amount;
	if(sscanf(params, "ud", target, amount)) return SendServerMessage(playerid, "/paraver [id/isim] [miktar]");
	if(!LoggedIn[target]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerNearPlayer(playerid, target, 3.0)) return SendServerMessage(playerid, "Kiþi yakýnýnýzda deðil.");
	if(target == playerid) return SendServerMessage(playerid, "Kendinize para veremezsiniz.");
	if(GetPlayerMoney(playerid) <= 0) return SendServerMessage(playerid, "Paranýz yok.");
	if(amount <= 0 || amount > Character[playerid][cMoney]) return SendServerMessage(playerid, "Hatalý miktar girdiniz ya da paranýz bulunmamaktadýr.");

	GiveMoney(target, amount);
	GiveMoney(playerid, -amount);

	SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s, %s'e bir miktar para verir.", GetRPName(playerid), GetRPName(target));
	SendServerMessage(playerid, "%s isimli kiþiye $%d miktar para verdiniz.", GetRPName(target), amount);
	SendServerMessage(target, "%s isimli kiþiden $%d miktar para aldýnýz.", GetRPName(playerid), amount);
	return true;
}

CMD:karakter(playerid, params[])
{
	ShowStats(playerid, playerid);
	return true;
}

CMD:animasyonlar(playerid, params[])
{
	SendClientMessageEx(playerid, C_GREY1, "/fall | /injured | /push | /handsup | /kiss | /cell | /slap | /bomb | /drunk | /laugh");
	SendClientMessageEx(playerid, C_GREY1, "/basket | /medic | /robman | /taichi | /lookout | /sit | /lay | /sup | /crossarms");
	SendClientMessageEx(playerid, C_GREY1, "/deal | /crack | /smoke | /chat | /hike | /dance | /fuck | /strip | /lean | /walk | /rap");
	SendClientMessageEx(playerid, C_GREY1, "/tired | /box | /scratch | /hide | /vomit | /eats | /cop | /stance | /run");
	SendClientMessageEx(playerid, C_GREY1, "/flag | /giver | /look | /show | /endchat | /caract | /riot | /wave | /gsign");
	SendClientMessageEx(playerid, C_GREY1, "Animasyonu durdurmak için space tuþuna basýn.");
	return true;
}
alias:animasyonlar("animler", "animations", "anims")

CMD:cezalarim(playerid, params[])
{
	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM penalty_tickets WHERE ticketOwner = '%i'", Character[playerid][cID]);
	GetData = mysql_query(conn, query);

	new rows, fields;
	cache_get_row_count(rows);
	cache_get_field_count(fields);
	if(cache_num_rows())
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "ticketOwner", Penalty[i][ticketOwner]);
			cache_get_value_name_int(i, "ticketID", Penalty[i][ticketID]);
			cache_get_value_name(i, "ticketReason", Penalty[i][ticketReason], 64);
			cache_get_value_name_int(i, "ticketAmount", Penalty[i][ticketAmount]);
			cache_get_value_name(i, "ticketDate", Penalty[i][ticketDate], 64);
			cache_get_value_name(i, "ticketOfficer", Penalty[i][ticketOfficer], 144);

			SendClientMessageEx(playerid, C_GREY1, "[%d / Tarih: %s] Sebep [%s] | Miktar [$%d] | Düzenleyen Memur [%s]", Penalty[i][ticketID], Penalty[i][ticketDate], Penalty[i][ticketReason], Penalty[i][ticketAmount], Penalty[i][ticketOfficer]);
		}
	}
	else
	{
		SendServerMessage(playerid, "Ödenmemiþ ceza bulunamadý.");
	}
	cache_delete(GetData);
	return true;
}

CMD:maske(playerid, params[])
{
	if(!HaveMask[playerid]) return SendServerMessage(playerid, "Maskeniz bulunmamaktadýr.");

	switch(UseMask[playerid])
	{
		case 0:
		{
			new maskid = randomEx(111111, 999999);
			format(MaskID[playerid], 124, "Maskeli_%d", maskid);

			UseMask[playerid] = 1;
			SetPlayerName(playerid, MaskID[playerid]);
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s maskesini yüzüne geçirir.", GetRPName(playerid));
			SendServerMessage(playerid, "Maskenizi taktýnýz.");
		}
		case 1:
		{
			SetPlayerName(playerid, Character[playerid][cName]);
			UseMask[playerid] = 0;
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s maskesini yüzünden çýkarýr.", GetRPName(playerid));
			SendServerMessage(playerid, "Maskenizi çýkarttýnýz.");
		}
	}
	return true;
}

CMD:sopa(playerid, params[])
{
	if(!HaveBat[playerid]) return SendServerMessage(playerid, "Sopanýz bulunmamaktadýr.");
	if(ImEquippedWeapon[playerid]) return SendServerMessage(playerid, "Elinizde silah varken, elinize sopa alamazsýnýz.");

	switch(UseBat[playerid])
	{
		case 0:
		{
			GivePlayerWeapon(playerid, 5, 1);
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s sopasýný eline alýr.", GetRPName(playerid));
			UseBat[playerid] = 1;
		}
		case 1:
		{
			ResetPlayerWeapons(playerid);
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s sopasýný saklar.", GetRPName(playerid));
			UseBat[playerid] = 0;
		}
	}
	return true;
}

CMD:cicek(playerid, params[])
{
	if(!HaveFlower[playerid]) return SendServerMessage(playerid, "Çiçeðiniz bulunmamaktadýr.");
	if(ImEquippedWeapon[playerid]) return SendServerMessage(playerid, "Elinizde silah varken, elinize çiçek alamazsýnýz.");

	switch(UseFlower[playerid])
	{
		case 0:
		{
			GivePlayerWeapon(playerid, 14, 1);
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s eline çiçek alýr.", GetRPName(playerid));
			UseFlower[playerid] = 1;
		}
		case 1:
		{
			ResetPlayerWeapons(playerid);
			SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s çiçeðini saklar.", GetRPName(playerid));
			UseFlower[playerid] = 0;
		}
	}
	return true;
}

CMD:sigara(playerid, params[])
{
	if(!Character[playerid][cCigaratte]) return SendServerMessage(playerid, "Sigaranýz bulunmamaktadýr.");
	if(ImEquippedWeapon[playerid]) return SendServerMessage(playerid, "Elinizde silah varken, elinize sigara alamazsýnýz.");
	if(!Character[playerid][cLighter]) return SendServerMessage(playerid, "Çakmaðýnýz bulunmamaktadýr.");
	if(Smoking[playerid]) return SendServerMessage(playerid, "Zaten sigara içiyorsun.");

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	Character[playerid][cCigaratte]--;
	Smoking[playerid] = 1;
	SendServerMessage(playerid, "Sigara yaktýnýz. N tuþuna basarak sigarayý atabilirsiniz.");
	return true;
}

CMD:toolkit(playerid, params[])
{
	if(!Character[playerid][cToolkit]) return SendServerMessage(playerid, "Alet çantanýz bulunmamaktadýr.");
	if(!GetNearestVehicleToPlayer(playerid, 5.0)) return SendServerMessage(playerid, "Yakýnýnýzda araç yok.");

	new id = GetNearestVehicleToPlayer(playerid, 5.0), Float: fHealth;
	GetVehicleHealth(id, fHealth);

	if(fHealth <= DAMAGED_VEHICLE_HEALTH)
	{
		SetPVarInt(playerid, "FixingCar", id);
		StartChallange(playerid, CHALLANGE_TOOLKIT);
	}

	return true;
}

CMD:maymuncuk(playerid, params[])
{
	if(!Character[playerid][cSkeletonKey]) return SendServerMessage(playerid, "Maymuncuða sahip deðilsiniz.");

	new opt[32];
	if(sscanf(params, "s[32]", opt))
	{
		SendServerMessage(playerid, "/maymuncuk [seçim]");
		SendClientMessage(playerid, C_GREY1, "ev, arac");
		return true;
	}

	if(!strcmp(opt, "ev", true))
	{
		if(!GetPlayerNearbyHouse(playerid)) return SendServerMessage(playerid, "Bir eve yakýn deðilsiniz.");
		new houseid = GetPlayerNearbyHouse(playerid);
		if(!House[houseid][hLocked]) return SendServerMessage(playerid, "Kapýnýn kilidi açýk.");

		SetPVarInt(playerid, "BreakingHouseKey", houseid);

		if(House[houseid][hLevel] > 1) {
			SendFactionMessage(FACTION_POLICE, C_FACTION, "* %s bölgesinde soygun ihbarý bildirildi.", GetLocation(House[houseid][hExtDoor][0], House[houseid][hExtDoor][1], House[houseid][hExtDoor][2]));
		}

		if(House[houseid][hLevel] > 3) {
			new robberyCheckpoint = CreateDynamicCP(House[houseid][hExtDoor][0], House[houseid][hExtDoor][1], House[houseid][hExtDoor][2], 1, 0, 0);

			foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(Character[i][cFaction] == 1)
					{
						SetPVarInt(i, "RobberyCP", robberyCheckpoint);
						TogglePlayerDynamicCP(i, robberyCheckpoint, true);
						SetTimerEx("FinishRobberyCP", 300*1000, false, "i", i);
					}
				}
			}
		}

		StartChallange(playerid, CHALLANGE_HOUSE_KEY);
	}
	else if(!strcmp(opt, "arac", true))
	{
		if(!GetNearestVehicleToPlayer(playerid, 3.0)) return SendServerMessage(playerid, "Araç bulunamadý.");
		new vehid = GetNearestVehicleToPlayer(playerid, 3.0);
		if(!Doors[vehid]) return SendServerMessage(playerid, "Kapýlar kilitli deðil.");

		SetPVarInt(playerid, "BreakingVehicleDoors", vehid);

		new Float:vehPos[3];
		GetVehiclePos(vehid, vehPos[0], vehPos[1], vehPos[2]);

		if(Vehicle[vehid][vFaction] == FACTION_POLICE 
		|| Vehicle[vehid][vFaction] == FACTION_MEDIC ||
			Vehicle[vehid][vFaction] == FACTION_FD)
		{
			new stealer[24];
			format(stealer, 24, "%s", Character[playerid][cName]);
			strreplace(stealer, '_', ' ');
			SendFactionMessage(FACTION_POLICE, C_FACTION, "* Kimliði %s olarak belirlenen kiþi, %s üzerinde bir devlet aracý çaldý.", stealer, GetLocation(vehPos[0], vehPos[1], vehPos[2]));	
		}

		if(Vehicle[vehid][vLockLevel] > 1) {
			SendFactionMessage(FACTION_POLICE, C_FACTION, "* %s bölgesinde hýrsýzlýk ihbarý bildirildi.", GetLocation(vehPos[0], vehPos[1], vehPos[2]));
		}

		if(Vehicle[vehid][vLockLevel] > 3) {
			new robberyCheckpoint2 = CreateDynamicCP(vehPos[0], vehPos[1], vehPos[2], 1, 0, 0);

			foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(Character[i][cFaction] == 1)
					{
						SetPVarInt(i, "RobberyCP2", robberyCheckpoint2);
						TogglePlayerDynamicCP(i, robberyCheckpoint2, true);
						SetTimerEx("FinishRobberyCP2", 300*1000, false, "i", i);
					}
				}
			}
		}

		if(Vehicle[vehid][vAlarmLevel])
		{
			for(new i = 0; i < Vehicle[vehid][vAlarmLevel]; i++)
			{
				PlaySoundEx(3200, vehPos[0], vehPos[1], vehPos[2], 20.0);
			}
		}

		StartChallange(playerid, CHALLANGE_VEH_KEY);
	}
	return true;
}

CMD:ustara(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araçta üst arayamazsýnýz.");

	new target;
	if(sscanf(params, "d", target)) return SendServerMessage(playerid, "/ustara [ID]");
	if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Hatalý ID girdiniz.");
	if(!IsPlayerNearPlayer(playerid, target, 5.0)) return SendServerMessage(playerid, "Oyuncuya yakýn deðilsin.");

    if(GetPlayerAnimationIndex(target))
    {
        new animLib[32], animName[32];
        GetAnimationName(GetPlayerAnimationIndex(playerid), animLib, sizeof animLib, animName, sizeof animName);
		if(strfind(animName, "SHP_HandsUp_Scr", false)) SearchPlayer(target, playerid);
    }
	else if(Cuffed[target])
	{
		SearchPlayer(target, playerid);
	}
	else if(!Cuffed[target])
	{
		SendSearchOffer(target, playerid);
	}
	return true;
}

CMD:kabulet(playerid, params[])
{
	new option[24];

	if(sscanf(params, "s[24]", option))
	{
		SendServerMessage(playerid, "/kabulet [SEÇENEK]");
		return SendClientMessageEx(playerid, C_VINEWOOD, "Seçenekler: ustara");
	}

	if(strfind(option, "ustara", false))
	{
		if(IsSendSearchOffer[playerid])
		{
			if(!IsPlayerNearPlayer(playerid, SearchOfferSender[playerid], 5.0)) return SendServerMessage(playerid, "Kiþiye yakýn deðilsiniz.");
			SearchPlayer(playerid, SearchOfferSender[playerid]);
		}
	}
	return true;
}