Dialog:SHOW_FURNITURE_1(playerid, response, listitem, const inputtext[])
{
    if(!response) return true;

    new dialogStr[256];

    foreach(new i : FurnitureItems) if(FurnitureItem[i][iIsValid]) {
        if(FurnitureItem[i][iType] == listitem) {
            format(dialogStr, sizeof(dialogStr), "%s%d\tModel: %d\n", dialogStr, FurnitureItem[i][iModel], FurnitureItem[i][iModel]);	
        }
    }
    SetPVarInt(playerid, "furniture_type", listitem);
    ShowPlayerDialog(playerid, S_DIALOG_FURNITURE, DIALOG_STYLE_PREVIEW_MODEL, "Vinewood Roleplay - Mobilya Sistemi", dialogStr, "Yerleştir", "Kapat");
    return true;
}

Dialog:ADD_F_CATEGORY(playerid, response, listitem, const inputtext[])
{
    if(!response) return true;
    if(strlen(inputtext) > 24 || strlen(inputtext) < 1) return SendServerMessage(playerid, "Hatalı karakter sayısı. (0-24)");

    new query[128], Cache:data, id = Iter_Free(FurnitureCategories);

    mysql_format(conn, query, sizeof(query), "INSERT INTO furniture_categories(name) VALUES('%e')", inputtext);
    data = mysql_query(conn, query, true);

    FurnitureCategory[id][cID] = cache_insert_id();
    FurnitureCategory[id][cIsValid] = true;
    FurnitureCategory[id][cType] = cache_insert_id() - 1;
    format(FurnitureCategory[id][cName], 64, "%s", inputtext);

    SendClientMessageEx(playerid, C_VINEWOOD, "%d ID'li mobilya kategorisini oluşturdun.", cache_insert_id());

    Iter_Add(FurnitureCategories, id);
    cache_delete(data);
    return true;
}

Dialog:EDIT_F_CATEGORY(playerid, response, listitem, const inputtext[])
{
    if(!response) return true;

    new name[64];
    format(name, 64, "%s", inputtext);

    foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid])
    {
        if(!strcmp(FurnitureCategory[i][cName], name, true))
        {
            EditingCategory[playerid] = i;
            break;
        }
    }
    Dialog_Show(playerid, EDIT_F_CATEGORY_2, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Mobilya Kategori İsmi", "Yeni kategori ismini girin:", "Değiştir", "Kapat");
    return true;
}

Dialog:EDIT_F_CATEGORY_2(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        new dialogStr[512];
        foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid])
            format(dialogStr, sizeof(dialogStr), "%s%s\n", dialogStr, FurnitureCategory[i][cName]);
        return Dialog_Show(playerid, EDIT_F_CATEGORY, DIALOG_STYLE_LIST, "Vinewood - Mobilya Kategorisi Düzenle", dialogStr, "Düzenle", "Kapat");
    }

    if(strlen(inputtext) > 63 || strlen(inputtext) < 1) return SendServerMessage(playerid, "Hatalı karakter girdiniz. (1-64)");

    format(FurnitureCategory[EditingCategory[playerid]][cName], 64, "%s", inputtext);
    return true;
}

Dialog:ADD_F_OBJECT(playerid, response, listitem, const inputtext[])
{
    if(!response) return true;
    new category[64];
    format(category, 64, "%s", inputtext);
    SetPVarString(playerid, "category", category);
    Dialog_Show(playerid, ADD_F_OBJECT_2, DIALOG_STYLE_INPUT, "Vinewood - Mobilya Objesi Ekle", "Lütfen obje modelini sayı olarak girin:", "Ekle", "Geri");
    return true;
}

Dialog:ADD_F_OBJECT_2(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        new dialogStr[512];
        foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid])
            format(dialogStr, sizeof(dialogStr), "%s%s\n", dialogStr, FurnitureCategory[i][cName]);
        return Dialog_Show(playerid, ADD_F_OBJECT, DIALOG_STYLE_LIST, "Vinewood - Mobilya Objesi Ekle", dialogStr, "Devam Et", "Kapat");
    }

    new category[64], obj[12], id, query[128], Cache:data;

    format(obj, sizeof(obj), "%s", inputtext);
    GetPVarString(playerid, "category", category, 64);

    foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid]) {
        if(strfind(FurnitureCategory[i][cName], category, true)) {
            id = FurnitureCategory[i][cID];
            printf("%d", id);
            break;
        }
    }

    mysql_format(conn, query, sizeof(query), "INSERT INTO furniture_items(furnitureType, modelID) VALUES(%d, %d)", id, strval(obj));
    data = mysql_query(conn, query, true);

    new item = Iter_Free(FurnitureItems);

    FurnitureItem[item][iID] = cache_insert_id();
    FurnitureItem[item][iIsValid] = true;
    FurnitureItem[item][iType] = id;
    FurnitureItem[item][iModel] = strval(obj);

    DeletePVar(playerid, "category");
    Iter_Add(FurnitureItems, item);
    cache_delete(data);
    return true;
}

Dialog:DEL_F_OBJECT(playerid, response, listitem, const inputtext[])
{
    if(!response) return true;

    new category[64], id, dialogStr[512];

    format(category, 64, "%s", inputtext);

    foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid]) {
        if(!strcmp(FurnitureCategory[i][cName], category, false)) {
            id = i;
            break;
        }
    }

    foreach(new i : FurnitureItems) if(FurnitureItem[i][iIsValid]) {
        if(FurnitureItem[i][iType] == FurnitureCategory[id][cType]) {
            format(dialogStr, sizeof(dialogStr), "%s%d\n", dialogStr, FurnitureItem[i][iModel]);
        }
    }

    Dialog_Show(playerid, DEL_F_OBJECT_2, DIALOG_STYLE_INPUT, "Vinewood - Mobilya Objesi Sil", dialogStr, "Ekle", "Geri");
    SetPVarInt(playerid, "category", id);
    return true;
}

Dialog:DEL_F_OBJECT_2(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        new dialogStr[512];
        foreach(new i : FurnitureCategories) if(FurnitureCategory[i][cIsValid])
            format(dialogStr, sizeof(dialogStr), "%s%s\n", dialogStr, FurnitureCategory[i][cName]);
        return Dialog_Show(playerid, DEL_F_OBJECT, DIALOG_STYLE_LIST, "Vinewood - Mobilya Objesi Sil", dialogStr, "Devam Et", "Kapat");
    }

    new id[10], n, query[128], Cache:data;

    format(id, 10, "%s", inputtext);

    foreach(new i : FurnitureItems) if(FurnitureItem[i][iIsValid]) {
        if(FurnitureItem[i][iModel] == strval(id)) {
            if(FurnitureItem[i][iType] == FurnitureCategory[GetPVarInt(playerid, "category")][cID] - 1) {
                n = i;
                break;
            }
        }
    }

    mysql_format(conn, query, sizeof(query), "DELETE FROM furniture_items WHERE id = %d", FurnitureItem[n][iID]);
    data = mysql_query(conn, query, true);
    
    FurnitureItem[n][iID] = -1;
    FurnitureItem[n][iIsValid] = false;
    FurnitureItem[n][iType] = -1;
    FurnitureItem[n][iModel] = -1;

    Iter_Remove(FurnitureItems, n);
    cache_delete(data);
    DeletePVar(playerid, "category");
    return true;
}