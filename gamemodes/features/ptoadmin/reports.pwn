CMD:rapor(playerid, params[])
{
	new content[124];
	if(sscanf(params, "s[124]", content)) return SendServerMessage(playerid, "/rapor [i�erik(124)]");
	if(Character[playerid][cReported] == true) return SendServerMessage(playerid, "Bekleyen bir raporunuz bulunmaktad�r.");

	Character[playerid][cReported] = true;
	format(Character[playerid][cReportContent], 124, "%s", content);

	SendAdminMessage(C_ADMIN, "[ID: %d] Rapor: %s isimli oyuncu bir rapor g�nderdi.", playerid, Character[playerid][cName]);
	SendAdminMessage(C_ADMIN, "Rapor ��eri�i: %s", content);

	SendServerMessage(playerid, "M�sait y�netim ekibi �yelerine raporunuz g�nderildi.");
	return true;
}

CMD:raporiptal(playerid, params[])
{
	if(!Character[playerid][cReported]) return SendServerMessage(playerid, "Bekleyen raporunuz bulunmamaktad�r.");

	Character[playerid][cReported] = false;
	format(Character[playerid][cReportContent], 124, "Bu rapor iptal edildi.");

	SendAdminMessage(C_ADMIN, "[ID: %d] %s isimli oyuncu raporunu iptal etti.", playerid, Character[playerid][cName]);

	SendServerMessage(playerid, "Raporunuz iptal edildi.");
	return true;
}

CMD:raporkabul(playerid, params[])
{
	if(Character[playerid][cAdmin] < 2) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");

	new id, answer[124];
	if(sscanf(params, "us[124]", id, answer)) return SendServerMessage(playerid, "/raporkabul [id/isim] [cevap(124)]");
	if(!LoggedIn[id]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!Character[id][cReported]) return SendServerMessage(playerid, "Rapor bulunamad�.");

	SendClientMessageEx(id, C_GREY1, "%s taraf�ndan raporunuz kabul edildi.", Character[playerid][cNickname]);
	SendClientMessageEx(id, C_GREY1, "Cevap: %s", answer);

	Character[id][cReported] = false;
	format(Character[id][cReportContent], 124, "Bu rapor %s taraf�ndan kabul edildi.", Character[playerid][cNickname]);

	SendServerMessage(playerid, "%s isimli oyuncunun raporunu kabul ettiniz.", Character[id][cName]);
	return true;
}

CMD:raporreddet(playerid, params[])
{
	if(Character[playerid][cAdmin] < 2) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");

	new id;
	if(sscanf(params, "u", id)) return SendServerMessage(playerid, "/raporreddet [id/isim]");
	if(!LoggedIn[id]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!Character[id][cReported]) return SendServerMessage(playerid, "Rapor bulunamad�.");

	SendClientMessageEx(id, C_GREY1, "%s taraf�ndan raporunuz reddedildi.", Character[playerid][cNickname]);

	Character[id][cReported] = false;
	format(Character[id][cReportContent], 124, "Bu rapor %s taraf�ndan reddedildi.", Character[playerid][cNickname]);

	SendServerMessage(playerid, "%s isimli oyuncunun raporunu reddettiniz.", Character[id][cName]);
	return true;
}