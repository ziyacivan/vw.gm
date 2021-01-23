CMD:fall(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/fall [1-6]");
	if(id < 1 || id > 6) return SendServerMessage(playerid, "/fall [1-6]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
		case 2: ApplyAnimationEx(playerid, "PED","FLOOR_hit_f", 4.1,0,1,1,1,0);
		case 3: ApplyAnimationEx(playerid, "PED","KO_shot_face", 4.1,0,1,1,1,0);
		case 4: ApplyAnimationEx(playerid, "PED","KO_shot_stom", 4.1,0,1,1,1,0);
		case 5: ApplyAnimationEx(playerid, "PED","KO_skid_back", 4.1,0,1,1,1,0);
		case 6: ApplyAnimationEx(playerid, "PED","KO_shot_front", 4.1,0,1,1,1,0);
	}
	return true;
}

CMD:injured(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/injured [1-4]");
	if(id < 1 || id > 4) return SendServerMessage(playerid, "/injured [1-4]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "WUZI", "CS_Dead_Guy", 4.0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimationEx(playerid, "PED", "gas_cwr", 4.0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimationEx(playerid, "FINALE", "FIN_Cop1_Loop", 4.0, 1, 0, 0, 0, 0);
	}
	return true;
}

CMD:push(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/push [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/push [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "GANGS","shake_cara",4.0,0,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "GANGS","shake_carSH",4.0,0,0,0,0,0);
	}
	return true;
}

CMD:handsup(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "ROB_BANK","SHP_HandsUp_Scr", 4.0, 0, 1, 1, 1, 0);
	return true;
}

CMD:kiss(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/kiss [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/kiss [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_02", 3.0, 0, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "BD_Fire", "grlfrd_kiss_03", 2.0, 0, 0, 0, 0, 0);
	}
	return true;
}

CMD:cell(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ClearAnimations(playerid);
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
	return true;
}

CMD:slap(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/slap [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/slap [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "MISC","Bitchslap",4.0,1,0,0,0,0);
	}
	return true;
}

CMD:bomb(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/bomb [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/bomb [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
		case 2: ApplyAnimationEx(playerid, "MISC", "plunger_01", 2.0, 0, 0, 0, 0, 0);
	}
	return true;
}

CMD:drunk(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/drunk [1-3]");
	if(id < 1 || id > 3) return SendServerMessage(playerid, "/drunk [1-3]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED","WALK_DRUNK",4.1,1,1,1,1,1);
		case 2: ApplyAnimationEx(playerid, "PAULNMAC", "pnm_loop_a", 3.0, 1, 0, 0, 0, 0);
		case 3: ApplyAnimationEx(playerid, "PAULNMAC", "pnm_loop_b", 3.0, 1, 0, 0, 0, 0);
	}
	return true;
}

CMD:laugh(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
	return true;
}

CMD:basket(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/basket [1-4]");
	if(id < 1 || id > 4) return SendServerMessage(playerid, "/basket [1-4]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "BSKTBALL","BBALL_idleloop",4.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
		case 4: ApplyAnimationEx(playerid, "BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
	}
	return true;
}

CMD:medic(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "MEDIC","CPR",4.0,0,0,0,0,0);
	return true;
}

CMD:robman(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/robman [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/robman [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "PED", "gang_gunstand", 4.0,1,0,0,0,0);
	}
	return true;
}

CMD:taichi(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
	return true;
}

CMD:lookout(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/lookout [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/lookout [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "FOOD", "eat_vomit_sk", 4.0,0,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "PED", "handscower", 4.0,0,1,1,1,1);
	}
	return true;
}

CMD:sit(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/sit [1-4]");
	if(id < 1 || id > 4) return SendServerMessage(playerid, "/sit [1-4]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED", "SEAT_down", 4.1, 0, 1, 1, 1, 0);
		case 2: ApplyAnimationEx(playerid, "MISC", "seat_lr", 2.0,1,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "MISC", "seat_talk_01", 2.0,1,0,0,0,0);
		case 4: ApplyAnimationEx(playerid, "MISC", "seat_talk_02", 2.0,1,0,0,0,0);
	}
	return true;
}

CMD:lay(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/lay [1-9]");
	if(id < 1 || id > 9) return SendServerMessage(playerid, "/lay [1-9]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "BEACH", "parksit_w_loop", 4.0, 1, 0, 0, 0, 0);
		case 3: ApplyAnimationEx(playerid, "BEACH","parksit_m_loop", 4.0, 1, 0, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "BEACH","lay_bac_loop", 4.0, 1, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "BEACH","sitnwait_loop_w", 4.0, 1, 0, 0, 0, 0);
		case 6: ApplyAnimationEx(playerid, "SUNBATHE","Lay_Bac_in",3.0,0,1,1,1,0);
		case 7: ApplyAnimationEx(playerid, "SUNBATHE","batherdown",3.0,0,1,1,1,0);
		case 8: ApplyAnimationEx(playerid, "SUNBATHE","parksit_m_in",3.0,0,1,1,1,0);
		case 9: ApplyAnimationEx(playerid, "CAR", "Fixn_Car_Loop", 4.0, 1, 0, 0, 0, 0);
	}
	return true;
}

CMD:sup(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/sup [1-3]");
	if(id < 1 || id > 3) return SendServerMessage(playerid, "/sup [1-3]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "GANGS","hndshkba",4.0,0,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "GANGS","hndshkda",4.0,0,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "GANGS","hndshkfa_swt",4.0,0,0,0,0,0);
	}
	return true;
}

CMD:crossarms(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/crossarms [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/crossarms [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);
		case 2: ApplyAnimationEx(playerid, "OTB", "wtchrace_loop", 4.0, 1, 0, 0, 0, 0);
	}
	return true;
}

CMD:deal(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
	return true;
}

CMD:crack(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/crack [1-5]");
	if(id < 1 || id > 5) return SendServerMessage(playerid, "/crack [1-5]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.0, 1, 0, 0, 0, 0);
		case 3: ApplyAnimationEx(playerid, "CRACK", "crckidle2", 4.0, 1, 0, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.0, 1, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "CRACK", "crckidle4", 4.0, 1, 0, 0, 0, 0);
	}
	return true;
}

CMD:smoke(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/smoke [1-6]");
	if(id < 1 || id > 6) return SendServerMessage(playerid, "/smoke [1-6]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0);
		case 3: ApplyAnimationEx(playerid, "SMOKING","M_smkstnd_loop", 4.0, 1, 0, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "SMOKING","M_smk_out", 4.0, 0, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "SMOKING","M_smk_in",3.0,0,0,0,0,0);
		case 6: ApplyAnimationEx(playerid, "SMOKING","M_smk_tap",3.0,0,0,0,0,0);
	}
	return true;
}

CMD:chat(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/chat [1-3]");
	if(id < 1 || id > 3) return SendServerMessage(playerid, "/chat [1-3]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED","IDLE_CHAT",2.0,1,0,0,1,1);
		case 2: ApplyAnimationEx(playerid, "MISC","IDLE_CHAT_02",2.0,1,0,0,1,1);
		case 3: ApplyAnimationEx(playerid, "BAR","Barcustom_order",3.0,0,0,0,0,0);
	}
	return true;
}

CMD:hike(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/hike [1-3]");
	if(id < 1 || id > 3) return SendServerMessage(playerid, "/hike [1-3]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "MISC","hiker_pose",4.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "MISC","hiker_pose_l",4.0,1,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "PED","idle_taxi",3.0,0,0,0,0,0);
	}
	return true;
}

CMD:dance(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/dance [1-17]");
	if(id < 1 || id > 17) return SendServerMessage(playerid, "/dance [1-17]");

	switch(id)
	{
		case 1: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		case 2: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		case 3: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		case 4: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
		case 5: ApplyAnimationEx(playerid, "DANCING", "dnce_M_e", 4.1, 1, 1, 1, 1, 1);
		case 6: ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.1, 1, 1, 1, 1, 1);
		case 7: ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.1, 1, 1, 1, 1, 1);
		case 8: ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.1, 1, 1, 1, 1, 1);
		case 9: ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.1, 1, 1, 1, 1, 1);
		case 10: ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.1, 1, 1, 1, 1, 1);
		case 11: ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.1, 1, 1, 1, 1, 1);
		case 12: ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.1, 1, 1, 1, 1, 1);
		case 13: ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.1, 1, 1, 1, 1, 1);
		case 14: ApplyAnimationEx(playerid, "DANCING", "dance_loop", 4.1, 1, 1, 1, 1, 1);
		case 15: ApplyAnimationEx(playerid, "DANCING", "bd_clap1", 4.1, 1, 1, 1, 1, 1);
		case 16: ApplyAnimationEx(playerid, "DANCING", "bd_clap", 4.1, 1, 1, 1, 1, 1);
	}
	return true;
}

CMD:fuck(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/fuck [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/fuck [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED","fucku",4.0,0,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "RIOT","RIOT_FUKU",2.0,0,0,0,0,0);
	}
	return true;
}

CMD:strip(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/strip [1-7]");
	if(id < 1 || id > 7) return SendServerMessage(playerid, "/strip [1-7]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "STRIP", "strip_A", 4.1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimationEx(playerid, "STRIP", "strip_B", 4.1, 1, 1, 1, 1, 1);
		case 3: ApplyAnimationEx(playerid, "STRIP", "strip_C", 4.1, 1, 1, 1, 1, 1);
		case 4: ApplyAnimationEx(playerid, "STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1);
		case 5: ApplyAnimationEx(playerid, "STRIP", "strip_E", 4.1, 1, 1, 1, 1, 1);
		case 6: ApplyAnimationEx(playerid, "STRIP", "strip_F", 4.1, 1, 1, 1, 1, 1);
		case 7: ApplyAnimationEx(playerid, "STRIP", "strip_G", 4.1, 1, 1, 1, 1, 1);
	}
	return true;
}

CMD:lean(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/lean [1-3]");
	if(id < 1 || id > 3) return SendServerMessage(playerid, "/lean [1-3]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "GANGS","leanIDLE",4.0,0,1,1,1,0);
		case 2: ApplyAnimationEx(playerid, "MISC","Plyrlean_loop",4.0,0,1,1,1,0);
		case 3: ApplyAnimationEx(playerid, "BAR","BARman_idle",3.0,0,1,1,1,0);
	}
	return true;
}

CMD:walk(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/walk [1-13]");
	if(id < 1 || id > 13) return SendServerMessage(playerid, "/walk [1-13]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED","WALK_gang1",4.1,1,1,1,1,1);
		case 2: ApplyAnimationEx(playerid, "PED","WALK_gang2",4.1,1,1,1,1,1);
		case 3: ApplyAnimationEx(playerid, "FAT","FatWalk",4.1,1,1,1,1,1);
		case 4: ApplyAnimationEx(playerid, "WUZI","CS_Wuzi_pt1",4.1,1,1,1,1,1);
		case 5: ApplyAnimationEx(playerid, "WUZI","Wuzi_walk",3.0,1,1,1,1,1);
		case 6: ApplyAnimationEx(playerid, "POOL","Pool_walk",3.0,1,1,1,1,1);
		case 7: ApplyAnimationEx(playerid, "PED","Walk_old",3.0,1,1,1,1,1);
		case 8: ApplyAnimationEx(playerid, "PED","Walk_fatold",3.0,1,1,1,1,1);
		case 9: ApplyAnimationEx(playerid, "PED","woman_walkfatold",3.0,1,1,1,1,1);
		case 10: ApplyAnimationEx(playerid, "PED","woman_walknorm",3.0,1,1,1,1,1);
		case 11: ApplyAnimationEx(playerid, "PED","woman_walkold",3.0,1,1,1,1,1);
		case 12: ApplyAnimationEx(playerid, "PED","woman_walkpro",3.0,1,1,1,1,1);
		case 13: ApplyAnimationEx(playerid, "PED","woman_walkshop",3.0,1,1,1,1,1);
	}
	return true;
}

CMD:rap(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/rap [1-5]");
	if(id < 1 || id > 5) return SendServerMessage(playerid, "/rap [1-5]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "RAPPING","RAP_A_Loop",4.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "GANGS","prtial_gngtlkD",4.0,1,0,0,0,0);
		case 4: ApplyAnimationEx(playerid, "GANGS","prtial_gngtlkH",4.0,1,0,0,1,1);
		case 5: ApplyAnimationEx(playerid, "BENCHPRESS","gym_bp_celebrate",4.0,0,0,0,0,0);
	}
	return true;
}

CMD:tired(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/tired [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/tired [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED","IDLE_tired",3.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "FAT","Idle_Tired",3.0,1,0,0,0,0);
	}
	return true;
}

CMD:box(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "GYMNASIUM","GYMshadowbox",4.0,1,1,1,1,0);
	return true;
}

CMD:scratch(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "MISC","Scratchballs_01",3.0,1,0,0,0,0);
	return true;
}

CMD:hide(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/hide [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/hide [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "ON_LOOKERS","panic_hide",3.0,1,0,0,0,0);
	}
	return true;
}

CMD:vomit(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
	return true;
}

CMD:eats(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
	return true;
}

CMD:cop(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/cop [1-7]");
	if(id < 1 || id > 7) return SendServerMessage(playerid, "/cop [1-7]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "SWORD","sword_block",50.0,0,1,1,1,1);
		case 2: ApplyAnimationEx(playerid, "POLICE","CopTraf_away",4.0,1,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1);
		case 4: ApplyAnimationEx(playerid, "POLICE","CopTraf_come",4.0,1,0,0,0,0);
		case 5: ApplyAnimationEx(playerid, "POLICE","CopTraf_left",4.0,1,0,0,0,0);
		case 6: ApplyAnimationEx(playerid, "POLICE","CopTraf_stop",4.0,1,0,0,0,0);
		case 7: ApplyAnimationEx(playerid, "POLICE","Cop_move_fwd",4.0,1,1,1,1,1);
	}
	return true;
}

CMD:stance(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/stance [1-15]");
	if(id < 1 || id > 15) return SendServerMessage(playerid, "/stance [1-15]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "DEALER","DEALER_IDLE",4.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 0, 1, 1, 1, -1);
		case 3: ApplyAnimationEx(playerid, "PED","WOMAN_IDLESTANCE",4.0,1,0,0,0,0);
		case 4: ApplyAnimationEx(playerid, "PED","CAR_HOOKERTALK",4.0,1,0,0,0,0);
		case 5: ApplyAnimationEx(playerid, "FAT","FatIdle",4.0,1,0,0,0,0);
		case 6: ApplyAnimationEx(playerid, "WUZI","Wuzi_Stand_Loop",4.0,1,0,0,0,0);
		case 7: ApplyAnimationEx(playerid, "GRAVEYARD","mrnf_loop",4.0,1,0,0,0,0);
		case 8: ApplyAnimationEx(playerid, "GRAVEYARD","mrnm_loop",4.0,1,0,0,0,0);
		case 9: ApplyAnimationEx(playerid, "GRAVEYARD","prst_loopa",4.0,1,0,0,0,0);
		case 10: ApplyAnimationEx(playerid, "PED","idlestance_fat",4.0,1,0,0,0,0);
		case 11: ApplyAnimationEx(playerid, "PED","idlestance_old",4.0,1,0,0,0,0);
		case 12: ApplyAnimationEx(playerid, "PED","turn_l",4.0,1,0,0,0,0);
		case 13: ApplyAnimationEx(playerid, "BAR","Barcustom_loop",4.0,1,0,0,0,0);
		case 14: ApplyAnimationEx(playerid, "BAR","Barserve_loop",4.0,1,0,0,0,0);
		case 15: ApplyAnimationEx(playerid, "CAMERA","camcrch_cmon",4.0, 0, 1, 1, 1, -1);
	}
	return true;
}

CMD:wave(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/wave [1-5]");
	if(id < 1 || id > 5) return SendServerMessage(playerid, "/wave [1-5]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "BD_Fire", "BD_GF_Wave", 4.0, 0, 0, 0, 0, 0);
		case 3: ApplyAnimationEx(playerid, "RIOT","RIOT_CHANT",4.0,1,1,1,1,0);
		case 4: ApplyAnimationEx(playerid, "WUZI", "Wuzi_Follow", 5.0, 0, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "KISSING", "gfwave2", 4.0, 0, 0, 0, 0, 0);
	}
	return true;
}

CMD:run(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/run [1-10]");
	if(id < 1 || id > 10) return SendServerMessage(playerid, "/run [1-10]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "FAT","FatRun",4.0,1,1,1,1,1);
		case 2: ApplyAnimationEx(playerid, "PED","jog_femaleA",4.0,1,1,1,1,1);
		case 3: ApplyAnimationEx(playerid, "PED","jog_maleA",4.0,1,1,1,1,1);
		case 4: ApplyAnimationEx(playerid, "PED","run_old",4.0,1,1,1,1,1);
		case 5: ApplyAnimationEx(playerid, "PED","run_left",4.0,1,1,1,1,1);
		case 6: ApplyAnimationEx(playerid, "PED","run_fatold",4.0,1,1,1,1,1);
		case 7: ApplyAnimationEx(playerid, "PED","run_gang1",4.0,1,1,1,1,1);
		case 8: ApplyAnimationEx(playerid, "PED","run_fat",4.0,1,1,1,1,1);
		case 9: ApplyAnimationEx(playerid, "PED","run_right",4.0,1,1,1,1,1);
		case 10: ApplyAnimationEx(playerid, "PED","run_wuzi",4.0,1,1,1,1,1);
	}
	return true;
}

CMD:gsign(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/gsign [1-10]");
	if(id < 1 || id > 10) return SendServerMessage(playerid, "/gsign [1-10]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "GHANDS","gsign1",4.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "GHANDS", "gsign1LH", 4.0, 1, 0, 0, 0, 0);
		case 3: ApplyAnimationEx(playerid, "GHANDS", "gsign2", 4.0, 1, 0, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "GHANDS", "gsign2LH", 4.0, 1, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "GHANDS", "gsign3",4.0, 1, 0, 0, 0, 0);
		case 6: ApplyAnimationEx(playerid, "GHANDS", "gsign3LH",4.0,1,0,0,0,0);
		case 7: ApplyAnimationEx(playerid, "GHANDS", "gsign4", 4.0, 1, 0, 0, 0, 0);
		case 8: ApplyAnimationEx(playerid, "GHANDS", "gsign4LH", 4.0, 1, 0, 0, 0, 0);
		case 9: ApplyAnimationEx(playerid, "GHANDS", "gsign5", 4.0, 1, 0, 0, 0, 0);
		case 10: ApplyAnimationEx(playerid, "GHANDS", "gsign5LH",4.0, 1, 0, 0, 0, 0);
	}
	return true;
}

CMD:flag(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "CAR","flag_drop",3.0,0,0,0,0,0);
	return true;
}

CMD:giver(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/giver [1-2]");
	if(id < 1 || id > 2) return SendServerMessage(playerid, "/giver [1-2]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "KISSING","gift_give",3.0,0,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "BAR","Barserve_give",3.0,0,0,0,0,0);
	}
	return true;
}

CMD:look(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/look [1-4]");
	if(id < 1 || id > 4) return SendServerMessage(playerid, "/look [1-4]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "ON_LOOKERS","lkup_loop",3.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "ON_LOOKERS","lkaround_loop",3.0,1,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "PED","flee_lkaround_01",3.0,1,1,1,1,1);
		case 4: ApplyAnimationEx(playerid, "BAR","Barserve_bottle",3.0,0,1,1,1,0);
	}
	return true;
}

CMD:show(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	ApplyAnimationEx(playerid, "ON_LOOKERS","point_loop",3.0,1,0,0,0,0);
	return true;
}

CMD:shouts(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/shouts [1-3]");
	if(id < 1 || id > 3) return SendServerMessage(playerid, "/shouts [1-3]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "ON_LOOKERS","shout_loop",3.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "ON_LOOKERS","shout_01",3.0,1,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "ON_LOOKERS","shout_02",3.0,1,0,0,0,0);
	}
	return true;
}

CMD:endchat(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/endchat [1-3]");
	if(id < 1 || id > 3) return SendServerMessage(playerid, "/endchat [1-3]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED","endchat_01",8.0,0,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "PED","endchat_02",8.0,0,0,0,0,0);
		case 3: ApplyAnimationEx(playerid, "PED","endchat_03",8.0,0,0,0,0,0);
	}
	return true;
}

CMD:face(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/face [1-6]");
	if(id < 1 || id > 6) return SendServerMessage(playerid, "/face [1-6]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "PED","facanger",3.0,1,1,1,1,1);
		case 2: ApplyAnimationEx(playerid, "PED","facgum",3.0,1,1,1,1,1);
		case 3: ApplyAnimationEx(playerid, "PED","facsurp",3.0,1,1,1,1,1);
		case 4: ApplyAnimationEx(playerid, "PED","facsurpm",3.0,1,1,1,1,1);
		case 5: ApplyAnimationEx(playerid, "PED","factalk",3.0,1,1,1,1,1);
		case 6: ApplyAnimationEx(playerid, "PED","facurios",3.0,1,1,1,1,1);
	}
	return true;
}

CMD:caract(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/caract [1-7]");
	if(id < 1 || id > 7) return SendServerMessage(playerid, "/caract [1-7]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "LOWRIDER", "Tap_hand", 4.1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimationEx(playerid, "CAR", "sit_relaxed", 4.0, 1, 0, 0, 0, 0);
		case 3: ApplyAnimationEx(playerid, "CAR", "tap_hand", 4.0, 1, 1, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_in", 4.0,0,1,1,1,0);
		case 5: ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_loopa", 4.0, 1, 0, 0, 0, 0);
		case 6: ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_loopb", 4.0, 1, 0, 0, 0, 0);
		case 7: ApplyAnimationEx(playerid, "DRIVEBYS","Gang_DrivebyLHS",3.0,0,0,0,0,0);
	}
	return true;
}

CMD:riot(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new id;
	if(sscanf(params, "d", id)) return SendServerMessage(playerid, "/riot [1-5]");
	if(id < 1 || id > 5) return SendServerMessage(playerid, "/riot [1-5]");

	switch(id)
	{
		case 1: ApplyAnimationEx(playerid, "RIOT","RIOT_ANGRY",4.0,1,0,0,0,0);
		case 2: ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.0, 1, 0, 0, 0, 0);
		case 3: ApplyAnimationEx(playerid, "RIOT", "RIOT_challenge", 4.0, 1, 0, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "RIOT", "RIOT_PUNCHES", 4.0, 1, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "RIOT","RIOT_shout",4.0, 1, 0, 0, 0, 0);
	}
	return true;
}