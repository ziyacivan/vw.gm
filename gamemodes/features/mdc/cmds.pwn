CMD:mdc(playerid, params[])
{
	if(!Character[playerid][cFaction]) return SendServerMessage(playerid, "Bir olu�uma �ye de�ilsiniz.");

	new factid = GetPlayerFactionID(playerid);
	new vehid = GetPlayerVehicleID(playerid);
	if(!IsPlayerInAnyVehicle(playerid)) return SendServerMessage(playerid, "Ara�ta olmal�s�n�z.");
	if(Vehicle[vehid][vFaction] != 1) return SendServerMessage(playerid, "LSPD arac�nda olmal�s�n�z.");
	if(Faction[factid][fType] != 1) return SendServerMessage(playerid, "Bu komutu kullanamazs�n�z.");

	Dialog_Show(playerid, MDC, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Ki�i Sorgulama\nPlaka Sorgulama\nAdres Sorgulama\nSicil Kayd� Ekleme\nSon �hbarlar", "Se�", "Kapat");
	return true;
}

Dialog:MDC(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			Dialog_Show(playerid, MDC_SEARCH_PEOPLE, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Kimlik Numaras� Sorgula\n�sim Sorgula", "Se�", "<<");
		}
		case 1:
		{
			Dialog_Show(playerid, MDC_SEARCH_PLATE, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "{FFFFFF}Sorgulamak istedi�iniz arac�n plakas�n� girin (LS 1234):", "Sorgula", "Kapat");
		}
		case 2:
		{
			Dialog_Show(playerid, MDC_SEARCH_ADRESS, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "Ev Adresi Sorgula\n��letme Adresi Sorgula", "Se�", "<<");
		}
		case 3:
		{
			Dialog_Show(playerid, MDC_REGISTRY_RECORD, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "Kay�t olu�turmak istedi�iniz ki�inin ismini girin (John_Doe):", "Devam", "<<");
		}
		case 4:
		{
			new str[1024], Cache:data, id, reporter, location[64], date[24], reporterName[24];
			
			data = mysql_query(conn, "SELECT * FROM reports ORDER BY id DESC LIMIT 10", true);

			if(!cache_num_rows()) return SendServerMessage(playerid, "Hi� ihbar bulunamad�.");
			format(str, sizeof(str), "ID\t\tG�nderen\t\t\tKonum\t\t\t\tTarih\n");

			for(new i; i < cache_num_rows(); i++)
			{
				cache_get_value_name_int(i, "id", id);
				cache_get_value_name_int(i, "reporter", reporter);
				cache_get_value_name(i, "place", location);
				cache_get_value_name(i, "date", date);

				format(reporterName, 24, "%s", GetNameFromSQLID(reporter));
				strreplace(reporterName, '_', ' ');

				format(str, sizeof(str), "%s{19870B}%d:\t\t%s\t\t\t%s\t\t%s\n", str, id, reporterName, location, date);
			}
			Dialog_Show(playerid, MDC_REPORTS, DIALOG_STYLE_LIST, "Vinewood - MDC (Son �hbarlar)", str, "�ncele", "Kapat");
			cache_delete(data);
		}
	}
	return true;
}

Dialog:MDC_REPORTS(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Ki�i Sorgulama\nPlaka Sorgulama\nAdres Sorgulama\nSicil Kayd� Ekleme\nSon �hbarlar", "Se�", "Kapat");
	
	new str[128], query[128], character, situation[255], id, Cache:data, header[128];
	format(str, 128, "%s", inputtext);
	
	for(new i; i < sizeof(str); i++)
	{
		if(str[i] == ':')
		{
			character = i;
			break;
		}
	}
	strdel(str, character, sizeof(str));
	
	mysql_format(conn, query, sizeof(query), "SELECT * FROM reports WHERE id = '%i'", strval(str));
	data = mysql_query(conn, query, true);

	cache_get_value_name_int(0, "id", id);
	cache_get_value_name(0, "situation", situation, 255);

	format(header, sizeof(header), "Vinewood - �hbar [#%d]", id);
	Dialog_Show(playerid, NONE, DIALOG_STYLE_MSGBOX, header, situation, "Tamam", "");

	cache_delete(data);
	return true;
}

Dialog:MDC_SEARCH_PEOPLE(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Ki�i Sorgulama\nPlaka Sorgulama\nAdres Sorgulama\nSicil Kayd� Ekleme\nSon �hbarlar", "Se�", "Kapat");

	switch(listitem)
	{
		case 0:
		{
			Dialog_Show(playerid, MDC_SEARCH_PEOPLE_ID, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "{FFFFFF}Sorgulamak istedi�iniz kimlik numaras�n� girin:", "Sorgula", "<<");
		}
		case 1:
		{
			Dialog_Show(playerid, MDC_SEARCH_PEOPLE_NAME, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "{FFFFFF}Sorgulamak istedi�iniz ismi girin (John_Doe):", "Sorgula", "<<");
		}
	}
	return true;
}

Dialog:MDC_SEARCH_PEOPLE_ID(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC_SEARCH_PEOPLE, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Kimlik Numaras� Sorgula\n�sim Sorgula", "Se�", "<<");
	if(strval(inputtext) < 111111 || strval(inputtext) > 999999) return SendServerMessage(playerid, "Ge�ersiz kimlik numaras� girdiniz.");

	new query[124], Cache:GetData, ino = strval(inputtext);
	mysql_format(conn, query, sizeof(query), "SELECT * FROM characters WHERE Identity = '%i'", ino);
	GetData = mysql_query(conn, query);

	if(cache_num_rows())
	{
		// variables
		new mdc_cname_dbid, mdc_cname[144], mdc_age, mdc_sex, mdc_skincolor, mdc_origin, mdc_identity;

		cache_get_value_name_int(0, "id", mdc_cname_dbid);
		cache_get_value_name(0, "Character_Name", mdc_cname);
		cache_get_value_name_int(0, "Age", mdc_age);
		cache_get_value_name_int(0, "Sex", mdc_sex);
		cache_get_value_name_int(0, "SkinColor", mdc_skincolor);
		cache_get_value_name_int(0, "Origin", mdc_origin);
		cache_get_value_name_int(0, "Identity", mdc_identity);

		new sextext[64], skincolortext[64];
		switch(mdc_sex)
		{
			case 0: sextext = "Yok";
			case 1: sextext = "Erkek";
			case 2: sextext = "Kad�n";
		}
		switch(mdc_skincolor)
		{
			case 0: skincolortext = "Yok";
			case 1: skincolortext = "Beyaz";
			case 2: skincolortext = "Siyahi";
		}

		SendClientMessageEx(playerid, -1, "{F0F2A5}%s ki�isinin bilgileri:", mdc_cname);
		SendClientMessageEx(playerid, -1, "[K�ML�K] Ya�: [%d] | Cinsiyet: [%s] | Ten Rengi: [%s] | K�ken: [%s] | Kimlik No: [%d]", mdc_age, sextext, skincolortext, Countries[mdc_origin], mdc_identity);
		for(new i; i < MAX_HOUSES; i++)
		{
			if(House[i][hIsValid])
			{
				if(House[i][hOwner] == mdc_cname_dbid)
				{
					SendClientMessageEx(playerid, -1, "[M�LK] Ev Kap� Numaras�: [%d] | Adres:[%s]", House[i][hDoorNumber], GetLocation(House[i][hExtDoor][0], House[i][hExtDoor][1], House[i][hExtDoor][2]));
				}
			}
		}
		for(new i; i < MAX_VEHICLES; i++)
		{
			if(Vehicle[i][vIsValid])
			{
				if(Vehicle[i][vOwner] == mdc_cname_dbid)
				{
					SendClientMessageEx(playerid, -1, "[ARA�] Ara� ID: [%d] | Model: [%s] | Renk: [%d/%d] | Plaka: [%s]", i, GetVehicleName(i), Vehicle[i][vColor1], Vehicle[i][vColor2], Vehicle[i][vPlate]);
				}
			}
		}
	}
	else
	{
		Dialog_Show(playerid, MDC_SEARCH_PEOPLE_ID_SCREEN, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - MDC", "{FFFFFF}Ki�i bilgileri bulunamad�.", "Kapat", "");
	}
	cache_delete(GetData);
	return true;
}

Dialog:MDC_SEARCH_PEOPLE_NAME(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC_SEARCH_PEOPLE, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Kimlik Numaras� Sorgula\n�sim Sorgula", "Se�", "<<");

	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM characters WHERE Character_Name = '%e'", inputtext);
	GetData = mysql_query(conn, query);

	if(cache_num_rows())
	{
		// variables
		new mdc_cname_dbid, mdc_cname[144], mdc_age, mdc_sex, mdc_skincolor, mdc_origin, mdc_identity;

		cache_get_value_name_int(0, "id", mdc_cname_dbid);
		cache_get_value_name(0, "Character_Name", mdc_cname);
		cache_get_value_name_int(0, "Age", mdc_age);
		cache_get_value_name_int(0, "Sex", mdc_sex);
		cache_get_value_name_int(0, "SkinColor", mdc_skincolor);
		cache_get_value_name_int(0, "Origin", mdc_origin);
		cache_get_value_name_int(0, "Identity", mdc_identity);

		new sextext[64], skincolortext[64];
		switch(mdc_sex)
		{
			case 0: sextext = "Yok";
			case 1: sextext = "Erkek";
			case 2: sextext = "Kad�n";
		}
		switch(mdc_skincolor)
		{
			case 0: skincolortext = "Yok";
			case 1: skincolortext = "Beyaz";
			case 2: skincolortext = "Siyahi";
		}

		SendClientMessageEx(playerid, -1, "{F0F2A5}%s ki�isinin bilgileri:", mdc_cname);
		SendClientMessageEx(playerid, -1, "[K�ML�K] Ya�: [%d] | Cinsiyet: [%s] | Ten Rengi: [%s] | K�ken: [%s] | Kimlik No: [%d]", mdc_age, sextext, skincolortext, Countries[mdc_origin], mdc_identity);
		for(new i; i < MAX_HOUSES; i++)
		{
			if(House[i][hIsValid])
			{
				if(House[i][hOwner] == mdc_cname_dbid)
				{
					SendClientMessageEx(playerid, -1, "[M�LK] Ev Kap� Numaras�: [%d] | Adres: [%s]", House[i][hDoorNumber], GetLocation(House[i][hExtDoor][0], House[i][hExtDoor][1], House[i][hExtDoor][2]));
				}
			}
		}
		for(new i; i < MAX_VEHICLES; i++)
		{
			if(Vehicle[i][vIsValid])
			{
				if(Vehicle[i][vOwner] == mdc_cname_dbid)
				{
					SendClientMessageEx(playerid, -1, "[ARA�] Ara� ID: [%d] | Model: [%s] | Renk: [%d/%d] | Plaka: [%s]", i, GetVehicleName(i), Vehicle[i][vColor1], Vehicle[i][vColor2], Vehicle[i][vPlate]);
				}
			}
		}
	}
	else
	{
		Dialog_Show(playerid, MDC_SEARCH_PEOPLE_NAME_SCREEN, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - MDC", "{FFFFFF}Ki�i bilgileri bulunamad�.", "Kapat", "");
	}
	cache_delete(GetData);
	return true;
}

Dialog:MDC_SEARCH_PLATE(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Ki�i Sorgulama\nPlaka Sorgulama\nAdres Sorgulama\nSicil Kayd� Ekleme\nSon �hbarlar", "Se�", "Kapat");

	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM vehicles WHERE Plate = '%e'", inputtext);
	GetData = mysql_query(conn, query);

	if(cache_num_rows())
	{
		new mdc_owner, mdc_model, mdc_color1, mdc_color2, mdc_plate[32];
		cache_get_value_name_int(0, "Owner", mdc_owner);
		cache_get_value_name_int(0, "Model", mdc_model);
		cache_get_value_name_int(0, "Color1", mdc_color1);
		cache_get_value_name_int(0, "Color2", mdc_color2);
		cache_get_value_name(0, "Plate", mdc_plate, 32);

		new dialogstr[256];
		format(dialogstr, sizeof(dialogstr), "{F0F2A5}%s plakal� arac�n bilgileri:\n\n{FFFFFF}Ara� sahibi: %s\n{FFFFFF}Model: %d\n{FFFFFF}Renkler: %d - %d\n{FFFFFF}Plaka: %s", mdc_plate, GetVehicleOwnerName(mdc_owner), mdc_model, mdc_color1, mdc_color2, mdc_plate);
		Dialog_Show(playerid, MDC_SEARCH_PLATE_SCREEN, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - MDC", dialogstr, "Kapat", "");
	}
	else
	{
		Dialog_Show(playerid, MDC_SEARCH_PLATE_SCREEN, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - MDC", "{FFFFFF}Ara� bulunamad�.", "Kapat", "");
	}
	cache_delete(GetData);
	return true;
}

Dialog:MDC_SEARCH_ADRESS(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Ki�i Sorgulama\nPlaka Sorgulama\nAdres Sorgulama\nSicil Kayd� Ekleme\nSon �hbarlar", "Se�", "Kapat");

	switch(listitem)
	{
		case 0:
		{
			Dialog_Show(playerid, MDC_SEARCH_ADRESS_HOUSE, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "Sorgulamak istedi�iniz evin adresini girin(ev kap� numaras�):", "Sorgula", "Kapat");
		}
		case 1:
		{
			SendServerMessage(playerid, "Bu b�l�m kullan�lam�yor.");
			//Dialog_Show(playerid, MDC_SEARCH_ADRESS_BUSINESS, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "Sorgulamak istedi�iniz i�letme adresini girin(i�letme kap� numaras�):", "Sorgula", "Kapat");
		}
	}
	return true;
}

Dialog:MDC_SEARCH_ADRESS_HOUSE(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC_SEARCH_ADRESS, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "Ev Adresi Sorgula\n��letme Adresi Sorgula", "Se�", "<<");

	new data[24];

	format(data, 24, "%s", inputtext);

	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM houses WHERE Door_Number = '%i'", strval(data));
	GetData = mysql_query(conn, query);

	if(cache_num_rows())
	{
		new houseowner, doornumber;
		cache_get_value_name_int(0, "Owner", houseowner);
		cache_get_value_name_int(0, "Door_Number", doornumber);

		new dialogstr[124];
		format(dialogstr, sizeof(dialogstr), "{F0F2A5}%d kap� numaral� evin bilgileri:\n\n{FFFFFF}Evin sahibi: %s\n{FFFFFF}Kap� numaras�: %d", GetHouseOwnerName(houseowner), doornumber);
		Dialog_Show(playerid, MDC_SEARCH_ADRESS_HOUSE_SCREEN, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - MDC", dialogstr, "Kapat", "");
	}
	else
	{
		Dialog_Show(playerid, MDC_SEARCH_ADRESS_HOUSE_SCREEN, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - MDC", "{FFFFFF}Ev bulunamad�.", "Kapat", "");
	}
	cache_delete(GetData);
	return true;
}

Dialog:MDC_REGISTRY_RECORD(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC, DIALOG_STYLE_LIST, "Vinewood Roleplay - MDC", "Ki�i Sorgulama\nPlaka Sorgulama\nAdres Sorgulama\nSicil Kayd� Ekleme\nSon �hbarlar", "Se�", "Kapat");

	format(MDC_REGISTRY[playerid], 144, "%s", inputtext);
	Dialog_Show(playerid, MDC_REGISTRY_RECORD2, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "Eklenecek su�u girin:", "Olu�tur", "<<");
	return true;
}

Dialog:MDC_REGISTRY_RECORD2(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, MDC_REGISTRY_RECORD, DIALOG_STYLE_INPUT, "Vinewood Roleplay - MDC", "Kay�t olu�turmak istedi�iniz ki�inin ismini girin (John_Doe):", "Devam", "<<");

	new name[144], reason[144], officer[144], date[144];
	format(name, 144, "%s", MDC_REGISTRY[playerid]);
	format(reason, 144, "%s", inputtext);
	format(officer, 144, "%s", GetRPName(playerid));

	for(new i; i < sizeof(name); i++) {
		if(name[i] == '_') {
			strreplace(name, '_', ' ');
			break;
		}
	}

	new hour, minute, second, year, month, day;
	gettime(hour, minute, second);
	getdate(year, month, day);
	format(date, 144, "%d/%d/%d - %d:%d:%d", day, month, year, hour, minute, second);

	new query[124], Cache:InsertData;
	mysql_format(conn, query, sizeof(query), "INSERT INTO registry_records (Name, Reason, Officer, Date) VALUES ('%e', '%e', '%e', '%e')",
		name, reason, officer, date);
	InsertData = mysql_query(conn, query);
	cache_delete(InsertData);

	SendFactionMessage(Faction[GetPlayerFactionID(playerid)][fID], C_FACTION, "* %s adl� memur, %s adl� ki�i ad�na ceza kayd� girdi.", GetRPName(playerid), name);
	return true;
}