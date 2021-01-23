CMD:galeri(playerid, params[])
{
	if(!GetPlayerNearbyGallery(playerid)) return SendServerMessage(playerid, "Galeride deðilsiniz.");

	new gid = GetPlayerNearbyGallery(playerid);
	switch(Gallery[gid][gType])
	{
		case 1:
		{
			new string[sizeof(GALLERY_TYPE_1) * 64];
			if(string[0] == EOS)
			{
				for(new i; i < sizeof(GALLERY_TYPE_1); i++)
				{
					format(string, sizeof(string), "%s%d\tUcret: $%d\n", string, GALLERY_TYPE_1[i][VEHICLE_MODEL], GALLERY_TYPE_1[i][VEHICLE_PRICE]);
				}
				ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PREVIEW_MODEL, "Galeri", string, "Satin Al", "Kapat");
			}
		}
		case 2:
		{
			new string[sizeof(GALLERY_TYPE_1) * 64];
			if(string[0] == EOS)
			{
				for(new i; i < sizeof(GALLERY_TYPE_2); i++)
				{
					format(string, sizeof(string), "%s%d\tUcret: $%d\n", string, GALLERY_TYPE_2[i][VEHICLE_MODEL], GALLERY_TYPE_2[i][VEHICLE_PRICE]);
				}
				ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PREVIEW_MODEL, "Galeri", string, "Satin Al", "Kapat");
			}
		}
		case 3:
		{
			new string[sizeof(GALLERY_TYPE_3) * 64];
			if(string[0] == EOS)
			{
				for(new i; i < sizeof(GALLERY_TYPE_3); i++)
				{
					format(string, sizeof(string), "%s%d\tUcret: $%d\n", string, GALLERY_TYPE_3[i][VEHICLE_MODEL], GALLERY_TYPE_3[i][VEHICLE_PRICE]);
				}
				ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PREVIEW_MODEL, "Galeri", string, "Satin Al", "Kapat");
			}
		}
		case 4:
		{
			new string[sizeof(GALLERY_TYPE_4) * 64];
			if(string[0] == EOS)
			{
				for(new i; i < sizeof(GALLERY_TYPE_4); i++)
				{
					format(string, sizeof(string), "%s%d\tUcret: $%d\n", string, GALLERY_TYPE_4[i][VEHICLE_MODEL], GALLERY_TYPE_4[i][VEHICLE_PRICE]);
				}
				ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PREVIEW_MODEL, "Galeri", string, "Satin Al", "Kapat");
			}
		}
		case 5:
		{
			new string[sizeof(GALLERY_TYPE_5) * 64];
			if(string[0] == EOS)
			{
				for(new i; i < sizeof(GALLERY_TYPE_5); i++)
				{
					format(string, sizeof(string), "%s%d\tUcret: $%d\n", string, GALLERY_TYPE_5[i][VEHICLE_MODEL], GALLERY_TYPE_5[i][VEHICLE_PRICE]);
				}
				ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PREVIEW_MODEL, "Galeri", string, "Satin Al", "Kapat");
			}
		}
	}
	return true;
}

CMD:galeriid(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	if(!GetPlayerNearbyGallery(playerid)) return SendServerMessage(playerid, "Galeri bulunamadý.");

	SendServerMessage(playerid, "%d numaralý galeridesiniz.", GetPlayerNearbyGallery(playerid));
	return true;
}

CMD:galeriyarat(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new name[124], type, Float:myPos[3], stocknumber;
	if(sscanf(params, "dds[124]", type, stocknumber, name))
	{
		SendServerMessage(playerid, "/galeriyarat [tip] [stok] [isim]");
		SendClientMessage(playerid, C_GREY1, "1: Otomobiller | 2: Bisiklet ve Motorsikletler | 3: Deniz Araçlarý");
		SendClientMessage(playerid, C_GREY1, "4: Hava Araçlarý | 5: Premium Araçlar");
	}
	else
	{
		if(!GalleryLimit()) return SendServerMessage(playerid, "Galeri limiti aþýldý.");
		if(type < 0 || type > 5) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");
		if(stocknumber < 0) return SendServerMessage(playerid, "Geçersiz stok numarasý girdiniz.");

		GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
		CreateGallery(name, type, myPos[0], myPos[1], myPos[2], stocknumber);
		SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan, bir galeri yaratýldý.", Character[playerid][cNickname]);
	}
	return true;
}

CMD:galerisil(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new gid;
	if(sscanf(params, "d", gid)) return SendServerMessage(playerid, "/galerisil [galeri id]");
	if(!Gallery[gid][gIsValid]) return SendServerMessage(playerid, "Galeri bulunamadý.");

	DeleteGallery(gid);
	SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir galeri silindi.", Character[playerid][cNickname]);
	return true;
}

CMD:galeriduzenle(playerid, params[])
{
	if(Character[playerid][cAdmin] < VWGAMEADMIN4) return SendServerMessage(playerid, "Yeterli yetkiniz bulunmamaktadýr.");
	new gid, opt[64], extra[124];
	if(sscanf(params, "ds[64]S()[124]", gid, opt, extra))
	{
		SendServerMessage(playerid, "/galeriduzenle [galeri id] [seçenek] [yeni deðer]");
		SendClientMessage(playerid, C_GREY1, "isim | tip | konum | aracspawn | stok");
	}
	else
	{
		if(!Gallery[gid][gIsValid]) return SendServerMessage(playerid, "Galeri bulunamadý.");

		if(!strcmp(opt, "isim", true))
		{
			new newname[124];
			if(sscanf(extra, "s[124]", newname)) return SendServerMessage(playerid, "/galeriduzenle [galeri id] [isim] [yeni isim]");

			format(Gallery[gid][gName], 124, "%s", newname);
			RefreshGallery(gid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir galeri düzenlendi.", Character[playerid][cNickname]);
		}
		else if(!strcmp(opt, "tip", true))
		{
			new type;
			if(sscanf(extra, "d", type)) return SendServerMessage(playerid, "/galeriduzenle [galeri id] [tip] [yeni tip]");
			if(type < 0 || type > 5) return SendServerMessage(playerid, "Geçersiz tip girdiniz.");

			Gallery[gid][gType] = type;
			RefreshGallery(gid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir galeri düzenlendi.", Character[playerid][cNickname]);
		}
		else if(!strcmp(opt, "konum", true))
		{
			new Float:myPos[3];
			GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
			Gallery[gid][gPos][0] = myPos[0];
			Gallery[gid][gPos][1] = myPos[1];
			Gallery[gid][gPos][2] = myPos[2];
			RefreshGallery(gid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir galeri düzenlendi.", Character[playerid][cNickname]);
		}
		else if(!strcmp(opt, "aracspawn", true))
		{
			new Float:myPos[3];
			GetPlayerPos(playerid, myPos[0], myPos[1], myPos[2]);
			Gallery[gid][gCarSpawnPos][0] = myPos[0];
			Gallery[gid][gCarSpawnPos][1] = myPos[1];
			Gallery[gid][gCarSpawnPos][2] = myPos[2];
			RefreshGallery(gid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir galeri düzenlendi.", Character[playerid][cNickname]);
		}
		else if(!strcmp(opt, "stok", true))
		{
			new stocknumber;
			if(sscanf(extra, "d", stocknumber)) return SendServerMessage(playerid, "/galeriduzenle [galeri id] [stok] [deðer]");

			Gallery[gid][gStock] = stocknumber;
			RefreshGallery(gid);
			SendAdminMessage(C_ADMIN, "AdmWarn: %s tarafýndan bir galeri düzenlendi.", Character[playerid][cNickname]);
		}
	}
	return true;
}

Vinewood:CreateGallery(name[], type, Float:x, Float:y, Float:z, stocknumber)
{
	newGalleryCreated++;
	new gid = newGalleryCreated, query[512], Cache:InsertData;

	mysql_format(conn, query, sizeof(query), "INSERT INTO gallerys (Name, Type, X, Y, Z, Spawn_Car_X, Spawn_Car_Y, Spawn_Car_Z, Stock) VALUES ('%e', %i, %.4f, %.4f, %.4f, 0.0, 0.0, 0.0, %i)", name, type, x, y, z, stocknumber);
	InsertData = mysql_query(conn, query);

	Gallery[gid][gID] = cache_insert_id();
	Gallery[gid][gIsValid] = true;
	format(Gallery[gid][gName], 124, "%s", name);
	Gallery[gid][gType] = type;
	Gallery[gid][gPos][0] = x;
	Gallery[gid][gPos][1] = y;
	Gallery[gid][gPos][2] = z;
	Gallery[gid][gCarSpawnPos][0] = 0.0;
	Gallery[gid][gCarSpawnPos][1] = 0.0;
	Gallery[gid][gCarSpawnPos][2] = 0.0;
	Gallery[gid][gStock] = stocknumber;

	Gallery[gid][gPickup] = CreateDynamicPickup(1318, 1, Gallery[gid][gPos][0], Gallery[gid][gPos][1], Gallery[gid][gPos][2], 0, 0);
	cache_delete(InsertData);
	return true;
}

Vinewood:LoadGallerys()
{
	new rows, fields, rowcount = 0;
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	for(new i; i < rows; i++)
	{
		Gallery[i+1][gIsValid] = true;

		cache_get_value_name_int(i, "id", Gallery[i+1][gID]);
		cache_get_value_name(i, "Name", Gallery[i+1][gName], 124);
		cache_get_value_name_int(i, "Type", Gallery[i+1][gType]);
		cache_get_value_name_float(i, "X", Gallery[i+1][gPos][0]);
		cache_get_value_name_float(i, "Y", Gallery[i+1][gPos][1]);
		cache_get_value_name_float(i, "Z", Gallery[i+1][gPos][2]);
		cache_get_value_name_float(i, "Spawn_Car_X", Gallery[i+1][gCarSpawnPos][0]);
		cache_get_value_name_float(i, "Spawn_Car_Y", Gallery[i+1][gCarSpawnPos][1]);
		cache_get_value_name_float(i, "Spawn_Car_Z", Gallery[i+1][gCarSpawnPos][2]);
		cache_get_value_name_int(i, "Stock", Gallery[i+1][gStock]);

		Gallery[i+1][gPickup] = CreateDynamicPickup(1318, 1, Gallery[i+1][gPos][0], Gallery[i+1][gPos][1], Gallery[i+1][gPos][2], 0, 0);
		rowcount++;
	}
	if(rowcount == 0) return printf("VinewoodDB >> Galeri bulunamadý.");
	printf("VinewoodDB >> %d galeri yüklendi.", rowcount);
	return true;
}

Vinewood:RefreshGallery(gid)
{
	if(IsValidDynamicPickup(Gallery[gid][gPickup]))
		DestroyDynamicPickup(Gallery[gid][gPickup]);

	Gallery[gid][gPickup] = CreateDynamicPickup(1318, 1, Gallery[gid][gPos][0], Gallery[gid][gPos][1], Gallery[gid][gPos][2], 0, 0);

	new query[512], Cache:UpdateData;
	mysql_format(conn, query, sizeof(query), "UPDATE gallerys SET Name = '%e', Type = %i, X = %.4f, Y = %.4f, Z = %.4f, Spawn_Car_X = %.4f, Spawn_Car_Y = %.4f, Spawn_Car_Z = %.4f, Stock = %i WHERE id = '%i'",
		Gallery[gid][gName],
		Gallery[gid][gType],
		Gallery[gid][gPos][0],
		Gallery[gid][gPos][1],
		Gallery[gid][gPos][2],
		Gallery[gid][gCarSpawnPos][0],
		Gallery[gid][gCarSpawnPos][1],
		Gallery[gid][gCarSpawnPos][2],
		Gallery[gid][gStock],
	Gallery[gid][gID]); UpdateData = mysql_query(conn, query);
	cache_delete(UpdateData);
	return true;
}

Vinewood:DeleteGallery(gid)
{
	if(IsValidDynamicPickup(Gallery[gid][gPickup]))
		DestroyDynamicPickup(Gallery[gid][gPickup]);

	new query[124], Cache:DeleteData;
	mysql_format(conn, query, sizeof(query), "DELETE FROM gallerys WHERE id = '%i'", Gallery[gid][gID]);
	DeleteData = mysql_query(conn, query);
	cache_delete(DeleteData);
	return true;
}

Vinewood:GalleryLimit()
{
	new status = 1;
	for(new i; i < MAX_GALLERY; i++)
	{
		if(Gallery[i][gIsValid])
		{
			if(i == MAX_GALLERY)
				status = 0;
		}
	}
	return status;
}

Vinewood:GetPlayerNearbyGallery(playerid)
{
	new galleryid = 0;
	for(new i; i < MAX_GALLERY; i++)
	{
		if(Gallery[i][gIsValid])
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Gallery[i][gPos][0], Gallery[i][gPos][1], Gallery[i][gPos][2]))
				galleryid = i;
		}
	}
	return galleryid;
}