Dialog:DIALOG_MARKET(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cMoney] < 5) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			new Float:health;
			GetPlayerHealth(playerid, health);
			if(health >= 100.0) return SendServerMessage(playerid, "Karnýnýz yeterince doydu.");

			GiveMoney(playerid, -5);
			GivePlayerHealth(playerid, 10);
			SendServerMessage(playerid, "Sandviç aldýnýz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 5;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 10) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			new Float:health;
			GetPlayerHealth(playerid, health);
			if(health >= 100.0) return SendServerMessage(playerid, "Karnýnýz yeterince doydu.");

			GiveMoney(playerid, -10);
			GivePlayerHealth(playerid, 10);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
			SendServerMessage(playerid, "Sprunk aldýnýz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 10;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 2000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(HaveMask[playerid]) return SendServerMessage(playerid, "Maskeniz bulunmaktadýr.");

			GiveMoney(playerid, -2000);
			HaveMask[playerid] = 1;
			SendServerMessage(playerid, "Maske aldýnýz, /maske ile takabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 2000;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 150) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(HaveBat[playerid]) return SendServerMessage(playerid, "Sopanýz bulunmaktadýr.");

			GiveMoney(playerid, -150);
			HaveBat[playerid] = 1;
			SendServerMessage(playerid, "Sopa aldýnýz, /sopa ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 150;
			RefreshBusiness(bsid);
		}
		case 4:
		{
			if(Character[playerid][cMoney] < 50) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(HaveFlower[playerid]) return SendServerMessage(playerid, "Çiçeðiniz bulunmaktadýr.");

			HaveFlower[playerid] = 1;
			GiveMoney(playerid, -50);
			SendServerMessage(playerid, "Çiçek aldýnýz, /cicek ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 50;
			RefreshBusiness(bsid);
		}
		case 5:
		{
			if(Character[playerid][cMoney] < 7) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -7);
			Character[playerid][cCigaratte] += 20;
			SendServerMessage(playerid, "Sigara aldýnýz, /sigara ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 7;
			RefreshBusiness(bsid);
		}
		case 6:
		{
			if(Character[playerid][cMoney] < 5) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(Character[playerid][cLighter]) return SendServerMessage(playerid, "Çakmaðýnýz bulunmaktadýr.");

			GiveMoney(playerid, -5);
			Character[playerid][cLighter] = 1;
			SendServerMessage(playerid, "Çakmak aldýnýz.");

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
			if(Character[playerid][cMoney] < 2) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -2);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet içki aldýnýz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 2;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 1) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet içki aldýnýz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 1;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 3) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -3);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet içki aldýnýz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 3;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 5) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -5);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet içki aldýnýz.");

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
			if(Character[playerid][cMoney] < 2) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -2);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet içki aldýnýz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 2;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 1) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet içki aldýnýz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 1;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 3) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -3);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet içki aldýnýz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 3;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 5) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

			GiveMoney(playerid, -5);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			SendServerMessage(playerid, "Bir adet içki aldýnýz.");

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
			if(Character[playerid][cMoney] < 350) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmaktadýr.");

			Character[playerid][cPhone] = 1;
			GiveMoney(playerid, -350);
			SendServerMessage(playerid, "Telefon satýn aldýnýz.");
			SaveCharacterData(playerid);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 350;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 35) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmaktadýr.");

			new number = randomEx(111111, 999999);
			GiveMoney(playerid, -35);
			Character[playerid][cPhoneNumber] = number;
			SendServerMessage(playerid, "Bir hat satýn aldýnýz.");
			SaveCharacterData(playerid);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 35;
			RefreshBusiness(bsid);
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 100) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(Character[playerid][cBoombox]) return SendServerMessage(playerid, "Boomboxunuz bulunmaktadýr.");

			GiveMoney(playerid, -100);
			Character[playerid][cBoombox] = 1;
			SendServerMessage(playerid, "Boombox satýn aldýnýz, /boombox ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 100;
			RefreshBusiness(bsid);
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 75) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(Character[playerid][cToolkit]) return SendServerMessage(playerid, "Alet çantanýz bulunmaktadýr.");

			GiveMoney(playerid, -75);
			Character[playerid][cToolkit] = 1;
			SendServerMessage(playerid, "Alet çantasý satýn aldýnýz, /toolkit ile kullanabilirsiniz.");

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 75;
			RefreshBusiness(bsid);
		}
		case 4:
		{
			if(Character[playerid][cMoney] < 25) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");
			if(Character[playerid][cSkeletonKey]) return SendServerMessage(playerid, "Maymuncuðunuz bulunmaktadýr.");

			GiveMoney(playerid, -25);
			Character[playerid][cSkeletonKey] = 1;
			SendServerMessage(playerid, "Maymuncuk satýn aldýnýz, /maymuncuk ile kullanabilirsiniz.");

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
			if(Character[playerid][cMoney] < 25) return SendServerMessage(playerid, "Yeteri kadar paranýz yok.");

			GivePlayerHealth(playerid, 15.0);
			GiveMoney(playerid, -1*25);
			SendClientMessage(playerid, C_VINEWOOD, "Sanvdiç yedin.");
			if(pHealth + 15.0 >= 100) SetPlayerHealth(playerid, 100.0);
			ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);

			new bsid = GetBusinessIDFromInt(playerid);

			Business[bsid][bsSafe] += 25;
			RefreshBusiness(bsid);
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 50) return SendServerMessage(playerid, "Yeteri kadar paranýz yok.");

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
			if(Character[playerid][cMoney] < 35) return SendServerMessage(playerid, "Yeteri kadar paranýz yok.");

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
			if(Character[playerid][cMoney] < 75) return SendServerMessage(playerid, "Yeteri kadar paranýz yok.");

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
		case 0: // isim deðiþtirme
		{
			Dialog_Show(playerid, BUSINESS_CHANGE_NAME, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "{FFFFFF}Deðiþtirmek istediðiniz yeni ismi girin:", "Devam", "<<");
		}
		case 1: // tip deðiþtirme
		{
			Dialog_Show(playerid, BUSINESS_CHANGE_TYPE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "Market\nÝçki Dükkaný\nPawn Shop\nRestaurant\nBar/Gece Kulübü\nTamirhane\nSpor Salonu\nKumarhane\nSilah Dükkaný\nKýyafet Dükkaný", "Seç", "<<");
		}
		case 2: // personeller
		{
			new str[1044];
			for(new i; i < 10; i++)
			{
				format(str, sizeof str, "%s%s", str, GetNameFromSQLID(Business[bsid][bsWorkers][i]));
			}
			Dialog_Show(playerid, BUSINESS_STAFF_LIST, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", str, "Seç", "Kapat");
		}
		case 3: // kasa
		{
			Dialog_Show(playerid, BUSINESS_SAFE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "Para Yatýr\nPara Çek\nKasa Durum", "Seç", "<<");
		}
		case 5: // kilit
		{
			switch(Business[bsid][bsLocked])
			{
				case 0: Business[bsid][bsLocked] = 1, SendServerMessage(playerid, "Kapýlarý kilitlediniz.");
				case 1: Business[bsid][bsLocked] = 0, SendServerMessage(playerid, "Kilitleri açtýnýz.");
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
		case 0: Dialog_Show(playerid, SAFE_DEPOSIT, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "{FFFFFF}Yatýrmak istediðiniz tutarý girin:", "Yatýr", "Kapat");
		case 1: Dialog_Show(playerid, SAFE_WITHDRAW, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "{FFFFFF}Çekmek istediðiniz tutarý girin:", "Çek", "Kapat");
		case 2: 
		{
			new bsid = GetPVarInt(playerid, "managedbsid"), bstr[124];
			format(bstr, sizeof(bstr), "%s\n\n{FFFFFF}Kasa: $%d", Business[bsid][bsName], Business[bsid][bsSafe]);
			Dialog_Show(playerid, SAFE_STATUS, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", bstr, "Kapat", "");
		}
	}
	return true;
}

Dialog:SAFE_DEPOSIT(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_SAFE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "Para Yatýr\nPara Çek", "Seç", "<<");
	if(strval(inputtext) > Character[playerid][cAdmin]) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

	new bsid = GetPVarInt(playerid, "managedbsid");

	Business[bsid][bsSafe] += strval(inputtext);
	GiveMoney(playerid, -strval(inputtext));
	RefreshBusiness(bsid);
	SendServerMessage(playerid, "%s isimli iþletmenizin kasasýna $%d aktardýnýz.", Business[bsid][bsName], strval(inputtext));
	return true;
}

Dialog:SAFE_WITHDRAW(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_SAFE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "Para Yatýr\nPara Çek", "Seç", "<<");
	new bsid = GetPVarInt(playerid, "managedbsid");
	if(Business[bsid][bsSafe] < strval(inputtext)) return SendServerMessage(playerid, "Kasada bu miktar bulunmuyor.");

	Business[bsid][bsSafe] -= strval(inputtext);
	GiveMoney(playerid, strval(inputtext));
	RefreshBusiness(bsid);
	SendServerMessage(playerid, "%s isimli iþletmenizin kasasýndan $%d çektiniz.", Business[bsid][bsName], strval(inputtext));
	return true;
}

Dialog:BUSINESS_STAFF_LIST(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new bsid = GetPVarInt(playerid, "managedbsid");
	SetPVarInt(playerid, "pickupstaffdbid", Business[bsid][bsWorkers][listitem]);
	SetPVarInt(playerid, "pickupstaffarray", listitem);
	
	Dialog_Show(playerid, MANAGE_STAFF, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "Maaþ Ayarla\nÝþten At", "Seç", "<<");
	return true;
}

Dialog:MANAGE_STAFF(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_MANAGE_PANEL, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Paneli", "Ýsim deðiþtir\nTip deðiþtir\nPersoneller\nKasa\n{000000}_\nKilit", "Seç", "Kapat");

	switch(listitem)
	{
		case 0:
		{
			Dialog_Show(playerid, MANAGE_PAYDAY, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Ýþletme Kontrol Paneli", "{FFFFFF}Gireceðiniz tutar saatlik maaþ tutarýdýr, bir tutar girin:", "Ayarla", "Kapat");
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

			SendServerMessage(targetid, "%s isimli iþletmenin personel kadrosundan çýkartýldýnýz.", Business[bsid][bsName]);
			SendServerMessage(playerid, "%s isimli kiþiyi %s iþletmesinin personel kadrosundan çýkarttýnýz.", GetRPName(targetid), Business[bsid][bsName]);
		}
	}
	return true;
}

Dialog:MANAGE_PAYDAY(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MANAGE_STAFF, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Ekraný", "Maaþ Ayarla\nÝþten At", "Seç", "<<");
	if(strval(inputtext) <= 0) return SendServerMessage(playerid, "Geçersiz miktar girdiniz.");

	new bsid = GetPVarInt(playerid, "managedbsid");
	new workerarray = GetPVarInt(playerid, "pickupstaffarray");
	new workerid = GetPVarInt(playerid, "pickupstaffdbid");

	new targetid = GetPlayerIDFromSQLID(workerid);

	Business[bsid][bsWorkersPayday][workerarray] = strval(inputtext);
	RefreshBusiness(bsid);
	SendServerMessage(targetid, "%s isimli iþletmede maaþýnýz $%d olarak güncellendi.", Business[bsid][bsName], strval(inputtext));
	SendServerMessage(playerid, "%s isimli kiþinin maaþýný $%d olarak güncellediniz.", GetRPName(targetid), strval(inputtext));
	return true;
}

Dialog:BUSINESS_CHANGE_NAME(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_MANAGE_PANEL, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Paneli", "Ýsim deðiþtir\nTip deðiþtir\nPersoneller\nKasa\n{000000}_\nKilit", "Seç", "Kapat");
	if(strlen(inputtext) < 1 || strlen(inputtext) > 124) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");

	new bsid = GetPVarInt(playerid, "managedbsid");
	format(Business[bsid][bsName], 124, "%s", inputtext);
	RefreshBusiness(bsid);

	SendServerMessage(playerid, "Ýþletmenizin ismi %s olarak deðiþtirildi.", Business[bsid][bsName]);
	return true;
}

Dialog:BUSINESS_CHANGE_TYPE(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, BUSINESS_MANAGE_PANEL, DIALOG_STYLE_LIST, "Vinewood Roleplay - Ýþletme Kontrol Paneli", "Ýsim deðiþtir\nTip deðiþtir\nPersoneller\nKasa\n{000000}_\nKilit", "Seç", "Kapat");

	new bsid = GetPVarInt(playerid, "managedbsid");
	switch(listitem)
	{
		case 0:
		{
			if(Character[playerid][cMoney] < 280000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($280000)");
		
			Business[bsid][bsType] = 1;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz market olarak deðiþtirildi.");
		}
		case 1:
		{
			if(Character[playerid][cMoney] < 180000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($180000)");

			Business[bsid][bsType] = 2;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz içki dükkaný olarak deðiþtirildi.");
		}
		case 2:
		{
			if(Character[playerid][cMoney] < 295000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($295000)");

			Business[bsid][bsType] = 3;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz pawn shop olarak deðiþtirildi.");
		}
		case 3:
		{
			if(Character[playerid][cMoney] < 90000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($90000)");

			Business[bsid][bsType] = 4;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz restaurant olarak deðiþtirildi.");
		}
		case 4:
		{
			if(Character[playerid][cMoney] < 110000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($110000)");

			Business[bsid][bsType] = 5;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz bar/gece kulübü olarak deðiþtirildi.");
		}
		case 5:
		{
			if(Character[playerid][cMoney] < 550000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($550000)");

			Business[bsid][bsType] = 6;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz tamirhane olarak deðiþtirildi.");
		}
		case 6:
		{
			if(Character[playerid][cMoney] < 480000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($480000)");

			Business[bsid][bsType] = 7;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz spor salonu olarak deðiþtirildi.");
		}
		case 7:
		{
			if(Character[playerid][cMoney] < 400000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($400000)");

			Business[bsid][bsType] = 8;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz kumarhane olarak deðiþtirildi.");
		}
		case 8:
		{
			if(Character[playerid][cMoney] < 1000000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($1000000)");

			Business[bsid][bsType] = 9;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz silah dükkaný olarak deðiþtirildi.");
		}
		case 9:
		{
			if(Character[playerid][cMoney] < 1000000) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr. ($1000000)");

			Business[bsid][bsType] = 10;
			RefreshBusiness(bsid);
			SendServerMessage(playerid, "Ýþletme tipiniz kýyafet dükkaný olarak deðiþtirildi.");
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
			if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Bir araç içerisinde olmalýsýn.");

			new vehid = GetPlayerVehicleID(playerid);
			SetPVarInt(playerid, "FixingGarageCarID", vehid);

			StartChallange(playerid, CHALLANGE_FIXING_CAR);
		}
		case 1:
		{
			if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Bir araç içerisinde olmalýsýn.");

			SendServerMessage(playerid, "Bu bölüm bir süre için pasif.");
			//Dialog_Show(playerid, COMPONENT_MENU, DIALOG_STYLE_LIST, "Vinewood Roleplay - Modifikasyon", "Lastikler\nRüzgarlýk\nYan Tamponlar\nEgzos\nÖn Tampon\nArka Tampon\nBody Kit\nHidrolik - $4000\nNitro(2x) - $10000\nRenk - $200\nPaintJob - $1000\nTamir - $150\nModifikasyonlarý Kaldýr", "Seç", "Ayrýl");
		}
	}
	return true;
}

Dialog:BUSINESS_OFFER(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		new targetid = OfferOwnerID[playerid];
		SendServerMessage(targetid, "%s isimli kiþi teklifinizi reddetti.", GetRPName(playerid));
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

		SendServerMessage(playerid, "%s isimli iþletmeyi $%d ücretle satýn aldýnýz.", Business[bsid][bsName], price);
		SendServerMessage(oldowner, "%s isimli iþletmeyi $%d ücretle sattýnýz.", Business[bsid][bsName], price);
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
			else if(Character[playerid][cSex] == 2 && Character[playerid][cSkinColor] == 1) // kadýn ve beyazsa
			{
				static string[sizeof(SHOP_WHITE_FEMALE) * 64];
				for(new i; i < sizeof(SHOP_WHITE_FEMALE); i++)
				{
					format(string, sizeof(string), "%s%i\t~w~Fiyat: ~g~$50\n", string, SHOP_WHITE_FEMALE[i][CLOTHES_MODEL]);
				}
				ShowPlayerDialog(playerid, BUY_WHITE_FEMALE, DIALOG_STYLE_PREVIEW_MODEL, "Vinewood Roleplay - Kiyafet", string, "Satin Al", "Kapat");
			}
			else if(Character[playerid][cSex] == 2 && Character[playerid][cSkinColor] == 2) // kadýn ve siyahi ise
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
				SendServerMessage(playerid, "Hata oluþtu, bir yöneticiye ulaþýn.");
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