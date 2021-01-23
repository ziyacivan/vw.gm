CMD:banka(playerid, params[])
{
	if(GetBuildingType(playerid) != 5) return SendServerMessage(playerid, "Bankada deðilsiniz.");

	Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yatýr\nPara Çek\nMevduat", "Seç", "Ýptal");
	return true;
}

Dialog:D_BANK(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[%d Numaralý Hesap]__________________", Character[playerid][cBankAccountNo]);
			SendClientMessageEx(playerid, C_GREY1, "Bakiye: $%d", Character[playerid][cBankCash]);
			SendClientMessageEx(playerid, C_GREY1, "Mevduat Oraný: 0.5");
			SendClientMessageEx(playerid, C_GREY1, "Mevduat: $%d", Character[playerid][cBankSaving]);
		}
		case 1: Dialog_Show(playerid, D_DEPOSIT, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Para Yatýr", "{FFFFFF}Hesabýnýza yatýrmak istediðiniz miktarý girin:", "Para Yatýr", "<<");
		case 2: Dialog_Show(playerid, D_WITHDRAW, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Para Çek", "{FFFFFF}Hesabýnýzdan çekmek istediðiniz miktarý girin:", "Para Çek", "<<");
		case 3:
		{
			if(!Character[playerid][cBankSaving])
			{
				Dialog_Show(playerid, D_SAVING, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Mevduat", "{FFFFFF}Bankamýzýn güncel mevduat oraný 0.5 olarak belirlenmiþtir.\n{FFFFFF}Mevduat faizinden yararlanmak istiyorsanýz minimum $25.000 yatýrmalýsýnýz.", "Para Yatýr", "<<");
			}
			else
			{
				new dgstr[124];
				format(dgstr, sizeof(dgstr), "{FFFFFF}Mevduat hesabýnýzda biriken tutar: {268126}$%d\n{FFFFFF}Paranýzý çekmek istiyor musunuz?", Character[playerid][cBankSaving]);
				Dialog_Show(playerid, D_SAVING_DEPOSIT, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Mevduat", dgstr, "Para Çek", "<<");
			}
		}
	}
	return true;
}

Dialog:D_DEPOSIT(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yatýr\nPara Çek\nMevduat", "Seç", "Ýptal");
	if(strval(inputtext) <= 0) return SendServerMessage(playerid, "Yatýrmak istediðiniz tutar minimum $1 olmalýdýr.");
	if(strval(inputtext) > Character[playerid][cMoney]) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

	Character[playerid][cBankCash] += strval(inputtext);
	GiveMoney(playerid, -strval(inputtext));
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%d numaralý hesabýnýza {268126}$%d {9A9B9D}tutarýnda para yatýrdýnýz.", Character[playerid][cBankAccountNo], strval(inputtext));
	return true;
}

Dialog:D_WITHDRAW(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yatýr\nPara Çek\nMevduat", "Seç", "Ýptal");
	if(strval(inputtext) <= 0) return SendServerMessage(playerid, "Çekmek istediðiniz tutar minimum $1 olmalýdýr.");
	if(strval(inputtext) > Character[playerid][cBankCash]) return SendServerMessage(playerid, "Hesabýnýzda bu tutar bulunmamaktadýr.");

	Character[playerid][cBankCash] -= strval(inputtext);
	GiveMoney(playerid, strval(inputtext));
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%d numaralý hesabýnýzdan {268126}$%d {9A9B9D}tutarýnda para çektiniz.", Character[playerid][cBankAccountNo], strval(inputtext));
	return true;
}

Dialog:D_SAVING(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yatýr\nPara Çek\nMevduat", "Seç", "Ýptal");
	if(strval(inputtext) < 25000 || strval(inputtext) > 50000) return SendServerMessage(playerid, "Yatýrabileceðiniz tutarlar, 25.000-50.000");

	Character[playerid][cBankSaving] += strval(inputtext);
	GiveMoney(playerid, -strval(inputtext));
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%d numaralý hesabýnýza {268126}$%d {9A9B9D}mevduat tutarý yatýrdýnýz.", Character[playerid][cBankAccountNo], strval(inputtext));
	return true;
}

Dialog:D_SAVING_DEPOSIT(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yatýr\nPara Çek\nMevduat", "Seç", "Ýptal");

	SendServerMessage(playerid, "%d numaralý hesabýnýzdan {268126}$%d {9A9B9D}mevduat tutarý çektiniz.", Character[playerid][cBankAccountNo], Character[playerid][cBankSaving]);
	GiveMoney(playerid, Character[playerid][cBankSaving]);
	Character[playerid][cBankSaving] = 0;
	SaveCharacterData(playerid);
	return true;
}