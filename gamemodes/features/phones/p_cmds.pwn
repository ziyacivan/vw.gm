CMD:telefonliste(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	PhoneList(playerid, playerid);
	return true;
}

CMD:telefon(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	new phoneid;
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/telefon [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait deðil.");

	Character[playerid][cPhoneID] = phoneid;
	Phone[phoneid][phStatus] = 1;

	Dialog_Show(playerid, DIALOG_PHONE, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Telefon", "Gelen Kutusu\nGiden Kutusu\nSon Aramalar\nRehber\n{000000}_\nTelefonu Kapat", "Seç", "Kapat");
	return true;
}

CMD:telefonat(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	new phoneid, Float:x, Float:y, Float:z, int, vw;
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/telefon [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait deðil.");

	GetPlayerPos(playerid, x, y, z);
	int = GetPlayerInterior(playerid);
	vw = GetPlayerVirtualWorld(playerid);

	Phone[phoneid][phOwner] = -1;
	Phone[phoneid][phOnTheGround] = 1;
	Phone[phoneid][phPos][0] = x;
	Phone[phoneid][phPos][1] = y;
	Phone[phoneid][phPos][2] = z;
	Phone[phoneid][phRot][0] = 90.0;
	Phone[phoneid][phRot][1] = 0.0;
	Phone[phoneid][phRot][2] = 0.0;
	Phone[phoneid][phInt] = int;
	Phone[phoneid][phVW] = vw;

	Phone[phoneid][phTempObject] = CreateDynamicObject(19513, Phone[phoneid][phPos][0], Phone[phoneid][phPos][1], Phone[phoneid][phPos][2]-0.95, Phone[phoneid][phRot][0], Phone[phoneid][phRot][1], Phone[phoneid][phRot][2], Phone[phoneid][phVW], Phone[phoneid][phInt]);
	RefreshPhone(phoneid);
	SendServerMessage(playerid, "%d numaralý telefonu yere býraktýnýz.", phoneid);
	return true;
}

CMD:telefonal(playerid, params[])
{
	if(!GetClosestPhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	new phoneid = GetClosestPhone(playerid);

	Phone[phoneid][phOnTheGround] = 0;
	Phone[phoneid][phOwner] = Character[playerid][cID];
	DestroyDynamicObject(Phone[phoneid][phTempObject]);
	RefreshPhone(phoneid);

	SendServerMessage(playerid, "%d numaralý telefonu yerden aldýnýz.", phoneid);
	return true;
}

CMD:ara(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	new phoneid, number;
	if(sscanf(params, "dd", phoneid, number)) return SendServerMessage(playerid, "/ara [telefon id] [numara]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait deðil.");
	if(!IsValidNumber(number)) return SendServerMessage(playerid, "Girilen numara geçersiz.");
	new callin_phoneid = GetPhoneIDFromNumber(number);
	if(Phone[callin_phoneid][phInCall]) return SendServerMessage(playerid, "Aradýðýnýz numara meþgul.");
	if(Phone[callin_phoneid][phCalling]) return SendServerMessage(playerid, "Aradýðýnýz numara meþgul.");

	foreach(new i : Phones) if(Phone[i][phIsValid]) {
		if(Phone[i][phNumber] == number) {
			if(Phone[i][phOwner] == Character[playerid][cID]) {
				return SendServerMessage(playerid, "Kendini arayamazsýn.");
			}
		}
	}	

	Character[playerid][cPhoneID] = phoneid;

	if(Phone[phoneid][phInCall]) return SendServerMessage(playerid, "Þuan baþka bir çaðrýdasýnýz.");
	if(Phone[phoneid][phCalling]) return SendServerMessage(playerid, "Þuan baþka bir çaðrýdasýnýz.");

	if(number == 911)
	{
		Phone[phoneid][phCalling] = 1;
		Dialog_Show(playerid, DIALOG_911_1, DIALOG_STYLE_INPUT, "Vinewood - 911 Hattý [#1]", "Operatör: 911 çaðrý hattý, kullanmak istediðiniz servis? (LSPD/LSFD/LSMD)", "Devam Et", "Kapat");	
	}
	else
	{
		if(!Phone[callin_phoneid][phStatus]) return SendServerMessage(playerid, "Aradýðýnýz kiþiye ulaþýlamýyor.");
		
		Phone[phoneid][phCalling] = 1;
		Phone[callin_phoneid][phCalling] = 1;

		Phone[phoneid][phCaller] = 0;
		Phone[callin_phoneid][phCaller] = phoneid;
		Phone[callin_phoneid][phCallerPID] = playerid;

		if(Phone[callin_phoneid][phOnTheGround])
		{
			foreach(new i: Player)
			{
				if(IsPlayerInRangeOfPoint(i, 10.0, Phone[callin_phoneid][phPos][0], Phone[callin_phoneid][phPos][1], Phone[callin_phoneid][phPos][2]))
					SendClientMessageEx(i, C_EMOTE, "* Çalmaktadýr. (( Telefon %d ))", callin_phoneid);
			}
		}
		else
		{
			foreach(new i: Player)
			{
				if(Phone[callin_phoneid][phOwner] == Character[i][cID])
				{
					new Float:x, Float:y, Float:z;
					GetPlayerPos(i, x, y, z);

					SendNearbyMessage(i, 10.0, C_EMOTE, "* Çalmaktadýr. (( Telefon %d ))", callin_phoneid);
					SendClientMessageEx(i, C_GREY1, "Telefonunuz çalmaktadýr, /cagrikabul %d ya da /cagrireddet %d.", callin_phoneid, callin_phoneid);
				}
			}
		}
		SendServerMessage(playerid, "%d numaralý telefonu arýyorsunuz...", number);
	}
	return true;
}

CMD:cagrikabul(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	new phoneid;
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/cagrikabul [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait deðil.");
	if(Phone[phoneid][phInCall]) return SendServerMessage(playerid, "Bu telefonla þuan bir çaðrýdasýnýz.");
	if(!Phone[phoneid][phCalling]) return SendServerMessage(playerid, "Bu telefon çalmýyor."); 

	new callerid = Phone[phoneid][phCaller];

	Phone[phoneid][phCalling] = 0;
	Phone[callerid][phCalling] = 0;

	new calling_line = randomEx(111, 999);
	Phone[phoneid][phInCall] = calling_line;
	Phone[callerid][phInCall] = calling_line;

	new targetid = Phone[phoneid][phCallerPID];

	InCall[playerid] = 1;
	InCall[targetid] = 1;

	CallTimer[playerid] = SetTimerEx("PhoneTimer", 5000, true, "d", playerid);

	InCall_Line[playerid] = calling_line;
	InCall_Line[targetid] = calling_line;

	SendServerMessage(playerid, "Çaðrýyý kabul ettiniz, konuþabilirsiniz.");
	SendServerMessage(targetid, "Çaðrýnýz açýldý, konuþabilirsiniz.");

	Phone[callerid][phCaller] = 0;
	return true;
}

CMD:cagrireddet(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	new phoneid;
	
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/cagrireddet [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait deðil.");
	if(Phone[phoneid][phInCall] == 0) return SendServerMessage(playerid, "Bu telefon çaðrýda deðil.");
	if(!Phone[phoneid][phCalling]) return SendServerMessage(playerid, "Bu telefon çalmýyor.");

	new callerid = Phone[phoneid][phCaller];

	Phone[phoneid][phCalling] = 0;
	Phone[callerid][phCalling] = 0;

	new targetid = Phone[phoneid][phCallerPID];
	SendServerMessage(playerid, "Çaðrýyý reddettiniz.");
	SendServerMessage(targetid, "Çaðrýnýz reddedildi.");

	Phone[callerid][phInCall] = 0;
	Phone[phoneid][phInCall] = 0;
	Phone[callerid][phCaller] = 0;
	Phone[phoneid][phCaller] = 0;
	return true;
}

CMD:cagrikapat(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	new phoneid;
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/cagrikapat [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait deðil.");
	if(!Phone[phoneid][phInCall]) return SendServerMessage(playerid, "Bu telefon çaðrýda deðil.");
	if(!InCall[playerid]) return SendServerMessage(playerid, "Çaðrýda deðilsiniz.");

	new callerid = Phone[phoneid][phCaller];

	Phone[phoneid][phCalling] = 0;
	Phone[callerid][phCalling] = 0;

	new targetid = Phone[phoneid][phCallerPID];
	SendServerMessage(playerid, "Çaðrýyý kapattýnýz.");
	SendServerMessage(targetid, "Çaðrý kapatýldý.");

	Phone[callerid][phInCall] = 0;
	Phone[phoneid][phInCall] = 0;
	Phone[callerid][phCaller] = 0;
	Phone[phoneid][phCaller] = 0;

	InCall[playerid] = 0;
	InCall[targetid] = 0;
	InCall_Line[playerid] = 0;
	InCall_Line[targetid] = 0;
	return true;
}

CMD:sms(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamadý.");

	new phoneid, number, text[124];
	if(sscanf(params, "dds[124]", phoneid, number, text)) return SendServerMessage(playerid, "/sms [telefon id] [numara] [mesaj(124)]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait deðil.");
	if(!IsValidNumber(number)) return SendServerMessage(playerid, "Geçersiz numara girdiniz.");
	if(strlen(text) < 1 || strlen(text) > 124) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");
	
	foreach(new i : Phones) if(Phone[i][phIsValid]) {
		if(Phone[i][phNumber] == number) {
			if(Phone[i][phOwner] == Character[playerid][cID]) {
				return SendServerMessage(playerid, "Kendine mesaj gönderemezsin.");
			}
		}
	}

	new targetid = GetOwnerIDFromNumber(number);
	SendClientMessageEx(targetid, C_PM, "[GELEN SMS: %d] %s", Phone[phoneid][phNumber], text);
	SendClientMessageEx(playerid, C_PM, "[GÝDEN SMS: %d] %s", Phone[phoneid][phNumber], text);
	GiveMoney(playerid, -1*MESSAGE_COST);

	InsertSMSData(playerid, phoneid, text);
	return true;
}