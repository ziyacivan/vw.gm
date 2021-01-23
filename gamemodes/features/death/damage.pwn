CMD:hasarlar(playerid, params[])
{
    new target;

    if(sscanf(params, "d", target)) return SendServerMessage(playerid, "/hasarlar [ID]");
    if(!IsPlayerConnected(target)) return SendServerMessage(playerid, "Bu kiþi oyunda deðil.");

    GetPlayerPos(target, Character[target][cPos][0], Character[target][cPos][1], Character[target][cPos][2]);

    if(!IsPlayerInRangeOfPoint(playerid, 7.5, Character[target][cPos][0], Character[target][cPos][1], Character[target][cPos][2])) return SendServerMessage(playerid, "Oyuncuya yakýn deðilsin.");
    if(!Character[target][cIsDead]) return SendServerMessage(playerid, "Bu kiþi ölü deðil.");

    new dialogStr[512], dialogHeader[64], weaponName[24];

    format(dialogHeader, sizeof(dialogHeader), "Vinewood Roleplay - %d'nin Hasarlarý", target);
    format(dialogStr, sizeof(dialogStr), "{CA543B}Hasar Veren\t\tSilah\t\tBölge\t\tHasar{DAD1CF}\n");

    foreach(new i : Damages)
    {
        if(Damage[i][dIsValid])
        {
            if(Damage[i][dDamaged] == target)
            {
                GetWeaponName(Damage[i][dWeapon], weaponName, sizeof(weaponName));
                format(dialogStr, sizeof(dialogStr), "%s%s\t\t%s\t\t%s\t\t%.2f\n", dialogStr, 
                    Damage[i][dDamager], weaponName, Damage[i][dBodyPart], Damage[i][dHealthTaken]
                );
            }
        }
    }

    Dialog_Show(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, dialogHeader, dialogStr, "Kapat", "");
    return true;
}

Vinewood:AddNewDamage(const damager[], damaged, weapon, Float:healthTaken, bodypart)
{
    new id = Iter_Free(Damages), temp_BodyPart[24];

    Damage[id][dIsValid] = true;
    format(Damage[id][dDamager], 24, "%s", damager);
    Damage[id][dDamaged] = damaged;
    Damage[id][dWeapon] = weapon;
    Damage[id][dHealthTaken] = healthTaken;

    switch(bodypart)
    {
        case 3: format(temp_BodyPart, 24, "Gövde");
        case 4: format(temp_BodyPart, 24, "Karýn");
        case 5: format(temp_BodyPart, 24, "Sol Kol");
        case 6: format(temp_BodyPart, 24, "Sað Kol");
        case 7: format(temp_BodyPart, 24, "Sol Bacak");
        case 8: format(temp_BodyPart, 24, "Sað Bacak");
        case 9: format(temp_BodyPart, 24, "Kafa");
    }

    format(Damage[id][dBodyPart], 24, "%s", temp_BodyPart);

    Iter_Add(Damages, id);
    return true;
}

Vinewood:DeleteDamage(id)
{
    Damage[id][dIsValid] = false;
    Damage[id][dDamager] = EOS;
    Damage[id][dDamaged] = INVALID_PLAYER_ID;
    Damage[id][dWeapon] = -1;
    Damage[id][dHealthTaken] = 0;
    Damage[id][dBodyPart] = EOS;
    Iter_Remove(Damages, id);
    return true;
}