new Text:KeyTextDraws[4];

enum ChallangeEnum {
    cChallange,
    cLeft,
    cType,
    cTrue,
    cFalse,
    cTimer,
    cKey
};
new ChallangeData[MAX_PLAYERS][ChallangeEnum];

enum DirectionEnum {
    ModelName[32],
    KEY
};
new DirectionData[4][DirectionEnum];

Vinewood:StartChallange(playerid, challange)
{
    new rand = random(sizeof(DirectionData));

    ChallangeData[playerid][cChallange] = 1;
    ChallangeData[playerid][cKey] = rand;

    TogglePlayerControllable(playerid, false);

    switch(challange)
    {
        case CHALLANGE_TOOLKIT:
        {
            ChallangeData[playerid][cLeft] = 10;
            ChallangeData[playerid][cTrue] = 0;
            ChallangeData[playerid][cFalse] = 0;
            ChallangeData[playerid][cType] = CHALLANGE_TOOLKIT;
        }
        case CHALLANGE_HOUSE_KEY:
        {
            ChallangeData[playerid][cLeft] = 10;
            ChallangeData[playerid][cTrue] = 0;
            ChallangeData[playerid][cFalse] = 0;
            ChallangeData[playerid][cType] = CHALLANGE_HOUSE_KEY;
        }
    }

    TextDrawShowForPlayer(playerid, KeyTextDraws[rand]);
    return true;
}

Vinewood:RefreshChallange(playerid)
{
    if(ChallangeData[playerid][cLeft] <= 0)
    {
        new success;

        if(ChallangeData[playerid][cTrue] >= ChallangeData[playerid][cFalse]) success = 1;
        else success = 0;

        CallRemoteFunction("OnPlayerFinishedChallange", "ddd", playerid, ChallangeData[playerid][cType], success);
        return KillTimer(ChallangeData[playerid][cTimer]);
    }

    KillTimer(ChallangeData[playerid][cTimer]);

    new rand = random(sizeof(DirectionData));

    for(new i; i < 4; i++) {
        TextDrawHideForPlayer(playerid, KeyTextDraws[i]);
        TextDrawColor(KeyTextDraws[i], 0xC6C3C3FF);
    }

    ChallangeData[playerid][cKey] = rand;
    ChallangeData[playerid][cTimer] = SetTimerEx("ChallangeTimer", CHALLANGE_INTERVAL*1000, false, "d", playerid);
    ChallangeData[playerid][cLeft]--;
    TextDrawShowForPlayer(playerid, KeyTextDraws[rand]);

    if(GetPVarInt(playerid, "clicked") == 0)
        ChallangeData[playerid][cFalse]++;
    return true;
}

Vinewood:LoadDirections()
{
    format(DirectionData[0][ModelName], 32, "LD_BEAT:up");
    format(DirectionData[1][ModelName], 32, "LD_BEAT:down");
    format(DirectionData[2][ModelName], 32, "LD_BEAT:left");
    format(DirectionData[3][ModelName], 32, "LD_BEAT:right");

    for(new i; i < 4; i++)
    {
        KeyTextDraws[i] = TextDrawCreate(100.0, 200.0, DirectionData[i][ModelName]);
        TextDrawFont(KeyTextDraws[i], 4);
        TextDrawTextSize(KeyTextDraws[i], 32.0, 32.0);
    }
    return true;
}

Vinewood:ChallangeTimer(playerid)
{
    if(ChallangeData[playerid][cLeft] <= 0)
    {
        new success;

        if(ChallangeData[playerid][cTrue] >= ChallangeData[playerid][cFalse]) success = 1;
        else success = 0;

        CallRemoteFunction("OnPlayerFinishedChallange", "ddd", playerid, ChallangeData[playerid][cType], success);
        return KillTimer(ChallangeData[playerid][cTimer]);
    }
    RefreshChallange(playerid);
    return true;
}