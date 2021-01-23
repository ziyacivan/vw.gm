CMD:aksesuar(playerid, params[])
{
    if(!IsHaveAcc(playerid)) return SendServerMessage(playerid, "Aksesuar bulunamad�.");

    new slot;
    if(sscanf(params, "d", slot)) return SendServerMessage(playerid, "/aksesuar [0-9]");
    if(slot < 0 || slot > 9) return SendServerMessage(playerid, "Ge�ersiz slot girdiniz.");
    if(IsEmptySlot(playerid, slot)) return SendServerMessage(playerid, "Bu slotta aksesuar bulunmamaktad�r.");
    if(IsPlayerAttachedObjectSlotUsed(playerid, slot)) return SendServerMessage(playerid, "Bu aksesuar tak�l� haldedir.");

    AttachAccessoryToPlayer(playerid, slot);
    return true;
}

CMD:aksesuarcikart(playerid, params[])
{
    if(!IsHaveAcc(playerid)) return SendServerMessage(playerid, "Aksesuar bulunamad�.");

    new slot;
    if(sscanf(params, "d", slot)) return SendServerMessage(playerid, "/aksesuarcikart [0-9]");
    if(slot < 0 || slot > 9) return SendServerMessage(playerid, "Ge�ersiz slot girdiniz.");
    if(IsEmptySlot(playerid, slot)) return SendServerMessage(playerid, "Bu slotta aksesuar bulunmamaktad�r.");
    if(!IsPlayerAttachedObjectSlotUsed(playerid, slot)) return SendServerMessage(playerid, "Bu aksesuar tak�l� de�il.");

    RemoveAttachAccessoryToPlayer(playerid, slot);
    return true;
}

CMD:aksesuarsil(playerid, params[])
{
    if(!IsHaveAcc(playerid)) return SendServerMessage(playerid, "Aksesuar bulunamad�.");

    new slot;
    if(sscanf(params, "d", slot)) return SendServerMessage(playerid, "/aksesuarsil [0-9]");
    if(slot < 0 || slot > 9) return SendServerMessage(playerid, "Ge�ersiz slot girdiniz.");
    if(IsEmptySlot(playerid, slot)) return SendServerMessage(playerid, "Bu slotta aksesuar bulunmamaktad�r.");
    if(IsPlayerAttachedObjectSlotUsed(playerid, slot)) return SendServerMessage(playerid, "Aksesuar� silmeden �nce ��kartman�z gerekmektedir.");

    DeleteCompleteAccessory(playerid, slot);
    return true;
}

CMD:aksesuarduzenle(playerid, params[])
{
    if(!IsHaveAcc(playerid)) return SendServerMessage(playerid, "Aksesuar bulunamad�.");

    new slot;
    if(sscanf(params, "d", slot)) return SendServerMessage(playerid, "/aksesuarduzenle [0-9]");
    if(slot < 0 || slot > 9) return SendServerMessage(playerid, "Ge�ersiz slot girdiniz.");
    if(IsEmptySlot(playerid, slot)) return SendServerMessage(playerid, "Bu slotta aksesuar bulunmamaktad�r.");
    if(IsPlayerAttachedObjectSlotUsed(playerid, slot)) return SendServerMessage(playerid, "Aksesuar� d�zenlemeden �nce ��kartman�z gerekmektedir.");

    SetPVarInt(playerid, "SelectEditSlotID", slot);
    Dialog_Show(playerid, EDIT_ACCESSORY, DIALOG_STYLE_LIST, "Vinewood Roleplay - Aksesuarlar", "B�lge D�zenle\nKonum D�zenle", "Se�", "Kapat");
    return true;
}