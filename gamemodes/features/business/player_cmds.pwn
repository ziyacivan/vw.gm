CMD:personelal(playerid, params[])
{
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");
	new bsid = GetBusinessID(playerid);
	if(!IsOwnerBusiness(playerid, bsid)) return SendServerMessage(playerid, "Bu iþyeri size ait deðil.");
	return true;
}

CMD:isyeriliste(playerid, params[])
{
	LoadBusinessList(playerid);
	return true;
}

CMD:isyerikontrol(playerid, params[])
{
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");
	new bsid = GetBusinessID(playerid);
	if(!IsOwnerBusiness(playerid, bsid)) return SendServerMessage(playerid, "Bu iþyeri size ait deðil.");

	SetPVarInt(playerid, "managedbsid", bsid);
	Dialog_Show(playerid, BUSINESS_MANAGE_PANEL, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Paneli", "Ýsim deðiþtir\nTip deðiþtir\nPersoneller\nKasa\n{000000}_\nKilit", "Seç", "Kapat");
	return true;
}

CMD:isyerisatinal(playerid, params[])
{
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");
	
	new bsid = GetBusinessID(playerid);

	if(Business[bsid][bsOwner] != -1) return SendServerMessage(playerid, "Bu iþyeri satýlýk deðil!");
	if(Character[playerid][cMoney] < Business[bsid][bsPrice]) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

	Business[bsid][bsOwner] = Character[playerid][cID];
	RefreshBusiness(bsid);
	GiveMoney(playerid, -Business[bsid][bsPrice]);
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%s isimli iþletmeyi $%d karþýlýðýnda satýn aldýnýz.", Business[bsid][bsName], Business[bsid][bsPrice]);
	return true;
}

CMD:isyerisistemesat(playerid, params[])
{
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");
	new bsid = GetBusinessID(playerid);

	if(Business[bsid][bsOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu iþyeri size ait deðil.");

	new price = Business[bsid][bsPrice] / 2;
	GiveMoney(playerid, price);
	Business[bsid][bsOwner] = -1;
	RefreshBusiness(bsid);
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%s isimli iþletmeyi $%d tutarýnda sisteme sattýnýz.", Business[bsid][bsName], price);
	return true;
}

CMD:isyerisat(playerid, params[])
{
	new targetid, price;
	if(sscanf(params, "ud", targetid, price)) return SendServerMessage(playerid, "/isyerisat [id/isim] [ücret]");
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "Ýþyeri bulunamadý.");
	new bsid = GetBusinessID(playerid);

	if(Business[bsid][bsOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu iþyeri size ait deðil.");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	if(!IsPlayerNearPlayer(playerid, targetid, 3.0)) return SendServerMessage(playerid, "Kiþi yakýnýnýzda deðil.");
	if(price <= 0) return SendServerMessage(playerid, "Minimum ücret $1 olmalýdýr.");
	if(price > Character[targetid][cMoney]) return SendServerMessage(playerid, "Kiþinin yeterli parasý bulunmamaktadýr.");
	if(OfferMode[playerid]) return SendServerMessage(playerid, "Teklif modunda satýþ yapamazsýnýz.");
	if(OfferMode[targetid]) return SendServerMessage(playerid, "Kiþi teklif modunda.");
	if(playerid == targetid) return SendServerMessage(playerid, "Kendinize satýþ yapamazsýnýz.");

	OfferBusinessID[targetid] = bsid;
	OfferBusinessPrice[targetid] = price;
	OfferMode[targetid] = true;
	OfferBSOwnerID[targetid] = playerid;
	OfferMode[playerid] = true;

	SendBusinessOffer(playerid, targetid, bsid, price);
	SendServerMessage(playerid, "%s isimli iþletmenizi %s isimli kiþiye $%d deðerinde satmayý teklif ettiniz.", Business[bsid][bsName], GetRPName(targetid), price);
	return true;
}

CMD:satinal(playerid, params[])
{
	if(!GetBusinessType(playerid)) return SendServerMessage(playerid, "Bir iþyerinde deðilsiniz.");

	switch(GetBusinessType(playerid))
	{
		case 0: return true;
		case 1:
		{
			Dialog_Show(playerid, DIALOG_MARKET, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Market", "{FFFFFF}Sandviç\t{268126}${FFFFFF}5\n{FFFFFF}Sprunk\t{268126}${FFFFFF}10\n{FFFFFF}Maske\t{268126}${FFFFFF}2000\n{FFFFFF}Sopa\t{268126}${FFFFFF}150\n{FFFFFF}Çiçek\t{268126}${FFFFFF}50\n{FFFFFF}Sigara(20 adet)\t{268126}${FFFFFF}7\n{FFFFFF}Çakmak\t{268126}${FFFFFF}5", "Satýn Al", "Kapat");
		}
		case 2:
		{
			Dialog_Show(playerid, DIALOG_WINESTORE, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Ýçki Dükkaný", "{FFFFFF}Yuengling Lager\t{268126}${FFFFFF}2\n{FFFFFF}Pabst Blue Ribbon\t{268126}${FFFFFF}1\n{FFFFFF}Schlitz\t{268126}${FFFFFF}3\n{FFFFFF}Iron City Beer\t{268126}${FFFFFF}5", "Satýn Al", "Kapat");
		}
		case 3:
		{
			Dialog_Show(playerid, DIALOG_PAWNSHOP, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Pawn Shop", "{FFFFFF}Cep Telefonu\t{268126}${FFFFFF}350\n{FFFFFF}Telefon Hattý\t{268126}${FFFFFF}35\n{FFFFFF}Boombox\t{268126}${FFFFFF}100\n{FFFFFF}Alet Çantasý\t{268126}${FFFFFF}75\n{FFFFFF}Maymuncuk\t{268126}${FFFFFF}25", "Satýn Al", "Kapat");
		}
		case 4:
		{
			Dialog_Show(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Restorant", "{FFFFFF}Sandviç\t{268126}${FFFFFF}25\n{FFFFFF}Pizza\t{268126}${FFFFFF}50\n{FFFFFF}Hamburger\t{268126}${FFFFFF}35\n{FFFFFF}Pirzola\t{268126}${FFFFFF}75\n", "Satýn Al", "Kapat");
		}
		case 5:
		{
			Dialog_Show(playerid, DIALOG_BAR, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Bar", "{FFFFFF}Yuengling Lager\t{268126}${FFFFFF}2\n{FFFFFF}Pabst Blue Ribbon\t{268126}${FFFFFF}1\n{FFFFFF}Schlitz\t{268126}${FFFFFF}3\n{FFFFFF}Iron City Beer\t{268126}${FFFFFF}5", "Satýn Al", "Kapat");
		}
		case 10:
		{
			Dialog_Show(playerid, DIALOG_CLOTHSHOP, DIALOG_STYLE_LIST, "Vinewood Roleplay - Kýyafet Dükkaný", "Kýyafetler\nAksesuarlar", "Seç", "Kapat");
		}
	}
	return true;
}

CMD:tamirhane(playerid, params[])
{
	if(!GetGarageOutDoor(playerid)) return SendServerMessage(playerid, "Tamirhane bölgesinde deðilsiniz.");
	if(!GetGarageType(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazsýnýz.");

	Dialog_Show(playerid, DIALOG_GARAGE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Garaj", "Aracý Tamir Et\nModifikasyon", "Seç", "Kapat");
	return true;
}