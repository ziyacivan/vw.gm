CMD:personelal(playerid, params[])
{
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "��yeri bulunamad�.");
	new bsid = GetBusinessID(playerid);
	if(!IsOwnerBusiness(playerid, bsid)) return SendServerMessage(playerid, "Bu i�yeri size ait de�il.");
	return true;
}

CMD:isyeriliste(playerid, params[])
{
	LoadBusinessList(playerid);
	return true;
}

CMD:isyerikontrol(playerid, params[])
{
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "��yeri bulunamad�.");
	new bsid = GetBusinessID(playerid);
	if(!IsOwnerBusiness(playerid, bsid)) return SendServerMessage(playerid, "Bu i�yeri size ait de�il.");

	SetPVarInt(playerid, "managedbsid", bsid);
	Dialog_Show(playerid, BUSINESS_MANAGE_PANEL, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Paneli", "�sim de�i�tir\nTip de�i�tir\nPersoneller\nKasa\n{000000}_\nKilit", "Se�", "Kapat");
	return true;
}

CMD:isyerisatinal(playerid, params[])
{
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "��yeri bulunamad�.");
	
	new bsid = GetBusinessID(playerid);

	if(Business[bsid][bsOwner] != -1) return SendServerMessage(playerid, "Bu i�yeri sat�l�k de�il!");
	if(Character[playerid][cMoney] < Business[bsid][bsPrice]) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

	Business[bsid][bsOwner] = Character[playerid][cID];
	RefreshBusiness(bsid);
	GiveMoney(playerid, -Business[bsid][bsPrice]);
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%s isimli i�letmeyi $%d kar��l���nda sat�n ald�n�z.", Business[bsid][bsName], Business[bsid][bsPrice]);
	return true;
}

CMD:isyerisistemesat(playerid, params[])
{
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "��yeri bulunamad�.");
	new bsid = GetBusinessID(playerid);

	if(Business[bsid][bsOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu i�yeri size ait de�il.");

	new price = Business[bsid][bsPrice] / 2;
	GiveMoney(playerid, price);
	Business[bsid][bsOwner] = -1;
	RefreshBusiness(bsid);
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%s isimli i�letmeyi $%d tutar�nda sisteme satt�n�z.", Business[bsid][bsName], price);
	return true;
}

CMD:isyerisat(playerid, params[])
{
	new targetid, price;
	if(sscanf(params, "ud", targetid, price)) return SendServerMessage(playerid, "/isyerisat [id/isim] [�cret]");
	if(!GetBusinessID(playerid)) return SendServerMessage(playerid, "��yeri bulunamad�.");
	new bsid = GetBusinessID(playerid);

	if(Business[bsid][bsOwner] != Character[playerid][cID]) return SendServerMessage(playerid, "Bu i�yeri size ait de�il.");
	if(!LoggedIn[targetid]) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerConnected(targetid)) return SendServerMessage(playerid, "Ki�i bulunamad�.");
	if(!IsPlayerNearPlayer(playerid, targetid, 3.0)) return SendServerMessage(playerid, "Ki�i yak�n�n�zda de�il.");
	if(price <= 0) return SendServerMessage(playerid, "Minimum �cret $1 olmal�d�r.");
	if(price > Character[targetid][cMoney]) return SendServerMessage(playerid, "Ki�inin yeterli paras� bulunmamaktad�r.");
	if(OfferMode[playerid]) return SendServerMessage(playerid, "Teklif modunda sat�� yapamazs�n�z.");
	if(OfferMode[targetid]) return SendServerMessage(playerid, "Ki�i teklif modunda.");
	if(playerid == targetid) return SendServerMessage(playerid, "Kendinize sat�� yapamazs�n�z.");

	OfferBusinessID[targetid] = bsid;
	OfferBusinessPrice[targetid] = price;
	OfferMode[targetid] = true;
	OfferBSOwnerID[targetid] = playerid;
	OfferMode[playerid] = true;

	SendBusinessOffer(playerid, targetid, bsid, price);
	SendServerMessage(playerid, "%s isimli i�letmenizi %s isimli ki�iye $%d de�erinde satmay� teklif ettiniz.", Business[bsid][bsName], GetRPName(targetid), price);
	return true;
}

CMD:satinal(playerid, params[])
{
	if(!GetBusinessType(playerid)) return SendServerMessage(playerid, "Bir i�yerinde de�ilsiniz.");

	switch(GetBusinessType(playerid))
	{
		case 0: return true;
		case 1:
		{
			Dialog_Show(playerid, DIALOG_MARKET, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Market", "{FFFFFF}Sandvi�\t{268126}${FFFFFF}5\n{FFFFFF}Sprunk\t{268126}${FFFFFF}10\n{FFFFFF}Maske\t{268126}${FFFFFF}2000\n{FFFFFF}Sopa\t{268126}${FFFFFF}150\n{FFFFFF}�i�ek\t{268126}${FFFFFF}50\n{FFFFFF}Sigara(20 adet)\t{268126}${FFFFFF}7\n{FFFFFF}�akmak\t{268126}${FFFFFF}5", "Sat�n Al", "Kapat");
		}
		case 2:
		{
			Dialog_Show(playerid, DIALOG_WINESTORE, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - ��ki D�kkan�", "{FFFFFF}Yuengling Lager\t{268126}${FFFFFF}2\n{FFFFFF}Pabst Blue Ribbon\t{268126}${FFFFFF}1\n{FFFFFF}Schlitz\t{268126}${FFFFFF}3\n{FFFFFF}Iron City Beer\t{268126}${FFFFFF}5", "Sat�n Al", "Kapat");
		}
		case 3:
		{
			Dialog_Show(playerid, DIALOG_PAWNSHOP, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Pawn Shop", "{FFFFFF}Cep Telefonu\t{268126}${FFFFFF}350\n{FFFFFF}Telefon Hatt�\t{268126}${FFFFFF}35\n{FFFFFF}Boombox\t{268126}${FFFFFF}100\n{FFFFFF}Alet �antas�\t{268126}${FFFFFF}75\n{FFFFFF}Maymuncuk\t{268126}${FFFFFF}25", "Sat�n Al", "Kapat");
		}
		case 4:
		{
			Dialog_Show(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Restorant", "{FFFFFF}Sandvi�\t{268126}${FFFFFF}25\n{FFFFFF}Pizza\t{268126}${FFFFFF}50\n{FFFFFF}Hamburger\t{268126}${FFFFFF}35\n{FFFFFF}Pirzola\t{268126}${FFFFFF}75\n", "Sat�n Al", "Kapat");
		}
		case 5:
		{
			Dialog_Show(playerid, DIALOG_BAR, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Bar", "{FFFFFF}Yuengling Lager\t{268126}${FFFFFF}2\n{FFFFFF}Pabst Blue Ribbon\t{268126}${FFFFFF}1\n{FFFFFF}Schlitz\t{268126}${FFFFFF}3\n{FFFFFF}Iron City Beer\t{268126}${FFFFFF}5", "Sat�n Al", "Kapat");
		}
		case 10:
		{
			Dialog_Show(playerid, DIALOG_CLOTHSHOP, DIALOG_STYLE_LIST, "Vinewood Roleplay - K�yafet D�kkan�", "K�yafetler\nAksesuarlar", "Se�", "Kapat");
		}
	}
	return true;
}

CMD:tamirhane(playerid, params[])
{
	if(!GetGarageOutDoor(playerid)) return SendServerMessage(playerid, "Tamirhane b�lgesinde de�ilsiniz.");
	if(!GetGarageType(playerid)) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	Dialog_Show(playerid, DIALOG_GARAGE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Garaj", "Arac� Tamir Et\nModifikasyon", "Se�", "Kapat");
	return true;
}