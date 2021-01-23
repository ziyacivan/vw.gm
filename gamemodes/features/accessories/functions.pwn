Vinewood:IsHaveAcc(playerid)
{
    new stat = 0, query[124];
    mysql_format(conn, query, sizeof(query), "SELECT * FROM accessories WHERE Owner = '%i'", Character[playerid][cID]);
    mysql_query(conn, query);

    if(cache_num_rows())
        stat = 1;
    
    return stat;
}

Vinewood:IsEmptySlot(playerid, slotid)
{
    new stat = 0;

    if(Character[playerid][cAcc][slotid] == 0)
        stat = 1;
    
    return stat;
}

Vinewood:AttachAccessoryToPlayer(playerid, slotid)
{
    new query[124];
    mysql_format(conn, query, sizeof(query), "SELECT * FROM accessories WHERE Owner = '%i' AND Slot = %i", Character[playerid][cID], slotid);
    mysql_query(conn, query);

    new slot, modelid, bone, Float:offsetx, Float:offsety, Float:offsetz, Float:rotx, Float:roty, Float: rotz, Float:scalex, Float:scaley, Float:scalez, macol1, macol2;
    cache_get_value_name_int(0, "Slot", slot);
    cache_get_value_name_int(0, "Model", modelid);
    cache_get_value_name_int(0, "Bone", bone);
    cache_get_value_name_float(0, "fOffSetX", offsetx);
    cache_get_value_name_float(0, "fOffSetY", offsety);
    cache_get_value_name_float(0, "fOffSetZ", offsetz);
    cache_get_value_name_float(0, "fRotX", rotx);
    cache_get_value_name_float(0, "fRotY", roty);
    cache_get_value_name_float(0, "fRotZ", rotz);
    cache_get_value_name_float(0, "fScaleX", scalex);
    cache_get_value_name_float(0, "fScaleY", scaley);
    cache_get_value_name_float(0, "fScaleZ", scalez);
    cache_get_value_name_int(0, "MaterialColor1", macol1);
    cache_get_value_name_int(0, "MaterialColor2", macol2);

    SetPlayerAttachedObject(playerid, slot, modelid, bone, offsetx, offsety, offsetz, rotx, roty, rotz, scalex, scaley, scalez, macol1, macol2);
    SendServerMessage(playerid, "%d slot numaralý aksesuarý taktýnýz.", slotid);
    return true;
}

Vinewood:RemoveAttachAccessoryToPlayer(playerid, slotid)
{
    RemovePlayerAttachedObject(playerid, slotid);
    SaveCharacterData(playerid);
    SendServerMessage(playerid, "%d slot numaralý aksesuarý çýkarttýnýz.", slotid);
    return true;
}

Vinewood:DeleteCompleteAccessory(playerid, slotid)
{
    Character[playerid][cAcc][slotid] = 0;
    new query[124];
    mysql_format(conn, query, sizeof(query), "DELETE FROM accessories WHERE Owner = '%i' AND Slot = '%i'", Character[playerid][cID], slotid);
    mysql_query(conn, query);

    SendServerMessage(playerid, "%d slot numaralý aksesuarý sildiniz.", slotid);
    return true;
}

Vinewood:EditAccessory(playerid, slotid)
{
    new query[124];
    mysql_format(conn, query, sizeof(query), "SELECT * FROM accessories WHERE Owner = '%i' AND Slot = '%i'", Character[playerid][cID], slotid);
    mysql_query(conn, query);

    new slot, model, bone, Float:offsetx, Float:offsety, Float:offsetz, Float:rotx, Float:roty, Float:rotz, Float:scalex, Float:scaley, Float:scalez, macol1, macol2;
    cache_get_value_name_int(0, "Slot", slot);
    cache_get_value_name_int(0, "Model", model);
    cache_get_value_name_int(0, "Bone", bone);
    cache_get_value_name_float(0, "fOffSetX", offsetx);
    cache_get_value_name_float(0, "fOffSetY", offsety);
    cache_get_value_name_float(0, "fOffSetZ", offsetz);
    cache_get_value_name_float(0, "fRotX", rotx);
    cache_get_value_name_float(0, "fRotY", roty);
    cache_get_value_name_float(0, "fRotZ", rotz);
    cache_get_value_name_float(0, "fScaleX", scalex);
    cache_get_value_name_float(0, "fScaleY", scaley);
    cache_get_value_name_float(0, "fScaleZ", scalez);
    cache_get_value_name_int(0, "MaterialColor1", macol1);
    cache_get_value_name_int(0, "MaterialColor2", macol2);

    Character[playerid][cAcc][slot] = 0;

    new queryex[124];
    mysql_format(conn, queryex, sizeof(queryex), "DELETE FROM accessories WHERE Owner = '%i' AND Slot = '%i'", Character[playerid][cID], slotid);
    mysql_query(conn, queryex);
    
    SetPlayerAttachedObject(playerid, slot, model, bone);
    EditAttachedObject(playerid, slot);

    Character[playerid][cAcc][slot] = model;
    SaveCharacterData(playerid);


    return true;
}