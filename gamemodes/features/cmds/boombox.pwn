CMD:boombox(playerid, params[])
{
	if(!Character[playerid][cBoombox]) return SendServerMessage(playerid, "Bir boomboxa sahip deðilsin.");
	if(IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Araçta boombox koyamazsýn.");
	if(GetPlayerInterior(playerid)) return SendServerMessage(playerid, "Boombox yalnýzca interior dýþýnda kullanýlabilir.");
	if(Iter_Count(Boomboxes) >= MAX_BOOMBOX) return SendServerMessage(playerid, "Sunucuda çok fazla boombox var.");
    if(GetClosestBoombox(playerid) != -1 && BoomboxData[GetClosestBoombox(playerid)][Owner] != playerid) 
        return SendServerMessage(playerid, "Yakýnýnda zaten bir boombox var");

	switch(Boombox[playerid])
	{
		case 0:
		{
			Dialog_Show(playerid, DIALOG_BOOMBOX, DIALOG_STYLE_INPUT, "Vinewood: Boombox Sistemi", "Lütfen aþaðýya müzik linkini girin:", "Gir", "Iptal");
		}
		case 1:
		{
			DestroyBoombox(playerid);
		}
	}
	return true;
}

Dialog:DIALOG_BOOMBOX(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;
    CreateBoombox(playerid, inputtext);
    return true;
}

Vinewood:CreateBoombox(playerid, url[])
{
    new Float: x, Float: y, Float: z, id = Iter_Free(Boomboxes), labelText[64];

    GetPlayerPos(playerid, x, y, z);
    format(BoomboxData[id][URL], 128, "%s", url);
    format(labelText, 64, "%s adlý kiþinin boomboxu, ID: %d", GetRPName(playerid), id);
    
    BoomboxData[id][Circle] = CreateDynamicCircle(x, y, BOOMBOX_RANGE, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
    BoomboxData[id][Object] = CreateDynamicObject(BOOMBOX_MODEL, x, y, z-0.97, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD, -1);
    BoomboxData[id][Label] = CreateDynamic3DTextLabel(labelText, -1, x, y, z, BOOMBOX_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
    BoomboxData[id][Owner] = playerid;
    BoomboxData[id][POS][0] = x;
    BoomboxData[id][POS][1] = y;
    BoomboxData[id][POS][2] = z;
    Boombox[playerid] = 1;

    OnPlayerEnterDynamicArea(playerid, BoomboxData[id][Circle]);
    Iter_Add(Boomboxes, id);
    return true;
}

Vinewood:DestroyBoombox(playerid)
{
    if(BoomboxData[GetClosestBoombox(playerid)][Owner] == playerid)
    {
        new id = GetClosestBoombox(playerid);

        foreach(new i : Player) {
            if(IsPlayerInRangeOfPoint(i, BOOMBOX_RANGE, BoomboxData[id][POS][0], BoomboxData[id][POS][1], BoomboxData[id][POS][2])) {
                StopAudioStreamForPlayer(playerid);
            }
        }

        BoomboxData[id][URL] = EOS;
        BoomboxData[id][Owner] = INVALID_PLAYER_ID;
        BoomboxData[id][POS][0] = 0;
        BoomboxData[id][POS][1] = 0;
        BoomboxData[id][POS][2] = 0;
        Boombox[playerid] = 0;

        DestroyDynamic3DTextLabel(BoomboxData[id][Label]);
        DestroyDynamicArea(BoomboxData[id][Circle]);
        DestroyDynamicObject(BoomboxData[id][Object]);

        Iter_Remove(Boomboxes, id);
    }
    else 
    {
        return SendServerMessage(playerid, "Bir boomboxa yakýn deðilsin veya boombox senin deðil.");
    }
    return true;
}

Vinewood:GetClosestBoombox(playerid)
{
    new id = -1;
    foreach(new i : Boomboxes) {
        if(IsPlayerInRangeOfPoint(playerid, BOOMBOX_RANGE, BoomboxData[i][POS][0], BoomboxData[i][POS][1], BoomboxData[i][POS][2])) {
            id = i;
            break;
        }
    }
    return id;
}

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
    foreach(new i : Boomboxes) {
        if(BoomboxData[i][Circle] == areaid) {
            PlayAudioStreamForPlayer(playerid, BoomboxData[i][URL], 0.0, 0.0, 0.0, 0.0, 0);
            break;
        }
    }
    return true;
}

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
    foreach(new i : Boomboxes) {
        if(BoomboxData[i][Circle] == areaid) {
            StopAudioStreamForPlayer(playerid);
            if(BoomboxData[i][Owner] == playerid) {
                DestroyBoombox(playerid);
            }
        }
    }
    return true;
}