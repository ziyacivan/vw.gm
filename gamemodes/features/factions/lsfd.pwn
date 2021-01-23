CMD:fdisbasi(playerid, params[])
{
	if(!IsPlayerFireOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	if(GetBuildingType(playerid) != 3) return SendServerMessage(playerid, "LSFD HQ'da deðilsiniz.");

	switch(FDWork[playerid])
	{
		case 0:
		{
			FDWork[playerid] = 1;
			SetPlayerColor(playerid, C_FIREDEPARTMENT);
			SendFactionMessageEx(FACTION_FD, C_FACTION, "* %s %s iþbaþýna geçti.", GetPlayerFactionRankName(playerid), GetRPName(playerid));
		}
		case 1:
		{
			FDWork[playerid] = 0;
			SetPlayerColor(playerid, C_WHITE);
			SendFactionMessageEx(FACTION_FD, C_FACTION, "* %s %s iþbaþýndan çýktý.", GetPlayerFactionRankName(playerid), GetRPName(playerid));
		}
	}
	return true;
}

CMD:fdkiyafet(playerid, params[])
{
	if(!IsPlayerFireOfficer(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	if(GetBuildingType(playerid) != 3) return SendServerMessage(playerid, "LSFD HQ'da deðilsiniz.");

	switch(Character[playerid][cSex])
	{
		case 0: return true;
		case 1:
		{
			static string[sizeof(LSFD_MALE) * 16];

			if(string[0] == EOS) {
				for(new i; i < sizeof(LSFD_MALE); i++)
				{
					format(string, sizeof string, "%s%i\n", string, LSFD_MALE[i][FD_SKIN_MODEL]);
				}
			}
			return Dialog_Show(playerid, DIALOG_FD_MALE_SKINS, DIALOG_STYLE_PREVIEW_MODEL, "LSFD - Erkek", string, "Sec", "Kapat");
		}
		case 2:
		{
			static string[sizeof(LSFD_FEMALE) * 16];

			if(string[0] == EOS) {
				for(new i; i < sizeof(LSFD_FEMALE); i++)
				{
					format(string, sizeof string, "%s%i\n", string, LSFD_FEMALE[i][FD_SKIN_MODEL]);
				}
			}
			return Dialog_Show(playerid, DIALOG_FD_FEMALE_SKINS, DIALOG_STYLE_PREVIEW_MODEL, "LSFD - Kadin", string, "Sec", "Kapat");
		}
	}
	return true;
}

Dialog:DIALOG_FD_MALE_SKINS(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPlayerSkin(playerid, LSFD_MALE[listitem][FD_SKIN_MODEL]);
	return true;
}

Dialog:DIALOG_FD_FEMALE_SKINS(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPlayerSkin(playerid, LSFD_FEMALE[listitem][FD_SKIN_MODEL]);
	return true;
}