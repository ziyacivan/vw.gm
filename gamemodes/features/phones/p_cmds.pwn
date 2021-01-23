CMD:telefonliste(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	PhoneList(playerid, playerid);
	return true;
}

CMD:telefon(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	new phoneid;
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/telefon [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait de�il.");

	Character[playerid][cPhoneID] = phoneid;
	Phone[phoneid][phStatus] = 1;

	Dialog_Show(playerid, DIALOG_PHONE, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Telefon", "Gelen Kutusu\nGiden Kutusu\nSon Aramalar\nRehber\n{000000}_\nTelefonu Kapat", "Se�", "Kapat");
	return true;
}

CMD:telefonat(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	new phoneid, Float:x, Float:y, Float:z, int, vw;
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/telefon [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait de�il.");

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
	SendServerMessage(playerid, "%d numaral� telefonu yere b�rakt�n�z.", phoneid);
	return true;
}

CMD:telefonal(playerid, params[])
{
	if(!GetClosestPhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	new phoneid = GetClosestPhone(playerid);

	Phone[phoneid][phOnTheGround] = 0;
	Phone[phoneid][phOwner] = Character[playerid][cID];
	DestroyDynamicObject(Phone[phoneid][phTempObject]);
	RefreshPhone(phoneid);

	SendServerMessage(playerid, "%d numaral� telefonu yerden ald�n�z.", phoneid);
	return true;
}

CMD:ara(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	new phoneid, number;
	if(sscanf(params, "dd", phoneid, number)) return SendServerMessage(playerid, "/ara [telefon id] [numara]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait de�il.");
	if(!IsValidNumber(number)) return SendServerMessage(playerid, "Girilen numara ge�ersiz.");
	new callin_phoneid = GetPhoneIDFromNumber(number);
	if(Phone[callin_phoneid][phInCall]) return SendServerMessage(playerid, "Arad���n�z numara me�gul.");
	if(Phone[callin_phoneid][phCalling]) return SendServerMessage(playerid, "Arad���n�z numara me�gul.");

	foreach(new i : Phones) if(Phone[i][phIsValid]) {
		if(Phone[i][phNumber] == number) {
			if(Phone[i][phOwner] == Character[playerid][cID]) {
				return SendServerMessage(playerid, "Kendini arayamazs�n.");
			}
		}
	}	

	Character[playerid][cPhoneID] = phoneid;

	if(Phone[phoneid][phInCall]) return SendServerMessage(playerid, "�uan ba�ka bir �a�r�das�n�z.");
	if(Phone[phoneid][phCalling]) return SendServerMessage(playerid, "�uan ba�ka bir �a�r�das�n�z.");

	if(number == 911)
	{
		Phone[phoneid][phCalling] = 1;
		Dialog_Show(playerid, DIALOG_911_1, DIALOG_STYLE_INPUT, "Vinewood - 911 Hatt� [#1]", "Operat�r: 911 �a�r� hatt�, kullanmak istedi�iniz servis? (LSPD/LSFD/LSMD)", "Devam Et", "Kapat");	
	}
	else
	{
		if(!Phone[callin_phoneid][phStatus]) return SendServerMessage(playerid, "Arad���n�z ki�iye ula��lam�yor.");
		
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
					SendClientMessageEx(i, C_EMOTE, "* �almaktad�r. (( Telefon %d ))", callin_phoneid);
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

					SendNearbyMessage(i, 10.0, C_EMOTE, "* �almaktad�r. (( Telefon %d ))", callin_phoneid);
					SendClientMessageEx(i, C_GREY1, "Telefonunuz �almaktad�r, /cagrikabul %d ya da /cagrireddet %d.", callin_phoneid, callin_phoneid);
				}
			}
		}
		SendServerMessage(playerid, "%d numaral� telefonu ar�yorsunuz...", number);
	}
	return true;
}

CMD:cagrikabul(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	new phoneid;
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/cagrikabul [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait de�il.");
	if(Phone[phoneid][phInCall]) return SendServerMessage(playerid, "Bu telefonla �uan bir �a�r�das�n�z.");
	if(!Phone[phoneid][phCalling]) return SendServerMessage(playerid, "Bu telefon �alm�yor."); 

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

	SendServerMessage(playerid, "�a�r�y� kabul ettiniz, konu�abilirsiniz.");
	SendServerMessage(targetid, "�a�r�n�z a��ld�, konu�abilirsiniz.");

	Phone[callerid][phCaller] = 0;
	return true;
}

CMD:cagrireddet(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	new phoneid;
	
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/cagrireddet [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait de�il.");
	if(Phone[phoneid][phInCall] == 0) return SendServerMessage(playerid, "Bu telefon �a�r�da de�il.");
	if(!Phone[phoneid][phCalling]) return SendServerMessage(playerid, "Bu telefon �alm�yor.");

	new callerid = Phone[phoneid][phCaller];

	Phone[phoneid][phCalling] = 0;
	Phone[callerid][phCalling] = 0;

	new targetid = Phone[phoneid][phCallerPID];
	SendServerMessage(playerid, "�a�r�y� reddettiniz.");
	SendServerMessage(targetid, "�a�r�n�z reddedildi.");

	Phone[callerid][phInCall] = 0;
	Phone[phoneid][phInCall] = 0;
	Phone[callerid][phCaller] = 0;
	Phone[phoneid][phCaller] = 0;
	return true;
}

CMD:cagrikapat(playerid, params[])
{
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	new phoneid;
	if(sscanf(params, "d", phoneid)) return SendServerMessage(playerid, "/cagrikapat [telefon id]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait de�il.");
	if(!Phone[phoneid][phInCall]) return SendServerMessage(playerid, "Bu telefon �a�r�da de�il.");
	if(!InCall[playerid]) return SendServerMessage(playerid, "�a�r�da de�ilsiniz.");

	new callerid = Phone[phoneid][phCaller];

	Phone[phoneid][phCalling] = 0;
	Phone[callerid][phCalling] = 0;

	new targetid = Phone[phoneid][phCallerPID];
	SendServerMessage(playerid, "�a�r�y� kapatt�n�z.");
	SendServerMessage(targetid, "�a�r� kapat�ld�.");

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
	if(!IsHavePhone(playerid)) return SendServerMessage(playerid, "Telefon bulunamad�.");

	new phoneid, number, text[124];
	if(sscanf(params, "dds[124]", phoneid, number, text)) return SendServerMessage(playerid, "/sms [telefon id] [numara] [mesaj(124)]");
	if(!IsOwnerPhone(playerid, phoneid)) return SendServerMessage(playerid, "Bu telefon size ait de�il.");
	if(!IsValidNumber(number)) return SendServerMessage(playerid, "Ge�ersiz numara girdiniz.");
	if(strlen(text) < 1 || strlen(text) > 124) return SendServerMessage(playerid, "Ge�ersiz karakter say�s� girdiniz.");
	
	foreach(new i : Phones) if(Phone[i][phIsValid]) {
		if(Phone[i][phNumber] == number) {
			if(Phone[i][phOwner] == Character[playerid][cID]) {
				return SendServerMessage(playerid, "Kendine mesaj g�nderemezsin.");
			}
		}
	}

	new targetid = GetOwnerIDFromNumber(number);
	SendClientMessageEx(targetid, C_PM, "[GELEN SMS: %d] %s", Phone[phoneid][phNumber], text);
	SendClientMessageEx(playerid, C_PM, "[G�DEN SMS: %d] %s", Phone[phoneid][phNumber], text);
	GiveMoney(playerid, -1*MESSAGE_COST);

	InsertSMSData(playerid, phoneid, text);
	return true;
}