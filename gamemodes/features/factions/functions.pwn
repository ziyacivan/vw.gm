Vinewood:FactionLimit()
{
	new limit = 0;
	for(new i; i < MAX_FACTIONS; i++)
	{
		if(Faction[i][fIsValid])
		{
			if(i >= MAX_FACTIONS)
				limit = 1;
		}
	}
	return limit;
}

Vinewood:FactionList(playerid)
{
	new count = 0;
	for(new i; i < MAX_FACTIONS; i++)
	{
		if(Faction[i][fIsValid])
		{
			SendClientMessageEx(playerid, C_GREY1, "ID: [%d] | %s | Seviye: [%d] | Bonus: [$%d]", i, Faction[i][fName], Faction[i][fLevel], Faction[i][fLevelBonus]);
			count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, C_GREY1, "Oluþum bulunamadý.");
	return true;
}

Vinewood:GetPlayerFactionID(playerid)
{
	new factionid = 0;
	for(new i; i < MAX_FACTIONS; i++)
	{
		if(Faction[i][fIsValid])
		{
			if(Character[playerid][cFaction] == Faction[i][fID])
				factionid = i;
		}
	}
	return factionid;
}

stock GetPlayerFactionRankName(playerid)
{
	new rankname[64];
	for(new i; i < MAX_FACTIONS; i++)
	{
		if(Faction[i][fIsValid])
		{
			if(Character[playerid][cFaction] == Faction[i][fID])
			{
				switch(Character[playerid][cFactionRank])
				{
					case 0: rankname = "Yok";
					case 1: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 2: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 3: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 4: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 5: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 6: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 7: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 8: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 9: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 10: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 11: format(rankname, 64, "%s", Faction[i][fRank1]);
					case 12: format(rankname, 64, "%s", Faction[i][fRank1]);
				}
			}
		}
	}
	return rankname;
}

Vinewood:SendFactionInvite(playerid, targetid, factid)
{
	new dialogstr[124];
	format(dialogstr, sizeof(dialogstr), "{FFFFFF}%s isimli oluþuma davet edildiniz.\n{FFFFFF}Katýlmak istiyor musunuz?");
	Dialog_Show(targetid, FACTION_INVITE, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Oluþum Davet Ekraný", dialogstr, "Evet", "Hayýr");

	FactionInviteID[playerid] = factid;
	FactionInviteMode[playerid] = true;
	return true;
}

Dialog:FACTION_INVITE(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new factid = FactionInviteID[playerid];
	Character[playerid][cFaction] = Faction[factid][fID];
	Character[playerid][cFactionRank] = Faction[factid][fLoginRank];
	FactionInviteMode[playerid] = false;
	SendServerMessage(playerid, "Daveti kabul ettiniz.");
	SendFactionMessage(GetPlayerFactionID(playerid), C_FACTION, "* %s oluþuma katýldý.", GetRPName(playerid));
	FactionInviteID[playerid] = 0;
	return true;
}

Vinewood:RespawnFactionVehicles(factid)
{
	for(new i; i < MAX_VEHICLES; i++)
	{
		if(Vehicle[i][vIsValid])
		{
			if(Vehicle[i][vFaction] == Faction[factid][fID])
			{
				SetVehicleToRespawn(i);
				SwitchVehicleEngine(i, false), Engine[i] = false;
				SwitchVehicleLight(i, false), Lights[i] = false;
				SwitchVehicleDoors(i, false), Doors[i] = false;
				SwitchVehicleBonnet(i, false), Bonnet[i] = false;
				SwitchVehicleBoot(i, false), Boot[i] = false;
			}
		}
	}
	return true;
}

Vinewood:IsPlayerOfficer(playerid)
{
	new status = 0;
	if(Character[playerid][cFaction])
	{
		new factid = GetPlayerFactionID(playerid);
		if(Faction[factid][fType] == FACTION_POLICE)
			status = 1;
		else
			status = 0;
	}
	return status;
}

Vinewood:IsPlayerMedicalOfficer(playerid)
{
	new status = 0;
	if(Character[playerid][cFaction])
	{
		new factid = GetPlayerFactionID(playerid);
		if(Faction[factid][fType] == 2)
			status = 1;
		else
			status = 0;
	}
	return status;
}

Vinewood:IsPlayerFireOfficer(playerid)
{
	new status = 0;
	if(Character[playerid][cFaction])
	{
		new factid = GetPlayerFactionID(playerid);
		if(Faction[factid][fType] == 3)
			status = 1;
		else
			status = 0;
	}
	return status;
}

Vinewood:GetFactionType(playerid)
{
	if(Character[playerid][cFaction] == 0)
		return false;
	return Faction[GetPlayerFactionID(playerid)][fType];
}