Vinewood:PhoneList(playerid, targetid)
{
	foreach(new i: Phones)
	{
		if(Phone[i][phIsValid])
		{
			if(Phone[i][phOwner] == Character[playerid][cID])
			{
				SendClientMessageEx(targetid, C_GREY1, "ID: %d - Numara: %d", i, Phone[i][phNumber]);
			}
		}
	}
	return true;
}

Vinewood:IsOwnerPhone(playerid, phoneid)
{
	new status = 0;
	if(Phone[phoneid][phOwner] == Character[playerid][cID])
		status = 1;
	return status;
}

Vinewood:IsHavePhone(playerid)
{
	new status;
	foreach(new i : Phones)
	{
		if(Phone[i][phIsValid])
		{
			if(Phone[i][phOwner] == Character[playerid][cID])
			{
				status = 1;
				break;
			}
		}
	}
	return status;
}

Vinewood:GetPhoneMessagesInbox(playerid, phoneid)
{
	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM phones_inbox_messages WHERE phoneID = '%i' LIMIT 10", Phone[phoneid][phID]);
	GetData = mysql_query(conn, query);

	new rows, fields, string[1044];
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	new messageID, message_Date[144], message_senderphone;
	if(cache_num_rows())
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "messageid", messageID);
			cache_get_value_name(i, "message_date", message_Date, 144);
			cache_get_value_name_int(i, "senderphone", message_senderphone);

			format(string, sizeof string, "%s%i: - %i - [%s]", string, messageID, GetPhoneNumberFromSQLID(message_senderphone), message_Date);
		}
		Dialog_Show(playerid, SHOW_INBOX_MESSAGES, DIALOG_STYLE_LIST, "Vinewood Roleplay - Mesajlarým", string, "Seç", "<<");
	}
	else return SendServerMessage(playerid, "Mesaj geçmiþi bulunamadý.");
	cache_delete(GetData);
	return true;
}

Vinewood:GetPhoneMessagesSendBox(playerid, phoneid)
{
	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM phones_inbox_messages WHERE senderphone = '%i' LIMIT 10", Phone[phoneid][phID]);
	GetData = mysql_query(conn, query);

	new rows, fields, string[1044];
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	new messageID, message_senderphone, message_Date[144], message_text[144];
	if(cache_num_rows())
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "messageid", messageID);
			cache_get_value_name(i, "message_text", message_text, 144);
			cache_get_value_name(i, "message_date", message_Date, 144);
			cache_get_value_name_int(i, "senderphone", message_senderphone);

			format(string, sizeof string, "%s%i: - %i - [%s]", string, messageID, GetPhoneNumberFromSQLID(message_senderphone), message_Date);
		}
		Dialog_Show(playerid, SHOW_SENDBOX_MESSAGES, DIALOG_STYLE_LIST, "Vinewood Roleplay - Mesajlarým", string, "Seç", "<<");
	}
	cache_delete(GetData);
	return true;
}

Vinewood:InsertSMSData(playerid, phoneid, text[])
{
	new day, month, year, hour, minute, second;
	gettime(hour, minute, second);
	getdate(year, month, day);
	new date[144];
	format(date, 144, "%d/%d/%d - %d:%d:%d", day, month, year, hour, minute, second);

	new query[512], Cache:InsertData;
	mysql_format(conn, query, sizeof(query), "INSERT INTO phones_inbox_messages (message_text, message_date, senderphone) VALUES ('%e', '%e', %i)", text, date, Phone[phoneid][phID]);
	InsertData = mysql_query(conn, query);

	SendServerMessage(playerid, "SMS gönderildi!");
	cache_delete(InsertData);
	return true;
}

Vinewood:SearchPlayer(targetid, playerid)
{
	new weaponName[24];

	SendClientMessageEx(playerid, C_DGREEN, "[%s'in üstünden çýkanlar:]\n___________________", GetRPName(targetid));

	foreach(new i : Phones) if(Phone[i][phIsValid]) {
		if(Phone[i][phOwner] == Character[targetid][cID]) {
			SendClientMessageEx(playerid, C_VINEWOOD, "Telefon: [%d] - Numara: [%d]", i, Phone[i][phNumber]);
		}
	}

	foreach(new i : Weapons) if(Weapon[i][wIsValid]) {
		if(Weapon[i][wOwner] == Character[targetid][cID]) {
			GetWeaponName(Weapon[i][wWeaponID], weaponName, 24);
			SendClientMessageEx(playerid, C_VINEWOOD, "Silah: [%d] - Model: [%s] - Mermi[%d]", i, weaponName, Weapon[i][wAmmo]);
		}
	}

	if(Character[targetid][cCigaratte] > 0) SendClientMessageEx(playerid, C_VINEWOOD, "Sigara: %d tane", Character[targetid][cCigaratte]);
	SendClientMessageEx(playerid, C_VINEWOOD, "Para: $%d", Character[targetid][cMoney]);
	if(Character[targetid][cToolkit]) SendClientMessageEx(playerid, C_VINEWOOD, "Alet Çantasý: 1 tane");
	if(Character[targetid][cSkeletonKey]) SendClientMessageEx(playerid, C_VINEWOOD, "Mamyuncuk: 1 tane");

	IsSendSearchOffer[targetid] = 0;
	SearchOfferSender[targetid] = 0;
	return true;
}

Vinewood:SendSearchOffer(targetid, playerid)
{
	IsSendSearchOffer[targetid] = 1;
	SearchOfferSender[targetid] = playerid;
	SendClientMessageEx(targetid, C_VINEWOOD, "%s tarafýndan üst arama isteði gönderildi. Kabul etmek için /kabulet ustara", GetRPName(playerid));
	return true;
}

Vinewood:GetPhoneNumberFromSQLID(phonesqlid)
{
	new number;
	foreach(new i: Phones)
	{
		if(Phone[i][phIsValid])
		{
			if(Phone[i][phID] == phonesqlid)
				number = Phone[i][phNumber];
		}
	}
	return number;
}

Vinewood:GetPhoneIDFromNumber(number)
{
	new phoneid;
	foreach(new i: Phones)
	{
		if(Phone[i][phIsValid])
			if(Phone[i][phNumber] == number)
				phoneid = i;
	}
	return phoneid;
}

Vinewood:GetOwnerIDFromNumber(number)
{
	new id, idx;
	foreach(new i: Phones)
	{
		if(Phone[i][phIsValid])
		{
			if(Phone[i][phNumber] == number)
			{
				if(Phone[i][phOwner])
				{
					id = Phone[i][phOwner];
					idx = GetPlayerIDFromSQLID(id);
				}
			}
		}
	}
	return idx;
}

Vinewood:IsValidDirectoryID(phoneid, directoryid)
{
	new status;
	new query[124], Cache:GetData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM phones_directory WHERE phoneid = '%i' AND directoryid = '%i'", Phone[phoneid][phID], directoryid);
	GetData = mysql_query(conn, query);

	if(cache_num_rows())
		status = 1;
	cache_delete(GetData);
	return status;
}

Vinewood:IsValidNumber(number)
{
	new status;
	foreach(new i: Phones)
	{
		if(Phone[i][phIsValid])
			if(Phone[i][phNumber] == number || number == 911)
				status = 1;
	}
	return status;
}

Vinewood:GetCallerIDFromPhoneID(phoneid)
{
	new id;
	foreach(new i: Phones)
	{
		if(Phone[i][phIsValid])
			if(Phone[i][phOwner])
				id = GetPlayerIDFromSQLID(Phone[i][phOwner]);
	}
	return id;
}

Vinewood:GetClosestPhone(playerid)
{
	new id;
	foreach(new i : Phones)
	{
		if(Phone[i][phIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Phone[i][phPos][0], Phone[i][phPos][1], Phone[i][phPos][2]))
				id = i;
		}
	}
	return id;
}

Vinewood:PhoneTimer(playerid)
{
	if(InCall[playerid])
	{
		GameTextForPlayer(playerid, "~g~-$5", 5000, 4);
		return GiveMoney(playerid, -1*CALL_COST);
	}
	KillTimer(CallTimer[playerid]);
	return true;
}

stock PhoneDirectoryName(playerid)
{
	new query[128], Cache:data, caller[32], dName[32];

	mysql_format(conn, query, sizeof(query), "SELECT * FROM phone_directory WHERE phoneid = %d AND number = %d LIMIT 1",
		Phone[Character[playerid][cPhoneID]][phID],
		Phone[Character[playerid][cPhoneID]][phNumber]
	);
	data = mysql_query(conn, query, true);

	if(cache_num_rows())
	{ 
		cache_get_value_name(0, "name", dName, 32);
		format(caller, 32, "%s", dName);
	}
	else format(caller, 32, "%d", Phone[Character[playerid][cPhoneID]][phNumber]);

	cache_delete(data);
	return caller;
}