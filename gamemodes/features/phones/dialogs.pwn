Dialog:DIALOG_PHONE(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			GetPhoneMessagesInbox(playerid, Character[playerid][cPhoneID]);
		}
		case 1:
		{
			GetPhoneMessagesSendBox(playerid, Character[playerid][cPhoneID]);
		}
		case 2:
		{
			//GetPhoneLastCalls(playerid, Character[playerid][cPhoneID]);
		}
		case 3:
		{
			Dialog_Show(playerid, DIALOG_DIRECTORY, DIALOG_STYLE_LIST, "Vinewood Roleplay - Telefon", "Kiþiler\nKiþi Ekle\nKiþi Sil", "Seç", "<<");
		}
		case 5:
		{
			new phoneid = Character[playerid][cPhoneID];
			Phone[phoneid][phStatus] = 0;
			SendServerMessage(playerid, "Telefonu kapattýnýz.");
		}
	}
	return true;
}

Dialog:SHOW_INBOX_MESSAGES(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, DIALOG_PHONE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Telefon", "Gelen Kutusu\nGiden Kutusu\nSon Aramalar\nRehber\n{000000}_\nTelefonu Kapat", "Seç", "Kapat");

	new test[128], message_id;
	format(test, 128, "%s", inputtext);
	for(new i; i < sizeof(test); i++)
	{
		if(test[i] == ':')
		{
		 	message_id = i;
			break;
		}
	}
	strdel(test, message_id, sizeof(test));

	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM phones_inbox_messages WHERE messageid = '%i'", strval(test));
	GetData = mysql_query(conn, query);

	new message_senderphone, message_text[144], message_date[144];

	cache_get_value_name_int(0, "senderphone", message_senderphone);
	cache_get_value_name(0, "message_text", message_text, 144);
	cache_get_value_name(0, "message_date", message_date, 144);

	new string[1044];
	format(string, sizeof string, "{FFFFFF}Gönderen: %d - [%s]\n{FFFFFF}Mesaj: %s", message_senderphone, message_date, message_text);
	Dialog_Show(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Gelen Mesaj", string, "Kapat", "");
	cache_delete(GetData);
	return true;
}

Dialog:SHOW_SENDBOX_MESSAGES(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, DIALOG_PHONE, DIALOG_STYLE_TABLIST, "Vinewood Roleplay - Telefon", "Gelen Kutusu\nGiden Kutusu\nSon Aramalar\nRehber\n{000000}_\nTelefonu Kapat", "Seç", "Kapat");

	new test[128], sender_phone;
	format(test, 128, "%s", inputtext);
	for(new i; i < sizeof(test); i++)
	{
		if(test[i] == ':')
		{
		 	sender_phone = i;
		}
	}
	strdel(test, sender_phone, sizeof(test));

	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM phones_inbox_messages WHERE senderphone = '%i'", strval(test));
	GetData = mysql_query(conn, query);

	new message_senderphone, message_text[144], message_date[144];

	cache_get_value_name_int(0, "senderphone", message_senderphone);
	cache_get_value_name(0, "message_text", message_text, 144);
	cache_get_value_name(0, "message_date", message_date, 144);

	new string[1044];
	format(string, sizeof string, "{FFFFFF}Alýcý: %d - [%s]\n{FFFFFF}Mesaj: %s", GetPhoneNumberFromSQLID(message_senderphone), message_date, message_text);
	Dialog_Show(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, "Vinewood Roleplay - Giden Mesaj", string, "Kapat", "");
	cache_delete(GetData);
	return true;
}

Dialog:DIALOG_DIRECTORY(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, DIALOG_PHONE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Telefon", "Gelen Kutusu\nGiden Kutusu\nSon Aramalar\nRehber\n{000000}_\nTelefonu Kapat", "Seç", "Kapat");

	switch(listitem)
	{
		case 0:
		{
			new query[124], Cache:GetData, phoneid = Character[playerid][cPhoneID];
			mysql_format(conn, query, sizeof(query), "SELECT * FROM phones_directory WHERE phoneid = '%i' LIMIT 10", Phone[phoneid][phID]);
			GetData = mysql_query(conn, query);

			if(!cache_num_rows()) return SendServerMessage(playerid, "Kiþi bulunamadý.");
	
			new directoryid, name[144], number;

			new rows, fields, string[1044];
			cache_get_row_count(rows);
			cache_get_field_count(fields);

			for(new i; i < rows; i++)
			{
				cache_get_value_name_int(i, "directoryid", directoryid);
				cache_get_value_name(i, "name", name, 144);
				cache_get_value_name_int(i, "number", number);

				format(string, sizeof string, "%s%i: %s - %d\n", string, directoryid, name, number);
			}
			Dialog_Show(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Kiþiler", string, "Kapat", "");
			cache_delete(GetData);
		}
		case 1:
		{
			Dialog_Show(playerid, ADD_DIRECTORY, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Kiþi Ekle", "{FFFFFF}Rehbere eklemek istediðiniz kiþinin ismini girin:", "Devam", "<<");
		}
		case 2:
		{
			Dialog_Show(playerid, DELETE_DIRECTORY, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Kiþi Sil", "{FFFFFF}Rehberden silmek istediðiniz kiþinin slot numarasýný girin:", "Devam", "<<");
		}
	}
	return true;
}

Dialog:ADD_DIRECTORY(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, DIALOG_DIRECTORY, DIALOG_STYLE_LIST, "Vinewood Roleplay - Telefon", "Kiþiler\nKiþi Ekle\nKiþi Sil", "Seç", "<<");
	if(strlen(inputtext) < 3 || strlen(inputtext) > 144) return SendServerMessage(playerid, "Geçersiz karakter sayýsý girdiniz.");

	format(AddDirectoryName[playerid], 144, "%s", inputtext);
	Dialog_Show(playerid, ADD_DIRECTORY2, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Kiþi Ekle", "{FFFFFF}Rehbere eklemek istediðiniz kiþinin numarasýný girin:", "Ekle", "<<");
	return true;
}

Dialog:ADD_DIRECTORY2(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, ADD_DIRECTORY, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Kiþi Ekle", "{FFFFFF}Rehbere eklemek istediðiniz kiþinin ismini girin:", "Devam", "<<");
	if(strval(inputtext) < 111111 || strval(inputtext) > 999999) return SendServerMessage(playerid, "Geçersiz numara girdiniz.");

	new phoneid = Character[playerid][cPhoneID];
	new query[512], Cache:InsertData;
	mysql_format(conn, query, sizeof(query), "INSERT INTO phones_directory (phoneid, name, number) VALUES (%i, '%e', %i)", Phone[phoneid][phID], AddDirectoryName[playerid], strval(inputtext)); 
	InsertData = mysql_query(conn, query);
	cache_delete(InsertData);

	SendServerMessage(playerid, "%s rehbere kaydedildi.", AddDirectoryName[playerid]);
	return true;
}

Dialog:DELETE_DIRECTORY(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, DIALOG_DIRECTORY, DIALOG_STYLE_LIST, "Vinewood Roleplay - Telefon", "Kiþiler\nKiþi Ekle\nKiþi Sil", "Seç", "<<");
	if(!IsValidDirectoryID(Character[playerid][cPhoneID], strval(inputtext))) return SendServerMessage(playerid, "Kiþi bulunamadý.");

	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM phones_directory WHERE directoryid = '%i'", strval(inputtext));
	DeleteData = mysql_query(conn, query);

	SendServerMessage(playerid, "Kiþi rehberden silindi.");
	cache_delete(DeleteData);
	return true;
}

Dialog:DIALOG_911_1(playerid, response, listitem, inputtext[])
{
	if(!response) return true;
	if(!strfind(inputtext, "lspd", false) || !strfind(inputtext, "lsfd", false) || !strfind(inputtext, "lsmd", false)) return Dialog_Show(playerid, DIALOG_911_1, DIALOG_STYLE_INPUT, "Vinewood - 911 Hattý [#1]", "Operatör: 911 çaðrý hattý, kullanmak istediðiniz servis? (LSPD/LSFD/LSMD)", "Devam Et", "Kapat");	
	
	new service = 0;
	
	if(strfind(inputtext, "lspd", false)) service = FACTION_POLICE;
	if(strfind(inputtext, "lsfd", false)) service = FACTION_FD;
	if(strfind(inputtext, "lsmd", false)) service = FACTION_MEDIC;

	SetPVarInt(playerid, "911_FACTION", service);
	Dialog_Show(playerid, DIALOG_911_2, DIALOG_STYLE_INPUT, "Vinewood - 911 Hattý [#2]", "Operatör: Yaþadýðýnýz sorun nedir?", "Devam Et", "<<");
	return true;
}

Dialog:DIALOG_911_2(playerid, response, listitem, inputtext[])
{
	if(!response || strlen(inputtext) > 255) return Dialog_Show(playerid, DIALOG_911_2, DIALOG_STYLE_INPUT, "Vinewood - 911 Hattý [#2]", "Operatör: Yaþadýðýnýz sorun nedir?", "Devam Et", "<<");
	SetPVarString(playerid, "911_SITUATION", inputtext);
	Dialog_Show(playerid, DIALOG_911_3, DIALOG_STYLE_INPUT, "Vinewood - 911 Hattý [#3]", "Operatör: Bulunduðunuz konum:", "Gönder", "<<");
	return true;
}

Dialog:DIALOG_911_3(playerid, response, listitem, inputtext[])
{
	if(!response || strlen(inputtext) > 255) return Dialog_Show(playerid, DIALOG_911_3, DIALOG_STYLE_INPUT, "Vinewood - 911 Hattý [#3]", "Operatör: Bulunduðunuz konum:", "Gönder", "<<");
	
	new service = GetPVarInt(playerid, "911_FACTION"), situation[256], Cache:data, query[256];
	GetPVarString(playerid, "911_SITUATION", situation, 256);

	mysql_format(conn, query, sizeof(query), "INSERT INTO reports(faction, reporter, situation, place) VALUES(%d, %d, '%e', '%e')",
		service,
		Character[playerid][cID],
		situation,
		inputtext
	);
	data = mysql_query(conn, query, true);

	SendFactionMessage(service, -1, "%s adlý kiþiden bir ihbar var.", Character[playerid][cName]);
	SendFactionMessage(service, -1, "Durum: %s", situation);
	SendFactionMessage(service, -1, "Konum: %s", inputtext);

	cache_delete(data);

	new phoneid = Character[playerid][cPhoneID];
	Phone[phoneid][phCalling] = 0;
	Character[playerid][cPhoneID] = 0;
	return true;
}