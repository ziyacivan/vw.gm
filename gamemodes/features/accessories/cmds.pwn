CMD:aksesuar(playerid, params[])
{
    if(!IsHaveAcc(playerid)) return SendServerMessage(playerid, "Aksesuar bulunamadý.");

    new slot;
    if(sscanf(params, "d", slot)) return SendServerMessage(playerid, "/aksesuar [0-9]");
    if(slot < 0 || slot > 9) return SendServerMessage(playerid, "Geçersiz slot girdiniz.");
    if(IsEmptySlot(playerid, slot)) return SendServerMessage(playerid, "Bu slotta aksesuar bulunmamaktadýr.");
    if(IsPlayerAttachedObjectSlotUsed(playerid, slot)) return SendServerMessage(playerid, "Bu aksesuar takýlý haldedir.");

    AttachAccessoryToPlayer(playerid, slot);
    return true;
}

CMD:aksesuarcikart(playerid, params[])
{
    if(!IsHaveAcc(playerid)) return SendServerMessage(playerid, "Aksesuar bulunamadý.");

    new slot;
    if(sscanf(params, "d", slot)) return SendServerMessage(playerid, "/aksesuarcikart [0-9]");
    if(slot < 0 || slot > 9) return SendServerMessage(playerid, "Geçersiz slot girdiniz.");
    if(IsEmptySlot(playerid, slot)) return SendServerMessage(playerid, "Bu slotta aksesuar bulunmamaktadýr.");
    if(!IsPlayerAttachedObjectSlotUsed(playerid, slot)) return SendServerMessage(playerid, "Bu aksesuar takýlý deðil.");

    RemoveAttachAccessoryToPlayer(playerid, slot);
    return true;
}

CMD:aksesuarsil(playerid, params[])
{
    if(!IsHaveAcc(playerid)) return SendServerMessage(playerid, "Aksesuar bulunamadý.");

    new slot;
    if(sscanf(params, "d", slot)) return SendServerMessage(playerid, "/aksesuarsil [0-9]");
    if(slot < 0 || slot > 9) return SendServerMessage(playerid, "Geçersiz slot girdiniz.");
    if(IsEmptySlot(playerid, slot)) return SendServerMessage(playerid, "Bu slotta aksesuar bulunmamaktadýr.");
    if(IsPlayerAttachedObjectSlotUsed(playerid, slot)) return SendServerMessage(playerid, "Aksesuarý silmeden önce çýkartmanýz gerekmektedir.");

    DeleteCompleteAccessory(playerid, slot);
    return true;
}

CMD:aksesuarduzenle(playerid, params[])
{
    if(!IsHaveAcc(playerid)) return SendServerMessage(playerid, "Aksesuar bulunamadý.");

    new slot;
    if(sscanf(params, "d", slot)) return SendServerMessage(playerid, "/aksesuarduzenle [0-9]");
    if(slot < 0 || slot > 9) return SendServerMessage(playerid, "Geçersiz slot girdiniz.");
    if(IsEmptySlot(playerid, slot)) return SendServerMessage(playerid, "Bu slotta aksesuar bulunmamaktadýr.");
    if(IsPlayerAttachedObjectSlotUsed(playerid, slot)) return SendServerMessage(playerid, "Aksesuarý düzenlemeden önce çýkartmanýz gerekmektedir.");

    SetPVarInt(playerid, "SelectEditSlotID", slot);
    Dialog_Show(playerid, EDIT_ACCESSORY, DIALOG_STYLE_LIST, "Vinewood Roleplay - Aksesuarlar", "Bölge Düzenle\nKonum Düzenle", "Seç", "Kapat");
    return true;
}