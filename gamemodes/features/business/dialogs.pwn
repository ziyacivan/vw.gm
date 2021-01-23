Dialog:DIALOG_MARKET(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cMoney] < 5) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			new Float:health;
			GetPlayerHealth(playerid, health);
			if(health >= 100.0) return SendServerMessage(playerid, "Karn�n�z yeterince doydu.");

			GiveMoney(playerid, -5);
			GivePlayerHealth(playerid, 10);
			SendServerMessage(playerid, "Sandvi� ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 5;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 10) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			new Float:health;
			GetPlayerHealth(playerid, health);
			if(health >= 100.0) return SendServerMessage(playerid, "Karn�n�z yeterince doydu.");

			GiveMoney(playerid, -10);
			GivePlayerHealth(playerid, 10);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
			SendServerMessage(playerid, "Sprunk ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 10;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 2000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(HaveMask[playerid]) return SendServerMessage(playerid, "Maskeniz bulunmaktad�r.");

			GiveMoney(playerid, -2000);
			HaveMask[playerid] = 1;
			SendServerMessage(playerid, "Maske ald�n�z, /maske ile takabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 2000;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 150) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(HaveBat[playerid]) return SendServerMessage(playerid, "Sopan�z bulunmaktad�r.");

			GiveMoney(playerid, -150);
			HaveBat[playerid] = 1;
			SendServerMessage(playerid, "Sopa ald�n�z, /sopa ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 150;
			RefreshBusiness(bsid);
		}
		case 4:
		{
			if(Character[playerid][cMoney] < 50) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(HaveFlower[playerid]) return SendServerMessage(playerid, "�i�e�iniz bulunmaktad�r.");

			HaveFlower[playerid] = 1;
			GiveMoney(playerid, -50);
			SendServerMessage(playerid, "�i�ek ald�n�z, /cicek ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 50;
			RefreshBusiness(bsid);
		}
		case 5:
		{
			if(Character[playerid][cMoney] < 7) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -7);
			Character[playerid][cCigaratte] += 20;
			SendServerMessage(playerid, "Sigara ald�n�z, /sigara ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 7;
			RefreshBusiness(bsid);
		}
		case 6:
		{
			if(Character[playerid][cMoney] < 5) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(Character[playerid][cLighter]) return SendServerMessage(playerid, "�akma��n�z bulunmaktad�r.");

			GiveMoney(playerid, -5);
			Character[playerid][cLighter] = 1;
			SendServerMessage(playerid, "�akmak ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 5;
			RefreshBusiness(bsid);
		}
	}
	return true;
}

Dialog:DIALOG_BAR(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cMoney] < 2) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -2);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet i�ki ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 2;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 1) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet i�ki ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 1;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 3) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -3);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet i�ki ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 3;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 5) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -5);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet i�ki ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 5;
			RefreshBusiness(bsid);
		}
	}
	return true;
}

Dialog:DIALOG_WINESTORE(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cMoney] < 2) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -2);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet i�ki ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 2;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 1) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet i�ki ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 1;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 3) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -3);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet i�ki ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 3;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 5) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

			GiveMoney(playerid, -5);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet i�ki ald�n�z.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 5;
			RefreshBusiness(bsid);
		}
	}
	return true;
}

Dialog:DIALOG_PAWNSHOP(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cMoney] < 350) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmaktad�r.");

			Character[playerid][cPhone] = 1;
			GiveMoney(playerid, -350);
			SendServerMessage(playerid, "Telefon sat�n ald�n�z.");
			SaveCharacterData(playerid);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 350;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 35) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hatt�n�z bulunmaktad�r.");

			new number = randomEx(111111, 999999);
			GiveMoney(playerid, -35);
			Character[playerid][cPhoneNumber] = number;
			SendServerMessage(playerid, "Bir hat sat�n ald�n�z.");
			SaveCharacterData(playerid);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 35;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 100) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(Character[playerid][cBoombox]) return SendServerMessage(playerid, "Boomboxunuz bulunmaktad�r.");

			GiveMoney(playerid, -100);
			Character[playerid][cBoombox] = 1;
			SendServerMessage(playerid, "Boombox sat�n ald�n�z, /boombox ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 100;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 75) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(Character[playerid][cToolkit]) return SendServerMessage(playerid, "Alet �antan�z bulunmaktad�r.");

			GiveMoney(playerid, -75);
			Character[playerid][cToolkit] = 1;
			SendServerMessage(playerid, "Alet �antas� sat�n ald�n�z, /toolkit ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 75;
			RefreshBusiness(bsid);
		}
		case 4:
		{
			if(Character[playerid][cMoney] < 25) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");
			if(Character[playerid][cSkeletonKey]) return SendServerMessage(playerid, "Maymuncu�unuz bulunmaktad�r.");

			GiveMoney(playerid, -25);
			Character[playerid][cSkeletonKey] = 1;
			SendServerMessage(playerid, "Maymuncuk sat�n ald�n�z, /maymuncuk ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 25;
			RefreshBusiness(bsid);
		}
	}
	return true;
}

Dialog:DIALOG_RESTAURANT(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new Float:pHealth;

	GetPlayerHealth(playerid, pHealth);

	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cMoney] < 25) return SendServerMessage(playerid, "Yeteri kadar paran�z yok.");

			GivePlayerHealth(playerid, 15.0);
			GiveMoney(playerid, -1*25);
			SendClientMessage(playerid, C_VINEWOOD, "Sanvdi� yedin.");
			if(pHealth + 15.0 >= 100) SetPlayerHealth(playerid, 100.0);
			ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 25;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 50) return SendServerMessage(playerid, "Yeteri kadar paran�z yok.");

			GivePlayerHealth(playerid, 20.0);
			GiveMoney(playerid, -1*50);
			SendClientMessage(playerid, C_VINEWOOD, "Pizza yedin.");
			if(pHealth + 20.0 >= 100) SetPlayerHealth(playerid, 100.0);
			ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 50;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 35) return SendServerMessage(playerid, "Yeteri kadar paran�z yok.");

			GivePlayerHealth(playerid, 17.0);
			GiveMoney(playerid, -1*35);
			SendClientMessage(playerid, C_VINEWOOD, "Hamburger yedin.");
			if(pHealth + 17.0 >= 100) SetPlayerHealth(playerid, 100.0);
			ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 35;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 75) return SendServerMessage(playerid, "Yeteri kadar paran�z yok.");

			GivePlayerHealth(playerid, 25.0);
			GiveMoney(playerid, -1*75);
			SendClientMessage(playerid, C_VINEWOOD, "Pirzola yedin.");
			if(pHealth + 25.0 > 100) SetPlayerHealth(playerid, 100.0);
			ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 75;
			RefreshBusiness(bsid);
		}		
	}
	return true;
}

Dialog:BUSINESS_MANAGE_PANEL(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new bsid = GetPVarInt(playerid, "managedbsid");

	switch(listitem)
	{
		case 0: // isim de�i�tirme
		{
			Dialog_Show(playerid, BUSINESS_CHANGE_NAME, DIALOG_STYLE_INPUT, "Vinewood Roleplay - ��letme Kontrol Ekran�", "{FFFFFF}De�i�tirmek istedi�iniz yeni ismi girin:", "Devam", "<<");
		}
		case 1: // tip de�i�tirme
		{
			Dialog_Show(playerid, BUSINESS_CHANGE_TYPE, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Ekran�", "Market\n��ki D�kkan�\nPawn Shop\nRestaurant\nBar/Gece Kul�b�\nTamirhane\nSpor Salonu\nKumarhane\nSilah D�kkan�\nK�yafet D�kkan�", "Se�", "<<");
		}
		case 2: // personeller
		{
			new str[1044];
			for(new i; i < 10; i++)
			{
				format(str, sizeof str, "%s%s", str, GetNameFromSQLID(Business[bsid][bsWorkers][i]));
			}
			Dialog_Show(playerid, BUSINESS_STAFF_LIST, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Ekran�", str, "Se�", "Kapat");
		}
		case 3: // kasa
		{
			Dialog_Show(playerid, BUSINESS_SAFE, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Ekran�", "Para Yat�r\nPara �ek\nKasa Durum", "Se�", "<<");
		}
		case 5: // kilit
		{
			switch(Business[bsid][bsLocked])
			{
				case 0: Business[bsid][bsLocked] = 1, SendServerMessage(playerid, "Kap�lar� kilitlediniz.");
				case 1: Business[bsid][bsLocked] = 0, SendServerMessage(playerid, "Kilitleri a�t�n�z.");
			}
		}
	}
	return true;
}

Dialog:BUSINESS_SAFE(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0: Dialog_Show(playerid, SAFE_DEPOSIT, DIALOG_STYLE_INPUT, "Vinewood Roleplay - ��letme Kontrol Ekran�", "{FFFFFF}Yat�rmak istedi�iniz tutar� girin:", "Yat�r", "Kapat");
		case 1: Dialog_Show(playerid, SAFE_WITHDRAW, DIALOG_STYLE_INPUT, "Vinewood Roleplay - ��letme Kontrol Ekran�", "{FFFFFF}�ekmek istedi�iniz tutar� girin:", "�ek", "Kapat");
		case 2: 
		{
			new bsid = GetPVarInt(playerid, "managedbsid"), bstr[124];
			format(bstr, sizeof(bstr), "%s\n\n{FFFFFF}Kasa: $%d", Business[bsid][bsName], Business[bsid][bsSafe]);
			Dialog_Show(playerid, SAFE_STATUS, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - ��letme Kontrol Ekran�", bstr, "Kapat", "");
		}
	}
	return true;
}

Dialog:SAFE_DEPOSIT(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_SAFE, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Ekran�", "Para Yat�r\nPara �ek", "Se�", "<<");
	if(strval(inputtext) > Character[playerid][cAdmin]) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r.");

	new bsid = GetPVarInt(playerid, "managedbsid");

	Business[bsid][bsSafe] += strval(inputtext);
	GiveMoney(playerid, -strval(inputtext));
	RefreshBusiness(bsid);
	SendServerMessage(playerid, "%s isimli i�letmenizin kasas�na $%d aktard�n�z.", Business[bsid][bsName], strval(inputtext));
	return true;
}

Dialog:SAFE_WITHDRAW(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_SAFE, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Ekran�", "Para Yat�r\nPara �ek", "Se�", "<<");
	new bsid = GetPVarInt(playerid, "managedbsid");
	if(Business[bsid][bsSafe] < strval(inputtext)) return SendServerMessage(playerid, "Kasada bu miktar bulunmuyor.");

	Business[bsid][bsSafe] -= strval(inputtext);
	GiveMoney(playerid, strval(inputtext));
	RefreshBusiness(bsid);
	SendServerMessage(playerid, "%s isimli i�letmenizin kasas�ndan $%d �ektiniz.", Business[bsid][bsName], strval(inputtext));
	return true;
}

Dialog:BUSINESS_STAFF_LIST(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new bsid = GetPVarInt(playerid, "managedbsid");
	SetPVarInt(playerid, "pickupstaffdbid", Business[bsid][bsWorkers][listitem]);
	SetPVarInt(playerid, "pickupstaffarray", listitem);
	
	Dialog_Show(playerid, MANAGE_STAFF, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Ekran�", "Maa� Ayarla\n��ten At", "Se�", "<<");
	return true;
}

Dialog:MANAGE_STAFF(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_MANAGE_PANEL, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Paneli", "�sim de�i�tir\nTip de�i�tir\nPersoneller\nKasa\n{000000}_\nKilit", "Se�", "Kapat");

	switch(listitem)
	{
		case 0:
		{
			Dialog_Show(playerid, MANAGE_PAYDAY, DIALOG_STYLE_INPUT, "Vinewood Roleplay - ��letme Kontrol Paneli", "{FFFFFF}Girece�iniz tutar saatlik maa� tutar�d�r, bir tutar girin:", "Ayarla", "Kapat");
		}
		case 1:
		{
			new workerarray = GetPVarInt(playerid, "pickupstaffarray");
			new workerid = GetPVarInt(playerid, "pickupstaffdbid");
			new bsid = GetPVarInt(playerid, "managedbsid");

			new targetid = GetPlayerIDFromSQLID(workerid);

			Business[bsid][bsWorkers][workerarray] = 0;
			Business[bsid][bsWorkersPayday][workerarray] = 0;
			RefreshBusiness(bsid);

			SendServerMessage(targetid, "%s isimli i�letmenin personel kadrosundan ��kart�ld�n�z.", Business[bsid][bsName]);
			SendServerMessage(playerid, "%s isimli ki�iyi %s i�letmesinin personel kadrosundan ��kartt�n�z.", GetRPName(targetid), Business[bsid][bsName]);
		}
	}
	return true;
}

Dialog:MANAGE_PAYDAY(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MANAGE_STAFF, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Ekran�", "Maa� Ayarla\n��ten At", "Se�", "<<");
	if(strval(inputtext) <= 0) return SendServerMessage(playerid, "Ge�ersiz miktar girdiniz.");

	new bsid = GetPVarInt(playerid, "managedbsid");
	new workerarray = GetPVarInt(playerid, "pickupstaffarray");
	new workerid = GetPVarInt(playerid, "pickupstaffdbid");

	new targetid = GetPlayerIDFromSQLID(workerid);

	Business[bsid][bsWorkersPayday][workerarray] = strval(inputtext);
	RefreshBusiness(bsid);
	SendServerMessage(targetid, "%s isimli i�letmede maa��n�z $%d olarak g�ncellendi.", Business[bsid][bsName], strval(inputtext));
	SendServerMessage(playerid, "%s isimli ki�inin maa��n� $%d olarak g�ncellediniz.", GetRPName(targetid), strval(inputtext));
	return true;
}

Dialog:BUSINESS_CHANGE_NAME(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_MANAGE_PANEL, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Paneli", "�sim de�i�tir\nTip de�i�tir\nPersoneller\nKasa\n{000000}_\nKilit", "Se�", "Kapat");
	if(strlen(inputtext) < 1 || strlen(inputtext) > 124) return SendServerMessage(playerid, "Ge�ersiz karakter say�s� girdiniz.");

	new bsid = GetPVarInt(playerid, "managedbsid");
	format(Business[bsid][bsName], 124, "%s", inputtext);
	RefreshBusiness(bsid);

	SendServerMessage(playerid, "��letmenizin ismi %s olarak de�i�tirildi.", Business[bsid][bsName]);
	return true;
}

Dialog:BUSINESS_CHANGE_TYPE(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_MANAGE_PANEL, DIALOG_STYLE_LIST, "Vinewood Roleplay - ��letme Kontrol Paneli", "�sim de�i�tir\nTip de�i�tir\nPersoneller\nKasa\n{000000}_\nKilit", "Se�", "Kapat");

	new bsid = GetPVarInt(playerid, "managedbsid");
	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cMoney] < 280000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($280000)");
		
			Business[bsid][bsType] = 1;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz market olarak de�i�tirildi.");
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 180000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($180000)");

			Business[bsid][bsType] = 2;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz i�ki d�kkan� olarak de�i�tirildi.");
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 295000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($295000)");

			Business[bsid][bsType] = 3;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz pawn shop olarak de�i�tirildi.");
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 90000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($90000)");

			Business[bsid][bsType] = 4;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz restaurant olarak de�i�tirildi.");
		}
		case 4:
		{
			if(Character[playerid][cMoney] < 110000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($110000)");

			Business[bsid][bsType] = 5;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz bar/gece kul�b� olarak de�i�tirildi.");
		}
		case 5:
		{
			if(Character[playerid][cMoney] < 550000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($550000)");

			Business[bsid][bsType] = 6;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz tamirhane olarak de�i�tirildi.");
		}
		case 6:
		{
			if(Character[playerid][cMoney] < 480000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($480000)");

			Business[bsid][bsType] = 7;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz spor salonu olarak de�i�tirildi.");
		}
		case 7:
		{
			if(Character[playerid][cMoney] < 400000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($400000)");

			Business[bsid][bsType] = 8;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz kumarhane olarak de�i�tirildi.");
		}
		case 8:
		{
			if(Character[playerid][cMoney] < 1000000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($1000000)");

			Business[bsid][bsType] = 9;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz silah d�kkan� olarak de�i�tirildi.");
		}
		case 9:
		{
			if(Character[playerid][cMoney] < 1000000) return SendServerMessage(playerid, "Yeterli paran�z bulunmamaktad�r. ($1000000)");

			Business[bsid][bsType] = 10;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "��letme tipiniz k�yafet d�kkan� olarak de�i�tirildi.");
		}
	}
	return true;
}

Dialog:DIALOG_GARAGE(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Bir ara� i�erisinde olmal�s�n.");

			new vehid = GetPlayerVehicleID(playerid);
			SetPVarInt(playerid, "FixingGarageCarID", vehid);

			StartChallange(playerid, CHALLANGE_FIXING_CAR);
		}
		case 1:
		{
			if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Bir ara� i�erisinde olmal�s�n.");

			SendServerMessage(playerid, "Bu b�l�m bir s�re i�in pasif.");
			//Dialog_Show(playerid, COMPONENT_MENU, DIALOG_STYLE_LIST, "Vinewood Roleplay - Modifikasyon", "Lastikler\nR�zgarl�k\nYan Tamponlar\nEgzos\n�n Tampon\nArka Tampon\nBody Kit\nHidrolik - $4000\nNitro(2x) - $10000\nRenk - $200\nPaintJob - $1000\nTamir - $150\nModifikasyonlar� Kald�r", "Se�", "Ayr�l");
		}
	}
	return true;
}

Dialog:BUSINESS_OFFER(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		new targetid = OfferOwnerID[playerid];
		SendServerMessage(targetid, "%s isimli ki�i teklifinizi reddetti.", GetRPName(playerid));
		SendServerMessage(playerid, "Teklifi reddettiniz.");

		OfferBusinessID[playerid] = -1;
		OfferBusinessPrice[playerid] = 0;
		OfferMode[playerid] = false;
		OfferOwnerID[playerid] = -1;
		OfferMode[targetid] = false;
	}
	else
	{
		new bsid = OfferBusinessID[playerid], price = OfferBusinessPrice[playerid], oldowner = OfferOwnerID[playerid];

		GiveMoney(playerid, -price);
		GiveMoney(oldowner, price);

		Business[bsid][bsOwner] = Character[playerid][cID];
		Business[bsid][bsLocked] = 0;
		RefreshBusiness(bsid);

		OfferBusinessID[playerid] = -1;
		OfferBusinessPrice[playerid] = 0;
		OfferMode[playerid] = false;
		OfferOwnerID[playerid] = -1;
		OfferMode[oldowner] = false;

		SendServerMessage(playerid, "%s isimli i�letmeyi $%d �cretle sat�n ald�n�z.", Business[bsid][bsName], price);
		SendServerMessage(oldowner, "%s isimli i�letmeyi $%d �cretle satt�n�z.", Business[bsid][bsName], price);
	}
	return true;
}

Dialog:DIALOG_CLOTHSHOP(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cSex] == 1 && Character[playerid][cSkinColor] == 1) // erkek ve beyazsa
			{
				static string[sizeof(SHOP_WHITE_MALE) * 64];
				for(new i; i < sizeof(SHOP_WHITE_MALE); i++)
				{
					format(string, sizeof(string), "%s%i\t~w~Fiyat: ~g~$50\n", string, SHOP_WHITE_MALE[i][CLOTHES_MODEL]);
				}
				ShowPlayerDialog(playerid, BUY_WHITE_MALE, DIALOG_STYLE_PREVIEW_MODEL, "Vinewood Roleplay - Kiyafet", string, "Satin Al", "Kapat");
			}
			else if(Character[playerid][cSex] == 1 && Character[playerid][cSkinColor] == 2) // erkek ve siyahi ise
			{
				static string[sizeof(SHOP_BLACK_MALE) * 64];
				for(new i; i < sizeof(SHOP_BLACK_MALE); i++)
				{
					format(string, sizeof(string), "%s%i\t~w~Fiyat: ~g~$50\n", string, SHOP_BLACK_MALE[i][CLOTHES_MODEL]);
				}
				ShowPlayerDialog(playerid, BUY_BLACK_MALE, DIALOG_STYLE_PREVIEW_MODEL, "Vinewood Roleplay - Kiyafet", string, "Satin Al", "Kapat");
			}
			else if(Character[playerid][cSex] == 2 && Character[playerid][cSkinColor] == 1) // kad�n ve beyazsa
			{
				static string[sizeof(SHOP_WHITE_FEMALE) * 64];
				for(new i; i < sizeof(SHOP_WHITE_FEMALE); i++)
				{
					format(string, sizeof(string), "%s%i\t~w~Fiyat: ~g~$50\n", string, SHOP_WHITE_FEMALE[i][CLOTHES_MODEL]);
				}
				ShowPlayerDialog(playerid, BUY_WHITE_FEMALE, DIALOG_STYLE_PREVIEW_MODEL, "Vinewood Roleplay - Kiyafet", string, "Satin Al", "Kapat");
			}
			else if(Character[playerid][cSex] == 2 && Character[playerid][cSkinColor] == 2) // kad�n ve siyahi ise
			{
				static string[sizeof(SHOP_BLACK_FEMALE) * 64];
				for(new i; i < sizeof(SHOP_BLACK_FEMALE); i++)
				{
					format(string, sizeof(string), "%s%i\t~w~Fiyat: ~g~$50\n", string, SHOP_BLACK_FEMALE[i][CLOTHES_MODEL]);
				}
				ShowPlayerDialog(playerid, BUY_BLACK_FEMALE, DIALOG_STYLE_PREVIEW_MODEL, "Vinewood Roleplay - Kiyafet", string, "Satin Al", "Kapat");
			}
			else
			{
				SendServerMessage(playerid, "Hata olu�tu, bir y�neticiye ula��n.");
			}
		}
		case 1:
		{
			static string[sizeof(ACCS) * 64];
			for(new i; i < sizeof(ACCS); i++)
			{
				format(string, sizeof(string), "%s%i\t~w~Fiyat: ~g~$~w~25\n", string, ACCS[i][ACCS_MODEL]);
			}
			ShowPlayerDialog(playerid, BUY_A_ACC, DIALOG_STYLE_PREVIEW_MODEL, "Vinewood Roleplay - Aksesuarlar", string, "Satin Al", "Kapat");
		}
	}
	return true;
}