Vinewood:KillPlayer(playerid, killerid, killerweapon)
{
    HideWeapon(playerid, EquippedWeapon[playerid]);
    Character[playerid][cIsDead] = 1;
    Character[playerid][cKillerPlayer] = killerid;
    Character[playerid][cKillerWeapon] = killerweapon;
    format(Character[playerid][cKilledAt], 64, "%s", GetLocation(Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2]));
    format(DeathText[playerid], 64, "(( Bu kullanýcý þu an yaralý. (/hasarlar %d) ))", playerid);
    Character[playerid][cDeathSecondsLeft] = DEFAULT_DEATH_SECONDS;
    TogglePlayerControllable(playerid, false);
    //Character[playerid][cDeathLabel] = CreateDynamic3DTextLabel(DeathText[playerid], DEATH_LABEL_COLOR, Character[playerid][cPos][0], Character[playerid][cPos][1], Character[playerid][cPos][2], DEATH_LABEL_DD);
    for(new i; i < 5; i++) ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.0, 1, 1, 1, 0, 0);
    return true;
}

Vinewood:RevivePlayer(playerid)
{  
    foreach(new i : Damages) if(Damage[i][dIsValid])
    {
        if(Damage[i][dDamaged] == playerid) DeleteDamage(i);
    }

    Character[playerid][cIsDead] = 0;
    Character[playerid][cKillerPlayer] = 0;
    Character[playerid][cKillerWeapon] = 0;
    format(Character[playerid][cKilledAt], 64, "nowhere");
    format(DeathText[playerid], 64, "none");
    TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);
    //DestroyDynamic3DTextLabel(Character[playerid][cDeathLabel]);
    GivePlayerHealth(playerid, 25.0);
    return true;
}
