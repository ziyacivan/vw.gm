new Iterator:Houses<MAX_HOUSES>;
new Iterator:Gallerys<MAX_GALLERYS>;
new Iterator:Weapons<MAX_WEAPONS>;
new Iterator:Factions<MAX_FACTIONS>;
new Iterator:Buildings<MAX_BUILDINGS>;
new Iterator:Business<MAX_BUSINESS>;
new Iterator:Boomboxes<MAX_BOOMBOX>;
new Iterator:ArrestPoints<MAX_ARREST_POINTS>;
new Iterator:Jails<MAX_JAILS>;
new Iterator:Furnitures<MAX_FURNITURES>;
new Iterator:FurnitureCategories<MAX_FURNITURE_CATEGORIES>;
new Iterator:FurnitureItems<MAX_FURNITURE_ITEMS>;
new Iterator:Damages<MAX_DAMAGES>;
new Iterator:Gasolines<MAX_GASOLINE>;

new InHouse[MAX_PLAYERS];
new PlayerHouse[MAX_PLAYERS];
new PDWork[MAX_PLAYERS];
new MDC_REGISTRY[MAX_PLAYERS][144];
new PassWarn[MAX_PLAYERS] = 0;
new bool:LoggedIn[MAX_PLAYERS]; 
new bool:PMBlock[MAX_PLAYERS];
new bool:Awork[MAX_PLAYERS];
new bool:Muted[MAX_PLAYERS];
new bool:SpecMode[MAX_PLAYERS];
new Float:SpecModePos[MAX_PLAYERS][4];
new SpecModeInt[MAX_PLAYERS]; 
new SpecModeVW[MAX_PLAYERS];
new bool:OnAnim[MAX_PLAYERS];
new PlayerHouseCheckpoint[MAX_PLAYERS];
new bool:OfferMode[MAX_PLAYERS];
new OfferBusinessID[MAX_PLAYERS];
new OfferBusinessPrice[MAX_PLAYERS];
new OfferBSOwnerID[MAX_PLAYERS];
new OfferHouseID[MAX_PLAYERS];
new OfferHousePrice[MAX_PLAYERS];
new OfferOwnerID[MAX_PLAYERS];
new OfferRentPrice[MAX_PLAYERS];
new OfferVehicleID[MAX_PLAYERS];
new OfferVehiclePrice[MAX_PLAYERS];
new EquippedWeapon[MAX_PLAYERS];
new EquippedWeaponID[MAX_PLAYERS];
new bool:ImEquippedWeapon[MAX_PLAYERS];
new CallTimer[MAX_PLAYERS];
new bool:Equipped[MAX_WEAPONS];
new bool:Engine[MAX_VEHICLES];
new bool:Doors[MAX_VEHICLES];
new bool:Lights[MAX_VEHICLES];
new bool:Bonnet[MAX_VEHICLES];
new bool:Boot[MAX_VEHICLES];
new FuelMeter[MAX_VEHICLES];
new UsageVehiclePark[MAX_PLAYERS];
new Float:VehicleParkPos[MAX_PLAYERS][3];
new Siren[MAX_VEHICLES];
new SirenObject[MAX_VEHICLES];

// furniture
new IsCreatingFurniture[MAX_PLAYERS];
new CreatingFurniture[MAX_PLAYERS];
new IsEditingFurniture[MAX_PLAYERS];
new IsDeletingFurniture[MAX_PLAYERS];

// gasoline
new HavingFuel[MAX_PLAYERS];
new FuelSeconds[MAX_PLAYERS];

new FactionInviteID[MAX_PLAYERS];
new bool:FactionInviteMode[MAX_PLAYERS];
new TakeTaser[MAX_PLAYERS];
new Cuffed[MAX_PLAYERS];
new TakeBarricade[MAX_PLAYERS];
new Gallery_FirstColor[MAX_PLAYERS];
new Gallery_SecondColor[MAX_PLAYERS];
new TakeBeanbag[MAX_PLAYERS];
new HaveMask[MAX_PLAYERS];
new MaskID[MAX_PLAYERS][124];
new UseMask[MAX_PLAYERS];
new HaveBat[MAX_PLAYERS];
new UseBat[MAX_PLAYERS];
new HaveFlower[MAX_PLAYERS];
new UseFlower[MAX_PLAYERS];
new Boombox[MAX_PLAYERS];
new FDWork[MAX_PLAYERS];
new Interview[MAX_PLAYERS];
new InterviewGuest[MAX_PLAYERS];
new InterviewInvite[MAX_PLAYERS];
new InterviewServer[MAX_PLAYERS];
//new AddDirectoryName[MAX_PLAYERS][144];
new InCall[MAX_PLAYERS];
new InCall_Line[MAX_PLAYERS];
new Smoking[MAX_PLAYERS];
new IsSendSearchOffer[MAX_PLAYERS];
new SearchOfferSender[MAX_PLAYERS];
new EditingCategory[MAX_PLAYERS];
new HasShotTB[MAX_PLAYERS];

// yaralý & ölüm sistemi
new DeathText[MAX_PLAYERS][64];
new DeathSecondsLeft[MAX_PLAYERS][24];

new Countries[][] =
{
	{"Almanya"},{"Amerika Birleþik Devletleri"},{"Arjantin"},{"Arnavutluk"},{"Hollanda"},{"Avustralya"},
	{"Avusturya"},{"Bahama Adalarý"},{"Bahreyn"},{"Bangladeþ"},{"Barbados"},{"Belçika"},{"Belize"},
	{"Benin"},{"Ýngiltere"},{"Beyaz Rusya"},{"Bhutan"},{"Birleþik Arap Emirlikleri"},{"Birmanya (Myanmar)"},
	{"Bolivya"},{"Bosna Hersek"},{"Botswana"},{"Brezilya"},{"Brunei"},{"Bulgaristan"},{"Çad"},{"Çek Cumhuriyeti"},
	{"Çin"},{"Danimarka"},{"Dominik Cumhuriyeti"},{"Ekvator"},{"Ekvator Ginesi"},{"El Salvador"},{"Endonezya"},
	{"Eritre"},{"Ermenistan"},{"Estonya"},{"Etiyopya"},{"Guatemala"},{"Fas"},{"Fiji"},{"Fildiþi Sahili"},{"Filipinler"},
	{"Filistin"},{"Finlandiya"},{"Folkland Adalarý, Ýngiltere"},{"Fransa"},{"Gabon"},{"Galler"},{"Gambiya"},{"Gana"},
	{"Gine"},{"Gine-Bissau"},{"Grenada"},{"Grönland"},{"Güney Kore"},{"Gürcista"},{"Güney Afrika"},{"Hýrvatistan"},
	{"Hindistan"},{"Hollanda"},{"Ýran"},{"Ýrlanda"},{"Ýskoçya"},{"Ýspanya"},{"Ýsrail"},{"Ýsveç"},{"Ýsviçre"},
	{"Ýtalya"},{"Ýzlanda"},{"Jamaika"},{"Japonya"},{"Kamboçya"},{"Kamerun"},{"Kanada"},{"Katar"},{"Kazakistan"},
	{"Kenya"},{"Kýrgýzistan"},{"Kiribati"},{"Kolombiya"},{"Komorlar"},{"Kongo"},{"Kosova"},{"Kosta Rika"},
	{"Kuveyt"},{"Kuzey Ýrlanda"},{"Kuzey Kore"},{"Küba"},{"Laos"},{"Lesotho"},{"Letonya"},{"Liberya"},{"Libya"},
	{"Liechtenstein"},{"Litvanya"},{"Lübnan"},{"Lüksemburg"},{"Macaristan"},{"Madagaskar"},{"Makau (Makao)"},
	{"Makedonya"},{"Malavi"},{"Maldiv Adalarý"},{"Malezya"},{"Mali"},{"Malta"},{"Marþal Adalarý"},{"Meksika"},
	{"Mýsýr"},{"Mikronezya"},{"Moðolistan"},{"Moldavya"},{"Monako"},{"Montserrat"},{"Moritanya"},{"Mozambik"},
	{"Namibia"},{"Nauru"},{"Nepal"},{"Nijer"},{"Nijerya"},{"Nikaragua"},{"Panama"},{"Papua Yeni Gine"},{"Paraguay"},
	{"Peru"},{"Polonya"},{"Portekiz"},{"Romanya"},{"Ruanda"},{"Rusya Federasyonu"},{"Samoa"},{"San Marino"},
	{"Santa Kitts ve Nevis"},{"Santa Lucia"},{"Santa Vincent ve Grenadinler"},{"Sao Tome ve Principe"},{"Senegal"},
	{"Seyþeller"},{"Sýrbistan"},{"Sierra Leone"},{"Singapur"},{"Slovakya"},{"Slovenya"},{"Solomon Adalarý"},{"Somali"},{"Sri Lanka"},
	{"Sudan"},{"Surinam"},{"Tacikistan"},{"Tanzanya"},{"Tayland"},{"Tayvan"},{"Togo"},{"Tonga"},{"Trinidad ve Tobago"},{"Tunus"},
	{"Uganda"},{"Ukrayna"},{"Umman"},{"Uruguay"},{"Yeni Zelanda"},{"Yunanistan"},{"Zambiya"},{"Zimbabve"}
};

new MySQL:conn;

enum CHARACTER_INFO
{
	cID,
	cAdmin,
	cNickname[124],
	cName[124],
	cPassword[124],
	cCreated,
	cAge,
	cSex,
	cSkinColor,
	cOrigin,
	cSkin,
	cInt,
	cVW,
	Float:cHP,
	Float:cArmour,
	Float:cPos[4],
	cMoney,
	cLevel,
	cHour,
	cMinute,
	cSecond,
	cIdentity,
	cBan,
	cWarn,
	bool:cAsked,
	cAskContent[124],
	bool:cReported,
	cReportContent[124],
	cTenantHouseID,
	cTenantPrice,
	cBankAccountNo,
	cBankCash,
	cBankSaving,
	cFaction,
	cFactionRank,
	cCuffed,
	cJail,
	cJailTimer,
	cJailTimeLeft,
	cOldSkin,
	cTaserTimer,
	cCigaratte,
	cLighter,
	cBoombox,
	cToolkit,
	cSkeletonKey,
	cPhoneID,
	cIsDead,
	cKillerPlayer,
	cKillerWeapon,
	cKilledAt[64],
	cDeathSecondsLeft,
	Text3D:cDeathLabel,
	cPhone,
	cPhoneNumber,
	cImCalling,
	cImCalled,
	cCallActive,
	cCallPartner,
	bool:cPhoneStatus,
	cChooseSlot,
	cInsideBusiness,
	cAcc[10]
}
new Character[MAX_PLAYERS][CHARACTER_INFO];

enum HOUSE_INFO
{
	hID,

	bool:hIsValid,
	hOwner,
	hDoorNumber,
	hPrice,
	Float:hExtDoor[3],
	Float:hIntDoor[3],
	hInt,
	hVW,
	hLocked,
	hKeyOwner,
	hLevel,
	hTenant,
	hCheckpoint,
	hPlayersInside
}
new House[MAX_HOUSES][HOUSE_INFO];

enum WEAPON_INFO
{
	wID,

	bool:wIsValid,
	wOwner,
	wWeaponID,
	wAmmo,
	wOnTheGround,
	Float:wPos[3],
	Float:wRot[3],
	wInt,
	wVW,
	wTempObject
}
new Weapon[MAX_WEAPONS][WEAPON_INFO];

enum BUILDING_INFO
{
	bID,

	bool:bIsValid,
	bName[124],
	bType,
	Float:bExtDoor[3],
	Float:bIntDoor[3],
	bInt,
	bVW,
	bLocked,
	bPickup
}
new Building[MAX_BUILDINGS][BUILDING_INFO];

enum VEHICLE_INFO
{
	vID,
	vVehicleID,

	bool:vIsValid,
	vOwner,
	vFaction,
	vModel,
	Float:vPos[4],
	vColor1,
	vColor2,
	vType,
	vPrice,
	vPlate[256],
	vKM,
	Float:vHealth,
	vFuel,
	vPark,
	vAccident,
	Float:vEngineLife,
	Float:vBatteryLife,
	vLockLevel,
	vAlarmLevel,
	vComp_Spoiler,
	vComp_Hood,
	vComp_Roof,
	vComp_SideSkirt,
	vComp_Lamps,
	vComp_Nitro,
	vComp_Exhaust,
	vComp_Wheels,
	vComp_Stereo,
	vComp_Hydraulics,
	vComp_FrontBumper,
	vComp_RearBumper,
	vComp_VentRight,
	vComp_VentLeft
}
new Vehicle[MAX_VEHICLES][VEHICLE_INFO];

enum FACTION_INFO
{
	fID,

	bool:fIsValid,
	fName[144],
	fType, // 0: Sivil, 1: LSPD, 2: LSMD, 3: LSFD, 4: Basýn, 5: GOV
	fRank1[64], // 1 tam yetki
	fRank2[64], // 2 tam yetki
	fRank3[64],
	fRank4[64],
	fRank5[64],
	fRank6[64],
	fRank7[64],
	fRank8[64],
	fRank9[64],
	fRank10[64],
	fRank11[64],
	fRank12[64],
	fLoginRank,
	fLevel,
	fLevelBonus,
	fAccessToWeapons,
	fAccessToDrugs,
	fChat
}
new Faction[MAX_FACTIONS][FACTION_INFO];

enum PENALTY_TICKETS_INFO
{
	ticketOwner,
	ticketID,
	ticketReason[64],
	ticketAmount,
	ticketDate[64],
	ticketOfficer[144]
}
new Penalty[MAX_PLAYERS][PENALTY_TICKETS_INFO];

enum BARRICADE_INFO
{
	Float:BARX,
	Float:BARY,
	Float:BARZ,
	bCreated,
	bObject,
	bOwner,
	bType[24]
}
new Barricade[MAX_BARRICADE][BARRICADE_INFO];

enum sInfo
{
    sCreated,
    Float:sXX,
    Float:sYY,
    Float:sZZ,
    sObject,
    sOwner
}
new SpikeInfo[MAX_SPIKESTRIPS][sInfo];

enum e_ZoneData
{
     	e_ZoneName[32 char],
     	Float:e_ZoneArea[6]
};
new const g_arrZoneData[][e_ZoneData] =
{
		{!"The Big Ear", 	              {-410.00, 1403.30, -3.00, -137.90, 1681.20, 200.00}},
		{!"Aldea Malvada",                {-1372.10, 2498.50, 0.00, -1277.50, 2615.30, 200.00}},
		{!"Angel Pine",                   {-2324.90, -2584.20, -6.10, -1964.20, -2212.10, 200.00}},
		{!"Arco del Oeste",               {-901.10, 2221.80, 0.00, -592.00, 2571.90, 200.00}},
		{!"Avispa Country Club",          {-2646.40, -355.40, 0.00, -2270.00, -222.50, 200.00}},
		{!"Avispa Country Club",          {-2831.80, -430.20, -6.10, -2646.40, -222.50, 200.00}},
		{!"Avispa Country Club",          {-2361.50, -417.10, 0.00, -2270.00, -355.40, 200.00}},
		{!"Avispa Country Club",          {-2667.80, -302.10, -28.80, -2646.40, -262.30, 71.10}},
		{!"Avispa Country Club",          {-2470.00, -355.40, 0.00, -2270.00, -318.40, 46.10}},
		{!"Avispa Country Club",          {-2550.00, -355.40, 0.00, -2470.00, -318.40, 39.70}},
		{!"Back o Beyond",                {-1166.90, -2641.10, 0.00, -321.70, -1856.00, 200.00}},
		{!"Battery Point",                {-2741.00, 1268.40, -4.50, -2533.00, 1490.40, 200.00}},
		{!"Bayside",                      {-2741.00, 2175.10, 0.00, -2353.10, 2722.70, 200.00}},
		{!"Bayside Marina",               {-2353.10, 2275.70, 0.00, -2153.10, 2475.70, 200.00}},
		{!"Beacon Hill",                  {-399.60, -1075.50, -1.40, -319.00, -977.50, 198.50}},
		{!"Blackfield",                   {964.30, 1203.20, -89.00, 1197.30, 1403.20, 110.90}},
		{!"Blackfield",                   {964.30, 1403.20, -89.00, 1197.30, 1726.20, 110.90}},
		{!"Blackfield Chapel",            {1375.60, 596.30, -89.00, 1558.00, 823.20, 110.90}},
		{!"Blackfield Chapel",            {1325.60, 596.30, -89.00, 1375.60, 795.00, 110.90}},
		{!"Blackfield Intersection",      {1197.30, 1044.60, -89.00, 1277.00, 1163.30, 110.90}},
		{!"Blackfield Intersection",      {1166.50, 795.00, -89.00, 1375.60, 1044.60, 110.90}},
		{!"Blackfield Intersection",      {1277.00, 1044.60, -89.00, 1315.30, 1087.60, 110.90}},
		{!"Blackfield Intersection",      {1375.60, 823.20, -89.00, 1457.30, 919.40, 110.90}},
		{!"Blueberry",                    {104.50, -220.10, 2.30, 349.60, 152.20, 200.00}},
		{!"Blueberry",                    {19.60, -404.10, 3.80, 349.60, -220.10, 200.00}},
		{!"Blueberry Acres",              {-319.60, -220.10, 0.00, 104.50, 293.30, 200.00}},
		{!"Caligula's Palace",            {2087.30, 1543.20, -89.00, 2437.30, 1703.20, 110.90}},
		{!"Caligula's Palace",            {2137.40, 1703.20, -89.00, 2437.30, 1783.20, 110.90}},
		{!"Calton Heights",               {-2274.10, 744.10, -6.10, -1982.30, 1358.90, 200.00}},
		{!"Chinatown",                    {-2274.10, 578.30, -7.60, -2078.60, 744.10, 200.00}},
		{!"City Hall",                    {-2867.80, 277.40, -9.10, -2593.40, 458.40, 200.00}},
		{!"Come-A-Lot",                   {2087.30, 943.20, -89.00, 2623.10, 1203.20, 110.90}},
		{!"Commerce",                     {1323.90, -1842.20, -89.00, 1701.90, -1722.20, 110.90}},
		{!"Commerce",                     {1323.90, -1722.20, -89.00, 1440.90, -1577.50, 110.90}},
		{!"Commerce",                     {1370.80, -1577.50, -89.00, 1463.90, -1384.90, 110.90}},
		{!"Commerce",                     {1463.90, -1577.50, -89.00, 1667.90, -1430.80, 110.90}},
		{!"Commerce",                     {1583.50, -1722.20, -89.00, 1758.90, -1577.50, 110.90}},
		{!"Commerce",                     {1667.90, -1577.50, -89.00, 1812.60, -1430.80, 110.90}},
		{!"Conference Center",            {1046.10, -1804.20, -89.00, 1323.90, -1722.20, 110.90}},
		{!"Conference Center",            {1073.20, -1842.20, -89.00, 1323.90, -1804.20, 110.90}},
		{!"Cranberry Station",            {-2007.80, 56.30, 0.00, -1922.00, 224.70, 100.00}},
		{!"Creek",                        {2749.90, 1937.20, -89.00, 2921.60, 2669.70, 110.90}},
		{!"Dillimore",                    {580.70, -674.80, -9.50, 861.00, -404.70, 200.00}},
		{!"Doherty",                      {-2270.00, -324.10, -0.00, -1794.90, -222.50, 200.00}},
		{!"Doherty",                      {-2173.00, -222.50, -0.00, -1794.90, 265.20, 200.00}},
		{!"Downtown",                     {-1982.30, 744.10, -6.10, -1871.70, 1274.20, 200.00}},
		{!"Downtown",                     {-1871.70, 1176.40, -4.50, -1620.30, 1274.20, 200.00}},
		{!"Downtown",                     {-1700.00, 744.20, -6.10, -1580.00, 1176.50, 200.00}},
		{!"Downtown",                     {-1580.00, 744.20, -6.10, -1499.80, 1025.90, 200.00}},
		{!"Downtown",                     {-2078.60, 578.30, -7.60, -1499.80, 744.20, 200.00}},
		{!"Downtown",                     {-1993.20, 265.20, -9.10, -1794.90, 578.30, 200.00}},
		{!"Downtown Los Santos",          {1463.90, -1430.80, -89.00, 1724.70, -1290.80, 110.90}},
		{!"Downtown Los Santos",          {1724.70, -1430.80, -89.00, 1812.60, -1250.90, 110.90}},
		{!"Downtown Los Santos",          {1463.90, -1290.80, -89.00, 1724.70, -1150.80, 110.90}},
		{!"Downtown Los Santos",          {1370.80, -1384.90, -89.00, 1463.90, -1170.80, 110.90}},
		{!"Downtown Los Santos",          {1724.70, -1250.90, -89.00, 1812.60, -1150.80, 110.90}},
		{!"Downtown Los Santos",          {1370.80, -1170.80, -89.00, 1463.90, -1130.80, 110.90}},
		{!"Downtown Los Santos",          {1378.30, -1130.80, -89.00, 1463.90, -1026.30, 110.90}},
		{!"Downtown Los Santos",          {1391.00, -1026.30, -89.00, 1463.90, -926.90, 110.90}},
		{!"Downtown Los Santos",          {1507.50, -1385.20, 110.90, 1582.50, -1325.30, 335.90}},
		{!"East Beach",                   {2632.80, -1852.80, -89.00, 2959.30, -1668.10, 110.90}},
		{!"East Beach",                   {2632.80, -1668.10, -89.00, 2747.70, -1393.40, 110.90}},
		{!"East Beach",                   {2747.70, -1668.10, -89.00, 2959.30, -1498.60, 110.90}},
		{!"East Beach",                   {2747.70, -1498.60, -89.00, 2959.30, -1120.00, 110.90}},
		{!"East Los Santos",              {2421.00, -1628.50, -89.00, 2632.80, -1454.30, 110.90}},
		{!"East Los Santos",              {2222.50, -1628.50, -89.00, 2421.00, -1494.00, 110.90}},
		{!"East Los Santos",              {2266.20, -1494.00, -89.00, 2381.60, -1372.00, 110.90}},
		{!"East Los Santos",              {2381.60, -1494.00, -89.00, 2421.00, -1454.30, 110.90}},
		{!"East Los Santos",              {2281.40, -1372.00, -89.00, 2381.60, -1135.00, 110.90}},
		{!"East Los Santos",              {2381.60, -1454.30, -89.00, 2462.10, -1135.00, 110.90}},
		{!"East Los Santos",              {2462.10, -1454.30, -89.00, 2581.70, -1135.00, 110.90}},
		{!"Easter Basin",                 {-1794.90, 249.90, -9.10, -1242.90, 578.30, 200.00}},
		{!"Easter Basin",                 {-1794.90, -50.00, -0.00, -1499.80, 249.90, 200.00}},
		{!"Easter Bay Airport",           {-1499.80, -50.00, -0.00, -1242.90, 249.90, 200.00}},
		{!"Easter Bay Airport",           {-1794.90, -730.10, -3.00, -1213.90, -50.00, 200.00}},
		{!"Easter Bay Airport",           {-1213.90, -730.10, 0.00, -1132.80, -50.00, 200.00}},
		{!"Easter Bay Airport",           {-1242.90, -50.00, 0.00, -1213.90, 578.30, 200.00}},
		{!"Easter Bay Airport",           {-1213.90, -50.00, -4.50, -947.90, 578.30, 200.00}},
		{!"Easter Bay Airport",           {-1315.40, -405.30, 15.40, -1264.40, -209.50, 25.40}},
		{!"Easter Bay Airport",           {-1354.30, -287.30, 15.40, -1315.40, -209.50, 25.40}},
		{!"Easter Bay Airport",           {-1490.30, -209.50, 15.40, -1264.40, -148.30, 25.40}},
		{!"Easter Bay Chemicals",         {-1132.80, -768.00, 0.00, -956.40, -578.10, 200.00}},
		{!"Easter Bay Chemicals",         {-1132.80, -787.30, 0.00, -956.40, -768.00, 200.00}},
		{!"El Castillo del Diablo",       {-464.50, 2217.60, 0.00, -208.50, 2580.30, 200.00}},
		{!"El Castillo del Diablo",       {-208.50, 2123.00, -7.60, 114.00, 2337.10, 200.00}},
		{!"El Castillo del Diablo",       {-208.50, 2337.10, 0.00, 8.40, 2487.10, 200.00}},
		{!"El Corona",                    {1812.60, -2179.20, -89.00, 1970.60, -1852.80, 110.90}},
		{!"El Corona",                    {1692.60, -2179.20, -89.00, 1812.60, -1842.20, 110.90}},
		{!"El Quebrados",                 {-1645.20, 2498.50, 0.00, -1372.10, 2777.80, 200.00}},
		{!"Esplanade East",               {-1620.30, 1176.50, -4.50, -1580.00, 1274.20, 200.00}},
		{!"Esplanade East",               {-1580.00, 1025.90, -6.10, -1499.80, 1274.20, 200.00}},
		{!"Esplanade East",               {-1499.80, 578.30, -79.60, -1339.80, 1274.20, 20.30}},
		{!"Esplanade North",              {-2533.00, 1358.90, -4.50, -1996.60, 1501.20, 200.00}},
		{!"Esplanade North",              {-1996.60, 1358.90, -4.50, -1524.20, 1592.50, 200.00}},
		{!"Esplanade North",              {-1982.30, 1274.20, -4.50, -1524.20, 1358.90, 200.00}},
		{!"Fallen Tree",                  {-792.20, -698.50, -5.30, -452.40, -380.00, 200.00}},
		{!"Fallow Bridge",                {434.30, 366.50, 0.00, 603.00, 555.60, 200.00}},
		{!"Fern Ridge",                   {508.10, -139.20, 0.00, 1306.60, 119.50, 200.00}},
		{!"Financial",                    {-1871.70, 744.10, -6.10, -1701.30, 1176.40, 300.00}},
		{!"Fisher's Lagoon",              {1916.90, -233.30, -100.00, 2131.70, 13.80, 200.00}},
		{!"Flint Intersection",           {-187.70, -1596.70, -89.00, 17.00, -1276.60, 110.90}},
		{!"Flint Range",                  {-594.10, -1648.50, 0.00, -187.70, -1276.60, 200.00}},
		{!"Fort Carson",                  {-376.20, 826.30, -3.00, 123.70, 1220.40, 200.00}},
		{!"Foster Valley",                {-2270.00, -430.20, -0.00, -2178.60, -324.10, 200.00}},
		{!"Foster Valley",                {-2178.60, -599.80, -0.00, -1794.90, -324.10, 200.00}},
		{!"Foster Valley",                {-2178.60, -1115.50, 0.00, -1794.90, -599.80, 200.00}},
		{!"Foster Valley",                {-2178.60, -1250.90, 0.00, -1794.90, -1115.50, 200.00}},
		{!"Frederick Bridge",             {2759.20, 296.50, 0.00, 2774.20, 594.70, 200.00}},
		{!"Gant Bridge",                  {-2741.40, 1659.60, -6.10, -2616.40, 2175.10, 200.00}},
		{!"Gant Bridge",                  {-2741.00, 1490.40, -6.10, -2616.40, 1659.60, 200.00}},
		{!"Ganton",                       {2222.50, -1852.80, -89.00, 2632.80, -1722.30, 110.90}},
		{!"Ganton",                       {2222.50, -1722.30, -89.00, 2632.80, -1628.50, 110.90}},
		{!"Garcia",                       {-2411.20, -222.50, -0.00, -2173.00, 265.20, 200.00}},
		{!"Garcia",                       {-2395.10, -222.50, -5.30, -2354.00, -204.70, 200.00}},
		{!"Garver Bridge",                {-1339.80, 828.10, -89.00, -1213.90, 1057.00, 110.90}},
		{!"Garver Bridge",                {-1213.90, 950.00, -89.00, -1087.90, 1178.90, 110.90}},
		{!"Garver Bridge",                {-1499.80, 696.40, -179.60, -1339.80, 925.30, 20.30}},
		{!"Glen Park",                    {1812.60, -1449.60, -89.00, 1996.90, -1350.70, 110.90}},
		{!"Glen Park",                    {1812.60, -1100.80, -89.00, 1994.30, -973.30, 110.90}},
		{!"Glen Park",                    {1812.60, -1350.70, -89.00, 2056.80, -1100.80, 110.90}},
		{!"Green Palms",                  {176.50, 1305.40, -3.00, 338.60, 1520.70, 200.00}},
		{!"Greenglass College",           {964.30, 1044.60, -89.00, 1197.30, 1203.20, 110.90}},
		{!"Greenglass College",           {964.30, 930.80, -89.00, 1166.50, 1044.60, 110.90}},
		{!"Hampton Barns",                {603.00, 264.30, 0.00, 761.90, 366.50, 200.00}},
		{!"Hankypanky Point",             {2576.90, 62.10, 0.00, 2759.20, 385.50, 200.00}},
		{!"Harry Gold Parkway",           {1777.30, 863.20, -89.00, 1817.30, 2342.80, 110.90}},
		{!"Hashbury",                     {-2593.40, -222.50, -0.00, -2411.20, 54.70, 200.00}},
		{!"Hilltop Farm",                 {967.30, -450.30, -3.00, 1176.70, -217.90, 200.00}},
		{!"Hunter Quarry",                {337.20, 710.80, -115.20, 860.50, 1031.70, 203.70}},
		{!"Idlewood",                     {1812.60, -1852.80, -89.00, 1971.60, -1742.30, 110.90}},
		{!"Idlewood",                     {1812.60, -1742.30, -89.00, 1951.60, -1602.30, 110.90}},
		{!"Idlewood",                     {1951.60, -1742.30, -89.00, 2124.60, -1602.30, 110.90}},
		{!"Idlewood",                     {1812.60, -1602.30, -89.00, 2124.60, -1449.60, 110.90}},
		{!"Idlewood",                     {2124.60, -1742.30, -89.00, 2222.50, -1494.00, 110.90}},
		{!"Idlewood",                     {1971.60, -1852.80, -89.00, 2222.50, -1742.30, 110.90}},
		{!"Jefferson",                    {1996.90, -1449.60, -89.00, 2056.80, -1350.70, 110.90}},
		{!"Jefferson",                    {2124.60, -1494.00, -89.00, 2266.20, -1449.60, 110.90}},
		{!"Jefferson",                    {2056.80, -1372.00, -89.00, 2281.40, -1210.70, 110.90}},
		{!"Jefferson",                    {2056.80, -1210.70, -89.00, 2185.30, -1126.30, 110.90}},
		{!"Jefferson",                    {2185.30, -1210.70, -89.00, 2281.40, -1154.50, 110.90}},
		{!"Jefferson",                    {2056.80, -1449.60, -89.00, 2266.20, -1372.00, 110.90}},
		{!"Julius Thruway East",          {2623.10, 943.20, -89.00, 2749.90, 1055.90, 110.90}},
		{!"Julius Thruway East",          {2685.10, 1055.90, -89.00, 2749.90, 2626.50, 110.90}},
		{!"Julius Thruway East",          {2536.40, 2442.50, -89.00, 2685.10, 2542.50, 110.90}},
		{!"Julius Thruway East",          {2625.10, 2202.70, -89.00, 2685.10, 2442.50, 110.90}},
		{!"Julius Thruway North",         {2498.20, 2542.50, -89.00, 2685.10, 2626.50, 110.90}},
		{!"Julius Thruway North",         {2237.40, 2542.50, -89.00, 2498.20, 2663.10, 110.90}},
		{!"Julius Thruway North",         {2121.40, 2508.20, -89.00, 2237.40, 2663.10, 110.90}},
		{!"Julius Thruway North",         {1938.80, 2508.20, -89.00, 2121.40, 2624.20, 110.90}},
		{!"Julius Thruway North",         {1534.50, 2433.20, -89.00, 1848.40, 2583.20, 110.90}},
		{!"Julius Thruway North",         {1848.40, 2478.40, -89.00, 1938.80, 2553.40, 110.90}},
		{!"Julius Thruway North",         {1704.50, 2342.80, -89.00, 1848.40, 2433.20, 110.90}},
		{!"Julius Thruway North",         {1377.30, 2433.20, -89.00, 1534.50, 2507.20, 110.90}},
		{!"Julius Thruway South",         {1457.30, 823.20, -89.00, 2377.30, 863.20, 110.90}},
		{!"Julius Thruway South",         {2377.30, 788.80, -89.00, 2537.30, 897.90, 110.90}},
		{!"Julius Thruway West",          {1197.30, 1163.30, -89.00, 1236.60, 2243.20, 110.90}},
		{!"Julius Thruway West",          {1236.60, 2142.80, -89.00, 1297.40, 2243.20, 110.90}},
		{!"Juniper Hill",                 {-2533.00, 578.30, -7.60, -2274.10, 968.30, 200.00}},
		{!"Juniper Hollow",               {-2533.00, 968.30, -6.10, -2274.10, 1358.90, 200.00}},
		{!"K.A.C.C. Military Fuels",      {2498.20, 2626.50, -89.00, 2749.90, 2861.50, 110.90}},
		{!"Kincaid Bridge",               {-1339.80, 599.20, -89.00, -1213.90, 828.10, 110.90}},
		{!"Kincaid Bridge",               {-1213.90, 721.10, -89.00, -1087.90, 950.00, 110.90}},
		{!"Kincaid Bridge",               {-1087.90, 855.30, -89.00, -961.90, 986.20, 110.90}},
		{!"King's",                       {-2329.30, 458.40, -7.60, -1993.20, 578.30, 200.00}},
		{!"King's",                       {-2411.20, 265.20, -9.10, -1993.20, 373.50, 200.00}},
		{!"King's",                       {-2253.50, 373.50, -9.10, -1993.20, 458.40, 200.00}},
		{!"LVA Freight Depot",            {1457.30, 863.20, -89.00, 1777.40, 1143.20, 110.90}},
		{!"LVA Freight Depot",            {1375.60, 919.40, -89.00, 1457.30, 1203.20, 110.90}},
		{!"LVA Freight Depot",            {1277.00, 1087.60, -89.00, 1375.60, 1203.20, 110.90}},
		{!"LVA Freight Depot",            {1315.30, 1044.60, -89.00, 1375.60, 1087.60, 110.90}},
		{!"LVA Freight Depot",            {1236.60, 1163.40, -89.00, 1277.00, 1203.20, 110.90}},
		{!"Las Barrancas",                {-926.10, 1398.70, -3.00, -719.20, 1634.60, 200.00}},
		{!"Las Brujas",                   {-365.10, 2123.00, -3.00, -208.50, 2217.60, 200.00}},
		{!"Las Colinas",                  {1994.30, -1100.80, -89.00, 2056.80, -920.80, 110.90}},
		{!"Las Colinas",                  {2056.80, -1126.30, -89.00, 2126.80, -920.80, 110.90}},
		{!"Las Colinas",                  {2185.30, -1154.50, -89.00, 2281.40, -934.40, 110.90}},
		{!"Las Colinas",                  {2126.80, -1126.30, -89.00, 2185.30, -934.40, 110.90}},
		{!"Las Colinas",                  {2747.70, -1120.00, -89.00, 2959.30, -945.00, 110.90}},
		{!"Las Colinas",                  {2632.70, -1135.00, -89.00, 2747.70, -945.00, 110.90}},
		{!"Las Colinas",                  {2281.40, -1135.00, -89.00, 2632.70, -945.00, 110.90}},
		{!"Las Payasadas",                {-354.30, 2580.30, 2.00, -133.60, 2816.80, 200.00}},
		{!"Las Venturas Airport",         {1236.60, 1203.20, -89.00, 1457.30, 1883.10, 110.90}},
		{!"Las Venturas Airport",         {1457.30, 1203.20, -89.00, 1777.30, 1883.10, 110.90}},
		{!"Las Venturas Airport",         {1457.30, 1143.20, -89.00, 1777.40, 1203.20, 110.90}},
		{!"Las Venturas Airport",         {1515.80, 1586.40, -12.50, 1729.90, 1714.50, 87.50}},
		{!"Last Dime Motel",              {1823.00, 596.30, -89.00, 1997.20, 823.20, 110.90}},
		{!"Leafy Hollow",                 {-1166.90, -1856.00, 0.00, -815.60, -1602.00, 200.00}},
		{!"Liberty City",                 {-1000.00, 400.00, 1300.00, -700.00, 600.00, 1400.00}},
		{!"Lil' Probe Inn",               {-90.20, 1286.80, -3.00, 153.80, 1554.10, 200.00}},
		{!"Linden Side",                  {2749.90, 943.20, -89.00, 2923.30, 1198.90, 110.90}},
		{!"Linden Station",               {2749.90, 1198.90, -89.00, 2923.30, 1548.90, 110.90}},
		{!"Linden Station",               {2811.20, 1229.50, -39.50, 2861.20, 1407.50, 60.40}},
		{!"Little Mexico",                {1701.90, -1842.20, -89.00, 1812.60, -1722.20, 110.90}},
		{!"Little Mexico",                {1758.90, -1722.20, -89.00, 1812.60, -1577.50, 110.90}},
		{!"Los Flores",                   {2581.70, -1454.30, -89.00, 2632.80, -1393.40, 110.90}},
		{!"Los Flores",                   {2581.70, -1393.40, -89.00, 2747.70, -1135.00, 110.90}},
		{!"Los Santos International",     {1249.60, -2394.30, -89.00, 1852.00, -2179.20, 110.90}},
		{!"Los Santos International",     {1852.00, -2394.30, -89.00, 2089.00, -2179.20, 110.90}},
		{!"Los Santos International",     {1382.70, -2730.80, -89.00, 2201.80, -2394.30, 110.90}},
		{!"Los Santos International",     {1974.60, -2394.30, -39.00, 2089.00, -2256.50, 60.90}},
		{!"Los Santos International",     {1400.90, -2669.20, -39.00, 2189.80, -2597.20, 60.90}},
		{!"Los Santos International",     {2051.60, -2597.20, -39.00, 2152.40, -2394.30, 60.90}},
		{!"Marina",                       {647.70, -1804.20, -89.00, 851.40, -1577.50, 110.90}},
		{!"Marina",                       {647.70, -1577.50, -89.00, 807.90, -1416.20, 110.90}},
		{!"Marina",                       {807.90, -1577.50, -89.00, 926.90, -1416.20, 110.90}},
		{!"Market",                       {787.40, -1416.20, -89.00, 1072.60, -1310.20, 110.90}},
		{!"Market",                       {952.60, -1310.20, -89.00, 1072.60, -1130.80, 110.90}},
		{!"Market",                       {1072.60, -1416.20, -89.00, 1370.80, -1130.80, 110.90}},
		{!"Market",                       {926.90, -1577.50, -89.00, 1370.80, -1416.20, 110.90}},
		{!"Market Station",               {787.40, -1410.90, -34.10, 866.00, -1310.20, 65.80}},
		{!"Martin Bridge",                {-222.10, 293.30, 0.00, -122.10, 476.40, 200.00}},
		{!"Missionary Hill",              {-2994.40, -811.20, 0.00, -2178.60, -430.20, 200.00}},
		{!"Montgomery",                   {1119.50, 119.50, -3.00, 1451.40, 493.30, 200.00}},
		{!"Montgomery",                   {1451.40, 347.40, -6.10, 1582.40, 420.80, 200.00}},
		{!"Montgomery Intersection",      {1546.60, 208.10, 0.00, 1745.80, 347.40, 200.00}},
		{!"Montgomery Intersection",      {1582.40, 347.40, 0.00, 1664.60, 401.70, 200.00}},
		{!"Mulholland",                   {1414.00, -768.00, -89.00, 1667.60, -452.40, 110.90}},
		{!"Mulholland",                   {1281.10, -452.40, -89.00, 1641.10, -290.90, 110.90}},
		{!"Mulholland",                   {1269.10, -768.00, -89.00, 1414.00, -452.40, 110.90}},
		{!"Mulholland",                   {1357.00, -926.90, -89.00, 1463.90, -768.00, 110.90}},
		{!"Mulholland",                   {1318.10, -910.10, -89.00, 1357.00, -768.00, 110.90}},
		{!"Mulholland",                   {1169.10, -910.10, -89.00, 1318.10, -768.00, 110.90}},
		{!"Mulholland",                   {768.60, -954.60, -89.00, 952.60, -860.60, 110.90}},
		{!"Mulholland",                   {687.80, -860.60, -89.00, 911.80, -768.00, 110.90}},
		{!"Mulholland",                   {737.50, -768.00, -89.00, 1142.20, -674.80, 110.90}},
		{!"Mulholland",                   {1096.40, -910.10, -89.00, 1169.10, -768.00, 110.90}},
		{!"Mulholland",                   {952.60, -937.10, -89.00, 1096.40, -860.60, 110.90}},
		{!"Mulholland",                   {911.80, -860.60, -89.00, 1096.40, -768.00, 110.90}},
		{!"Mulholland",                   {861.00, -674.80, -89.00, 1156.50, -600.80, 110.90}},
		{!"Mulholland Intersection",      {1463.90, -1150.80, -89.00, 1812.60, -768.00, 110.90}},
		{!"North Rock",                   {2285.30, -768.00, 0.00, 2770.50, -269.70, 200.00}},
		{!"Ocean Docks",                  {2373.70, -2697.00, -89.00, 2809.20, -2330.40, 110.90}},
		{!"Ocean Docks",                  {2201.80, -2418.30, -89.00, 2324.00, -2095.00, 110.90}},
		{!"Ocean Docks",                  {2324.00, -2302.30, -89.00, 2703.50, -2145.10, 110.90}},
		{!"Ocean Docks",                  {2089.00, -2394.30, -89.00, 2201.80, -2235.80, 110.90}},
		{!"Ocean Docks",                  {2201.80, -2730.80, -89.00, 2324.00, -2418.30, 110.90}},
		{!"Ocean Docks",                  {2703.50, -2302.30, -89.00, 2959.30, -2126.90, 110.90}},
		{!"Ocean Docks",                  {2324.00, -2145.10, -89.00, 2703.50, -2059.20, 110.90}},
		{!"Ocean Flats",                  {-2994.40, 277.40, -9.10, -2867.80, 458.40, 200.00}},
		{!"Ocean Flats",                  {-2994.40, -222.50, -0.00, -2593.40, 277.40, 200.00}},
		{!"Ocean Flats",                  {-2994.40, -430.20, -0.00, -2831.80, -222.50, 200.00}},
		{!"Octane Springs",               {338.60, 1228.50, 0.00, 664.30, 1655.00, 200.00}},
		{!"Old Venturas Strip",           {2162.30, 2012.10, -89.00, 2685.10, 2202.70, 110.90}},
		{!"Palisades",                    {-2994.40, 458.40, -6.10, -2741.00, 1339.60, 200.00}},
		{!"Palomino Creek",               {2160.20, -149.00, 0.00, 2576.90, 228.30, 200.00}},
		{!"Paradiso",                     {-2741.00, 793.40, -6.10, -2533.00, 1268.40, 200.00}},
		{!"Pershing Square",              {1440.90, -1722.20, -89.00, 1583.50, -1577.50, 110.90}},
		{!"Pilgrim",                      {2437.30, 1383.20, -89.00, 2624.40, 1783.20, 110.90}},
		{!"Pilgrim",                      {2624.40, 1383.20, -89.00, 2685.10, 1783.20, 110.90}},
		{!"Pilson Intersection",          {1098.30, 2243.20, -89.00, 1377.30, 2507.20, 110.90}},
		{!"Pirates in Men's Pants",       {1817.30, 1469.20, -89.00, 2027.40, 1703.20, 110.90}},
		{!"Playa del Seville",            {2703.50, -2126.90, -89.00, 2959.30, -1852.80, 110.90}},
		{!"Prickle Pine",                 {1534.50, 2583.20, -89.00, 1848.40, 2863.20, 110.90}},
		{!"Prickle Pine",                 {1117.40, 2507.20, -89.00, 1534.50, 2723.20, 110.90}},
		{!"Prickle Pine",                 {1848.40, 2553.40, -89.00, 1938.80, 2863.20, 110.90}},
		{!"Prickle Pine",                 {1938.80, 2624.20, -89.00, 2121.40, 2861.50, 110.90}},
		{!"Queens",                       {-2533.00, 458.40, 0.00, -2329.30, 578.30, 200.00}},
		{!"Queens",                       {-2593.40, 54.70, 0.00, -2411.20, 458.40, 200.00}},
		{!"Queens",                       {-2411.20, 373.50, 0.00, -2253.50, 458.40, 200.00}},
		{!"Randolph Industrial Estate",   {1558.00, 596.30, -89.00, 1823.00, 823.20, 110.90}},
		{!"Redsands East",                {1817.30, 2011.80, -89.00, 2106.70, 2202.70, 110.90}},
		{!"Redsands East",                {1817.30, 2202.70, -89.00, 2011.90, 2342.80, 110.90}},
		{!"Redsands East",                {1848.40, 2342.80, -89.00, 2011.90, 2478.40, 110.90}},
		{!"Redsands West",                {1236.60, 1883.10, -89.00, 1777.30, 2142.80, 110.90}},
		{!"Redsands West",                {1297.40, 2142.80, -89.00, 1777.30, 2243.20, 110.90}},
		{!"Redsands West",                {1377.30, 2243.20, -89.00, 1704.50, 2433.20, 110.90}},
		{!"Redsands West",                {1704.50, 2243.20, -89.00, 1777.30, 2342.80, 110.90}},
		{!"Regular Tom",                  {-405.70, 1712.80, -3.00, -276.70, 1892.70, 200.00}},
		{!"Richman",                      {647.50, -1118.20, -89.00, 787.40, -954.60, 110.90}},
		{!"Richman",                      {647.50, -954.60, -89.00, 768.60, -860.60, 110.90}},
		{!"Richman",                      {225.10, -1369.60, -89.00, 334.50, -1292.00, 110.90}},
		{!"Richman",                      {225.10, -1292.00, -89.00, 466.20, -1235.00, 110.90}},
		{!"Richman",                      {72.60, -1404.90, -89.00, 225.10, -1235.00, 110.90}},
		{!"Richman",                      {72.60, -1235.00, -89.00, 321.30, -1008.10, 110.90}},
		{!"Richman",                      {321.30, -1235.00, -89.00, 647.50, -1044.00, 110.90}},
		{!"Richman",                      {321.30, -1044.00, -89.00, 647.50, -860.60, 110.90}},
		{!"Richman",                      {321.30, -860.60, -89.00, 687.80, -768.00, 110.90}},
		{!"Richman",                      {321.30, -768.00, -89.00, 700.70, -674.80, 110.90}},
		{!"Robada Intersection",          {-1119.00, 1178.90, -89.00, -862.00, 1351.40, 110.90}},
		{!"Roca Escalante",               {2237.40, 2202.70, -89.00, 2536.40, 2542.50, 110.90}},
		{!"Roca Escalante",               {2536.40, 2202.70, -89.00, 2625.10, 2442.50, 110.90}},
		{!"Rockshore East",               {2537.30, 676.50, -89.00, 2902.30, 943.20, 110.90}},
		{!"Rockshore West",               {1997.20, 596.30, -89.00, 2377.30, 823.20, 110.90}},
		{!"Rockshore West",               {2377.30, 596.30, -89.00, 2537.30, 788.80, 110.90}},
		{!"Rodeo",                        {72.60, -1684.60, -89.00, 225.10, -1544.10, 110.90}},
		{!"Rodeo",                        {72.60, -1544.10, -89.00, 225.10, -1404.90, 110.90}},
		{!"Rodeo",                        {225.10, -1684.60, -89.00, 312.80, -1501.90, 110.90}},
		{!"Rodeo",                        {225.10, -1501.90, -89.00, 334.50, -1369.60, 110.90}},
		{!"Rodeo",                        {334.50, -1501.90, -89.00, 422.60, -1406.00, 110.90}},
		{!"Rodeo",                        {312.80, -1684.60, -89.00, 422.60, -1501.90, 110.90}},
		{!"Rodeo",                        {422.60, -1684.60, -89.00, 558.00, -1570.20, 110.90}},
		{!"Rodeo",                        {558.00, -1684.60, -89.00, 647.50, -1384.90, 110.90}},
		{!"Rodeo",                        {466.20, -1570.20, -89.00, 558.00, -1385.00, 110.90}},
		{!"Rodeo",                        {422.60, -1570.20, -89.00, 466.20, -1406.00, 110.90}},
		{!"Rodeo",                        {466.20, -1385.00, -89.00, 647.50, -1235.00, 110.90}},
		{!"Rodeo",                        {334.50, -1406.00, -89.00, 466.20, -1292.00, 110.90}},
		{!"Royal Casino",                 {2087.30, 1383.20, -89.00, 2437.30, 1543.20, 110.90}},
		{!"San Andreas Sound",            {2450.30, 385.50, -100.00, 2759.20, 562.30, 200.00}},
		{!"Santa Flora",                  {-2741.00, 458.40, -7.60, -2533.00, 793.40, 200.00}},
		{!"Santa Maria Beach",            {342.60, -2173.20, -89.00, 647.70, -1684.60, 110.90}},
		{!"Santa Maria Beach",            {72.60, -2173.20, -89.00, 342.60, -1684.60, 110.90}},
		{!"Shady Cabin",                  {-1632.80, -2263.40, -3.00, -1601.30, -2231.70, 200.00}},
		{!"Shady Creeks",                 {-1820.60, -2643.60, -8.00, -1226.70, -1771.60, 200.00}},
		{!"Shady Creeks",                 {-2030.10, -2174.80, -6.10, -1820.60, -1771.60, 200.00}},
		{!"Sobell Rail Yards",            {2749.90, 1548.90, -89.00, 2923.30, 1937.20, 110.90}},
		{!"Spinybed",                     {2121.40, 2663.10, -89.00, 2498.20, 2861.50, 110.90}},
		{!"Starfish Casino",              {2437.30, 1783.20, -89.00, 2685.10, 2012.10, 110.90}},
		{!"Starfish Casino",              {2437.30, 1858.10, -39.00, 2495.00, 1970.80, 60.90}},
		{!"Starfish Casino",              {2162.30, 1883.20, -89.00, 2437.30, 2012.10, 110.90}},
		{!"Temple",                       {1252.30, -1130.80, -89.00, 1378.30, -1026.30, 110.90}},
		{!"Temple",                       {1252.30, -1026.30, -89.00, 1391.00, -926.90, 110.90}},
		{!"Temple",                       {1252.30, -926.90, -89.00, 1357.00, -910.10, 110.90}},
		{!"Temple",                       {952.60, -1130.80, -89.00, 1096.40, -937.10, 110.90}},
		{!"Temple",                       {1096.40, -1130.80, -89.00, 1252.30, -1026.30, 110.90}},
		{!"Temple",                       {1096.40, -1026.30, -89.00, 1252.30, -910.10, 110.90}},
		{!"The Camel's Toe",              {2087.30, 1203.20, -89.00, 2640.40, 1383.20, 110.90}},
		{!"The Clown's Pocket",           {2162.30, 1783.20, -89.00, 2437.30, 1883.20, 110.90}},
		{!"The Emerald Isle",             {2011.90, 2202.70, -89.00, 2237.40, 2508.20, 110.90}},
		{!"The Farm",                     {-1209.60, -1317.10, 114.90, -908.10, -787.30, 251.90}},
		{!"The Four Dragons Casino",      {1817.30, 863.20, -89.00, 2027.30, 1083.20, 110.90}},
		{!"The High Roller",              {1817.30, 1283.20, -89.00, 2027.30, 1469.20, 110.90}},
		{!"The Mako Span",                {1664.60, 401.70, 0.00, 1785.10, 567.20, 200.00}},
		{!"The Panopticon",               {-947.90, -304.30, -1.10, -319.60, 327.00, 200.00}},
		{!"The Pink Swan",                {1817.30, 1083.20, -89.00, 2027.30, 1283.20, 110.90}},
		{!"The Sherman Dam",              {-968.70, 1929.40, -3.00, -481.10, 2155.20, 200.00}},
		{!"The Strip",                    {2027.40, 863.20, -89.00, 2087.30, 1703.20, 110.90}},
		{!"The Strip",                    {2106.70, 1863.20, -89.00, 2162.30, 2202.70, 110.90}},
		{!"The Strip",                    {2027.40, 1783.20, -89.00, 2162.30, 1863.20, 110.90}},
		{!"The Strip",                    {2027.40, 1703.20, -89.00, 2137.40, 1783.20, 110.90}},
		{!"The Visage",                   {1817.30, 1863.20, -89.00, 2106.70, 2011.80, 110.90}},
		{!"The Visage",                   {1817.30, 1703.20, -89.00, 2027.40, 1863.20, 110.90}},
		{!"Unity Station",                {1692.60, -1971.80, -20.40, 1812.60, -1932.80, 79.50}},
		{!"Valle Ocultado",               {-936.60, 2611.40, 2.00, -715.90, 2847.90, 200.00}},
		{!"Verdant Bluffs",               {930.20, -2488.40, -89.00, 1249.60, -2006.70, 110.90}},
		{!"Verdant Bluffs",               {1073.20, -2006.70, -89.00, 1249.60, -1842.20, 110.90}},
		{!"Verdant Bluffs",               {1249.60, -2179.20, -89.00, 1692.60, -1842.20, 110.90}},
		{!"Verdant Meadows",              {37.00, 2337.10, -3.00, 435.90, 2677.90, 200.00}},
		{!"Verona Beach",                 {647.70, -2173.20, -89.00, 930.20, -1804.20, 110.90}},
		{!"Verona Beach",                 {930.20, -2006.70, -89.00, 1073.20, -1804.20, 110.90}},
		{!"Verona Beach",                 {851.40, -1804.20, -89.00, 1046.10, -1577.50, 110.90}},
		{!"Verona Beach",                 {1161.50, -1722.20, -89.00, 1323.90, -1577.50, 110.90}},
		{!"Verona Beach",                 {1046.10, -1722.20, -89.00, 1161.50, -1577.50, 110.90}},
		{!"Vinewood",                     {787.40, -1310.20, -89.00, 952.60, -1130.80, 110.90}},
		{!"Vinewood",                     {787.40, -1130.80, -89.00, 952.60, -954.60, 110.90}},
		{!"Vinewood",                     {647.50, -1227.20, -89.00, 787.40, -1118.20, 110.90}},
		{!"Vinewood",                     {647.70, -1416.20, -89.00, 787.40, -1227.20, 110.90}},
		{!"Whitewood Estates",            {883.30, 1726.20, -89.00, 1098.30, 2507.20, 110.90}},
		{!"Whitewood Estates",            {1098.30, 1726.20, -89.00, 1197.30, 2243.20, 110.90}},
		{!"Willowfield",                  {1970.60, -2179.20, -89.00, 2089.00, -1852.80, 110.90}},
		{!"Willowfield",                  {2089.00, -2235.80, -89.00, 2201.80, -1989.90, 110.90}},
		{!"Willowfield",                  {2089.00, -1989.90, -89.00, 2324.00, -1852.80, 110.90}},
		{!"Willowfield",                  {2201.80, -2095.00, -89.00, 2324.00, -1989.90, 110.90}},
		{!"Willowfield",                  {2541.70, -1941.40, -89.00, 2703.50, -1852.80, 110.90}},
		{!"Willowfield",                  {2324.00, -2059.20, -89.00, 2541.70, -1852.80, 110.90}},
		{!"Willowfield",                  {2541.70, -2059.20, -89.00, 2703.50, -1941.40, 110.90}},
		{!"Yellow Bell Station",          {1377.40, 2600.40, -21.90, 1492.40, 2687.30, 78.00}},
		{!"Los Santos",                   {44.60, -2892.90, -242.90, 2997.00, -768.00, 900.00}},
		{!"Las Venturas",                 {869.40, 596.30, -242.90, 2997.00, 2993.80, 900.00}},
		{!"Bone County",                  {-480.50, 596.30, -242.90, 869.40, 2993.80, 900.00}},
		{!"Tierra Robada",                {-2997.40, 1659.60, -242.90, -480.50, 2993.80, 900.00}},
		{!"Tierra Robada",                {-1213.90, 596.30, -242.90, -480.50, 1659.60, 900.00}},
		{!"San Fierro",                   {-2997.40, -1115.50, -242.90, -1213.90, 1659.60, 900.00}},
		{!"Red County",                   {-1213.90, -768.00, -242.90, 2997.00, 596.30, 900.00}},
		{!"Flint County",                 {-1213.90, -2892.90, -242.90, 44.60, -768.00, 900.00}},
		{!"Whetstone",                    {-2997.40, -2892.90, -242.90, -1213.90, -1115.50, 900.00}}
};

enum ACCS_INFO
{
	ACCS_MODEL
}
new const ACCS[][ACCS_INFO] =
{
	{18633}, {18635}, {18638}, {18639}, {18692}, {18640}, {18975}, {19136}, {19274}, {18641}, {18644}, 
	{18645}, {18865}, {18866}, {18867}, {18868}, {18890}, {18891}, {18892}, {18893}, {18894}, {18895}, 
	{18896}, {18897}, {18898}, {18900}, {18901}, {18902}, {18903}, {18904}, {18905}, {18906}, {18907}, 
	{18908}, {18909}, {18910}, {18911}, {18912}, {18913}, {18914}, {18915}, {18916}, {18917}, {18918}, 
	{18919}, {18920}, {18974}, {19036}, {19037}, {19038}, {19039}, {19040}, {19041}, {19042}, {199043}, 
	{19044}, {19048}, {18921}, {18922}, {18964}, {18965}, {18966}, {18926}, {18927}, {18928}, {18929}, 
	{18930}, {18931}, {18932}, {18933}, {18934}, {18935}, {19116}, {19067}, {19528}, {18936}, {18937}, 
	{18938}, {18976}, {18978}, {18979}, {19006}, {19007}, {19008}, {19009}, {19010}, {19011}, {19012}, 
	{19013}, {19014}, {19015}, {19016}, {19017}, {19018}, {19020}, {19021}, {19022}, {19023}, {19024},
	{19025}, {19026}, {19027}, {19028}, {19029}, {19030}, {19031}, {19032}, {19033}, {19034}, {19035}, 
	{18939}, {18940}, {18941}, {18942}, {18943}, {18944}, {18945}, {18946}, {18947}, {18948}, {18949}, 
	{18950}, {18951}, {19085}, {19094}, {19101}, {19107}, {19114}, {19115}, {19137}, {19163}, {19330}, 
	{1210}, {19559}, {19878}, {19591}, {19610}, {19317}, {19622}, {19624}, {19625}, {19626}
};

enum CLOTHES_INFO
{
	CLOTHES_MODEL
}
new const SHOP_WHITE_MALE[][CLOTHES_INFO] =
{
	{1},{2},{3},{23},{26},{27},{29},{30},{32},{33},{34},{35},{37},{42},{43},{44},{45},{46},{47},{48},
	{49},{50},{51},{52},{57},{58},{59},{60},{62},{68},{72},{73},{78},{94},{95},{96},{97},{98},{100},{101},
	{108},{109},{110},{111},{112},{113},{114},{115},{116},{117},{118},{119},{120},{121},{122},{123},{124},
	{125},{126},{127},{128},{132},{133},{135},{137},{153},{155},{156},{158},{159},{160},{161},{162},{164},
	{165},{170},{171},{173},{174},{175},{177},{179},{181},{184},{186},{187},{188},{189},{200},{202},{203},
	{204},{206},{208},{209},{210},{212},{213},{217},{223},{227},{228},{229},{230},{234},{235},{236},{239},
	{240},{241},{242},{247},{248},{249},{250},{254},{255},{258},{259},{261},{268},{272},{273},{289},{290},
	{291},{292},{294},{295},{299}
};
new const SHOP_BLACK_MALE[][CLOTHES_INFO] =
{
	{4},{5},{6},{7},{14},{15},{16},{17},{18},{19},{20},{21},{22},{24},{25},{28},{51},{66},{67},{79},
	{86},{102},{103},{104},{105},{106},{107},{136},{142},{143},{144},{149},{156},{163},{166},{167},{168},
	{176},{180},{182},{183},{220},{221},{222},{253},{260},{262},{269},{270},{271},{293},{296},{297}
};
new const SHOP_WHITE_FEMALE[][CLOTHES_INFO] =
{
	{12}, {31}, {38}, {39}, {40}, {41}, {53}, {54}, {55}, {56}, {63}, {64}, {75}, {76}, {85}, {87}, {88}, 
	{89}, {90}, {91}, {93}, {129}, {130}, {131}, {138}, {140}, {141}, {145}, {150}, {151}, {152}, {157}, 
	{169}, {172}, {178}, {191}, {192}, {193}, {194}, {198}, {201}, {205}, {214}, {216}, {224}, {225}, {226}, 
	{232}, {233}, {237}, {251}, {257}, {263}
};
new const SHOP_BLACK_FEMALE[][CLOTHES_INFO] =
{
	{9}, {10}, {11}, {13}, {40}, {63}, {65}, {69}, {76}, {139}, {190}, {195}, {207}, {219}, {233}, {256}, {298}
};

enum GALLERY_INFO
{
	gID,
	bool:gIsValid,
	gName[32],
	Float:gPos[3],
	Float:gSpawnPos[3],
	gPickup
}
new Gallery[MAX_GALLERYS][GALLERY_INFO];

enum GALLERY_VEHICLE_LIST
{
	GALLERY_VEHICLE_MODEL,
	GALLERY_VEHICLE_PRICE
};
new const VEHICLE_GALLERY[][GALLERY_VEHICLE_LIST] =
{
	{400, 50000},
	{401, 13000},
	{404, 14000},
	{405, 41000},
	{410, 12500},
	{412, 26000},
	{413, 34000},
	{414, 68000},
	{418, 18000},
	{419, 17000},
	{421, 45000},
	{422, 13000},
	{426, 62000},
	{436, 12000},
	{439, 60000},
	{440, 51000},
	{445, 40000,},
	{458, 18000},
	{466, 7500},
	{467, 9000},
	{474, 40000},
	{475, 52000},
	{478, 16000},
	{479, 19500},
	{482, 41000},
	{483, 30000},
	{489, 90000},
	{491, 1300},
	{492, 15000},
	{496, 42000},
	{498, 47000},
	{500, 45000},
	{507, 33000},
	{508, 50000},
	{516, 13250},
	{517, 17750},
	{518, 12000},
	{526, 15500},
	{527, 11000},
	{529, 14000},
	{533, 57000},
	{534, 38000},
	{535, 60000},
	{536, 24000},
	{540, 33000},
	{542, 11000},
	{543, 10000},
	{546, 12000},
	{547, 10000},
	{549, 6000},
	{550, 32000},
	{551, 43000},
	{554, 20000},
	{566, 25000},
	{567, 32000},
	{575, 47000},
	{576, 14000},
	{587, 40000},
	{585, 13000},
	{588, 20000},
	{589, 47000},
	{600, 10000},
	{602, 45000},
	{420, 15000},
	{438, 18000},
	{423, 20000},
	{525, 12750},
	{579, 120000},
	{402, 100000},
	{415, 250000},
	{429, 200000},
	{477, 85000},
	{565, 90000},
	{480, 130000},
	{533, 57000},
	{555, 150000},
	{558, 95000},
	{559, 110000},
	{560, 90000},
	{561, 35000},
	{562, 120000},
	{603, 170000},
	{580, 500000},
	{545, 400000},
	{409, 700000},
	{462, 6000},
	{471, 25000},
	{468, 15000},
	{463, 20000},
	{586, 32000},
	{581, 20000},
	{461, 30000},
	{521, 50000}
};

new stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

enum PD_SKIN_INFO
{
	PD_SKIN_MODEL
};
new const LSPD_MALE[][PD_SKIN_INFO] =
{
	{21},
	{22},
	{23},
	{25001}, 
	{25002}, 
	{25003}, 
	{25004}, 
	{25005}, 
	{25006}, 
	{25007}, 
	{25008}, 
	{25009}, 
	{25010}, 
	{25011}, 
	{25012}, 
	{25013},
	{25014}, 
	{25020}, 
	{25021}, 
	{25022}, 
	{25023}, 
	{25026}, 
	{25027}, 
	{25028}, 
	{25029}
};
new const LSPD_FEMALE[][PD_SKIN_INFO] =
{
	{25015}, 
	{25016}, 
	{25017}, 
	{25018}, 
	{25019}, 
	{25024}, 
	{25025}, 
	{25030}, 
	{25031}, 
	{25032}
};

enum BUSINESS_INFO
{
	bsID,

	bool:bsIsValid,
	bsOwner,
	bsPrice,
	bsName[124],
	bsType,
	Float:bsExtDoor[3],
	Float:bsIntDoor[3],
	bsInt,
	bsVW,
	bsLocked,
	bsWorkers[10],
	bsWorkersPayday[10],
	bsSafe,
	bsPickup,
	bsMapIcon
}
new Business[MAX_BUSINESS][BUSINESS_INFO];

enum BoomboxEnum {
    Owner,
    Float: POS[3],
    Object,
    Circle,
    Text3D: Label,
    URL[128]
};
new BoomboxData[MAX_BOOMBOX][BoomboxEnum];

enum JailData {
	ID,
	Float: POS[3],
	bool: IsValid,
	VirtualWorld,
	Interior
};
new Jail[MAX_JAILS][JailData];

enum ArrestPointData {
	ID,
	Float: POS[3],
	VirtualWorld,
	Interior,
	Text3D:TextLabel,
	STREAMER_TAG_PICKUP: Pickup,
	bool: IsValid
};
new ArrestPoint[MAX_ARREST_POINTS][ArrestPointData];

enum FD_SKIN_INFO
{
	FD_SKIN_MODEL
};
new const LSFD_MALE[][FD_SKIN_INFO] =
{
	{26000}, {26001}, {26002}, {26003}, {26004}
};
new const LSFD_FEMALE[][FD_SKIN_INFO] =
{
	{26005}, {26006}, {26007}, {26008}
};

/*
enum PHONE_INFO
{
	phID,

	bool:phIsValid,
	phOwner,
	phNumber,
	phOnTheGround,
	Float:phPos[3],
	Float:phRot[3],
	phInt,
	phVW,
	phStatus,

	// memory
	phTempObject,
	phSendingACall,
	phSendingPID,
	phReceivingACall,
	phReceivingPID,
	phLine
}
new Phone[MAX_PHONES][PHONE_INFO];*/

enum FurnitureData {
    fID,

    bool:fIsValid,

    fHouse,
    fType,
    fObjModel,
    fIsHidden,
    fInterior,
    fVirtualWorld,

    STREAMER_TAG_OBJECT:fObject,

    Float:fPOS[3],
    Float:fROT[3]
};
new Furniture[MAX_FURNITURES][FurnitureData];

enum FurnitureCategoryData {
    cID,
    bool:cIsValid,
    cName[64],
    cType
};
new FurnitureCategory[MAX_FURNITURE_CATEGORIES][FurnitureCategoryData];

enum FurnitureItemData {
    iID,
    bool:iIsValid,
    iType,
    iModel
};
new FurnitureItem[MAX_FURNITURE_ITEMS][FurnitureItemData];

enum DIRECTORY_INFO
{
	dOwner,

	bool:dIsValid,
	dName[124],
	dNumber
}
new Directory[MAX_PLAYERS][MAX_DIRECTORY][DIRECTORY_INFO];

enum DAMAGE_INFO {
    bool:dIsValid,
    dDamager[24],
    dDamaged,
    dWeapon,
    Float:dHealthTaken,
	dBodyPart[24]
};
new Damage[MAX_DAMAGES][DAMAGE_INFO];

enum GASOLINE_INFO {
    gID,
    bool:gIsValid,
    Float:gPos[3],
    gCost,
    gPickup,
    gStationName[24]
};
new Gasoline[MAX_GASOLINE][GASOLINE_INFO];