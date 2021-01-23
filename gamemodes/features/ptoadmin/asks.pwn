CMD:sorusor(playerid, params[])
{
	new ask[124];
	if(sscanf(params, "s[124]", ask)) return SendServerMessage(playerid, "/sorusor [içerik(124)]");
	if(Character[playerid][cAsked] == true) return SendServerMessage(playerid, "Bekleyen bir sorunuz bulunmaktadýr.");

	Character[playerid][cAsked] = true;
	format(Character[playerid][cAskContent], 124, "%s", ask);

	SendTesterMessage(C_ADMIN, "[ID: %d] Soru: %s isimli oyuncu bir soru sordu.", playerid, Character[playerid][cName]);
	SendTesterMessage(C_ADMIN, "Soru Ýçeriði: %s", Character[playerid][cAskContent]);

	SendServerMessage(playerid, "Müsait tester ekibi üyelerine sorunuz iletildi.");
	return true;
}

CMD:soruiptal(playerid, params[])
{
	if(!Character[playerid][cAsked]) return SendServerMessage(playerid, "Sorunuz bulunmamaktadýr.");

	Character[playerid][cAsked] = false;
	format(Character[playerid][cAskContent], 124, "Bu soru iptal edildi.");

	SendTesterMessage(C_ADMIN, "[ID: %d] %s isimli oyuncu sorusunu iptal etti.", playerid, Character[playerid][cName]);

	SendServerMessage(playerid, "Sorunuz iptal edildi.");
	return true;
}

CMD:sorucevap(playerid, params[])
{
	if(!Character[playerid][cAdmin]) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new id, answer[124];
	if(sscanf(params, "us[124]", id, answer)) return SendServerMessage(playerid, "/sorucevap [id/isim] [cevap(124)]");
	if(!LoggedIn[id]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!Character[id][cAsked]) return SendServerMessage(playerid, "Kiþinin sorusu bulunmamaktadýr.");

	SendClientMessageEx(id, C_GREY1, "Sorunuz %s tarafýndan kabul edildi.", Character[playerid][cNickname]);
	SendClientMessageEx(id, C_GREY1, "Cevap: %s", answer);

	Character[id][cAsked] = false;
	format(Character[id][cAskContent], 124, "Bu soru %s tarafýndan yanýtlandý.", Character[playerid][cNickname]);

	SendServerMessage(playerid, "%s isimli oyuncunun sorusunu yanýtladýnýz.", Character[id][cName]);
	return true;
}

CMD:sorureddet(playerid, params[])
{
	if(!Character[playerid][cAdmin]) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new id;
	if(sscanf(params, "u", id)) return SendServerMessage(playerid, "/sorureddet [id/isim]");
	if(!LoggedIn[id]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!Character[id][cAsked]) return SendServerMessage(playerid, "Kiþinin sorusu bulunmamaktadýr.");

	SendClientMessageEx(id, C_GREY1, "Sorunuz %s tarafýndan reddedildi.", Character[playerid][cNickname]);

	Character[id][cAsked] = false;
	format(Character[id][cAskContent], 124, "Bu soru %s tarafýndan reddedildi.", Character[playerid][cNickname]);

	SendServerMessage(playerid, "%s isimli oyuncunun sorusunu reddettiniz.", Character[id][cName]);
	return true;
}