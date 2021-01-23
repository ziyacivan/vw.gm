CMD:telefon(playerid)
{
	if(!Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmamaktadýr.");
	if(!Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmamaktadýr.");
	
	ShowPhone(playerid);
	SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s cebinden telefonunu çýkarýr ve tuþlara basmaya baþlar.", GetRPName(playerid));
	return true;
}

CMD:cagrikabul(playerid)
{
	if(!Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmamaktadýr.");
	if(!Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmamaktadýr.");
	if(Character[playerid][cImCalling]) return SendServerMessage(playerid, "Birisini arýyorken bir baþka çaðrýyý kabul edemezsiniz.");
	if(!Character[playerid][cImCalled]) return SendServerMessage(playerid, "Bir aramanýz bulunmamaktadýr.");
	if(Character[playerid][cCallActive]) return SendServerMessage(playerid, "Aktif bir çaðrýda baþka bir çaðrýyý kabul edemezsiniz.");
	
	new callerid = Character[playerid][cCallPartner];

	SendServerMessage(playerid, "Çaðrýyý kabul ettiniz, görüþme baþlatýldý.");
	SendServerMessage(callerid, "Aradýðýnýz kiþi çaðrýyý kabul etti, görüþme baþlatýldý.");

	Character[playerid][cCallActive] = 1;
	Character[callerid][cCallActive] = 1;
	return true;
}

CMD:cagrireddet(playerid)
{
	if(!Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmamaktadýr.");
	if(!Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmamaktadýr.");
	if(Character[playerid][cImCalling]) return SendServerMessage(playerid, "Birisini arýyorken bir baþka çaðrýyý kabul edemezsiniz.");
	if(!Character[playerid][cImCalled]) return SendServerMessage(playerid, "Bir aramanýz bulunmamaktadýr.");
	if(Character[playerid][cCallActive]) return SendServerMessage(playerid, "Aktif bir çaðrýda baþka bir çaðrýyý kabul edemezsiniz.");

	new callerid = Character[playerid][cCallPartner];

	SendServerMessage(playerid, "Çaðrýyý reddettiniz.");
	SendServerMessage(callerid, "Aradýðýnýz kiþi çaðrýyý reddetti.");

	Character[playerid][cCallActive] = 0;
	Character[playerid][cImCalled] = 0;
	Character[playerid][cCallPartner] = -1;

	Character[callerid][cCallActive] = 0;
	Character[callerid][cImCalling] = 0;
	Character[callerid][cCallPartner] = -1;
	return true;
}

CMD:cagriiptal(playerid)
{
	if(!Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmamaktadýr.");
	if(!Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmamaktadýr.");
	if(!Character[playerid][cImCalling]) return SendServerMessage(playerid, "Bir aramanýz bulunmamaktadýr.");

	new callingid = Character[playerid][cCallActive];

	SendServerMessage(playerid, "Çaðrýyý iptal ettiniz.");
	SendServerMessage(callingid, "Sizi arayan kiþi çaðrýyý iptal etti.");

	Character[playerid][cImCalling] = 0;
	Character[callingid][cImCalled] = 0;

	Character[playerid][cCallPartner] = -1;
	Character[callingid][cCallPartner] = -1;
	return true;
}

CMD:cagrikapat(playerid)
{
	if(!Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmamaktadýr.");
	if(!Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmamaktadýr.");
	if(!Character[playerid][cCallActive]) return SendServerMessage(playerid, "Bir aramanýz bulunmamaktadýr.");

	new callerid = Character[playerid][cCallPartner];

	SendServerMessage(playerid, "Çaðrýyý kapattýnýz.");
	SendServerMessage(callerid, "Görüþme sonlandýrýldý.");

	Character[playerid][cCallActive] = 0;
	Character[callerid][cCallActive] = 0;
	Character[playerid][cCallPartner] = -1;
	Character[callerid][cCallPartner] = -1;

	Character[playerid][cImCalling] = 0;
	Character[callerid][cImCalling] = 0;
	Character[playerid][cImCalled] = 0;
	Character[callerid][cImCalled] = 0;
	return true;
}

CMD:ara(playerid, params[])
{
	if(!Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmamaktadýr.");
	if(!Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmamaktadýr.");
	if(!Character[playerid][cPhoneStatus]) return SendServerMessage(playerid, "Telefonunuz kapalý.");

	new number;
	if(sscanf(params, "d", number)) return SendServerMessage(playerid, "/ara [numara]");
	if(!CheckNumber(number) && number != 911) return SendServerMessage(playerid, "Hatalý numara girdiniz.");
	if(!CheckPhone(number)) return SendServerMessage(playerid, "Aradýðýnýz kiþiye ulaþýlamýyor.");

	new numberowner = GetNumberOwner(number);
	if(numberowner == playerid) return SendServerMessage(playerid, "Kendinizi arayamazsýnýz.");

	if(number == 911)
	{
		Character[playerid][cImCalling] = 1;
		Dialog_Show(playerid, DIALOG_911_1, DIALOG_STYLE_INPUT, "Vinewood - 911 Hattý [#1]", "Operatör: 911 çaðrý hattý, kullanmak istediðiniz servis? (LSPD/LSFD/LSMD)", "Devam Et", "Kapat");	
	}
	else
	{
		CreateCall(playerid, numberowner);
		SendNearbyMessage(playerid, 20.0, C_EMOTE, "* %s cebinden telefonunu çýkarýr ve tuþlara basmaya baþlar.", GetRPName(playerid));
	}
	return true;
}

CMD:rehberekle(playerid, params[])
{
	if(!Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmamaýktadýr.");
	if(!Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmamaktadýr.");

	new name[32], number;
	if(sscanf(params, "s[32]d", name, number)) return SendServerMessage(playerid, "/rehberekle [isim(32)] [numara]");
	if(CheckDirectorySlot(playerid)) return SendServerMessage(playerid, "Boþ slot bulunmamaktadýr.");
	if(strlen(name) < 0 || strlen(name) > 32) return SendServerMessage(playerid, "Geçersiz karakter girdiniz (0-32).");

	AddDirectory(playerid, name, number);
	return true;
}

CMD:sms(playerid, params[])
{
	if(!Character[playerid][cPhone]) return SendServerMessage(playerid, "Telefonunuz bulunmamaýktadýr.");
	if(!Character[playerid][cPhoneNumber]) return SendServerMessage(playerid, "Hattýnýz bulunmamaktadýr.");

	new number, message[128];
	if(sscanf(params, "ds[128]", number, message)) return SendServerMessage(playerid, "/sms [numara] [mesaj(128)]");
	if(!CheckNumber(number)) return SendServerMessage(playerid, "Geçersiz numara girdiniz.");
	if(!CheckPhone(number)) return SendServerMessage(playerid, "Mesaj iletilemedi.");
	if(!Character[playerid][cMoney]) return SendServerMessage(playerid, "Yeterli paranýz bulunmamaktadýr.");

	new numberowner = GetNumberOwner(number), phoneno = 0, phonename[128];

	for(new i = 0; i < MAX_DIRECTORY; i++)
	{
		if(Character[playerid][cPhoneNumber] == Directory[numberowner][i][dNumber])
		{
			phoneno++;
			format(phonename, 128, Directory[numberowner][i][dName]);
		}
	}
	if(phoneno == 0)
	{
		SendClientMessageEx(numberowner, C_PM, "(Gelen SMS) %d: %s", Character[playerid][cPhoneNumber], message);
		SendClientMessageEx(playerid, C_PM, "(Giden SMS) %d: %s", Character[playerid][cPhoneNumber], message);
	}
	else if(phoneno != 0)
	{
		SendClientMessageEx(numberowner, C_PM, "(Gelen SMS) %s: %s", phonename, message);
		SendClientMessageEx(playerid, C_PM, "(Giden SMS) %s: %s", GetRPName(playerid), message);
	}

	GiveMoney(playerid, -1);
	return true;
}

// functions
Vinewood:ShowPhone(playerid)
{
	new header[128];
	format(header, sizeof(header), "{E2B960}Telefon: {FFFFFF}%d", Character[playerid][cPhoneNumber]);

	switch(Character[playerid][cPhoneStatus])
	{
		case false:
		{
			Dialog_Show(playerid, PHONE_OFF, DIALOG_STYLE_MSGBOX, header, "{FFFFFF}Telefonunuz kapalý durumdadýr, açmak istiyorsanuz lütfen ''aç'' butonuna basýn.", "Aç", "Kapat");
		}
		case true:
		{
			Dialog_Show(playerid, PHONE_MAIN, DIALOG_STYLE_LIST, header, "Arama\nRehber\n{000000}_\n{E2B960}Telefonu Kapat", "Seç", "Kapat");
		}
	}
	return true;
}

Vinewood:CheckNumber(number)
{
	new count = 0;
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i) && LoggedIn[i])
		{
			if(number == Character[i][cPhoneNumber])
				count = 1;
		}
	}
	return count;
}

Vinewood:CheckPhone(number)
{
	new count = 0;
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i) && LoggedIn[i])
		{
			if(number == Character[i][cPhoneNumber])
			{
				if(Character[i][cPhoneStatus])
				{
					count = 1;
				}
			}
		}
	}
	return count;
}

Vinewood:GetNumberOwner(number)
{
	new count = -1;
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i) && LoggedIn[i])
		{
			if(number == Character[i][cPhoneNumber])
				count = i;
		}
	}
	return count;
}

Vinewood:CheckDirectorySlot(playerid)
{
	new count = 0;
	for(new i = 0; i < MAX_DIRECTORY; i++)
	{
		if(Directory[playerid][i][dIsValid])
		{
			if(i >= MAX_DIRECTORY)
				count = 1;
		}
	}
	return count;
}

Vinewood:CreateCall(playerid, numberowner)
{
	if(Character[numberowner][cCallActive]) return SendServerMessage(playerid, "Aradýðýnýz kiþi bir baþkasýyla görüþüyor.");
	if(Character[playerid][cCallActive]) return SendServerMessage(playerid, "Aktif bir çaðrýda bir baþkasýný arayamazsýnýz.");
	if(Character[numberowner][cImCalling]) return SendServerMessage(playerid, "Aradýðýnýz kiþi bir baþkasýyla görüþüyor.");
	if(Character[numberowner][cImCalled]) return SendServerMessage(playerid, "Aradýðýnýz kiþi bir baþkasýyla görüþüyor.");
	if(numberowner == playerid) return SendServerMessage(playerid, "Kendi numaranýzý arayamazsýnýz.");
	if(Character[playerid][cImCalling]) return SendServerMessage(playerid, "Baþka birisini arýyorsunuz.");
	if(!Character[numberowner][cPhoneStatus]) return SendServerMessage(playerid, "Aradýðýnýz kiþiye ulaþýlamýyor.");

	Character[playerid][cImCalling] = 1;
	Character[numberowner][cImCalled] = 1;

	Character[playerid][cCallPartner] = numberowner;
	Character[numberowner][cCallPartner] = playerid;

	SendServerMessage(playerid, "Çaðrý baþlatýlýyor..");
	SendServerMessage(numberowner, "Gelen bir çaðrýnýz var..");
	SendServerMessage(numberowner, "Çaðrýyý kabul etmek için /cagrikabul, reddetmek için /cagrireddet komutunu girebilirsiniz.");
	SendNearbyMessage(numberowner, 20.0, C_EMOTE, "* Telefonu çalmaktadýr. (( %s ))", GetRPName(numberowner));
	return true;
}

Vinewood:ShowDirectory(playerid)
{
	new str[1024], count = 0;
	for(new i = 0; i < MAX_DIRECTORY; i++)
	{
		if(Directory[playerid][i][dIsValid])
		{
			format(str, sizeof(str), "%sSlot: %d\tÝsim: %s\tNumara: %d\n", str, i, Directory[playerid][i][dName], Directory[playerid][i][dNumber]);
			count++;
		}
	}
	if(!count) return SendServerMessage(playerid, "Rehberinizde kayýtlý kiþi bulunmamaktadýr.");

	new header[128];
	format(header, sizeof(header), "{E2B960}Telefon: {FFFFFF}%d", Character[playerid][cPhoneNumber]);
	Dialog_Show(playerid, DIRECTORY_LIST, DIALOG_STYLE_TABLIST, header, str, "Seç", "Kapat");
	return true;
}

Vinewood:DeleteDirectory(playerid, slot)
{
	new query[128];
	mysql_format(conn, query, sizeof(query), "DELETE FROM directorys WHERE Owner = '%i'", Character[playerid][cID]);
	mysql_tquery(conn, query);

	Directory[playerid][slot][dIsValid] = false;
	Directory[playerid][slot][dNumber] = 0;
	format(Directory[playerid][slot][dName], 128, "Yok");

	mysql_format(conn, query, sizeof(query), "SELECT * FROM directorys WHERE Owner = '%i'", Character[playerid][cID]);
	mysql_tquery(conn, query, "LoadDirectorys", "i", playerid);

	SendServerMessage(playerid, "Bir kiþiyi sildiniz.");
	return true;
}

Vinewood:LoadDirectorys(playerid)
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);
	for(new i = 0; i < rows; i++)
	{
		Directory[playerid][i][dIsValid] = true;
		cache_get_value_name_int(i, "Owner", Directory[playerid][i][dOwner]);
		cache_get_value_name(i, "Name", Directory[playerid][i][dName], 128);
		cache_get_value_name_int(i, "Number", Directory[playerid][i][dNumber]);
		rowcount++;
	}
	printf("VinewoodDB >> Veritabanýndan ''%s'' isimli kiþiye ait ''%i'' adet rehber yüklendi.", GetRPName(playerid), rowcount);
	return true;
}

Vinewood:SaveDirectoryData(playerid)
{
	new query[512];
	for(new i = 0; i < MAX_DIRECTORY; i++)
	{
		if(Directory[playerid][i][dIsValid])
		{
			mysql_format(conn, query, sizeof(query), "UPDATE directorys SET Name = '%e', Number = %i WHERE Owner = '%i'", Directory[playerid][i][dName], Directory[playerid][i][dNumber], Character[playerid][cID]);
			mysql_tquery(conn, query);
		}
	}
	return true;
}

Vinewood:AddDirectory(playerid, name[], number)
{
	new query[128];
	mysql_format(conn, query, sizeof(query), "INSERT INTO directorys (Owner, Name, Number) VALUES (%i, '%e', %i)", Character[playerid][cID], name, number);
	mysql_tquery(conn, query);

	mysql_format(conn, query, sizeof(query), "SELECT * FROM directorys WHERE Owner = '%i'", Character[playerid][cID]);
	mysql_tquery(conn, query, "LoadDirectorys", "i", playerid);

	SendServerMessage(playerid, "Bir kiþi kaydettiniz.");
	return true;
}

Vinewood:CheckDirectoryData(playerid, number)
{
	new count;
	for(new i = 0; i < MAX_DIRECTORY; i++)
	{
		if(Directory[playerid][i][dIsValid])
		{
			if(number == Directory[playerid][i][dNumber])
				count = 1;
		}
	}
	return count;
}

// dialogs
Dialog:PHONE_OFF(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	Character[playerid][cPhoneStatus] = true;
	SendServerMessage(playerid, "Telefonunuz açýldý.");
	ShowPhone(playerid);
	return true;
}

Dialog:PHONE_MAIN(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new header[128];
	switch(listitem)
	{
		case 0:
		{
			format(header, sizeof(header), "{E2B960}Telefon: {FFFFFF}%d", Character[playerid][cPhoneNumber]);
			Dialog_Show(playerid, PHONE_CALL, DIALOG_STYLE_LIST, header, "Arama Yap", "Seç", "Kapat");
		}
		case 1:
		{
			ShowDirectory(playerid);
		}
		case 3:
		{
			Character[playerid][cPhoneStatus] = false;
			SendServerMessage(playerid, "Telefonu kapattýnýz.");
		}
	}
	return true;
}

Dialog:PHONE_CALL(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new header[128];

	switch(listitem)
	{
		case 0:
		{
			format(header, sizeof(header), "{E2B960}Telefon: {FFFFFF}%d", Character[playerid][cPhoneNumber]);
			Dialog_Show(playerid, PHONE_CALL2, DIALOG_STYLE_INPUT, header, "{FFFFFF}Lütfen aramak yapmak istediðiniz numarayý girin:", "Ara", "Kapat");
		}
	}
	return true;
}

Dialog:PHONE_CALL2(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new number = strval(inputtext);
	if(!CheckNumber(number)) return SendServerMessage(playerid, "Geçersiz numara girdiniz.");
	if(!CheckPhone(number)) return SendServerMessage(playerid, "Aradýðýnýz kiþiye ulaþýlamýyor.");

	new numberowner = GetNumberOwner(number);

	CreateCall(playerid, numberowner);
	return true;
}

Dialog:DIRECTORY_LIST(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new header[128];

	new slot = listitem;
	switch(slot)
	{
		case 0 .. 10:
		{
			Character[playerid][cChooseSlot] = slot;
			format(header, sizeof(header), "{E2B960}Telefon: {FFFFFF}%d", Character[playerid][cPhoneNumber]);
			Dialog_Show(playerid, CHOSENSLOT, DIALOG_STYLE_LIST, header, "Ara\nKiþi Düzenle\nKiþiyi Sil", "Seç", "Kapat");
		}
	}
	return true;
}

Dialog:CHOSENSLOT(playerid, response, listitem, inputtext[])
{
	if(!response) return Character[playerid][cChooseSlot] = -1, true;

	new slot = Character[playerid][cChooseSlot];

	new header[128];
	switch(listitem)
	{
		case 0:
		{
			new number = Directory[playerid][slot][dNumber];
			if(!CheckNumber(number)) return SendServerMessage(playerid, "Geçersiz numara girdiniz.");
			if(!CheckPhone(number)) return SendServerMessage(playerid, "Aradýðýnýz kiþiye ulaþýlamýyor.");

			new numberowner = GetNumberOwner(number);

			Character[playerid][cChooseSlot] = -1;
			CreateCall(playerid, numberowner);
		}
		case 1:
		{
			format(header, sizeof(header), "{E2B960}Telefon: {FFFFFF}%d", Character[playerid][cPhoneNumber]);
			Dialog_Show(playerid, EDITDIRECTORY, DIALOG_STYLE_LIST, header, "Numara Düzenle\nÝsim Düzenle", "Seç", "Kapat");
		}
		case 2:
		{
			DeleteDirectory(playerid, slot);
		}
	}
	return true;
}

Dialog:EDITDIRECTORY(playerid, response, listitem, inputtext[])
{
	if(!response) return Character[playerid][cChooseSlot] = -1, true;

	new header[128];

	format(header, sizeof(header), "{E2B960}Telefon: {FFFFFF}%d", Character[playerid][cPhoneNumber]);
	switch(listitem)
	{
		case 0: Dialog_Show(playerid, EDITNUMBER, DIALOG_STYLE_INPUT, header, "{FFFFFF}Lütfen bu kiþi için yeni bir numara girin:", "Seç", "Kapat");
		case 1: Dialog_Show(playerid, EDITNAME, DIALOG_STYLE_INPUT, header, "{FFFFFF}Lütfen bu kiþi için yeni bir isim girin:", "Seç", "Kapat");
	}
	return true;
}

Dialog:EDITNUMBER(playerid, response, listitem, inputtext[])
{
	if(!response) return Character[playerid][cChooseSlot] = -1, true;

	new slot = Character[playerid][cChooseSlot];
	if(!CheckNumber(strval(inputtext))) return SendServerMessage(playerid, "Geçersiz numara girdiniz.");

	Directory[playerid][slot][dNumber] = strval(inputtext);
	SendServerMessage(playerid, "%d slottaki %s isimli kiþinin numarasýný %d olarak güncellediniz.", slot, Directory[playerid][slot][dName], Directory[playerid][slot][dName]);
	Character[playerid][cChooseSlot] = -1;
	return true;
}

Dialog:EDITNAME(playerid, response, listitem, inputtext[])
{
	if(!response) return Character[playerid][cChooseSlot] = -1, true;

	new slot = Character[playerid][cChooseSlot];
	if(strlen(inputtext) < 0 || strlen(inputtext) > 32) return SendServerMessage(playerid, "Geçersiz karakter girdiniz (0-24).");

	format(Directory[playerid][slot][dName], 128, "%s", inputtext);
	SendServerMessage(playerid, "%d slottaki kiþinin ismini %s olarak güncellediniz.", Directory[playerid][slot][dName]);
	Character[playerid][cChooseSlot] = -1;
	return true;
}