CMD:sorusor(playerid, params[])
{
	new ask[124];
	if(sscanf(params, "s[124]", ask)) return SendServerMessage(playerid, "/sorusor [i�erik(124)]");
	if(Character[playerid][cAsked] == true) return SendServerMessage(playerid, "Bekleyen bir sorunuz bulunmaktad�r.");

	Character[playerid][cAsked] = true;
	format(Character[playerid][cAskContent], 124, "%s", ask);

	SendTesterMessage(C_ADMIN, "[ID: %d] Soru: %s isimli oyuncu bir soru sordu.", playerid, Character[playerid][cName]);
	SendTesterMessage(C_ADMIN, "Soru ��eri�i: %s", Character[playerid][cAskContent]);

	SendServerMessage(playerid, "M�sait tester ekibi �yelerine sorunuz iletildi.");
	return true;
}

CMD:soruiptal(playerid, params[])
{
	if(!Character[playerid][cAsked]) return SendServerMessage(playerid, "Sorunuz bulunmamaktad�r.");

	Character[playerid][cAsked] = false;
	format(Character[playerid][cAskContent], 124, "Bu soru iptal edildi.");

	SendTesterMessage(C_ADMIN, "[ID: %d] %s isimli oyuncu sorusunu iptal etti.", playerid, Character[playerid][cName]);

	SendServerMessage(playerid, "Sorunuz iptal edildi.");
	return true;
}

CMD:sorucevap(playerid, params[])
{
	if(!Character[playerid][cAdmin]) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");
	new id, answer[124];
	if(sscanf(params, "us[124]", id, answer)) return SendServerMessage(playerid, "/sorucevap [id/isim] [cevap(124)]");
	if(!LoggedIn[id]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!Character[id][cAsked]) return SendServerMessage(playerid, "Ki�inin sorusu bulunmamaktad�r.");

	SendClientMessageEx(id, C_GREY1, "Sorunuz %s taraf�ndan kabul edildi.", Character[playerid][cNickname]);
	SendClientMessageEx(id, C_GREY1, "Cevap: %s", answer);

	Character[id][cAsked] = false;
	format(Character[id][cAskContent], 124, "Bu soru %s taraf�ndan yan�tland�.", Character[playerid][cNickname]);

	SendServerMessage(playerid, "%s isimli oyuncunun sorusunu yan�tlad�n�z.", Character[id][cName]);
	return true;
}

CMD:sorureddet(playerid, params[])
{
	if(!Character[playerid][cAdmin]) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktad�r.");
	new id;
	if(sscanf(params, "u", id)) return SendServerMessage(playerid, "/sorureddet [id/isim]");
	if(!LoggedIn[id]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!Character[id][cAsked]) return SendServerMessage(playerid, "Ki�inin sorusu bulunmamaktad�r.");

	SendClientMessageEx(id, C_GREY1, "Sorunuz %s taraf�ndan reddedildi.", Character[playerid][cNickname]);

	Character[id][cAsked] = false;
	format(Character[id][cAskContent], 124, "Bu soru %s taraf�ndan reddedildi.", Character[playerid][cNickname]);

	SendServerMessage(playerid, "%s isimli oyuncunun sorusunu reddettiniz.", Character[id][cName]);
	return true;
}