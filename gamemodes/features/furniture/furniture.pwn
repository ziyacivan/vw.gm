CMD:mobilya(playerid, params[])
{
    if(!InHouse[playerid]) return SendServerMessage(playerid, "Bir evde deðilsin.");
    
    new choice[24];
    if(sscanf(params, "s[24]", choice)) return SendServerMessage(playerid, "/mobilya [SEÇENEK] (liste, duzenle, sil)");
    
    if(!strcmp(params, "liste", true))
    {
        if(House[PlayerHouse[playerid]][hOwner] == Character[playerid][cID] 
        || House[PlayerHouse[playerid]][hKeyOwner] == Character[playerid][cID]
        ) ShowFurnitureMenu(playerid, PlayerHouse[playerid]);
    }
    else if(!strcmp(params, "duzenle", true))
    {
        if(!GetNearestFurniture(playerid)) return SendServerMessage(playerid, "Herhangi bir mobilyaya yakýn deðilsin.");

        if(House[PlayerHouse[playerid]][hOwner] == Character[playerid][cID] 
        || House[PlayerHouse[playerid]][hKeyOwner] == Character[playerid][cID]
        )
        {
            IsEditingFurniture[playerid] = 1;
            SelectObject(playerid);
        }
    }
    else if(!strcmp(params, "sil", true))
    {
        if(!GetNearestFurniture(playerid)) return SendServerMessage(playerid, "Herhangi bir mobilyaya yakýn deðilsin.");

        if(House[PlayerHouse[playerid]][hOwner] == Character[playerid][cID] 
        || House[PlayerHouse[playerid]][hKeyOwner] == Character[playerid][cID]
        )
        {
            IsDeletingFurniture[playerid] = 1;
            SelectObject(playerid);
        }
    }
    return true;
}

CMD:amobilya(playerid, params[])
{
    if(Character[playerid][cAdmin] < VWLEADADMIN) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamakta.");

    new choice[24];

    if(sscanf(params, "s[24]", choice))
    {
        SendServerMessage(playerid, "/amobilya [SEÇENEK]");
        return SendServerMessage(playerid, "SEÇENEKLER: kategoriekle, kategoriduzenle, objeekle, objesil");
    }

    if(!strcmp(params, "kategoriekle", true))
    {
        Dialog_Show(playerid, ADD_F_CATEGORY, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Mobilya Kategorisi Ekle", "Lütfen oluþturmak istediðiniz kategorinin ismini girin:", "Oluþtur", "Kapat");
    }

    if(!strcmp(params, "kategoriduzenle", true))
    {
        new dialogStr[512];
        foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid])
            format(dialogStr, sizeof(dialogStr), "%s%s\n", dialogStr, FurnitureCategory[i][cName]);
        Dialog_Show(playerid, EDIT_F_CATEGORY, DIALOG_STYLE_LIST, "Vinewood - Mobilya Kategorisi Düzenle", dialogStr, "Düzenle", "Kapat");
    }

    if(!strcmp(params, "objeekle", true))
    {
        new dialogStr[512];
        foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid])
            format(dialogStr, sizeof(dialogStr), "%s%s\n", dialogStr, FurnitureCategory[i][cName]);
        Dialog_Show(playerid, ADD_F_OBJECT, DIALOG_STYLE_LIST, "Vinewood - Mobilya Objesi Ekle", dialogStr, "Devam Et", "Kapat");
    }

    if(!strcmp(params, "objesil", true))
    {
        new dialogStr[512];
        foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid])
            format(dialogStr, sizeof(dialogStr), "%s%s\n", dialogStr, FurnitureCategory[i][cName]);
        Dialog_Show(playerid, DEL_F_OBJECT, DIALOG_STYLE_LIST, "Vinewood - Mobilya Objesi Sil", dialogStr, "Devam Et", "Kapat");
    }
    return true;
}

Vinewood:ShowFurnitureMenu(playerid, house)
{
    new dialogStr[128];
    foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid]) {
        format(dialogStr, sizeof(dialogStr), "%s%s\n", dialogStr, FurnitureCategory[i][cName]);
    }
    Dialog_Show(playerid, SHOW_FURNITURE_1, DIALOG_STYLE_LIST, "Vinewood - Mobilya Kategorileri", dialogStr, "Ýncele", "Kapat");
    return true;
}

Vinewood:CreateNewFurniture(playerid, houseid, objid)
{
    new id = Iter_Free(Furnitures), Float:pPOS[3], query[256], Cache:cache, rand;

    GetPlayerPos(playerid, pPOS[0], pPOS[1], pPOS[2]);

    Furniture[id][fIsValid] = true;

    Furniture[id][fHouse] = House[houseid][hID];
    Furniture[id][fType] = GetPVarInt(playerid, "furniture_type");
    Furniture[id][fObjModel] = objid;
    Furniture[id][fIsHidden] = 0;
    Furniture[id][fInterior] = GetPlayerInterior(playerid);
    Furniture[id][fVirtualWorld] = GetPlayerVirtualWorld(playerid);

    Furniture[id][fPOS][0] = pPOS[0];
    Furniture[id][fPOS][1] = pPOS[1];
    Furniture[id][fPOS][2] = pPOS[2];

    Furniture[id][fROT][0] = 0;
    Furniture[id][fROT][1] = 0;
    Furniture[id][fROT][2] = 0;

    IsCreatingFurniture[playerid] = 1;
    CreatingFurniture[playerid] = id;

    Furniture[id][fObject] = CreateDynamicObject(Furniture[id][fObjModel], pPOS[0], pPOS[1], pPOS[2], 0, 0, 0, Furniture[id][fVirtualWorld], Furniture[id][fInterior]);

    EditDynamicObject(playerid, Furniture[id][fObject]);

    mysql_format(conn, query, sizeof(query), "INSERT INTO furnitures(house, type, objModel, interior, virtualworld, pX, pY, pZ) VALUES(%d, %d, %d, %d, %d, %.4f, %.4f, %.4f)",
        House[houseid][hID],
        GetPVarInt(playerid, "furniture_type"),
        objid,
        GetPlayerInterior(playerid),
        GetPlayerVirtualWorld(playerid),
        pPOS[0],
        pPOS[1],
        pPOS[2]
    );
    cache = mysql_query(conn, query, true);

    Furniture[id][fID] = cache_insert_id();

    rand = randomEx(100, 200);
    GiveMoney(playerid, -1 * rand);

    Iter_Add(Furnitures, id);
    cache_delete(cache);
    DeletePVar(playerid, "furniture_type");
    return true;
}

Vinewood:DestroyFurniture(playerid, id)
{
    new query[128];

    Furniture[id][fIsValid] = false;

    mysql_format(conn, query, sizeof(query), "DELETE FROM furnitures WHRE id = %d", Furniture[id][fID]);
    mysql_query(conn, query, false);
    
    DestroyDynamicObject(Furniture[id][fObject]);

    Iter_Remove(Furnitures, id);
    return true;
}

Vinewood:LoadFurnitures()
{
    if(!cache_num_rows()) return printf("VinewoodDB >> Hiç mobilya yüklenmedi.");

    Iter_Add(Furnitures, 0);

    for(new i; i < cache_num_rows(); i++)
    {
        Furniture[i+1][fIsValid] = true;

        cache_get_value_name_int(i, "id", Furniture[i+1][fID]);
        cache_get_value_name_int(i, "house", Furniture[i+1][fHouse]);
        cache_get_value_name_int(i, "objModel", Furniture[i+1][fObjModel]);
        cache_get_value_name_int(i, "interior", Furniture[i+1][fInterior]);
        cache_get_value_name_int(i, "virtualworld", Furniture[i+1][fVirtualWorld]);
        cache_get_value_name_int(i, "type", Furniture[i+1][fType]);
    
        cache_get_value_name_float(i, "pX", Furniture[i+1][fPOS][0]);
        cache_get_value_name_float(i, "pY", Furniture[i+1][fPOS][1]);
        cache_get_value_name_float(i, "pZ", Furniture[i+1][fPOS][1]);

        cache_get_value_name_float(i, "rX", Furniture[i+1][fROT][0]);
        cache_get_value_name_float(i, "rY", Furniture[i+1][fROT][1]);
        cache_get_value_name_float(i, "rZ", Furniture[i+1][fROT][2]);

        Furniture[i+1][fObject] = CreateDynamicObject(Furniture[i+1][fObjModel], Furniture[i+1][fPOS][0], Furniture[i+1][fPOS][1], Furniture[i+1][fPOS][2], Furniture[i+1][fROT][0], Furniture[i+1][fROT][1], Furniture[i+1][fROT][2], Furniture[i+1][fVirtualWorld], Furniture[i+1][fInterior]);

        Iter_Add(Furnitures, i+1);
    }
    printf("VinewoodDB >> %d adet mobilya yüklendi.", cache_num_rows());
    return true;
}

Vinewood:LoadFurnitureCategories(playerid)
{
    if(!cache_num_rows()) return printf("VinewoodDB >> Hiç mobilya kategorisi yüklenemedi.");

    Iter_Add(FurnitureCategories, 0);

    for(new i; i < cache_num_rows(); i++)
    {
        FurnitureCategory[i+1][cIsValid] = true;

        cache_get_value_name_int(i, "id", FurnitureCategory[i+1][cID]);
        cache_get_value_name(i, "name", FurnitureCategory[i+1][cName], 64);
        FurnitureCategory[1+1][cType] = FurnitureCategory[i+1][cID] - 1;

        Iter_Add(FurnitureCategories, i+1);
    }
    printf("VinewoodDB >> %d adet mobilya kategorisi yüklendi.", cache_num_rows());
    return true;
}

Vinewood:LoadFurnitureItems()
{
    if(!cache_num_rows()) return true;

    Iter_Add(FurnitureItems, 0);

    for(new i; i < cache_num_rows(); i++)
    {
        FurnitureItem[i+1][iIsValid] = true;
        
        cache_get_value_name_int(i, "id", FurnitureItem[i+1][iID]);
        cache_get_value_name_int(i, "modelID", FurnitureItem[i+1][iModel]);
        cache_get_value_name_int(i, "furnitureType", FurnitureItem[i+1][iType]);

        Iter_Add(FurnitureItems, i+1);
    }

    return true;
}

Vinewood:RefreshFurniture(i)
{
    new query[512];

    GetDynamicObjectPos(Furniture[i][fObject], Furniture[i][fPOS][0], Furniture[i][fPOS][1], Furniture[i][fPOS][2]);
    GetDynamicObjectRot(Furniture[i][fObject], Furniture[i][fROT][0], Furniture[i][fROT][1], Furniture[i][fROT][2]);

    mysql_format(conn, query, sizeof(query), "UPDATE furnitures SET house = %d, type = %d, objModel = %d, interior = %d, virtualworld = %d, pX = %.4f, pY = %.4f, pZ = %.4f, rX = %.4f, rY = %.4f, rZ = %.4f WHERE id = %d",
        Furniture[i][fHouse],
        Furniture[i][fType],
        Furniture[i][fObjModel],
        Furniture[i][fInterior],
        Furniture[i][fVirtualWorld],
        Furniture[i][fPOS][0],
        Furniture[i][fPOS][1],
        Furniture[i][fPOS][2],
        Furniture[i][fROT][0],
        Furniture[i][fROT][1],
        Furniture[i][fROT][2],
        Furniture[i][fID]
    );
    mysql_query(conn, query, false);
    return true;
}

Vinewood:CreateHouseFurnitures(house)
{
    foreach(new i : Furnitures) if(Furniture[i][fIsValid]) {
        if(Furniture[i][fHouse] == House[house][hID]) {
            Furniture[i][fIsHidden] = 0;
            Furniture[i][fObject] = CreateDynamicObject(Furniture[i][fObjModel], Furniture[i][fPOS][0], Furniture[i][fPOS][1], Furniture[i][fPOS][2], Furniture[i][fROT][0], Furniture[i][fROT][1], Furniture[i][fROT][2], Furniture[i][fVirtualWorld], Furniture[i][fInterior]);
        }
    }
    return true;
}

Vinewood:HideHouseFurnitures(house)
{
    foreach(new i : Furnitures) if(Furniture[i][fIsValid]) {
        if(Furniture[i][fHouse] == House[house][hID]) {
            Furniture[i][fIsHidden] = 1;
            DestroyDynamicObject(Furniture[i][fObject]);
        }
    }
    return true;
}

Vinewood:RefreshFurnitureCategory(i)
{
    new query[128];
    mysql_format(conn, query, sizeof(query), "UPDATE furnitures SET name = '%e' WHERE id = %d",
        FurnitureCategory[i][cName],
        FurnitureCategory[i][cID]
    );
    mysql_query(conn, query, false);
    return true;
}

Vinewood:RefreshFurnitureItem(i)
{
    new query[512];
    mysql_format(conn, query, sizeof(query), "UPDATE furnitures SET furnitureType = %d, modelID = %d WHERE id = %d",
        FurnitureItem[i][iType],
        FurnitureItem[i][iModel],
        FurnitureItem[i][iID]
    );
    mysql_query(conn, query, false);
    return true;
}

Vinewood:GetNearestFurniture(playerid)
{
    new id = 0;
    foreach(new i : Furnitures) if(Furniture[i][fIsValid] && !Furniture[i][fIsHidden]) {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, Furniture[i][fPOS][0], Furniture[i][fPOS][1], Furniture[i][fPOS][2])) {
            id = i;
            break;
        }
    }
    return id;
}