CMD:haber(playerid, params[])
{
	if(GetFactionType(playerid) != 4) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	if(!IsValidVehicle(playerid)) return SendServerMessage(playerid, "Araç içerisinde olmalýsýnýz.");

	new vehid = GetPlayerVehicleID(playerid);
	new factid = GetPlayerFactionID(playerid);
	if(Vehicle[vehid][vFaction] != Character[playerid][cFaction]) return SendServerMessage(playerid, "Bu araç oluþumunuza ait deðil.");

	new text[144];
	if(sscanf(params, "s[144]", text)) return SendServerMessage(playerid, "/haber [yayýn içeriði(144)]");
	if(strlen(text) < 5 || strlen(text) > 144) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");

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
	if(GetFactionType(playerid) != 4) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");

	switch(Interview[playerid])
	{
		case 0: SendAllMessage(C_NEWS, "[%s - Canlý Yayýn] canlý yayýna baþladý.", GetRPName(playerid)), Interview[playerid] = 1;
		case 1: SendAllMessage(C_NEWS, "[%s - Canlý Yayýn] canlý yayýndan çýktý.", GetRPName(playerid)), Interview[playerid] = 0;
	}
	return true;
}

CMD:yayindavetet(playerid, params[])
{
	if(GetFactionType(playerid) != 4) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	if(!Interview[playerid]) return SendServerMessage(playerid, "Öncelikle canlý yayýn baþlatmalýsýnýz.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/yayindavetet [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(playerid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendServerMessage(playerid, "Kiþi yakýnýnýzda deðil.");
	if(InterviewInvite[targetid]) return SendServerMessage(playerid, "Kiþi bir davet ekranýnda.");
	if(InterviewGuest[targetid]) return SendServerMessage(playerid, "Kiþi þu anda konuk durumundadýr.");

	SendServerMessage(targetid, "%s tarafýndan canlý yayýna davet edildiniz. (/davetkabul - /davetreddet)", GetRPName(playerid));
	SendServerMessage(playerid, "%s isimli kiþiyi canlý yayýna davet ettiniz.", GetRPName(targetid));

	InterviewInvite[targetid] = 1;
	InterviewServer[targetid] = playerid;
	return true;
}

CMD:yayindancikart(playerid, params[])
{
	if(GetFactionType(playerid) != 4) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");
	if(!Interview[playerid]) return SendServerMessage(playerid, "Öncelikle canlý yayýn baþlatmalýsýnýz.");

	new targetid;
	if(sscanf(params, "u", targetid)) return SendServerMessage(playerid, "/yayindancikart [id/isim]");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(playerid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerNearPlayer(playerid, targetid, 5.0)) return SendServerMessage(playerid, "Kiþi yakýnýnýzda deðil.");
	if(InterviewInvite[targetid]) return SendServerMessage(playerid, "Kiþi bir davet ekranýnda.");
	if(!InterviewGuest[targetid]) return SendServerMessage(playerid, "Kiþi konuðunuz deðil.");

	SendServerMessage(targetid, "%s tarafýndan canlý yayýndan çýkartýldýnýz.", GetRPName(playerid));
	SendServerMessage(playerid, "%s canlý yayýndan çýkartýldý.", GetRPName(playerid));

	InterviewInvite[targetid] = 0;
	InterviewServer[targetid] = -1;
	InterviewGuest[targetid] = 0;
	return true;
}

CMD:davetkabul(playerid, params[])
{
	if(InterviewGuest[playerid]) return SendServerMessage(playerid, "Konuk durumundayken baþka bir canlý yayýn teklifini kabul edemezsiniz.");
	if(!InterviewInvite[playerid]) return SendServerMessage(playerid, "Canlý yayýna davetli deðilsiniz.");

	InterviewGuest[playerid] = 1;
	SendServerMessage(playerid, "Daveti kabul ettiniz, þuan mikrofon açýk durumdadýr.");
	SendServerMessage(InterviewServer[playerid], "%s tarafýndan davetiniz kabul edildi.", GetRPName(playerid));
	return true;
}

CMD:davetreddet(playerid, params[])
{
	if(!InterviewInvite[playerid]) return SendServerMessage(playerid, "Herhangi bir teklif almadýnýz.");

	SendServerMessage(playerid, "Daveti reddettiniz.");
	SendServerMessage(InterviewServer[playerid], "%s tarafýndan davetiniz reddedildi.", GetRPName(playerid));
	InterviewInvite[playerid] = 0;
	InterviewServer[playerid] = -1;
	InterviewGuest[playerid] = 0;
	return true;
}