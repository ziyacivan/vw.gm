Vinewood:BusinessOutDoor(playerid)
{
	new status = 0;
	for(new i; i < MAX_BUSINESS; i++)
	{
		if(Business[i][bsIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, Business[i][bsExtDoor][0], Business[i][bsExtDoor][1], Business[i][bsExtDoor][2]))
				status = 1;
		}
	}
	return status;
}

Vinewood:BusinessIntDoor(playerid)
{
	new status = 0;
	for(new i; i < MAX_BUSINESS; i++)
	{
		if(Business[i][bsIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, Business[i][bsIntDoor][0], Business[i][bsIntDoor][1], Business[i][bsIntDoor][2]))
				status = 1;
		}
	}
	return status;
}

Vinewood:GetPlayerNearbyBusiness(playerid)
{
	new bsid;
	for(new i; i < MAX_BUSINESS; i++)
	{
		if(Business[i][bsIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, 
			Business[i][bsExtDoor][0], Business[i][bsExtDoor][1], Business[i][bsExtDoor][2]) 
			|| IsPlayerInRangeOfPoint(playerid, 5.0, 
			Business[i][bsIntDoor][0], Business[i][bsIntDoor][1], Business[i][bsIntDoor][2]))
				bsid = i;
		}
	}
	return bsid;
}

Vinewood:GetBusinessType(playerid)
{
	new type = 0;
	foreach(new i : Business)
	{
		if(Business[i][bsIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 50.0, 
			Business[i][bsIntDoor][0], Business[i][bsIntDoor][1], Business[i][bsIntDoor][2]))
			{
				type = Business[i][bsType];
				break;
			}
		}
	}
	return type;
}

Vinewood:GetGarageOutDoor(playerid)
{
	new status;
	foreach(new i : Business)
	{
		if(Business[i][bsIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 30.0, Business[i][bsExtDoor][0], Business[i][bsExtDoor][1], Business[i][bsExtDoor][2]))
			{
				if(Business[i][bsType] == 6)
				status = 1; 
				break;
			}
		}
	}
	return status;
}

Vinewood:GetGarageType(playerid)
{
	new status;
	foreach(new i : Business)
	{
		if(Business[i][bsIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 30.0, Business[i][bsExtDoor][0], Business[i][bsExtDoor][1], Business[i][bsExtDoor][2]))
			{
				if(Business[i][bsType] == 6)
				{
					if(Business[i][bsOwner] == Character[playerid][cID] || IsWorkerInBusiness(playerid, i))
					status = 1;
				}
			}
		}
	}
	return status;
}

Vinewood:GetBusinessID(playerid)
{
	new id;
	foreach(new i : Business)
	{
		if(Business[i][bsIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Business[i][bsExtDoor][0], Business[i][bsExtDoor][1], Business[i][bsExtDoor][2]))
				id = i;	
		}
	}
	return id;
}

Vinewood:GetBusinessIDFromInt(playerid)
{
	new id;
	foreach(new i : Business)
	{
		if(Business[i][bsIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 50.0, Business[i][bsIntDoor][0], Business[i][bsIntDoor][1], Business[i][bsIntDoor][2]))
				id = i;	
		}
	}
	return id;
}

Vinewood:IsOwnerBusiness(playerid, bsid)
{
	new status = 0;
	foreach(new i : Business)
	{
		if(Business[i][bsIsValid])
		{
			if(Business[i][bsOwner] == Character[playerid][cID])
				status = 1;
		}
	}
	return status;
}

Vinewood:IsWorkerInBusiness(playerid, businessid)
{
	for(new i; i < 10; i++) {
		if(Business[businessid][bsWorkers][i] == Character[playerid][cID]) return true;
	}
	return false;
}

Vinewood:LoadBusinessList(playerid)
{
	new count;
	foreach(new i : Business)
	{
		if(Business[i][bsIsValid])
		{
			if(Business[i][bsOwner] == Character[playerid][cID])
			{
				new lock[32];
				switch(Business[i][bsLocked])
				{
					case 0: lock = "Açýk";
					case 1: lock = "Kilitli";
				}

				SendClientMessageEx(playerid, C_GREY1, "Ýsim: [%s] | Durum: [%s] | Bölge: [%s]", Business[i][bsName], lock, GetLocation(Business[i][bsExtDoor][0], Business[i][bsExtDoor][1], Business[i][bsExtDoor][2]));
				count++;
			}
		}
	}
	if(!count) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");
	return true;
}

Vinewood:SendBusinessOffer(playerid, targetid, bsid, price)
{
	new str[512];
	format(str, sizeof(str), "{FFFFFF}%s isimli kiþiden, %s isimli iþletmenin {268126}$%d {FFFFFF} ücretle satýþ teklifini aldýnýz.\n{FFFFFF}Teklifi kabul ediyor musunuz?", GetRPName(playerid), Business[bsid][bsName], price);
	Dialog_Show(targetid, BUSINESS_OFFER, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Teklif", str, "Onayla", "Reddet");
	return true;
}