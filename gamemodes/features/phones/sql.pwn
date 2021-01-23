Vinewood:LoadPhones()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	Iter_Add(Phones, 0);

	for(new i = 0; i < rows; i++)
	{
		Phone[i+1][phIsValid] = true;

		cache_get_value_name_int(i, "id", Phone[i+1][phID]);
		cache_get_value_name_int(i, "Owner", Phone[i+1][phOwner]);
		cache_get_value_name_int(i, "Number", Phone[i+1][phNumber]);
		cache_get_value_name_int(i, "On_The_Ground", Phone[i+1][phOnTheGround]);
		cache_get_value_name_float(i, "X", Phone[i+1][phPos][0]);
		cache_get_value_name_float(i, "Y", Phone[i+1][phPos][1]);
		cache_get_value_name_float(i, "Z", Phone[i+1][phPos][2]);
		cache_get_value_name_float(i, "R1", Phone[i+1][phRot][0]);
		cache_get_value_name_float(i, "R2", Phone[i+1][phRot][1]);
		cache_get_value_name_float(i, "R3", Phone[i+1][phRot][2]);
		cache_get_value_name_int(i, "Interior", Phone[i+1][phInt]);
		cache_get_value_name_int(i, "VW", Phone[i+1][phVW]);
		cache_get_value_name_int(i, "Status", Phone[i+1][phStatus]);

		if(Phone[i+1][phOnTheGround] && Phone[i+1][phOwner] == -1)
		{
			Phone[i+1][phTempObject] = CreateDynamicObject(18870, Phone[i+1][phPos][0], Phone[i+1][phPos][1], Phone[i+1][phPos][2]-0.95, Phone[i+1][phRot][0], Phone[i+1][phRot][1], Phone[i+1][phRot][2], Phone[i+1][phVW], Phone[i+1][phInt]);
		}
		rowcount++;
		Iter_Add(Phones, i+1);
	}
	if(rowcount == 0) return printf("VinewoodDB >> Telefon bulunamadý.");
	printf("VinewoodDB >> %d adet telefon yüklendi.", rowcount);
	return true;
}

Vinewood:RefreshPhone(phoneid)
{
	new query[512], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE phones SET Owner = %i, Number = %i, On_The_Ground = %i, X = %.4f, Y = %.4f, Z = %.4f, R1 = %.4f, R2 = %.4f, R3 = %.4f, Interior = %i, VW = %i, Status = %i WHERE id = '%i'",
		Phone[phoneid][phOwner],
		Phone[phoneid][phNumber],
		Phone[phoneid][phOnTheGround],
		Phone[phoneid][phPos][0],
		Phone[phoneid][phPos][1],
		Phone[phoneid][phPos][2],
		Phone[phoneid][phRot][0],
		Phone[phoneid][phRot][1],
		Phone[phoneid][phRot][2],
		Phone[phoneid][phInt],
		Phone[phoneid][phVW],
		Phone[phoneid][phStatus],
	Phone[phoneid][phID]); UpdateData = mysql_query(conn, query);
	cache_delete(UpdateData);
	return true;
}

Vinewood:DeletePhone(phoneid)
{
	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM phones WHERE id = '%i'", Phone[phoneid][phID]);
	DeleteData = mysql_query(conn, query);
	cache_delete(DeleteData);
	Iter_Add(Phones, phoneid);
	return true;
}