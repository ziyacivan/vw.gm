#define HOSTNAME		"[0.3DL] Vinewood Roleplay - vw-rp.com"
#define VERSION 		"VW:RP"
#define MAP 			"Los Santos"
#define DEVELOPER		"Inked & Glorfin"
#define PASSWORD 		"ink32"
#define LANGUAGE		"Vinelish"
#define WEBSITE			"www.vw-rp.com"

#define CONNECTION_TYPE		(1)

#define V_HOST	"127.0.0.1"
#define V_USER	"root"
#define V_PASS 	"secretx123"
#define V_DB 	"vinewood"

#define L_HOST	"localhost"
#define L_USER	"root"
#define L_PASS 	""
#define L_DB 	"vinewood"

#define SPAWN_POS_X			1742.9924
#define SPAWN_POS_Y			-1861.4882
#define SPAWN_POS_Z			13.5775
#define SPAWN_POS_A			90

#define C_VINEWOOD			(0x9A9B9DFF)
#define C_WHITE				(0xFFFFFFFF)
#define C_ADMIN 			(0xFF6347AA)
#define C_BLACK1			(0xE6E6E6E6)
#define C_BLACK2			(0xC8C8C8C8)
#define C_BLACK3			(0xAAAAAAAA)
#define C_BLACK4			(0x8C8C8C8C)	
#define C_BLACK5			(0x6E6E6E6E)
#define C_EMOTE 			(0xD0AEEBFF)
#define C_PINK 				(0xFF8282FF)
#define C_YELLOW 			(0xFFFF0000)
#define C_PM 				(0xFFBB0000)
#define C_DGREEN 			(0x33AA33FF)
#define C_GREY1				(0x9A9B9DFF)
#define C_GREY2				(0xE6E6E6E6)
#define C_BLUE 				(0x2196F3FF)
#define C_GREEN 			(0x268126FF)
#define C_FACTION			(0x6C7BE6FF)
#define C_FIREDEPARTMENT	(0xdf3053FF)
#define C_NEWS 				(0x276123FF)

#define Vinewood:%0(%1) forward %0(%1); public %0(%1)

#define Holding(%0) \
        ((newkeys & (%0)) == (%0))

#define PRESSING(%0,%1) \
    (%0 & (%1))

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define RELEASED(%0) \
    (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, 0xAFAFAFFF, "[!] {9A9B9D}"%1)

#define VWTESTER 						(1)
#define VWGAMEADMIN1					(2)
#define VWGAMEADMIN2					(3)
#define VWGAMEADMIN3					(4)
#define VWGAMEADMIN4					(5)
#define VWDEVELOPER						(6)
#define VWLEADADMIN						(7)

#define MAX_HOUSES						(200)
#define MAX_WEAPONS						(500)
#define MAX_BUILDINGS					(100)
#define MAX_GALLERYS					(10)
#define MAX_FACTIONS					(100)
#define MAX_BOLOS						(12)
#define MAX_APB							(12)
#define MAX_BARRICADE					(100)
#define MAX_SPIKESTRIPS					(100)
#define MAX_BUSINESS					(250)
#define MAX_JAILS 						(20)
#define MAX_BOOMBOX                     (30)
#define MAX_DIRECTORY					(10)
#define MAX_DAMAGES                     (100)

#define DEFAULT_DEATH_SECONDS           (15)
#define DEATH_LABEL_DD                  (30.0)
#define DEATH_LABEL_COLOR               (0xBF4957FF)

#define DAMAGED_VEHICLE_HEALTH          (350.0)

#define FACTION_POLICE					(1)
#define FACTION_MEDIC					(2)
#define FACTION_FD						(3)
#define FACTION_NEWS					(4)
#define FACTION_DOC             		(6)

#define S_DIALOG_GALLERY				(1)	
#define S_DIALOG_MALEPD					(2)
#define S_DIALOG_FEMALEPD				(3)
#define S_DIALOG_FURNITURE              (4)
#define M_COMPONENT_LANDSTALKER			(5)
#define BUY_BLACK_MALE                  (10)
#define BUY_WHITE_MALE                  (11)
#define BUY_BLACK_FEMALE                (12)
#define BUY_WHITE_FEMALE                (13)
#define BUY_A_ACC                       (14)

#define BOOMBOX_RANGE                   (20.0)
#define BOOMBOX_MODEL                   (2226)

#define PRISONER_SKIN_1 				(1)
#define PRISONER_SKIN_2					(2)

#define JAIL_OUT_X						(1234.5112)
#define JAIL_OUT_Y						(25.5112)
#define JAIL_OUT_Z						(2.5112)

#define MAX_ARREST_POINTS 				(20)
#define ARREST_POINT_PICKUP				(1247)

#define CHALLANGE_TOOLKIT               (1)
#define CHALLANGE_INTERVAL              (2)
#define CHALLANGE_HOUSE_KEY				(3)
#define CHALLANGE_VEH_KEY				(4)
#define CHALLANGE_FIXING_CAR            (5)

#define MESSAGE_COST                    (5)
#define CALL_COST                       (5)

#define MAX_FURNITURES                  (100)
#define MAX_FURNITURE_ITEMS             (50)
#define MAX_FURNITURE_CATEGORIES        (20)

#define MAX_GASOLINE            (20)
#define GASOLINE_MODEL          (1650)
#define GASOLINE_DISTANCE       (10.0)