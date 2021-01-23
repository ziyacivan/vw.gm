CMD:banka(playerid, params[])
{
	if(GetBuildingType(playerid) != 5) return SendServerMessage(playerid, "Bankada de�ilsiniz.");

	Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yat�r\nPara �ek\nMevduat", "Se�", "�ptal");
	return true;
}

Dialog:D_BANK(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			SendClientMessageEx(playerid, C_DGREEN, "{F0F2A5}__________________[%d Numaral� Hesap]__________________", Character[playerid][cBankAccountNo]);
			SendClientMessageEx(playerid, C_GREY1, "Bakiye: $%d", Character[playerid][cBankCash]);
			SendClientMessageEx(playerid, C_GREY1, "Mevduat Oran�: 0.5");
			SendClientMessageEx(playerid, C_GREY1, "Mevduat: $%d", Character[playerid][cBankSaving]);
		}
		case 1: Dialog_Show(playerid, D_DEPOSIT, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Para Yat�r", "{FFFFFF}Hesab�n�za yat�rmak istedi�iniz miktar� girin:", "Para Yat�r", "<<");
		case 2: Dialog_Show(playerid, D_WITHDRAW, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Para �ek", "{FFFFFF}Hesab�n�zdan �ekmek istedi�iniz miktar� girin:", "Para �ek", "<<");
		case 3:
		{
			if(!Character[playerid][cBankSaving])
			{
				Dialog_Show(playerid, D_SAVING, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Mevduat", "{FFFFFF}Bankam�z�n g�ncel mevduat oran� 0.5 olarak belirlenmi�tir.\n{FFFFFF}Mevduat faizinden yararlanmak istiyorsan�z minimum $25.000 yat�rmal�s�n�z.", "Para Yat�r", "<<");
			}
			else
			{
				new dgstr[124];
				format(dgstr, sizeof(dgstr), "{FFFFFF}Mevduat hesab�n�zda biriken tutar: {268126}$%d\n{FFFFFF}Paran�z� �ekmek istiyor musunuz?", Character[playerid][cBankSaving]);
				Dialog_Show(playerid, D_SAVING_DEPOSIT, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Mevduat", dgstr, "Para �ek", "<<");
			}
		}
	}
	return true;
}

Dialog:D_DEPOSIT(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yat�r\nPara �ek\nMevduat", "Se�", "�ptal");
	if(strval(inputtext) <= 0) return SendServerMessage(playerid, "Yat�rmak istedi�iniz tutar minimum $1 olmal�d�r.");
	if(strval(inputtext) > Character[playerid][cMoney]) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

	Character[playerid][cBankCash] += strval(inputtext);
	GiveMoney(playerid, -strval(inputtext));
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%d numaral� hesab�n�za {268126}$%d {9A9B9D}tutar�nda para yat�rd�n�z.", Character[playerid][cBankAccountNo], strval(inputtext));
	return true;
}

Dialog:D_WITHDRAW(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yat�r\nPara �ek\nMevduat", "Se�", "�ptal");
	if(strval(inputtext) <= 0) return SendServerMessage(playerid, "�ekmek istedi�iniz tutar minimum $1 olmal�d�r.");
	if(strval(inputtext) > Character[playerid][cBankCash]) return SendServerMessage(playerid, "Hesab�n�zda bu tutar bulunmamaktad�r.");

	Character[playerid][cBankCash] -= strval(inputtext);
	GiveMoney(playerid, strval(inputtext));
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%d numaral� hesab�n�zdan {268126}$%d {9A9B9D}tutar�nda para �ektiniz.", Character[playerid][cBankAccountNo], strval(inputtext));
	return true;
}

Dialog:D_SAVING(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yat�r\nPara �ek\nMevduat", "Se�", "�ptal");
	if(strval(inputtext) < 25000 || strval(inputtext) > 50000) return SendServerMessage(playerid, "Yat�rabilece�iniz tutarlar, 25.000-50.000");

	Character[playerid][cBankSaving] += strval(inputtext);
	GiveMoney(playerid, -strval(inputtext));
	SaveCharacterData(playerid);

	SendServerMessage(playerid, "%d numaral� hesab�n�za {268126}$%d {9A9B9D}mevduat tutar� yat�rd�n�z.", Character[playerid][cBankAccountNo], strval(inputtext));
	return true;
}

Dialog:D_SAVING_DEPOSIT(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, D_BANK, DIALOG_STYLE_LIST, "Vinewood Roleplay - Banka", "Hesap Bilgileri\nPara Yat�r\nPara �ek\nMevduat", "Se�", "�ptal");

	SendServerMessage(playerid, "%d numaral� hesab�n�zdan {268126}$%d {9A9B9D}mevduat tutar� �ektiniz.", Character[playerid][cBankAccountNo], Character[playerid][cBankSaving]);
	GiveMoney(playerid, Character[playerid][cBankSaving]);
	Character[playerid][cBankSaving] = 0;
	SaveCharacterData(playerid);
	return true;
}