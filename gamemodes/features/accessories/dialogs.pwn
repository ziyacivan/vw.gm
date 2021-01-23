Dialog:DIALOG_BONES(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new boneid = listitem + 1;
	SetPVarInt(playerid, "SelectedBoneID", boneid);

	Dialog_Show(playerid, DIALOG_SELECT_SLOT, DIALOG_STYLE_INPUT, "Vinewood Roleplay - Aksesuarlar", "{FFFFFF}Lütfen aksesuarý yerleþtirmek istediðiniz slot numarasýný girin(0-9):", "Devam", "Kapat");
	return true;
}

Dialog:DIALOG_SELECT_SLOT(playerid, response, listitem, inputtext[])
{
	if(!response) return true;
    if(strval(inputtext) < 0 || strval(inputtext) > 9) return SendServerMessage(playerid, "Geçersiz slot numarasý girdiniz.");

	new selected_accid = GetPVarInt(playerid, "SelectedACCID");
	new selected_boneid = GetPVarInt(playerid, "SelectedBoneID");
	new selected_slotid = strval(inputtext);

	SetPlayerAttachedObject(playerid, selected_slotid, selected_accid, selected_boneid);
	EditAttachedObject(playerid, selected_slotid);
	SendServerMessage(playerid, "Bir aksesuar satýn aldýnýz, 'kaydet' butonuna bastýktan sonra konumu kaydedilecektir.");
	GiveMoney(playerid, -50);

	new bsid = GetBusinessIDFromInt(playerid);
	Business[bsid][bsSafe] += 50;

	Character[playerid][cAcc][selected_slotid] = selected_accid;

	SaveCharacterData(playerid);
	DeletePVar(playerid, "SelectedACCID");
	DeletePVar(playerid, "SelectedBoneID");

	new query[124], Cache:CheckData;
	mysql_format(conn, query, sizeof(query), "SELECT * FROM accessories WHERE Owner = %i AND Slot = '%i'", Character[playerid][cID], selected_slotid);
	CheckData = mysql_query(conn, query);

	if(cache_num_rows())
	{
		new queryex[124], Cache:DeleteData;
		mysql_format(conn, queryex, sizeof(queryex), "DELETE FROM accessories WHERE Slot = '%i'", selected_slotid);
		DeleteData = mysql_query(conn, queryex);
		cache_delete(DeleteData);
	}
	cache_delete(CheckData);
	return true;
}

Dialog:EDIT_ACCESSORY(playerid, response, listitem, inputtext[])
{
    if(!response) return true;

    switch(listitem)
    {
        case 0: // bölge düzenle
        {
            Dialog_Show(playerid, EDIT_ACCESSORY_BONE, DIALOG_STYLE_LIST, "Vinewood Roleplay - Aksesuarlar", "Omurga\nKafa\nSol üst kol\nSað üst kol\nSol el\nSað el\nSol uyluk\nSað uyluk\nSol ayak\nSað ayak\nSað baldýr\nSol baldýr\nSol ön kol\nSað ön kol\nSol omuz\nSað omuz\nBoyun\nÇene", "Seç", "Kapat");
        }
        case 1: // konum düzenle
        {
            new slotid = GetPVarInt(playerid, "SelectEditSlotID");

            EditAccessory(playerid, slotid);
        }
    }
    return true;
}

Dialog:EDIT_ACCESSORY_BONE(playerid, response, listitem, inputtext[])
{
    if(!response) return true;

    new boneid = listitem + 1;
    new slotid = GetPVarInt(playerid, "SelectEditSlotID");

    new query[124];
    mysql_format(conn, query, sizeof(query), "UPDATE accessories SET Bone = %i WHERE Owner = '%i' AND Slot = '%i'", boneid, Character[playerid][cID], slotid);
    mysql_query(conn, query);

    SendServerMessage(playerid, "%d slot numaralý aksesuarýn bölgesi deðiþtirildi.", slotid);
    DeletePVar(playerid, "SelectEditSlotID");
    return true;
}