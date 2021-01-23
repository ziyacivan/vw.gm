CMD:haber(playerid, params[])
{
	if(GetFactionType(playerid) != 4) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!IsValidVehicle(playerid)) return SendServerMessage(playerid, "Ara� i�erisinde olmal�s�n�z.");

	new vehid = GetPlayerVehicleID(playerid);
	new factid = GetPlayerFactionID(playerid);
	if(Vehicle[vehid][vFaction] != Character[playerid][cFaction]) return SendServerMessage(playerid, "Bu ara� olu�umunuza ait de�il.");

	new text[144];
	if(sscanf(params, "s[144]", text)) return SendServerMessage(playerid, "/haber [yay�n i�eri�i(144)]");
	if(strlen(text) < 5 || strlen(text) > 144) return SendServerMessage(playerid, "Ge�ersiz karakter say�s� girdiniz.");

	if(strlen(text) > 84)
	{
		SendAllMessage(C_NEWS, "[%s - Haber] %s: %.84s", Faction[factid][fName], GetRPName(playerid), text);
		SendAllMessage(C_NEWS, "[%s - Haber] %s: ... %s", Faction[factid][fName], GetRPName(playerid), text[84]);
	}
	else
	{
		SendAllMessage(C_NEWS, "[%s - Haber] %s: %s", Faction[factid][fName], GetRPName(playerid), text);
	}
	return true;
}

CMD:canliyayin(playerid, params[])
{
	if(GetFactionType(playerid) != 4) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	switch(Interview[playerid])
	{
		case 0: SendAllMessage(C_NEWS, "[%s - Canl� Yay�n] canl� yay�na ba�lad�.", GetRPName(playerid)), Interview[playerid] = 1;
		case 1: SendAllMessage(C_NEWS, "[%s - Canl� Yay�n] canl� yay�ndan ��kt�.", GetRPName(playerid)), Interview[playerid] = 0;
	}
	return true;
}

CMD:yayindavetet(playerid, params[])
{
	if(GetFactionType(playerid) != 4) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!Interview[playerid]) return SendServerMessage(playerid, "�ncelikle canl� yay�n ba�latmal�s�n�z.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/yayindavetet [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(playerid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendServerMessage(playerid, "Ki�i yak�n�n�zda de�il.");
	if(InterviewInvite[targetid]) return SendServerMessage(playerid, "Ki�i bir davet ekran�nda.");
	if(InterviewGuest[targetid]) return SendServerMessage(playerid, "Ki�i �u anda konuk durumundad�r.");

	SendServerMessage(targetid, "%s taraf�ndan canl� yay�na davet edildiniz. (/davetkabul - /davetreddet)", GetRPName(playerid));
	SendServerMessage(playerid, "%s isimli ki�iyi canl� yay�na davet ettiniz.", GetRPName(targetid));

	InterviewInvite[targetid] = 1;
	InterviewServer[targetid] = playerid;
	return true;
}

CMD:yayindancikart(playerid, params[])
{
	if(GetFactionType(playerid) != 4) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");
	if(!Interview[playerid]) return SendServerMessage(playerid, "�ncelikle canl� yay�n ba�latmal�s�n�z.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/yayindancikart [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(playerid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendServerMessage(playerid, "Ki�i yak�n�n�zda de�il.");
	if(InterviewInvite[targetid]) return SendServerMessage(playerid, "Ki�i bir davet ekran�nda.");
	if(!InterviewGuest[targetid]) return SendServerMessage(playerid, "Ki�i konu�unuz de�il.");

	SendServerMessage(targetid, "%s taraf�ndan canl� yay�ndan ��kart�ld�n�z.", GetRPName(playerid));
	SendServerMessage(playerid, "%s canl� yay�ndan ��kart�ld�.", GetRPName(playerid));

	InterviewInvite[targetid] = 0;
	InterviewServer[targetid] = -1;
	InterviewGuest[targetid] = 0;
	return true;
}

CMD:davetkabul(playerid, params[])
{
	if(InterviewGuest[playerid]) return SendServerMessage(playerid, "Konuk durumundayken ba�ka bir canl� yay�n teklifini kabul edemezsiniz.");
	if(!InterviewInvite[playerid]) return SendServerMessage(playerid, "Canl� yay�na davetli de�ilsiniz.");

	InterviewGuest[playerid] = 1;
	SendServerMessage(playerid, "Daveti kabul ettiniz, �uan mikrofon a��k durumdad�r.");
	SendServerMessage(InterviewServer[playerid], "%s taraf�ndan davetiniz kabul edildi.", GetRPName(playerid));
	return true;
}

CMD:davetreddet(playerid, params[])
{
	if(!InterviewInvite[playerid]) return SendServerMessage(playerid, "Herhangi bir teklif almad�n�z.");

	SendServerMessage(playerid, "Daveti reddettiniz.");
	SendServerMessage(InterviewServer[playerid], "%s taraf�ndan davetiniz reddedildi.", GetRPName(playerid));
	InterviewInvite[playerid] = 0;
	InterviewServer[playerid] = -1;
	InterviewGuest[playerid] = 0;
	return true;
}