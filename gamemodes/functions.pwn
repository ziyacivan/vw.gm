Vinewood:SetServerSettings()
{
    new rcon[80];
    format(rcon, sizeof(rcon), "hostname %s", HOSTNAME);
    SendRconCommand(rcon);
    format(rcon, sizeof(rcon), "language %s", LANGUAGE);
    SendRconCommand(rcon);
    /*format(rcon, sizeof(rcon), "password %s", PASSWORD);
    SendRconCommand(rcon);*/
    format(rcon, sizeof(rcon), "website %s", WEBSITE);
    SendRconCommand(rcon);
    format(rcon, sizeof(rcon), "map %s", MAP);
    SendRconCommand(rcon);

    SetGameModeText(VERSION);

    ManualVehicleEngineAndLights();
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);
    SetNameTagDrawDistance(20.0);
    ShowPlayerMarkers(0);

    ShowNameTags(1);
    AllowInteriorWeapons(1);

    Streamer_TickRate(60);
    Streamer_VisibleItems(STREAMER_TYPE_OBJECT , 999);

    new hour, minute, second;
    gettime(hour, minute, second);
    SetWorldTime(hour);
    return true;
}

Vinewood:SetDatabaseSettings()
{
    mysql_log(ERROR | WARNING);
    switch(CONNECTION_TYPE)
    {
        case 1: conn = mysql_connect(V_HOST, V_USER, V_PASS, V_DB);
        case 2: conn = mysql_connect(L_HOST, L_USER, L_PASS, L_DB);
    }
    mysql_set_charset("latin5", conn);

    if(!conn) return printf("%s", mysql_errno(conn));
    return true;
}

Vinewood:ShutdownServer()
{
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

    mysql_close(conn);
    return true;
}

//---------------
stock GetNickname(playerid)
{
    new name[MAX_PLAYER_NAME];
    format(name, MAX_PLAYER_NAME, "%s", Character[playerid][cNickname]);
    return name;
}

Vinewood:MainTimer()
{
    foreach(new i : Player)
    {
        if(LoggedIn[i])
        {
            if(HasShotTB[i]) 
            {
                TogglePlayerControllable(i, true);
                HasShotTB[i] = 0;
            }

            if(HavingFuel[i])
            {
                FuelSeconds[i]--;
                GiveMoney(i, -1 * Gasoline[ClosestGasStation(i)][gCost]);
                Vehicle[GetPlayerVehicleID(i)][vFuel] = Vehicle[GetPlayerVehicleID(i)][vFuel] + 2;
                if(FuelSeconds[i] <= 0)
                {
                    HavingFuel[i] = 0;
                    TogglePlayerControllable(i, true);
                    SendClientMessage(i, C_VINEWOOD, "Benzin doldurdun.");
                }
            }

            if(Character[i][cIsDead])
            {
                Character[i][cDeathSecondsLeft]--;
                format(DeathSecondsLeft[i], 24, "%d saniye", Character[i][cDeathSecondsLeft]);
                GameTextForPlayer(i, DeathSecondsLeft[i], 1000, 3);
                if(Character[i][cDeathSecondsLeft] == 0) 
                {
                    Character[i][cIsDead] = 0;
                    Character[i][cDeathSecondsLeft] = 0;
                    RevivePlayer(i);
                }
            }
            
            Character[i][cSecond]++;
            if(Character[i][cSecond] >= 60)
            {
                Character[i][cSecond] = 0;
                Character[i][cMinute]++;
                if(Character[i][cMinute] >= 60)
                {
                    Character[i][cMinute] = 0;
                    Character[i][cHour]++;

                    new newlevel = Character[i][cLevel] + 1;
                    new totalhour = newlevel * 4;

                    SendServerMessage(i, "Saatlik maaþ ($350) cüzdanýnýza aktarýldý, seviye atlamanýza kalan süre: (%d/%d)", Character[i][cHour], totalhour);
                    GiveMoney(i, 350);

                    // Mevduat faiz sistemi
                    if(Character[i][cBankSaving] > 0 && Character[i][cBankSaving] < 350000)
                    {
                        new account = Character[i][cBankSaving] * 1005;
                        account = account / 1000;
                        Character[i][cBankSaving] = account;
                        SendClientMessageEx(i, C_GREY1, "{F0F2A5}__________________[%d Numaralý Hesap]__________________", Character[i][cBankAccountNo]);
                        SendClientMessageEx(i, C_GREY1, "Bakiye: $%i", Character[i][cBankCash]);
                        SendClientMessageEx(i, C_GREY1, "Mevduat Oraný: 0.5");
                        SendClientMessageEx(i, C_GREY1, "Mevduat: $%i", Character[i][cBankSaving]);
                    }

                    // Ýþletme maaþ
                    foreach(new j : Business)
                        if(Business[j][bsIsValid])
                            for(new w; w < 10; w++)
                                if(Business[j][bsWorkers][w] == Character[i][cID])
                                    if(!Business[j][bsSafe])
                                        SendClientMessage(i, C_GREY1, "Ek iþ(iþletme) maaþ: $0");
                                    else
                                        Character[i][cBankCash] += Business[j][bsWorkersPayday][w], SendClientMessageEx(i, C_GREY1, "Ek iþ(iþletme) maaþ: $%i", Business[j][bsWorkersPayday][w]);

                    // Oluþum Bonusu
                    if(Character[i][cFaction])
                    {
                        new factid = GetPlayerFactionID(i);
                        SendClientMessageEx(i, C_GREY1, "Oluþum seviye bonusu: $%d", Faction[factid][fLevelBonus]);
                        Character[i][cBankCash] += Faction[factid][fLevelBonus];
                    }

                    // Ev kiralama sistemi
                    if(Character[i][cTenantHouseID] > 0)
                    {
                        if(Character[i][cMoney] > Character[i][cTenantPrice])
                        {
                            GiveMoney(i, -Character[i][cTenantPrice]);
                            SendClientMessageEx(i, C_GREEN, "Ev kira tutarýnýz olan $%d otomatik olarak ödendi.", Character[i][cTenantPrice]);
                        }
                        else
                        {
                            Character[i][cTenantHouseID] = -1;
                            Character[i][cTenantPrice] = 0;
                            new houseid = GetHouseIDbyDBID(Character[i][cTenantHouseID]);
                            House[houseid][hTenant] = -1;
                            RefreshHouse(houseid);
                            SendClientMessage(i, C_GREEN, "Ev kiranýzý ödeyemediðiniz için kontranýtýz iptal edildi.");
                        }
                    }

                    // Saatlik bonus
                    if(Character[i][cHour] >= totalhour)
                    {
                        Character[i][cHour] = 0;
                        Character[i][cLevel]++;
                        SetPlayerScore(i, Character[i][cLevel]);
                        SendServerMessage(i, "Seviye atladýnýz, +$500 seviye bonusu kazandýnýz.");
                        GiveMoney(i, 500);
                    }
                }
            }
            // benzin sistemi
            if(IsPlayerInAnyVehicle(i))
            {
                new vehid = GetPlayerVehicleID(i);
                new driverid = GetVehicleDriverID(vehid);
                if(driverid == i)
                {
                    if(Engine[vehid])
                    {
                        FuelMeter[vehid]++;
                        if(FuelMeter[vehid] >= 30) // 180s
                        {
                            FuelMeter[vehid] = 0;
                            Vehicle[vehid][vFuel]--;
                            Vehicle[vehid][vKM]++;
                            if(Vehicle[vehid][vFuel] == 0)
                            {
                                SwitchVehicleEngine(vehid, false), Engine[vehid] = false;
                                GameTextForPlayer(i, "~w~YAKIT ~r~BITTI", 3000, 4);
                                Vehicle[vehid][vFuel] = 0;
                                RefreshVehicle(vehid);
                            }
                        } 
                    }
                }
            }
        }
    }
    return true;
}

Vinewood:ShowStats(playerid, targetid)
{
    new created[12], sex[12], skincolor[12];
    switch(Character[playerid][cCreated])
    {
        case 0: created = "Hayýr";
        case 1: created = "Evet";
    }
    switch(Character[playerid][cSex])
    {
        case 0: sex = "Yok";
        case 1: sex = "Erkek";
        case 2: sex = "Kadýn";
    }
    switch(Character[playerid][cSkinColor])
    {
        case 0: skincolor = "Yok";
        case 1: skincolor = "Beyaz";
        case 2: skincolor = "Siyahi";
    }

    SendClientMessageEx(targetid, C_GREY1, "--------------- [SQLID: %d] %s ---------------", Character[playerid][cID], GetRPName(playerid));
    SendClientMessageEx(targetid, C_GREY1, "Nickname: [%s] | Yönetici: [%d] | Oluþturuldu: [%s]", Character[playerid][cNickname], Character[playerid][cAdmin], created);
    SendClientMessageEx(targetid, C_GREY1, "Cüzdan: [$%d] | Hesap NO: [%d] | Hesap Bakiye: [$%d] | Mevduat: [$%d] | Seviye: [%d] | Saat: [%d] | Dakika: [%d]", Character[playerid][cMoney], Character[playerid][cBankAccountNo], Character[playerid][cBankCash], Character[playerid][cBankSaving], Character[playerid][cLevel], Character[playerid][cHour], Character[playerid][cMinute]);
    SendClientMessageEx(targetid, C_GREY1, "Vatandaþlýk Numarasý: [%d] | Yaþ: [%d] | Cinsiyet: [%s] | Ten Rengi: [%s] | Köken: [%s]", Character[playerid][cIdentity], Character[playerid][cAge], sex, skincolor, Countries[Character[playerid][cOrigin]]);
    SendClientMessageEx(targetid, C_GREY1, "Skin: [%d] | Interior: [%d] | World: [%d]", Character[playerid][cSkin], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
    return true;
}

/*IsNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}
ReturnUser(const text[])
{
        new pos = 0;
        while (text[pos] < 0x21)
        {
            if (text[pos] == 0) return INVALID_PLAYER_ID;
            pos++;
        }
        new userid = INVALID_PLAYER_ID;
        if (IsNumeric(text[pos]))
        {
            userid = strval(text[pos]);
            if (userid >=0 && userid < MAX_PLAYERS)
            {
                if(!IsPlayerConnected(userid))
                {
                    userid = INVALID_PLAYER_ID;
                }
                else
                {
                    return userid;
                }
            }
        }
        new len = strlen(text[pos]);
        new count = 0;
        new name[MAX_PLAYER_NAME];
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i))
            {
                GetPlayerName(i, name, sizeof (name));
                if (strcmp(name, text[pos], true, len) == 0)
                {
                if (len == strlen(name))
                    {
                        return i;
                    }
                    else
                    {
                        count++;
                        userid = i;
                    }
                }
            }
        }
        if (count != 1)
        {
            userid = INVALID_PLAYER_ID;
        }
        return userid;
}*/

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

Vinewood:GiveMoney(playerid, amount)
{
    Character[playerid][cMoney] += amount;
    GivePlayerMoney(playerid, amount);
    return true;
}

randomEx(min, max)
return random(max-min)+min;

KickEx(playerid)
{
    SetTimerEx("KickTimer", 100, false, "d", playerid);
    return true;
}

Vinewood:KickTimer(playerid)
{
      Kick(playerid);
}

BanServer(playerid)
{
    Character[playerid][cBan] = 1;
    SaveCharacterData(playerid);
    SetTimerEx("BanTimer", 100, false, "d", playerid);
    return true;
}

Vinewood:BanTimer(playerid)
{
    Ban(playerid);
}

stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

stock GetRPName(playerid)
{
    new name[24];
    switch(UseMask[playerid])
    {
        case 1:
        {
            format(name, 24, "%s", MaskID[playerid]);
        }
        case 0:
        {
            format(name, 24, "%s", GetName(playerid));
            strreplace(name, '_', ' ');
        }
    }
    return name;
}

stock GetNameFromSQLID(i)
{
	new name[32], query[64], Cache:data;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM characters WHERE id = %d", i);
	data = mysql_query(conn, query, true);
	cache_get_value_name(0, "Character_Name", name, 32);
	cache_delete(data);
	return name;
}

strreplace(string[], find, replace)
{
    for(new i=0; string[i]; i++)
    {
        if(string[i] == find)
        {
            string[i] = replace;
        }
    }
}

stock strmatch(const String1[], const String2[])
{
    if ((strcmp(String1, String2, true, strlen(String2)) == 0) && (strlen(String2) == strlen(String1)))
    {
        return true;
    }
    else
    {
        return false;
    }
}

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if (args > 16)
    {
            #emit ADDR.pri str
            #emit STOR.pri start

            for (end = start + (args - 16); end > start; end -= 4)
            {
                #emit LREF.pri end
                #emit PUSH.pri
            }
            #emit PUSH.S str
            #emit PUSH.C 144
            #emit PUSH.C string

            #emit LOAD.S.pri 8
            #emit CONST.alt 4
            #emit SUB
            #emit PUSH.pri

            #emit SYSREQ.C format
            #emit LCTRL 5
            #emit SCTRL 4

          foreach (new i : Player)
            {
                    if (IsPlayerNearPlayer(i, playerid, radius)) {
                        SendClientMessage(i, color, string);
                    }
            }
          return 1;
    }
    foreach (new i : Player)
    {
            if (IsPlayerNearPlayer(i, playerid, radius)) {
                SendClientMessage(i, color, str);
            }
    }
    return 1;
}

stock SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
    static
        args,
        str[144];

    /*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
    */
    if ((args = numargs()) == 3)
    {
        SendClientMessage(playerid, color, text);
    }
    else
    {
        while (--args >= 3)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit PUSH.S 8
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessage(playerid, color, str);

        #emit RETN
    }
    return 1;
}

stock SendAdminMessage(color, const str[], {Float,_}:...)
{
  static
      args,
      start,
      end,
      string[144]
  ;
  #emit LOAD.S.pri 8
  #emit STOR.pri args

  if (args > 8)
  {
    #emit ADDR.pri str
    #emit STOR.pri start

      for (end = start + (args - 8); end > start; end -= 4)
    {
          #emit LREF.pri end
          #emit PUSH.pri
    }
    #emit PUSH.S str
    #emit PUSH.C 144
    #emit PUSH.C string

    #emit LOAD.S.pri 8
    #emit ADD.C 4
    #emit PUSH.pri

    #emit SYSREQ.C format
    #emit LCTRL 5
    #emit SCTRL 4

    foreach (new i : Player)
    {
        if (Character[i][cAdmin] > 1) {
            SendClientMessage(i, color, string);
        }
    }
    return 1;
  }
  foreach (new i : Player)
  {
    if (Character[i][cAdmin] > 1) {
        SendClientMessage(i, color, str);
    }
  }
  return 1;
}

stock SendTesterMessage(color, const str[], {Float,_}:...)
{
  static
      args,
      start,
      end,
      string[144]
  ;
  #emit LOAD.S.pri 8
  #emit STOR.pri args

  if (args > 8)
  {
    #emit ADDR.pri str
    #emit STOR.pri start

      for (end = start + (args - 8); end > start; end -= 4)
    {
          #emit LREF.pri end
          #emit PUSH.pri
    }
    #emit PUSH.S str
    #emit PUSH.C 144
    #emit PUSH.C string

    #emit LOAD.S.pri 8
    #emit ADD.C 4
    #emit PUSH.pri

    #emit SYSREQ.C format
    #emit LCTRL 5
    #emit SCTRL 4

    foreach (new i : Player)
    {
        if (Character[i][cAdmin] == 1) {
            SendClientMessage(i, color, string);
        }
    }
    return 1;
  }
  foreach (new i : Player)
  {
    if (Character[i][cAdmin] == 1) {
        SendClientMessage(i, color, str);
    }
  }
  return 1;
}

stock SendAllMessage(color, const text[], {Float, _}:...)
{
  static args, str[144];

  if((args = numargs()) == 2)
  {
      SendClientMessageToAll(color, text);
  }
  else
  {
    while (--args >= 2)
    {
      #emit LCTRL 5
      #emit LOAD.alt args
      #emit SHL.C.alt 2
      #emit ADD.C 12
      #emit ADD
      #emit LOAD.I
      #emit PUSH.pri
    }
    #emit PUSH.S text
    #emit PUSH.C 144
    #emit PUSH.C str
    #emit LOAD.S.pri 8
    #emit ADD.C 4
    #emit PUSH.pri
    #emit SYSREQ.C format
    #emit LCTRL 5
    #emit SCTRL 4

    SendClientMessageToAll(color, str);
    #emit RETN
  }
  return true;
}

stock SendFactionMessage(factionid, color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if (args > 12)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 12); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string
        #emit PUSH.C args

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player) if (Character[i][cFaction] == Faction[factionid][fID]) {
            SendClientMessage(i, color, string);
        }
        return 1;
    }
    foreach (new i : Player) if (Character[i][cFaction] == Faction[factionid][fID]) {
        SendClientMessage(i, color, str);
    }
    return 1;
}

stock SendFactionMessageEx(type, color, const str[], {Float,_}:...)
{
    static
        args,
        start,
        end,
        string[144]
    ;
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if (args > 12)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 12); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string
        #emit PUSH.C args

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player) if (GetFactionType(i) == type) {
            SendClientMessage(i, color, string);
        }
        return 1;
    }
    foreach (new i : Player) if (GetFactionType(i) == type) {
        SendClientMessage(i, color, str);
    }
    return 1;
}

stock PlaySoundEx(soundid, Float:x, Float:y, Float:z, Float:range)
{
    foreach(new i : Player)
    {
        if(!IsPlayerConnected(i)) continue;
        if(!IsPlayerInRangeOfPoint(i, range, x, y, z)) continue;
        PlayerPlaySound(i, soundid, 0, 0, 0);
    }
    return true;
}

stock GetLocation(Float:fX, Float:fY, Float:fZ)
{
    new
        name[32] = "San Andreas";

    for (new i = 0; i != sizeof(g_arrZoneData); i ++) if ((fX >= g_arrZoneData[i][e_ZoneArea][0] && fX <= g_arrZoneData[i][e_ZoneArea][3]) && (fY >= g_arrZoneData[i][e_ZoneArea][1] && fY <= g_arrZoneData[i][e_ZoneArea][4]) && (fZ >= g_arrZoneData[i][e_ZoneArea][2] && fZ <= g_arrZoneData[i][e_ZoneArea][5])) {
        strunpack(name, g_arrZoneData[i][e_ZoneName]);

        break;
    }
    return name;
}

stock CreateStrip(playerid, Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
    {
        if(SpikeInfo[i][sCreated] == 0)
        {
            SpikeInfo[i][sOwner] = playerid;
            SpikeInfo[i][sCreated]=1;
            SpikeInfo[i][sXX]=x;
            SpikeInfo[i][sYY]=y;
            SpikeInfo[i][sZZ]=z-0.7;
            SpikeInfo[i][sObject] = CreateDynamicObject(2892, x, y, z-0.95, 0, 0, Angle-90);
            return 1;
        }
    }
    return 0;
}

stock DeleteAllStrip()
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
    {
        if(SpikeInfo[i][sCreated] == 1)
        {
            SpikeInfo[i][sCreated]=0;
            SpikeInfo[i][sXX]=0.0;
            SpikeInfo[i][sYY]=0.0;
            SpikeInfo[i][sZZ]=0.0;
            DestroyDynamicObject(SpikeInfo[i][sObject]);
        }
    }
    return 0;
}
stock DeleteStrip(playerid)
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
    {
        if(SpikeInfo[i][sCreated] == 1)
        {
            if(SpikeInfo[i][sOwner] == playerid)
            {
            SpikeInfo[i][sCreated]=0;
            SpikeInfo[i][sXX]=0.0;
            SpikeInfo[i][sYY]=0.0;
            SpikeInfo[i][sZZ]=0.0;
            DestroyDynamicObject(SpikeInfo[i][sObject]);
            }
        }
    }
    return 0;
}
stock DeleteClosestStrip(playerid)
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
    {
            if(SpikeInfo[i][sCreated] == 1)
            {
                SpikeInfo[i][sCreated]=0;
                SpikeInfo[i][sXX]=0.0;
                SpikeInfo[i][sYY]=0.0;
                SpikeInfo[i][sZZ]=0.0;
                DestroyDynamicObject(SpikeInfo[i][sObject]);
                return 1;
            }
    }
    return 0;
}

stock GivePlayerHealth(playerid, Float:health)
{
    new Float:health1;
    GetPlayerHealth(playerid,health1);
    SetPlayerHealth(playerid, health1+health);
    return 1;
}

stock GivePlayerArmour(playerid,armour)
{
    new Float:armour1;
    GetPlayerArmour(playerid,armour1);
    SetPlayerArmour(playerid, armour1+armour);
    return 1;
}

Vinewood:GetPlayerIDFromSQLID(sqlid)
{
    new id;
    foreach(new i : Player)
    {
        if(IsPlayerConnected(i) && LoggedIn[i])
            if(Character[i][cID] == sqlid)
                id = i;
    }
    return id;
}

Vinewood:FinishRobberyCP(playerid)
{
    new cpid = GetPVarInt(playerid, "RobberyCP");
    TogglePlayerDynamicCP(playerid, cpid, false);
    DestroyDynamicCP(cpid);
    return true;
}

Vinewood:FinishRobberyCP2(playerid)
{
    new cpid = GetPVarInt(playerid, "RobberyCP2");
    TogglePlayerDynamicCP(playerid, cpid, false);
    DestroyDynamicCP(cpid);
    return true;
}

Vinewood:SearchPlayer(targetid, playerid)
{
    new weaponName[24];

    SendClientMessageEx(playerid, C_DGREEN, "[%s'in üstünden çýkanlar:]\n___________________", GetRPName(targetid));

    /*foreach(new i : Phones) if(Phone[i][phIsValid]) {
        if(Phone[i][phOwner] == Character[targetid][cID]) {
            SendClientMessageEx(playerid, C_VINEWOOD, "Telefon: [%d] - Numara: [%d]", i, Phone[i][phNumber]);
        }
    }*/

    foreach(new i : Weapons) if(Weapon[i][wIsValid]) {
        if(Weapon[i][wOwner] == Character[targetid][cID]) {
            GetWeaponName(Weapon[i][wWeaponID], weaponName, 24);
            SendClientMessageEx(playerid, C_VINEWOOD, "Silah: [%d] - Model: [%s] - Mermi[%d]", i, weaponName, Weapon[i][wAmmo]);
        }
    }

    if(Character[targetid][cCigaratte] > 0) SendClientMessageEx(playerid, C_VINEWOOD, "Sigara: %d tane", Character[targetid][cCigaratte]);
    SendClientMessageEx(playerid, C_VINEWOOD, "Para: $%d", Character[targetid][cMoney]);
    if(Character[targetid][cToolkit]) SendClientMessageEx(playerid, C_VINEWOOD, "Alet Çantasý: 1 tane");
    if(Character[targetid][cSkeletonKey]) SendClientMessageEx(playerid, C_VINEWOOD, "Mamyuncuk: 1 tane");

    IsSendSearchOffer[targetid] = 0;
    SearchOfferSender[targetid] = 0;
    return true;
}

Vinewood:SendSearchOffer(targetid, playerid)
{
    IsSendSearchOffer[targetid] = 1;
    SearchOfferSender[targetid] = playerid;
    SendClientMessageEx(targetid, C_VINEWOOD, "%s tarafýndan üst arama isteði gönderildi. Kabul etmek için /kabulet ustara", GetRPName(playerid));
    return true;
}