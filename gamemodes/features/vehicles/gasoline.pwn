CMD:benzinlikyarat(playerid, params[])
{
    if(Character[playerid][cAdmin] < VWDEVELOPER) return SendServerMessage(playerid, "Yetkiniz yok.");

    new price, name[24];
    if(sscanf(params, "ds[24]", price, name)) return SendServerMessage(playerid, "/benzinlikyarat [FIYAT] [ISIM]");
    CreateGasoline(playerid, name, price);
    SendAdminMessage(C_ADMIN, "AdmWarn: %s, %s isimli benzinliði yarattý.", GetNickname(playerid), name);
    return true;
}

CMD:benzinliksil(playerid, params[])
{
    if(Character[playerid][cAdmin] < VWDEVELOPER) return SendServerMessage(playerid, "Yetkiniz yok.");

    new id;
    if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/benzinliksil [ID]");
    SendAdminMessage(C_ADMIN, "AdmWarn: %s, %d ID'li benzinliði sildi.", GetNickname(playerid), id);
    DestroyGasoline(id);
    return true;
}

CMD:benzin(playerid, params[])
{
    if(!ClosestGasStation(playerid)) return SendServerMessage(playerid, "Herhangi bir benzinliðe yakýn deðilsin.");
    if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araçta deðilsin.");
    if(Vehicle[GetPlayerVehicleID(playerid)][vFuel] >= 99) SendServerMessage(playerid, "Bu aracýn benzini zaten dolu.");
    
    TogglePlayerControllable(playerid, false);
    HavingFuel[playerid] = 1;
    FuelSeconds[playerid] = (100 - Vehicle[GetPlayerVehicleID(playerid)][vFuel]) / 2;
    return true;
}

CMD:benzindurdur(playerid, params[])
{
    if(!HavingFuel[playerid]) return SendServerMessage(playerid, "Benzin doldurmuyorsun.");

    TogglePlayerControllable(playerid, true);
    HavingFuel[playerid] = 0;
    FuelSeconds[playerid] = 0;   
    return true;
}

Vinewood:LoadGasolines()
{
    if(!cache_num_rows()) return printf("VinewoodDB >> Yüklenecek benzinlik bulunamadý.");

    Iter_Add(Gasolines, 0);

    for(new i; i < cache_num_rows(); i++)
    {
        Gasoline[i+1][gIsValid] = true;

        cache_get_value_name_int(i, "id", Gasoline[i+1][gID]);
        cache_get_value_name_int(i, "cost", Gasoline[i+1][gCost]);
        cache_get_value_name(i, "name", Gasoline[i+1][gStationName], 24);
        cache_get_value_name_float(i, "x", Gasoline[i+1][gPos][0]);
        cache_get_value_name_float(i, "y", Gasoline[i+1][gPos][1]);
        cache_get_value_name_float(i, "z", Gasoline[i+1][gPos][2]);

        Gasoline[i+1][gPickup] = CreateDynamicPickup(GASOLINE_MODEL, 1, Gasoline[i+1][gPos][0], Gasoline[i+1][gPos][1], Gasoline[i+1][gPos][2]);
        
        Iter_Add(Gasolines, i+1);
    }
    printf("VinewoodDB >> %d adet benzinlik yüklendi.", cache_num_rows());
    return true;
}

Vinewood:CreateGasoline(playerid, const stationName[], cost)
{
    new id = Iter_Free(Gasolines), query[256], Cache:data;
    
    GetPlayerPos(playerid, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2]);
    
    Gasoline[id][gIsValid] = true;
    for(new i; i < 3; i++) Gasoline[id][gPos][i] = Character[playerid][cPos][i];
    Gasoline[id][gCost] = cost;
    Gasoline[id][gPickup] = CreateDynamicPickup(GASOLINE_MODEL, 1, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2]);
    format(Gasoline[id][gStationName], 24, "%s", stationName);

    mysql_format(conn, query, sizeof(query), "INSERT INTO gasolines(cost, name, x, y, z) VALUES(%d, '%e', %.4f, %.4f, %.4f)",
        cost,
        stationName,
        Gasoline[id][gPos][0], Gasoline[id][gPos][1], Gasoline[id][gPos][2]
    );
    data = mysql_query(conn, query, true);
    
    Gasoline[id][gID] = cache_insert_id();

    Iter_Add(Gasolines, id);
    cache_delete(data);
    return true;
}

Vinewood:DestroyGasoline(id)
{
    Gasoline[id][gIsValid] = false;
    for(new i; i < 3; i++) Gasoline[id][gPos][i] = 0.0;
    Gasoline[id][gCost] = -1;
    DestroyDynamicPickup(Gasoline[id][gPickup]);

    new query[64];

    mysql_format(conn, query, sizeof(query), "DELETE FROM gasolines WHERE id = %d", Gasoline[id][gID]);
    mysql_query(conn, query, false);

    Iter_Remove(Gasolines, id);
    return true;
}

Vinewood:ClosestGasStation(playerid)
{
    new id = 0;
    foreach(new i : Gasolines) if(Gasoline[i][gIsValid])
    {
        if(IsPlayerInRangeOfPoint(playerid, GASOLINE_DISTANCE, Gasoline[i][gPos][0], Gasoline[i][gPos][1], Gasoline[i][gPos][2]))
        {
            id = i;
            break;
        }
    }
    return id;
}