#define MAX_GRAFFITI            (100)
#define GRAFFITI_DISTANCE       (20.0)
#define GRAFFITI_OBJECT         (-2010)

enum GraffitiData {
    gID,
    gOwner,
    gText[128],
    bool:gIsValid,
    Float:gPOS[3],
    Float:gROT[3],
    STREAMER_TAG_OBJECT:gObject
};
new Graffiti[MAX_GRAFFITI][GraffitiData];
new Iterator: Graffities<MAX_GRAFFITI>;

new IsEditingObject[MAX_PLAYERS];
new STREAMER_TAG_OBJECT:EditingObject[MAX_PLAYERS];
new EditingGraffiti[MAX_PLAYERS];
new SprayTimes[MAX_PLAYERS];

CMD:graffiti(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araçta graffiti yapamazsýn.");
    if(GetPlayerWeapon(playerid) != 41) return SendServerMessage(playerid, "Elinde spray yok.");
    if(GetPlayerAmmo(playerid) <= 100) return SendServerMessage(playerid, "Sprayin içinde yeteri kadar boya yok. (En az 100 mermi)");
    if(Iter_Count(Graffities) >= MAX_GRAFFITI) return SendServerMessage(playerid, "Sunucudaki graffiti sýnýrýna ulaþýlmýþ.");
    Dialog_Show(playerid, GRAFFITI_1, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Graffiti #1", "Þu anda graffiti yapýyorsun.\nYazdýðýn cümleyi gir:", "Devam", "Iptal");
    return true;
}

Dialog:GRAFFITI_1(playerid, response, lisitem, inputtext[])
{
    if(!response) return true;
    if(strlen(inputtext) > 128 || strlen(inputtext) < 1) return SendServerMessage(playerid, "Hatalý karakter sayýsý. 1 - 128");
    CreateGraffiti(playerid, inputtext);
    return true;
}

Vinewood:CreateGraffiti(playerid, text[])
{
    new id = Iter_Free(Graffities), Float:x, Float:y, Float:z, i, query[256], Cache:data;
    i = id - 1;
    
    GetPlayerPos(playerid, x, y, z);
    format(Graffiti[id][gText], 128, "%s", text);

    Graffiti[id][gPOS][0] = x;
    Graffiti[id][gPOS][1] = y;
    Graffiti[id][gPOS][2] = z;

    Graffiti[id][gROT][0] = 0;
    Graffiti[id][gROT][1] = 0;
    Graffiti[id][gROT][2] = 0;

    Graffiti[i+1][gOwner] = Character[playerid][cID];
    Graffiti[i+1][gObject] = CreateDynamicObject(GRAFFITI_OBJECT, Graffiti[i+1][gPOS][0], Graffiti[i+1][gPOS][1], Graffiti[i+1][gPOS][2], Graffiti[i+1][gROT][0], Graffiti[i+1][gROT][1], Graffiti[i+1][gROT][2], -1, -1, -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD, -1);
    SetDynamicObjectMaterialText(Graffiti[i+1][gObject], 0, Graffiti[i+1][gText], OBJECT_MATERIAL_SIZE_256x128, "Arial", 24, 1, 0xFFFFFFFF, 0, 0);
    EditingObject[playerid] = Graffiti[i+1][gObject];
    EditingGraffiti[playerid] = id;
    IsEditingObject[playerid] = 1;

    EditDynamicObject(playerid, Graffiti[i+1][gObject]);
    Iter_Add(Graffities, id);

    mysql_format(conn, query, sizeof(query), "INSERT INTO graffities(owner, text, posX, posY, posZ, rotX, rotY, rotZ) VALUES(%i, '%e', %.4f, %.4f, %.4f, %.4f, %.4f, %.4f)",
        Graffiti[i+1][gOwner],
        Graffiti[id][gPOS][0],
        Graffiti[id][gPOS][1],
        Graffiti[id][gPOS][2],
        0.0,
        0.0,
        0.0
    );
    data = mysql_query(conn, query, true);

    Graffiti[i+1][gID] = cache_insert_id();

    cache_delete(data);
    return true;
}

Vinewood:DestroyGraffiti(playerid, id)
{
    new query[128];

    Graffiti[id][gIsValid] = false;

    mysql_format(conn, query, sizeof(query), "DELETE FROM graffities WHERE id = %d", Graffiti[id][gID]);
    mysql_query(conn, query, false);

    EditingGraffiti[playerid] = -1;
    IsEditingObject[playerid] = 0;

    DestroyDynamicObject(Graffiti[id][gObject]);
    Iter_Remove(Graffities, id);
    return true;
}

Vinewood:LoadGraffities()
{
    if(!cache_num_rows()) return printf("VinewoodDB >> Graffiti bulunamadý.");

    Iter_Add(Graffities, 0);

    for(new i; i < cache_num_rows(); i++)
    {
        Graffiti[i+1][gIsValid] = true;

        cache_get_value_name_int(i, "id", Graffiti[i+1][gID]);
        cache_get_value_name_int(i, "owner", Graffiti[i+1][gOwner]);

        cache_get_value_name(i, "text", Graffiti[i+1][gText]);

        cache_get_value_name_float(i, "posX", Graffiti[i+1][gPOS][0]);
        cache_get_value_name_float(i, "posY", Graffiti[i+1][gPOS][1]);
        cache_get_value_name_float(i, "posZ", Graffiti[i+1][gPOS][2]);

        cache_get_value_name_float(i, "rotX", Graffiti[i+1][gROT][0]);
        cache_get_value_name_float(i, "rotY", Graffiti[i+1][gROT][1]);
        cache_get_value_name_float(i, "rotZ", Graffiti[i+1][gROT][2]);
        
        Graffiti[i+1][gObject] = CreateDynamicObject(GRAFFITI_OBJECT, Graffiti[i+1][gPOS][0], Graffiti[i+1][gPOS][1], Graffiti[i+1][gPOS][2], Graffiti[i+1][gROT][0], Graffiti[i+1][gROT][1], Graffiti[i+1][gROT][2], -1, -1, -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD, -1);
        SetDynamicObjectMaterialText(Graffiti[i+1][gObject], 0, Graffiti[i+1][gText], OBJECT_MATERIAL_SIZE_256x128, "Arial", 24, 1, 0xFFFFFFFF, 0, 0);
        
        Iter_Add(Graffities, i+1);
    }
	printf("VinewoodDB >> %i adet graffiti yüklendi.", cache_num_rows());
    return true;
}