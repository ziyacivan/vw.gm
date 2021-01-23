Vinewood:LoadBusiness()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	Iter_Add(Business, 0);

	for(new i = 0; i < rows; i++)
	{
		Business[i+1][bsIsValid] = true;

		cache_get_value_name_int(i, "id", Business[i+1][bsID]);
		cache_get_value_name_int(i, "Owner", Business[i+1][bsOwner]);
		cache_get_value_name_int(i, "Price", Business[i+1][bsPrice]);
		cache_get_value_name(i, "Name", Business[i+1][bsName], 124);
		cache_get_value_name_int(i, "Type", Business[i+1][bsType]);
		cache_get_value_name_float(i, "ExtX", Business[i+1][bsExtDoor][0]);
		cache_get_value_name_float(i, "ExtY", Business[i+1][bsExtDoor][1]);
		cache_get_value_name_float(i, "ExtZ", Business[i+1][bsExtDoor][2]);
		cache_get_value_name_float(i, "IntX", Business[i+1][bsIntDoor][0]);
		cache_get_value_name_float(i, "IntY", Business[i+1][bsIntDoor][1]);
		cache_get_value_name_float(i, "IntZ", Business[i+1][bsIntDoor][2]);
		cache_get_value_name_int(i, "Interior", Business[i+1][bsInt]);
		cache_get_value_name_int(i, "VW", Business[i+1][bsVW]);
		cache_get_value_name_int(i, "Locked", Business[i+1][bsLocked]);
		cache_get_value_name_int(i, "Safe", Business[i+1][bsSafe]);

		new str[124];
		for(new j = 0; j < 10; j++)
		{
			format(str, 124, "Worker%d", j+1);
			cache_get_value_name_int(i, str, Business[j+1][bsWorkers][j]);
		}
		for(new j2 = 0; j2 < 10; j2++)
		{
			format(str, 124, "Worker%dPayday", j2+1);
			cache_get_value_name_int(i, str, Business[j2+1][bsWorkersPayday][j2]);
		}

		Business[i+1][bsPickup] = CreateDynamicPickup(1272, 1, Business[i+1][bsExtDoor][0], Business[i+1][bsExtDoor][1], Business[i+1][bsExtDoor][2], 0, 0);
		rowcount++;
		Iter_Add(Business, i+1);
	}
	if(rowcount == 0) return printf("VinewoodDB >> Ýþyeri bulamadý.");
	printf("VinewoodDB >> %i adet iþyeri yüklendi.", rowcount);
	return true;
}

Vinewood:RefreshBusiness(bsid)
{
	if(IsValidDynamicPickup(Business[bsid][bsPickup]))
		DestroyDynamicPickup(Business[bsid][bsPickup]);

	Business[bsid][bsPickup] = CreateDynamicPickup(1272, 1, Business[bsid][bsExtDoor][0], Business[bsid][bsExtDoor][1], Business[bsid][bsExtDoor][2], 0, 0);

	new query[1024], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE business SET Owner = %i, Price = %i, Name = '%e', Type = %i, ExtX = %.4f, ExtY = %.4f, ExtZ = %.4f, IntX = %.4f, IntY = %.4f, IntZ = %.4f, Interior = %i, VW = %i, Locked = %i, Safe = %i WHERE id = '%i'",
		Business[bsid][bsOwner],
		Business[bsid][bsPrice],
		Business[bsid][bsName],
		Business[bsid][bsType],
		Business[bsid][bsExtDoor][0],
		Business[bsid][bsExtDoor][1],
		Business[bsid][bsExtDoor][2],
		Business[bsid][bsIntDoor][0],
		Business[bsid][bsIntDoor][1],
		Business[bsid][bsIntDoor][2],
		Business[bsid][bsInt],
		Business[bsid][bsVW],
		Business[bsid][bsLocked],
		Business[bsid][bsSafe],
	Business[bsid][bsID]); UpdateData = mysql_query(conn, query);

	mysql_format(conn, query, sizeof(query), "UPDATE business SET Worker1 = %i, Worker2 = %i, Worker3 = %i, Worker4 = %i, Worker5 = %i, Worker6 = %i, Worker7 = %i, Worker8 = %i, Worker9 = %i, Worker10 = %i WHERE id = '%i'", 
		Business[bsid][bsWorkers][0],
		Business[bsid][bsWorkers][1],
		Business[bsid][bsWorkers][2],
		Business[bsid][bsWorkers][3],
		Business[bsid][bsWorkers][4],
		Business[bsid][bsWorkers][5],
		Business[bsid][bsWorkers][6],
		Business[bsid][bsWorkers][7],
		Business[bsid][bsWorkers][8],
		Business[bsid][bsWorkers][9],
	Business[bsid][bsID]); UpdateData = mysql_query(conn, query);

	mysql_format(conn, query, sizeof(query), "UPDATE business SET Worker1Payday = %i, Worker2Payday = %i, Worker3Payday = %i, Worker4Payday = %i, Worker5Payday = %i, Worker6Payday = %i, Worker7Payday = %i, Worker8Payday = %i, Worker9Payday = %i, Worker10Payday = %i WHERE id = '%i'", 
		Business[bsid][bsWorkersPayday][0],
		Business[bsid][bsWorkersPayday][1],
		Business[bsid][bsWorkersPayday][2],
		Business[bsid][bsWorkersPayday][3],
		Business[bsid][bsWorkersPayday][4],
		Business[bsid][bsWorkersPayday][5],
		Business[bsid][bsWorkersPayday][6],
		Business[bsid][bsWorkersPayday][7],
		Business[bsid][bsWorkersPayday][8],
		Business[bsid][bsWorkersPayday][9],
	Business[bsid][bsID]); UpdateData = mysql_query(conn, query);
	cache_delete(UpdateData);
	return true;
}

Vinewood:DeleteBusiness(bsid)
{
	if(IsValidDynamicPickup(Business[bsid][bsPickup]))
		DestroyDynamicPickup(Business[bsid][bsPickup]);

	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM business WHERE id = '%i'", Business[bsid][bsID]);
	DeleteData = mysql_query(conn, query);
	Business[bsid][bsIsValid] = false;
	Business[bsid][bsOwner] = -1;
	cache_delete(DeleteData);
	Iter_Remove(Business, bsid);
	return true;
}