Vinewood:LoadFactions()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	Iter_Add(Factions, 0);

	for(new i; i < rows; i++)
	{
		Faction[i+1][fIsValid] = true;

		cache_get_value_name_int(i, "id", Faction[i+1][fID]);
		cache_get_value_name(i, "Name", Faction[i+1][fName], 144);
		cache_get_value_name_int(i, "Type", Faction[i+1][fType]);
		cache_get_value_name(i, "Rank1", Faction[i+1][fRank1], 64);
		cache_get_value_name(i, "Rank2", Faction[i+1][fRank2], 64);
		cache_get_value_name(i, "Rank3", Faction[i+1][fRank3], 64);
		cache_get_value_name(i, "Rank4", Faction[i+1][fRank4], 64);
		cache_get_value_name(i, "Rank5", Faction[i+1][fRank5], 64);
		cache_get_value_name(i, "Rank6", Faction[i+1][fRank6], 64);
		cache_get_value_name(i, "Rank7", Faction[i+1][fRank7], 64);
		cache_get_value_name(i, "Rank8", Faction[i+1][fRank8], 64);
		cache_get_value_name(i, "Rank9", Faction[i+1][fRank9], 64);
		cache_get_value_name(i, "Rank10", Faction[i+1][fRank10], 64);
		cache_get_value_name(i, "Rank11", Faction[i+1][fRank11], 64);
		cache_get_value_name(i, "Rank12", Faction[i+1][fRank12], 64);
		cache_get_value_name_int(i, "LoginRank", Faction[i+1][fLoginRank]);
		cache_get_value_name_int(i, "Level", Faction[i+1][fLevel]);
		cache_get_value_name_int(i, "LevelBonus", Faction[i+1][fLevelBonus]);
		cache_get_value_name_int(i, "Access_To_Weapons", Faction[i+1][fAccessToWeapons]);
		cache_get_value_name_int(i, "Access_To_Drugs", Faction[i+1][fAccessToDrugs]);
		rowcount++;
		Iter_Add(Factions, i+1);
	}
	if(rowcount == 0) return printf("VinewoodDB >> Oluþum bulunamadý.");
	printf("VinewoodDB >> %d oluþum yüklendi.", rowcount);
	return true;
}

Vinewood:RefreshFaction(fid)
{
	new query[1024], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE factions SET Name = '%e', Type = %i, Rank1 = '%e', Rank2 = '%e', Rank3 = '%e', Rank4 = '%e', Rank5 = '%e', Rank6 = '%e', Rank7 = '%e', Rank8 = '%e', Rank9 = '%e', Rank10 = '%e', Rank11 = '%e', Rank12 = '%e', LoginRank = %i, Level = %i, LevelBonus = %i, Access_To_Weapons = %i, Access_To_Drugs = %i WHERE id = '%i'",
		Faction[fid][fName],
		Faction[fid][fType],
		Faction[fid][fRank1],
		Faction[fid][fRank2],
		Faction[fid][fRank3],
		Faction[fid][fRank4],
		Faction[fid][fRank5],
		Faction[fid][fRank6],
		Faction[fid][fRank7],
		Faction[fid][fRank8],
		Faction[fid][fRank9],
		Faction[fid][fRank10],
		Faction[fid][fRank11],
		Faction[fid][fRank12],
		Faction[fid][fLoginRank],
		Faction[fid][fLevel],
		Faction[fid][fLevelBonus],
		Faction[fid][fAccessToWeapons],
		Faction[fid][fAccessToDrugs],
	Faction[fid][fID]); UpdateData = mysql_query(conn,query);
	cache_delete(UpdateData);
	return true;
}

Vinewood:DeleteFaction(fid)
{
	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM factions WHERE id = '%i'", Faction[fid][fID]);
	DeleteData = mysql_query(conn, query);
	cache_delete(DeleteData);

	Faction[fid][fID] = 0;
	Faction[fid][fIsValid] = false;
	Iter_Remove(Factions, fid);
	return true;
}

Vinewood:CreateFaction(name[], type)
{
	new query[1024], Cache:InsertData;
	mysql_format(conn, query, sizeof(query), "INSERT INTO factions (Name, Type) VALUES ('%e', %i)", name, type);
	InsertData = mysql_query(conn, query);

	new fid = Iter_Free(Factions);

	Faction[fid][fID] = cache_insert_id();
	Faction[fid][fIsValid] = true;
	format(Faction[fid][fName], 144, "%s", name);
	Faction[fid][fType] = type;
	format(Faction[fid][fRank1], 64, "Yok");
	format(Faction[fid][fRank2], 64, "Yok");
	format(Faction[fid][fRank3], 64, "Yok");
	format(Faction[fid][fRank4], 64, "Yok");
	format(Faction[fid][fRank5], 64, "Yok");
	format(Faction[fid][fRank6], 64, "Yok");
	format(Faction[fid][fRank7], 64, "Yok");
	format(Faction[fid][fRank8], 64, "Yok");
	format(Faction[fid][fRank9], 64, "Yok");
	format(Faction[fid][fRank10], 64, "Yok");
	format(Faction[fid][fRank11], 64, "Yok");
	format(Faction[fid][fRank12], 64, "Yok");
	Faction[fid][fLoginRank] = 12;
	Faction[fid][fLevel] = 0;
	Faction[fid][fLevelBonus] = 50;
	Faction[fid][fAccessToWeapons] = 0;
	Faction[fid][fAccessToDrugs] = 0;
	cache_delete(InsertData);
	Iter_Add(Factions, fid);
	return true;
}