(*****************************************************************************
==============================================================================
CODEMETER.PAS                          Public Borland Delphi definition module
==============================================================================

This module implements the interface for Borland Delphi.

==============================================================================

Copyright  2004-2018 by WIBU-SYSTEMS AG
           Rueppurrer Strasse 52-54, D-76137 Karlsruhe, Germany/Europe
           Website: http://wwww.wibu.com, Email: support@wibu.com
           Phone: +49-721-93172-0, Fax: +49-721-93172-22
           All rights reserved.

Version .. 6.70 of 2018Jun28
Project .. dev/include/
System ... Windows XP, Windows 7, Windows 10
Tools .... Borland Delphi 5.0, Borland Delphi 7.0

Change Report
2004Mar03 1.00 ra:   initial version
2004Oct12 2.00 ra:   added 1 byte alignment for programming and enabling structures
2005Jun16 2.10 ra:   added musProductItemReference parameter to CMACCESS structure
2005Jun17 2.10 ra:   updated Remote Programming API
2005Nov23 2.20 sts:  new structures and constants added
2006Sep09 3.10 mh:   new structures and constants added
2007Jan25 3.20 mh:   CM_CRYPT_AES_DIRECT, CM_CRYPT_RSA added.
2007Apr20 3.21 mh:   CM_GS_ALL_SERVERS added.
2007May29 3.21 mh:   ErrorCode 90, 91 CONST naming changed.
2007Oct17 3.21 mh:   CM_GS_REMOTE_SERVERS_ONLY added.
2007Oct30 3.21 mh:   CM_GBC_USELOCALTIME and CM_GEI_USELOCALTIME added.
2008Jan11 3.30 mh:   new structures (CMACCESS2, CMCREDENTIAL) and new functions added.
2008Feb08 3.30 wv:   removing unused functions / structures
2008Feb18 3.30a wv:  adding ordinals to function calls
2008Mar28 3.30a: mh: new CM_GEI_BOXSTATUS flags, CodeMeterAct flags
2008Nov12 4.00: mb:  add new structures and functions of CodeMeter.h v1.197
2009Feb25 4.01: sts: updated according to CodeMeter.h v1.213
2009Jul27 4.10: rk:  updated according to CodeMeter.h v1.224
2009Aug14 4.10a: mb:  updated according to CodeMeter.h v1.225
2010Apr22 4.20: dar:  updated according to CodeMeter.h v1.245
2010Dez20 4.30: dar:  updated according to CodeMeter.h v1.281
2011Apr12 4.30: wv:  Bugfix in CmGetRemoteContext2() and CmGetRemoteContextBuffer
2011Apr15 4.30: mb:  updated according to CodeMeter. h
2011Apr15 4.30: mb:  Remove CmTalk
2011Nov07 4.40: sig: added CM_ACCESS_IGNORE_LINGERTIME
2012Jan31 5.00: mz: updated error codes and flags from CodeMeter.h
2012Feb19 5.00: mz: adopted changes of the current version of CodeMeter.h
2013Jun14 5.01: mz: adopted changes of the current version of CodeMeter.h
2014Apr15 5.20: mz: adopted changes of the current version of CodeMeter.h
*****************************************************************************)

unit CodeMeter;

interface

uses WinTypes;

(* general types *)
type PBYTE = ^BYTE;
type PLONGWORD = ^LONGWORD;
type PWORD = ^WORD;

{$IFDEF WIN32}
	const LIB = 'WibuCm32.dll';
{$ELSE}
	const LIB = 'WibuCm64.dll';
{$ENDIF}

(*****************************************************************************
 ************************* CodeMeter error codes *****************************
******************************************************************************)

(* common errors of the CodeMeter driver components *)
(* common no error code is 0 *)
const CMERROR_NO_ERROR                        = 0;
(* box specific error codes *)
const CMERROR_COMMANDUNDEFINED                = 1;
const CMERROR_COMMANDINVALID                  = 2;
const CMERROR_COMMANDTOOLARGE                 = 3;
const CMERROR_COMMANDWRONG                    = 4;
const CMERROR_COMMANDTVBWRONG                 = 5;
const CMERROR_COMMANDINCOMPLETE               = 6;
const CMERROR_AWAITENCRYPTIONRESTART          = 7;
const CMERROR_ANSWERBUFFERFULL                = 8;
const CMERROR_VALUETOOLARGE                   = 9;
const CMERROR_OPTIONUNDEFINED                 = 10;
const CMERROR_OPTIONINVALID                   = 11;
const CMERROR_TYPEUNDEFINED                   = 12;
const CMERROR_TYPEWRONG                       = 13;
const CMERROR_KEYSOURCEUNDEFINED              = 14;
const CMERROR_KEYSOURCEINVALID                = 15;
const CMERROR_KEYSOURCEMISSED                 = 16;
const CMERROR_KEYSOURCEWRONG                  = 17;
const CMERROR_DATATOOSHORT                    = 18;
const CMERROR_DATATOOLONG                     = 19;
const CMERROR_DATAWRONG                       = 20;
const CMERROR_FIRMITEMINVALID                 = 21;
const CMERROR_FIRMCODEEXISTS                  = 22;
const CMERROR_PRODUCTITEMINVALID              = 23;
const CMERROR_PRODUCTITEMOPTIONUNDEFINED      = 24;
const CMERROR_PRODUCTITEMOPTIONINVALID        = 25;
const CMERROR_PRODUCTITEMOPTIONMISSED         = 26;
const CMERROR_FIRMCODEWRONG                   = 27;
const CMERROR_PRODUCTCODEWRONG                = 28;
const CMERROR_FEATUREMAPMISSED                = 29;
const CMERROR_FEATUREMAPINCOMPATIBLE          = 30;
const CMERROR_UNITCOUNTERMISSED               = 31;
const CMERROR_UNITCOUNTERZERO                 = 32;
const CMERROR_UNITCOUNTERUNDERRUN             = 33;
const CMERROR_EXPIRATIONTIMEMISSED            = 34;
const CMERROR_EXPIRATIONTIMEOVERRUN           = 35;
const CMERROR_ACTIVATIONTIMEMISSED            = 36;
const CMERROR_ACTIVATIONTIMEUNDERRUN          = 37;
const CMERROR_FIRMACCESSCOUNTERZERO           = 38;
const CMERROR_CERTIFIEDTIMEOBSOLETE           = 39;
const CMERROR_ENCRYPTIONINVALID               = 40;
const CMERROR_DIFFIEHELLMANFAILED             = 41;
const CMERROR_ECIESFAILED                     = 42;
const CMERROR_SUBCOMMANDUNDEFINED             = 43;
const CMERROR_SUBCOMMANDINVALID               = 44;
const CMERROR_SUBCOMMANDINCOMPLETE            = 45;
const CMERROR_SUBCOMMANDSTRUCTUREWRONG        = 46;
const CMERROR_TVBWRONG                        = 47;
const CMERROR_FIRMUPDATECOUNTERWRONG          = 48;
const CMERROR_PITVBFLAGINVALID                = 49;
const CMERROR_PITVBFLAGINCOMPATIBLE           = 50;
const CMERROR_ENABLEBLOCKUSED                 = 51;
const CMERROR_BOXDISABLED                     = 52;
const CMERROR_FIRMITEMDISABLED                = 53;
const CMERROR_PRODUCTITEMDISABLED             = 54;
const CMERROR_INDEXINVALID                    = 55;
const CMERROR_LEVELINVALID                    = 56;
const CMERROR_TABLEFULL                       = 57;
const CMERROR_MEMORYFULL                      = 58;
const CMERROR_MEMORYDAMAGED                   = 59;
const CMERROR_QUEENMEMORYDAMAGED              = 60;
const CMERROR_FIRMITEMDAMAGED                 = 61;
const CMERROR_CRTOKENOBSOLETE                 = 62;
const CMERROR_MEMORYWRITEFAILED               = 63;
const CMERROR_BOXBUSY                         = 64;
const CMERROR_FEATURECODEINVALID              = 65;
const CMERROR_COMMANDUNSUPPORTED              = 66;
const CMERROR_FIELDUPDATELIMITEXCEEDED        = 67;
const CMERROR_FLASHWRITEFAILED                = 68;
const CMERROR_ACCESSMODEWRONG                 = 69;
const CMERROR_BOXLOST                         = 70;
const CMERROR_USAGEPERIODOVERRUN              = 71;
const CMERROR_USAGEPERIODUNDERRUN             = 72;
const CMERROR_BOXLOCKED                       = 73;
const CMERROR_BOX_DAMAGED                     = 74;
const CMERROR_BOX_LOCKED_TO                   = 75;
const CMERROR_MAINTENANCEPERIODMISSING        = 76;
const CMERROR_MAINTENANCEPERIODUNDERRUN       = 77;
const CMERROR_MAINTENANCEPERIODOVERRUN        = 78;
const CMERROR_MAINTENANCEPERIODINVALID        = 79;
const CMERROR_BOXMEMORYDAMAGED                = 80;
const CMERROR_BOSSMEMORY_DAMAGED              = 81;
const CMERROR_FIRMWAREMEMORY_DAMAGED          = 82;
const CMERROR_BOSS_FIRMWAREMEMORY_DAMAGED     = 83;
const CMERROR_FUMMEMORY_DAMAGED               = 84;
const CMERROR_BOSS_FUMMEMORY_DAMAGED          = 85;
const CMERROR_FIRMWARE_FUMMEMORY_DAMAGED      = 86;
const CMERROR_BOSS_FIRMWARE_FUMMEMORY_DAMAGED = 87;
const CMERROR_SYSTIMEOBSOLETE                 = 88;
const CMERROR_BAD_IO_MODE                     = 89;
const CMERROR_FULA_UPDATEEB_REACHED           = 90;
const CMERROR_FULA_ENCRCOMM_REACHED           = 91;
const CMERROR_UNFRAMED_COMMAND_REJECTED       = 92;
const CMERROR_COMMAND_PARTIALLY_REJECTED      = 93;
const CMERROR_COMMAND_PARTIALLY_UNSUPPORTED   = 94;
const CMERROR_BOX_COMMUNICATION_95            = 95;
const CMERROR_BOX_COMMUNICATION_96            = 96;
const CMERROR_BOX_COMMUNICATION_97            = 97;
const CMERROR_BOX_COMMUNICATION_98            = 98;
const CMERROR_BOX_LICENSEMEMORY_NOT_FORMATTED = 99;

(* management related error codes *)
const CMERROR_NETWORK_FAULT                   = 100;
const CMERROR_SERVER_NOT_FOUND                = 101;
const CMERROR_SEND_FAULT                      = 102;
const CMERROR_RECEIVE_FAULT                   = 103;
const CMERROR_INTERNAL_ORGANISATION           = 104;
const CMERROR_INVALID_PARAMETER               = 105;
const CMERROR_INVALID_HANDLE                  = 106;
const CMERROR_NO_MORE_HANDLES                 = 107;
const CMERROR_NO_MORE_MEMORY                  = 108;
const CMERROR_SECURITY_PROBLEM                = 109;
const CMERROR_NO_LOCAL_SERVER_STARTED         = 110;
const CMERROR_NO_NETWORK_SERVER               = 111;
const CMERROR_BUFFER_OVERFLOW                 = 112;
const CMERROR_BAD_ADDRESS                     = 113;
const CMERROR_BAD_HANDLE                      = 114;
const CMERROR_WRONG_HANDLE_TYPE               = 115;
const CMERROR_UNDEFINED_SYSTEM_HANDLE         = 116;
const CMERROR_NO_EVENT_OCCURRED               = 117;
const CMERROR_CTCS_FAULT                      = 118;
const CMERROR_UNKNOWN_OS                      = 119;
const CMERROR_NO_SECURITY_OBJECT              = 120;
const CMERROR_WRONG_SECURITY_OBJECT           = 121;
const CMERROR_NO_FSB_FUNCTIONALITY            = 122;
const CMERROR_NO_CTSB_FUNCTIONALITY           = 123;
const CMERROR_WRONG_OEMID                     = 124;
const CMERROR_SERVER_VERSION_TOO_OLD          = 125;
(* replaced by CMERROR_LIBRARY_NOT_FOUND in version 4.00:
  #define CMERROR_SUBSYSTEM_NOT_AVAILABLE         126
*)

const CMERROR_LIBRARY_NOT_FOUND               = 126;
const CMERROR_HANDLE_INCONSISTENCY            = 127;
const CMERROR_LICENSE_TYPE_CMACT_DEACTIVATED  = 128;
const CMERROR_USER_RUNTIME_VERSION_TOO_OLD    = 129;
const CMERROR_REDUNDANCY_SERVER_MISSING       = 130;

(* Internal box communication specific error codes *)
const CMERROR_BOX_COMMUNICATION_176           = 176;
const CMERROR_BOX_COMMUNICATION_177           = 177;
const CMERROR_BOX_COMMUNICATION_178           = 178;
const CMERROR_BOX_COMMUNICATION_179           = 179;
const CMERROR_BOX_COMMUNICATION_180           = 180;
const CMERROR_BOX_COMMUNICATION_181           = 181;
const CMERROR_BOX_COMMUNICATION_182           = 182;
const CMERROR_BOX_COMMUNICATION_183           = 183;
const CMERROR_BOX_COMMUNICATION_184           = 184;
const CMERROR_BOX_COMMUNICATION_185           = 185;
const CMERROR_BOX_COMMUNICATION_186           = 186;
const CMERROR_BOX_COMMUNICATION_187           = 187;
const CMERROR_BOX_COMMUNICATION_188           = 188;
const CMERROR_BOX_COMMUNICATION_189           = 189;
const CMERROR_BOX_COMMUNICATION_190           = 190;
const CMERROR_BOX_COMMUNICATION_191           = 191;

(* I2C error codes *)
const CMERROR_I2C_TIMEOUT_REQUEST             = 192;
const CMERROR_I2C_TIMEOUT_ANSWER              = 193;
const CMERROR_I2C_ANSWER_CRC                  = 194;
const CMERROR_I2C_TWCOMMAND_INVALID           = 195;
const CMERROR_I2C_PROTOCOL_VERSION            = 196;
const CMERROR_I2C_COMMUNICATION               = 197;
const CMERROR_I2C_REQUEST_CRC                 = 198;
const CMERROR_I2C_ANSWER_BEFORE_REQUEST       = 199;


(* box command execution related error codes *)
const CMERROR_ENTRY_NOT_FOUND                 = 200;
const CMERROR_BOX_NOT_FOUND                   = 201;
const CMERROR_CRYPTION_FAILED                 = 202;
const CMERROR_CRC_VERIFY_FAILED               = 203;
const CMERROR_NO_ENABLING_EXISTS              = 204;
const CMERROR_NO_PIO_SET                      = 205;
const CMERROR_FIRMKEY_TOO_SHORT               = 206;
const CMERROR_NO_BOXLOCK_NEEDED               = 207;
const CMERROR_BOXLOCK_NOT_CHANGED             = 208;
const CMERROR_NO_DATA_AVAILABLE               = 209;
const CMERROR_SIGNEDLIST_FAILED               = 210;
const CMERROR_VALIDATION_FAILED               = 211;
const CMERROR_NO_MORE_LICENSES                = 212;
const CMERROR_EXCLUSIVE_MODE_CONFLICT         = 213;
const CMERROR_RESERVEDFI_MISSED               = 214;
const CMERROR_WRONG_CONTENT                   = 215;
const CMERROR_FIELDUPDATE_FAILED              = 216;
const CMERROR_LICENSEFILE_CREATION_FAILED     = 217;
const CMERROR_NO_LICENSE_AVAILABLE            = 218;
const CMERROR_CONTEXT_FILE_WRITING_FAILED     = 219;
const CMERROR_UPDATE_FILE_READING_FAILED      = 220;
const CMERROR_NETINFO_FAILED                  = 221;
const CMERROR_FIELDUPDATE_RESET_FAILED        = 222;
const CMERROR_WRONG_ACCESS_MODE               = 223;
const CMERROR_WRONG_BOX_VERSION               = 224;
const CMERROR_INVALID_LICENSE_PARAMETER       = 225;
const CMERROR_BORROW_LICENSE_FAILED           = 226;
const CMERROR_BORROW_LICENSE_ISENABLED        = 227;
const CMERROR_UPDATE_TOO_NEW                  = 228;
const CMERROR_UPDATE_TOO_OLD                  = 229;
const CMERROR_SEVERAL_REASONS                 = 230;
const CMERROR_ACCESS_DENIED                   = 231;
const CMERROR_BORROW_TIMEDIFFTOOLARGE         = 232;
const CMERROR_UPDATE_FAILED                   = 233;
const CMERROR_UPDATE_ABORTED                  = 234;
const CMERROR_COMMAND_PENDING                 = 235;
const CMERROR_NO_WAN_LICENSE                  = 236;
const CMERROR_CMWAN_CREDENTIALS_CHANGED       = 237;
const CMERROR_SERVER_START_PENDING            = 238;
const CMERROR_REMOTE_ACCESS_DENIED            = 239;

const CMERROR_INTERNAL                        = 254;
const CMERROR_UNKNOWN                         = 255;

(* CmActLicense related error codes *)
const CMERROR_CMACT_SUBSYSTEM_FAILED              = 260;
const CMERROR_CMACT_LICENSE_NOT_ACTIVATED         = 261;
const CMERROR_CMACT_LICENSE_ALREADY_ACTIVATED     = 262;
const CMERROR_CMACT_LICENSE_REACTIVATION_REQUIRED = 263;
const CMERROR_CMACT_LICENSE_INVALID               = 264;
const CMERROR_CMACT_COMMAND_NOT_SUPPORTED         = 265;
const CMERROR_CMACT_LICENSE_ALREADY_EXISTS        = 266;
const CMERROR_CMACT_RUN_AS_SERVICE_REQUIRED       = 267;
const CMERROR_CMACT_BINDING_NOT_POSSIBLE          = 268;
const CMERROR_CMACT_OPEN_FIRMITEM_TEMPLATE_FAILED = 269;
const CMERROR_CMACT_OSVERSION_NOT_PERMITTED       = 270;
const CMERROR_CMACT_HOST_ID_NOT_AVAILABLE         = 271;
const CMERROR_CMACT_PLUGIN_MALFUNCTION            = 272;
const CMERROR_CMACT_VIRTUAL_MACHINE_NOT_ALLOWED   = 273;
const CMERROR_INCOMPATIBLE_SYSTEM_SOFTWARE_FOUND  = 274;


(* basic error codes *)
const CMERROR_ERRORTEXT_NOT_FOUND             = 300;
const CMERROR_SEND_PROTECTION_FAILED          = 301;
const CMERROR_ANALYSING_DETECTED              = 302;
const CMERROR_COMMAND_EXECUTION_FAILED        = 303;
const CMERROR_FUNCTION_NOT_IMPLEMENTED        = 304;
const CMERROR_OBSOLETE_FUNCTION               = 305;
const CMERROR_FUNCTION_NOT_SUPPORTED          = 306;
const CMERROR_EXCEPTION_CAUGHT                = 307;
const CMERROR_VERIFY_FAILED                   = 308;
const CMERROR_REQUEST_OVERLOAD_REJECTED       = 309;
const CMERROR_TIME_CONVERSION                 = 310;
const CMERROR_OPERATION_NOT_SUPPORTED_FOR_UNIVERSAL_LICENSE = 311;
const CMERROR_INTERNAL_COMMAND_FAILED         = 312;

(* 100..175  --->  700..775 (new higher box error codes, 1st block) *)
const CMERROR_BOX_ASN1_DECODER_FAILED         = 700;
const CMERROR_BOX_ASN1_SIGNATURE_FAILED       = 701;
const CMERROR_BOX_ASN1_ENCRYPT_DECRYPT_FAILED = 702;
const CMERROR_BOX_ASN1_INPUT_BUFFER_MISMATCH  = 703;
const CMERROR_BOX_LTUC_WRONG                  = 704;

const CMERROR_BOX_INTEGRITY_ERROR             = 730;
const CMERROR_BOX_INTEGRITY_WARNING           = 731;

(* 200..255  --->  780..835 (new higher box error codes, 2nd block) *)
const CMERROR_BOX_REPORT1_TYPE2_UNSUPPORTED   = 780;


(*****************************************************************************
 **************************** Global definitions *****************************
******************************************************************************)

const CM_CHALLENGE_LEN              = 16;
const CM_BLOCK_SIZE                 = 16;
const CM_BLOCKCIPHER_KEY_LEN        = 32;
const CM_DIGEST_LEN                 = 32;
const CM_IP_ADDRESS_LEN             = 8;
const CM_PRIVATE_KEY_LEN            = 32;
const CM_PUBLIC_KEY_LEN             = 64;
const CM_SESSIONID_LEN              = 8;
const CM_TVB_LEN                    = 16;
const CM_RSA1024_KEY_LEN            = 128;
const CM_RSA2048_KEY_LEN 			= 256;
const CM_RSA_MINIMAL_KEY_LEN        = 8;
const CM_SYM_KEY_LEN                = 16;
const CM_SIGNATURE_LEN              = 64;
const CM_EPHEMERAL_POINT_LEN        = 64;
const CM_BORROW_SERVERID_LEN        = 8;

const CM_MAX_COMPANY_LEN            = 32;
const CM_MAX_STRING_LEN             = 256;
const CM_MAX_PASSWORD_LEN           = 64;

(*****************************************************************************
 ***************************** Type definitions ******************************
******************************************************************************)

(*****
 definition of gobal flags
*****)
(*
  * used in mflFiCtrl of CMBOXENTRY
  * used in mflFiCtrl of CMBOXENTRY2
  * used in mflCtrl of CMCRYPTSIM
  * used in mflCtrl of CMPIOCK
  * used in musFirmItemTypePlain & musFirmItemTypeEncrypted of CMPROGRAM_ADD_FIRMITEM
  * used in mulFirmItemType of CMINTERNALENTRYINFO
  * used in mulFirmItemType of CMCREATEITEM
*)
const CM_GF_FILEBASED               = $0000;
const CM_GF_BOXBASED                = $0001;
const CM_GF_TRANSFERBASED           = $0004;
const CM_GF_SEC_MASK                = $0005;
const CM_GF_FI_RESERVED             = $8000;



(*
  * used in flCtrl for CmCreateSequence()
  * used in flCtrl for CmProgram()
*)
const CM_GF_ADD_FIRMITEM            = $0000;
const CM_GF_UPDATE_FIRMITEM         = $0001;
const CM_GF_DELETE_FIRMITEM         = $0002;
const CM_GF_ADD_PRODUCTITEM         = $0003;
const CM_GF_UPDATE_PRODUCTITEM      = $0004;
const CM_GF_DELETE_PRODUCTITEM      = $0005;
const CM_GF_SET_BOXCONTROL          = $0006;
const CM_GF_SET_BOXLOCK             = $0007;
const CM_GF_SET_FIRMKEY             = $0008;
const CM_GF_SET_USERKEY             = $0009;
const CM_GF_ADD_ENABLEBLOCK         = $000a;
const CM_GF_UPDATE_ENABLEBLOCK      = $000b;
const CM_GF_DELETE_ENABLEBLOCK      = $000c;
const CM_GF_ATTACH_ENABLEBLOCK      = $000d;
const CM_GF_DETACH_ENABLEBLOCK      = $000e;
const CM_GF_SET_ENABLEBLOCK         = $0011;
const CM_GF_ENABLEITEM              = $0012;
const CM_GF_DISABLEITEM             = $0013;
const CM_GF_TEMPENABLEITEM          = $0014;
const CM_GF_SET_BOXPASSWORD         = $002f;
const CM_GF_CHANGE_BOXPASSWORD      = $003f;
const CM_GF_RESET_BOXPASSWORD       = $004f;
const CM_GF_UPDATECHECKOUT_BORROW   = $005f;
const CM_GF_SET_BOXPASSWORD2        = $006f;

const CM_GF_ITEM_MASK               = $007f;

(*
  * used in mflSetPios of CMBOXENTRY
  * used in mflCtrl of CMENTRYDATA
  * used in musPioType of CMSECUREDATA
  * ! not used in CMBOXENTRY2, but most values are the same
*)
const CM_GF_PRODUCTCODE             = $0001;
const CM_GF_FEATUREMAP              = $0002;
const CM_GF_EXPTIME                 = $0004;
const CM_GF_ACTTIME                 = $0008;
const CM_GF_UNITCOUNTER             = $0010;
const CM_GF_PROTDATA                = $0020;
const CM_GF_EXTPROTDATA             = $0040;
const CM_GF_HIDDENDATA              = $0080;
const CM_GF_SECRETDATA              = $0100;
const CM_GF_USERDATA                = $0200;
const CM_GF_TEXT                    = $0400;
const CM_GF_USAGEPERIOD             = $0800;
const CM_GF_LICENSEQUANTITY         = $1000;
const CM_GF_BORROWCLIENT            = $2000;
const CM_GF_BORROWSERVER            = $4000;
const CM_GF_COLI                    = $8000; 
const CM_GF_PIO_MASK                = $ffff;

(*
  * used in mflTvbCtrl of CMCPIO_PRODUCTCODE
  * used in mflDependency of CMENTRYDATA
  * used in mfbDependencyXX of CMBOXENTRY
*)
const CM_GF_DATA                    = $0001;
const CM_GF_FUC                     = $0002;
const CM_GF_SERIAL                  = $0004;

(*****************************************************************************
 ************************** Structures declarations **************************
******************************************************************************)

(*******************
 1.) Main structures
********************)

(***** CMBOXCONTROL *****)
type TCMBOXCONTROL = record
    musIndicatorFlags:    WORD;
    musSwitchFlags:       WORD;
    mulReserve:           LONGWORD;
end;

(***** CMBOXINFO *****)
type TCMBOXINFO = record
    mbMajorVersion:       BYTE;
    mbMinorVersion:       BYTE;
    musBoxMask:           WORD;
    mulSerialNumber:      LONGWORD;
    musBoxKeyId:          WORD;
    musUserKeyId:         WORD;
    mabBoxPublicKey:      array[0..CM_PUBLIC_KEY_LEN-1] of BYTE;
    mabSerialPublicKey:   array[0..CM_PUBLIC_KEY_LEN-1] of BYTE;
    mulReserve:           LONGWORD;
end;
(*
  flags for midCps in all CMBORROWXXX structures
*)
const CM_CPS_CODEMETER              = $00000000;
const CM_CPS_CODEMETERACT           = $00000001;

(***** CMBORROWCLIENT *****)
type TCMBORROWCLIENT = record
  mulStatus:              LONGWORD;
  (* data from EPD 130 *)
  midEnableBlock:         WORD;
  midCps:                 WORD;
  mulFirmCode:            LONGWORD;
  mulProductCode:         LONGWORD;
  mabUpdateProgSeq:       array[0..32-1] of BYTE;
  mabServerID:            array[0..CM_BORROW_SERVERID_LEN-1] of BYTE;
  mabReserved1:           array[0..12-1] of BYTE;
  (* data from EPD 131 *)
  musReserved:            WORD;
  musServerBoxMask:       WORD;
  mulServerBoxSerial:     LONGWORD;
  mszServerName:          array[0..128-1] of BYTE;
  mabReserved2:           array[0..12-1] of BYTE;
end;

(***** CMBORROWDATA *****)
type TCMBORROWDATA = record
  mulStatus:                    LONGWORD;
  midEnableBlock:               WORD;
  midCps:                       WORD;
  mulFirmCode:                  LONGWORD;
  mulProductCode:               LONGWORD;
  mulFeatureMap:                LONGWORD;
  musReserved:                  WORD;
  musBoxMask:                   WORD;
  mulBoxSerial:                 LONGWORD;
  mabSerialPublicKey:           array[0..CM_PUBLIC_KEY_LEN-1] of BYTE;
  mabServerID:                  array[0..CM_BORROW_SERVERID_LEN-1] of BYTE;
  mszClientName:                array[0..128-1] of BYTE;
  mabTrailingValidationBlock:   array[0..CM_TVB_LEN-1] of BYTE;
  mulClientRequestTime:			LONGWORD;
  mulMaintenancePeriodStart:    LONGWORD;
  mulMaintenancePeriodEnd:      LONGWORD;
end;

(***** CMBORROWITEM *****)
type TCMBORROWITEM = record
  (* data from EPD 132 *)
  midCps:                 WORD;
  musReserved:            WORD;
  mulFirmCode:            LONGWORD;
  mulProductCode:         LONGWORD;
  mulFeatureMap:          LONGWORD;
  mcLicenseQuantity:      LONGWORD;
  mulCheckoutDuration:    LONGWORD;
  mabServerID:            array[0..CM_BORROW_SERVERID_LEN-1] of BYTE;
  mabReserved:            array[0..28-1] of BYTE;
  musUsedLicenses:        WORD;
  musFreeLicenses:        WORD;
end;

(***** CMBORROWMANAGE *****)
type TCMBORROWMANAGE = record
  (* data from EPD 133 *)
  mabUpdateProgSeq:         array[0..32-1] of BYTE;
  mcBorrowedLicenses:       LONGWORD;
  mabHashBorrowedLicenses:  array[0..CM_TVB_LEN-1] of BYTE;
  mabReserved:              array[0..12-1] of BYTE;

end;
(***** CMACCESS *****)
(*
  flags for mflCtrl in CMACCESS
*)
(* flags for kind of access *)
const CM_ACCESS_USERLIMIT           = $00000000;
const CM_ACCESS_NOUSERLIMIT         = $00000100;
const CM_ACCESS_EXCLUSIVE           = $00000200;
const CM_ACCESS_STATIONSHARE        = $00000300;
const CM_ACCESS_CONVENIENT          = $00000400;
(* mask for the access modes *)
const CM_ACCESS_STRUCTMASK          = $00000700;

(* no validation check of the entry data *)
const CM_ACCESS_FORCE               = $00010000;
(* constant for searching a fitting FSB entry *)
const CM_ACCESS_CHECK_FSB           = $00020000;
(* constant for searching a fitting CTSB entry *)
const CM_ACCESS_CHECK_CTSB          = $00040000;
(* allow normal subsystem access if no CmContainer is found *)
const CM_ACCESS_SUBSYSTEM           = $00080000;
(* force FI access to prevent access to a FC:PC=x:0 *)
const CM_ACCESS_FIRMITEM            = $00100000;

(* flag access to borrow license *)
const CM_ACCESS_BORROW_ACCESS       = $01000000;
(* flag release to borrow license *)
const CM_ACCESS_BORROW_RELEASE      = $02000000;
(* flag check borrowed license *)
const CM_ACCESS_BORROW_VALIDATE     = $04000000;
(* flag ignore entry state for release to borrow license *)
const CM_ACCESS_BORROW_IGNORESTATE  = $08000000;

const CM_ACCESS_BORROW_MASK         = $0f000000;
(* flag ignore Linger Time of License *)
const CM_ACCESS_IGNORE_LINGERTIME   = $10000000;

(* These option constants are used in Feature Codes which are FSB-internally
   created for a specific FSB operation (mulFeatureCode). *)

(* Feature Code for the <FsbEncryptAddFi> FSB operation *)
const CM_FSBFEATURECODE_ADDFI           = $00000001;
(* Feature Code for the <FsbHashBoxAlg::DeleteFi> FSB operation *)
const CM_FSBFEATURECODE_DELETEFI        = $00000002;
(* Feature Code for the <FsbHashBoxAlg::UpdateFi> FSB operation *)
const CM_FSBFEATURECODE_UPDATEFI        = $00000004;
(* Feature Code for the(<FsbHashBoxAlg::AddPi> FSB operation *)
const CM_FSBFEATURECODE_ADDPI           = $00000008;
(* Feature Code for the <FsbHashBoxAlg::DeletePi> FSB operation *)
const CM_FSBFEATURECODE_DELETEPI        = $00000010;
(* Feature Code for the <FsbHashBoxAlg::UpdatePi> FSB operation *)
const CM_FSBFEATURECODE_UPDATEPI        = $00000020;
(* Feature Code for the <FsbHashBoxAlg::AddEb> FSB operation *)
const CM_FSBFEATURECODE_ADDEB           = $00000040;
(* Feature Code for the <FsbHashBoxAlg::DeleteEb> FSB operation *)
const CM_FSBFEATURECODE_DELETEEB        = $00000080;
(* Feature Code for the <FsbHashBoxAlg::UpdateEb> FSB operation *)
const CM_FSBFEATURECODE_UPDATEEB        = $00000100;
(* Feature Code for the <FsbHashBoxAlg::AttachEb> FSB operation *)
const CM_FSBFEATURECODE_ATTACHEB        = $00000200;
(* Feature Code for the <FsbHashBoxAlg::GetBoxTimeSign> FSB operation *)
const CM_FSBFEATURECODE_GETBOXTIMESIGN  = $00002000;
(* Feature Code for the <FsbHashBoxAlg::DeleteFiSign> FSB operation *)
const CM_FSBFEATURECODE_DELETEFISIGN    = $00004000;
(* Feature Code for the <FsbHashBoxAlg::ListSign> FSB operation *)
const CM_FSBFEATURECODE_LISTSIGN        = $00008000;
(* Feature Code for the <FsbHashBoxAlg::Encrypt> FSB operation *)
const CM_FSBFEATURECODE_ENCRYPT         = $00010000;
(* Feature Code for the <FsbPriceDeduct> FSB operation *)
const CM_FSBFEATURECODE_PRICEDEDUCT     = $00020000;
(* Feature Code for storing the CmAct serial numbers *)
const CMACT_FSBFEATURECODE_SERIALNUMBERS = $00040000;
(* Feature Code for licenses with non binding *)
const CMACT_FSBFEATURECODE_NONELICENSES = $00080000;
(* Feature Code for trial licenses *)
const CMACT_FSBFEATURECODE_TRIALLICENSES = $00100000;

type TCMACCESS = record
    mflCtrl:                 LONGWORD;
    mulFirmCode:             LONGWORD;
    mulProductCode:          LONGWORD;
    mulFeatureCode:          LONGWORD;
    mulUsedRuntimeVersion:   LONGWORD;
    midProcess:              LONGWORD;
    musProductItemReference: WORD;
    musSession:              WORD;
    mabIPv4Address:          array[0..3] of AnsiChar;
    mcmBoxInfo:              TCMBOXINFO;
end;

(* These option constants are used in CMCREDENTIAL in combination
   with a CmGetInfo and CM_GEI_CREDENTIAL or CM_GEI_NETINFO_USER_EXT
   request and are informal (mulAccessCtrl). *)

(* Indicate that an access is based on CM_ACCESS_LOCAL *)
const CM_CRED_LICENSE_LOCATION_LOCAL    = $0001;
(* Indicate that an access is based on CM_ACCESS_LAN *)
const CM_CRED_LICENSE_LOCATION_LAN      = $0002;
(* Indicate that an access is based on CM_ACCESS_WAN *)
const CM_CRED_LICENSE_LOCATION_WAN      = $0004;
const CM_CRED_LICENSE_LOCATION_MASK     = $0007;

(* Indicate that a handle is based on a Entry Access *)
const CM_CRED_HANDLE_ACCESS_ENTRY       = $0008;
(* Indicate that a handle is based on a FI Access *)
const CM_CRED_HANDLE_ACCESS_FI          = $0010;
(* Indicate that a handle is based on a Box Access *)
const CM_CRED_HANDLE_ACCESS_BOX         = $0018;
(* Indicate that a handle is based on a SubSystem Access *)
const CM_CRED_HANDLE_ACCESS_SUBSYSTEM   = $0020;
const CM_CRED_HANDLE_ACCESS_MASK        = $0038;

(***** CMTIME *****)
type TCMTIME = record
    musYear:                    WORD;
    musMonth:                   WORD;
    musDay:                     WORD;
    musHours:                   WORD;
    musMinutes:                 WORD;
    musSeconds:                 WORD;
    mulSecondsSince01_01_2000:  LONGWORD;
end;

(***** CMCREDENTIAL *****)
type TCMCREDENTIAL = record
  mulPID:                   LONGWORD;
  mulSession:               LONGWORD;
  mulCleanupTime:           LONGWORD;
  mulMaxLifeTime:           LONGWORD;
  mulCreationTime:          LONGWORD;
  mulAccessCtrl:            LONGWORD;
  mulExpirationTime:        LONGWORD;
  mulUserDefinedID:         LONGWORD;
  mszUserDefinedText:       array[0..127] of AnsiChar;
  mszUsername:              array[0..31] of AnsiChar;
  mulOtherBorrowFirmCode:   LONGWORD;
  mulOtherBorrowProductCode:LONGWORD;
  mulOtherBorrowFeatureMap: LONGWORD;
  mulOtherBorrowSerial:     LONGWORD;
  musOtherBorrowMask:       WORD;
  mabReserved1:             array[0..1] of AnsiChar;
  mulCurrentCmInstanceUid: 	LONGWORD;
  mulPreviousCmInstanceUid:	LONGWORD;
  mszDomainName:            array[0..15] of AnsiChar;
  mabReserved2:             array[0..3] of AnsiChar;
end;

(***** CMACCESS2 *****)
type TCMACCESS2 = record
  mflCtrl:                 LONGWORD;
  mulFirmCode:             LONGWORD;
  mulProductCode:          LONGWORD;
  mulFeatureCode:          LONGWORD;
  mulUsedRuntimeVersion:   LONGWORD;
  mulReserved1:            LONGWORD;
  mulProductItemReference: LONGWORD;
  mulReserved2:            LONGWORD;
  mbMinBoxMajorVersion:    BYTE;
  mbMinBoxMinorVersion:    BYTE;
  musBoxMask:              WORD;
  mulSerialNumber:         LONGWORD;
  mulReserved3:            LONGWORD;
  mulReserved4:            LONGWORD;
  mszServername:           array[0..127] of AnsiChar;
  mcmReleaseDate:          TCMTIME;
  mabReserved:             array[0..15] of AnsiChar;
  mcmBorrowData:           TCMBORROWDATA;
  mcmCredential:           TCMCREDENTIAL;
end;

(***** CMAUTHENTICATE *****)
(*
  flags for mflCtrl in CMAUTHENTICATE
*)
(* Key Source specification *)
const  CM_AUTH_FIRMKEY               = $00000000;
const  CM_AUTH_HIDDENDATA            = $00000001;
const  CM_AUTH_SECRETDATA            = $00000002;
const  CM_AUTH_SERIALKEY             = $00000003;
const  CM_AUTH_BOXKEY                = $00000004;
const  CM_AUTH_PISK                  = $00000005;
const  CM_AUTH_KSMASK                = $00000007;
(* Authentication mode specification *)
const CM_AUTH_DIRECT                 = $00000000;
const CM_AUTH_EXTENDED               = $00010000;
const CM_AUTH_SERIAL                 = $00020000;
const CM_AUTH_EXTENDED2              = $00030000;
const CM_AUTH_AMMASK                 = $00030000;
(***** CMAUTHENTICATE *****)
type TCMAUTHENTICATE = record
  mflCtrl:                   LONGWORD;
  mulKeyExtType:             LONGWORD;
  mulFirmCode:               LONGWORD;
  mulProductCode:            LONGWORD;
  mulEncryptionCodeOptions:  LONGWORD;
  mulFeatureCode:            LONGWORD;
  mcmBoxInfo:                TCMBOXINFO;
  mabDigest:                 array[0..CM_DIGEST_LEN-1] of BYTE;
end;


(***** CMBOXENTRY *****)
(*
 global flags used for mflFiCtrl, mflSetPios & mfbDependencyXX of CMBOXENTRY
*)
type TCMBOXENTRY = record
    (* Firm Item data *)
    mflFiCtrl:               LONGWORD;
    mulFirmCode:             LONGWORD;
    musFirmAccessCounter:    WORD;
    musReserve1:             WORD;
    mulFirmUpdateCounter:    LONGWORD;
    mulFirmPreciseTime:      LONGWORD;
    mausFirmItemText:        array[0..CM_MAX_STRING_LEN-1] of WORD;
    (* flag specified the set ProductItem Option *)
    mflSetPios:              LONGWORD;
    (* Product Item data *)
    mulProductCode:          LONGWORD;
    mulFeatureMap:           LONGWORD;
    mulUnitCounter:          LONGWORD;
    mcmExpirationTime:       TCMTIME;
    mcmActivationTime:       TCMTIME;
    mfbDependencyPC:         BYTE;
    mfbDependencyFM:         BYTE;
    mfbDependencyUC:         BYTE;
    mfbDependencyET:         BYTE;
    mfbDependencyAT:         BYTE;
    mbReserve:               BYTE;
    musProductItemRef:       WORD;
end;

(*
 flags for mflFiCtrl of CMBOXENTRY2
*)
const CM_GF_FI_ALLOWED_TO_PULL      = $4000;

(*
 flags for mflSetPios of CMBOXENTRY2
*)
const CM_BE_PRODUCTCODE             = CM_GF_PRODUCTCODE;     //* 0x00000001 */
const CM_BE_FEATUREMAP              = CM_GF_FEATUREMAP;      //* 0x00000002 */
const CM_BE_EXPTIME                 = CM_GF_EXPTIME;         //* 0x00000004 */
const CM_BE_ACTTIME                 = CM_GF_ACTTIME;         //* 0x00000008 */
const CM_BE_UNITCOUNTER             = CM_GF_UNITCOUNTER;     //* 0x00000010 */
const CM_BE_PROTDATA                = CM_GF_PROTDATA;        //* 0x00000020 */
const CM_BE_EXTPROTDATA             = CM_GF_EXTPROTDATA;     //* 0x00000040 */
const CM_BE_HIDDENDATA              = CM_GF_HIDDENDATA;      //* 0x00000080 */
const CM_BE_SECRETDATA              = CM_GF_SECRETDATA;      //* 0x00000100 */
const CM_BE_USERDATA                = CM_GF_USERDATA;        //* 0x00000200 */
const CM_BE_TEXT                    = CM_GF_TEXT;            //* 0x00000400 */
const CM_BE_USAGEPERIOD             = CM_GF_USAGEPERIOD;     //* 0x00000800 */
const CM_BE_LICENSEQUANTITY         = CM_GF_LICENSEQUANTITY; //* 0x00001000 */
const CM_BE_BORROWCLIENT            = CM_GF_BORROWCLIENT;    //* 0x00002000 */
const CM_BE_BORROWSERVER            = CM_GF_BORROWSERVER;    //* 0x00004000 */
const CM_BE_COLI                    = CM_GF_COLI;            //* 0x00008000 */
const CM_BE_MAINTENANCEPERIOD       = $00010000;
const CM_BE_LINGERTIME              = $00020000;
const CM_BE_MINIMUMVERSION          = $00040000;
const CM_BE_MODULE_ITEM             = $00080000;
const CM_BE_BORROWEXPIRATIONTIME    = $00100000;
const CM_BE_HISTORY                 = $00200000;
const CM_BE_PASSWORD                = $00400000;
const CM_BE_TRANSFEROPTIONS         = $00800000;
const CM_BE_RETURNINFO              = $01000000;
const CM_BE_ACCEPTSPULL             = $02000000;
const CM_BE_STATUS                  = $04000000;
const CM_BE_PIO_MASK                = $07ffffff;

(*
 definition of the mflLicenseQuantityFlags
*)
const CM_LQ_DENIEDUSERLIMIT         = $00000001;
const CM_LQ_DENIEDNOUSERLIMIT       = $00000002;
const CM_LQ_DENIEDEXCLUSIVE         = $00000004;
const CM_LQ_DENIEDSTATIONSHARE      = $00000008;
const CM_LQ_ALLOWCMWAN              = $00000100;
const CM_LQ_TRIPLEMODEREDUNDANCY    = $00000200;
const CM_LQ_LOCALACCESSONLY         = $00000400;
const CM_LQ_DENIEDALL               = $0000000f;
const CM_LQ_MAXVALUE                = $0000070f;

(*
 definition of the mflTransferStatus
*)
const CM_TRANSFER_STATUS_ENABLED    = 1;
const CM_TRANSFER_STATUS_DISABLED   = 2;
const CM_TRANSFER_STATUS_DELETED    = 3;


//***** CMBOXENTRY2 *****/
(*
// global flags used for mflFiCtrl, mflSetPios & mfbDependencyXX of CMBOXENTRY2
*)
type TCMBOXENTRY2 = record
  //* Firm Item data */
  mflFiCtrl:                              LONGWORD;
  mulFirmCode:                            LONGWORD;
  musFirmAccessCounter:                   WORD;
  musReserve1:                            WORD;
  mulFirmUpdateCounter:                   LONGWORD;
  mulFirmPreciseTime:                     LONGWORD;
  mausFirmItemText:                       array[0..CM_MAX_STRING_LEN-1] of WORD;
  mabReserve1:                            array[0..99] of BYTE; //* aligned to 632 */
  //* flag specified the set ProductItem Option */
  mflSetNativePios:                       LONGWORD;
  mflSetEffectivePios:                    LONGWORD;
  mflSetPios:                             LONGWORD;
  //* Product Item data */
  mulProductCode:                         LONGWORD;
  mulFeatureMap:                          LONGWORD;
  mcmMaintenancePeriodStart:              TCMTIME;
  mcmMaintenancePeriodEnd:                TCMTIME;
  mulUnitCounter:                         LONGWORD;
  mcmExpirationTime:                      TCMTIME;
  mcmActivationTime:                      TCMTIME;
  mulUsagePeriodLifeTime:                 LONGWORD;
  mcmUsagePeriodStartTime:                TCMTIME;
  mulLicenseQuantity:                     LONGWORD;
  mulLingerTime:                          LONGWORD;
  mulMinimumRuntimeVersion:               LONGWORD;
  mflLicenseQuantityFlags:                LONGWORD;
  mulLicenseTag:                          LONGWORD;
  mflTransferStatus:                      LONGWORD;
  mabReserve2:                            array[0..31] of BYTE; //* aligned to 796 */
  mfbDependencyPC:                        BYTE;
  mfbDependencyFM:                        BYTE;
  mfbDependencyMP:                        BYTE;
  mfbDependencyUC:                        BYTE;
  mfbDependencyET:                        BYTE;
  mfbDependencyAT:                        BYTE;
  mfbDependencyUP:                        BYTE;
  mfbDependencyLQ:                        BYTE;
  mfbDependencyLT:                        BYTE;
  mfbDependencyMV:                        BYTE;
  mabReserve3:                            array[0..11] of BYTE; //* aligned to 818 */
  musModuleRef:                           WORD;
  musProductItemRef:                      WORD;
  musTransferBoxMask:                     WORD;
  mulTransferSerialNumber:                LONGWORD;
  mcmTransferBorrowExpirationTime:        TCMTIME;
  mabTransferId:                          array[0..9] of BYTE;
  mabReserve4:                            array[0..169] of BYTE; //* aligned to 1024 */
end;

(***** CMBOXSECURITY *****)
type TCMBOXSECURITY = record
    midOem:           LONGWORD;
    mulFsbFirmCode:   LONGWORD;
    mulCtsbFirmCode:  LONGWORD;
    mulReserve:       LONGWORD;
end;

(***** CMBOXTIME *****)
type TCMBOXTIME = record
   mcmCertifiedTime:    TCMTIME;
   mcmBoxTime:          TCMTIME;
   mcmSystemTime:       TCMTIME;
end;
(***** CMUSAGEPERIOD *****)
type TCMUSAGEPERIOD = record
  mulPeriod: LONGWORD;
  mcmStartTime:    TCMTIME;
end;

(***** CMBASECRYPT *****)

(*
  flags for mflCtrl in CMBASECRYPT
*)
(* Key Source specification *)
const CM_CRYPT_FIRMKEY              = $00000000;
const CM_CRYPT_HIDDENDATA           = $00000001;
const CM_CRYPT_SECRETDATA           = $00000002;
const CM_CRYPT_KSMASK               = $00000003;
(* CM-Stick encryption algorithms *)
const CM_CRYPT_AES                  = $00000000;
const CM_CRYPT_ECIES                = $01000000;
const CM_CRYPT_ECIES_STD            = $02000000;
const CM_CRYPT_AES_DIRECT           = $03000000;
const CM_CRYPT_RSA                  = $05000000;
const CM_CRYPT_ALGMASK              = $ff000000;
(* flags for CRC calculation and checking *)
const CM_CRYPT_CHKCRC               = $00010000;
const CM_CRYPT_CALCCRC              = $00020000;

(*
  flags for mulEncryptionCodeOptions in CMBASECRYPT
*)
const CM_CRYPT_RES1MASK             = $C0000000;
const CM_CRYPT_UCMASK               = $30000000;
const CM_CRYPT_UCCHECK              = $00000000;
const CM_CRYPT_UCIGNORE             = $20000000;
const CM_CRYPT_UCREQUIRED           = $10000000;
const CM_CRYPT_ATMASK               = $0C000000;
const CM_CRYPT_ATCHECK              = $00000000;
const CM_CRYPT_ATIGNORE             = $08000000;
const CM_CRYPT_ATREQUIRED           = $04000000;
const CM_CRYPT_ETMASK               = $03000000;
const CM_CRYPT_ETCHECK              = $00000000;
const CM_CRYPT_ETIGNORE             = $02000000;
const CM_CRYPT_ETREQUIRED           = $01000000;
const CM_CRYPT_MPREQUIRED           = $00100000;
const CM_CRYPT_TOPLAINONLY          = $00200000;
const CM_CRYPT_FACDECREMENT         = $00400000;
const CM_CRYPT_CERTTIME             = $00800000;

const CM_CRYPT_RES2MASK             = $00F00000;
const CM_CRYPT_SAMASK               = $000F0000;
const CM_CRYPT_SAEXCLUSIVE          = $00080000;
const CM_CRYPT_SAUNLIMITED          = $00000000;
const CM_CRYPT_SAUSERLIMIT          = $00040000;
const CM_CRYPT_SASTATIONSHARE       = $00020000;
const CM_CRYPT_RES3MASK             = $0000C000;
const CM_CRYPT_UCDELTAMASK          = $00003FFF;
const CM_CRYPT_MAX                  = $FFFFFFFF;

type TCMBASECRYPT = record
    mflCtrl:                    LONGWORD;
    mulKeyExtType:              LONGWORD;
    mulEncryptionCode:          LONGWORD;
    mulEncryptionCodeOptions:   LONGWORD;
    mulFeatureCode:             LONGWORD;
    mulCrc:                     LONGWORD;
end;

(***** CMBASECRYPT2 *****)
type TCMBASECRYPT2 = record
    mflCtrl:                    LONGWORD;
    mulKeyExtType:              LONGWORD;
    mulEncryptionCode:          LONGWORD;
    mulEncryptionCodeOptions:   LONGWORD;
    mulFeatureCode:             LONGWORD;
    mcmReleaseDate:             TCMTIME;
    mulCrc:                     LONGWORD;
    mulReserved:                array[0..9] of LONGWORD;
end;

(***** CMCRYPT *****)
type TCMCRYPT = record
    mcmBaseCrypt:   TCMBASECRYPT;
    mabInitKey:     array[0..CM_BLOCK_SIZE-1] of BYTE;
end;

(***** CMCRYPT2 *****)
type TCMCRYPT2 = record
    mcmBaseCrypt:                       TCMBASECRYPT2;
    mabDirectAesKey:                    array[0..CM_BLOCK_SIZE-1] of BYTE;
    mabInitKey:                         array[0..CM_BLOCK_SIZE-1] of BYTE;
    mulReserved:                        array[0..7] of LONGWORD;
end;

(***** CMCRYPTSIM *****)
(*
  global flags used in mflCtrl of CMCRYPTSIM
*)
type TCMCRYPTSIM = record
    mflCtrl:        LONGWORD;
    mulFirmCode:    LONGWORD;
    mulProductCode: LONGWORD;
    mcmBaseCrypt:   TCMBASECRYPT;
    mabInitKey:     array[0..CM_BLOCK_SIZE-1] of BYTE;
    mcbExtFirmKey:  LONGWORD;
    mabExtFirmKey:  array[0..CM_BLOCKCIPHER_KEY_LEN-1] of BYTE;
end;

(***** CMCRYPTSIM2 *****/
/*
  global flags used in mflCtrl of CMCRYPTSIM2
*)
type TCMCRYPTSIM2 = record
    mflCtrl:                                LONGWORD;
    mulFirmCode:                            LONGWORD;
    mulProductCode:                         LONGWORD;
    mcmBaseCrypt:                           TCMBASECRYPT2;
    mabInitKey:                             array[0..CM_BLOCK_SIZE-1] of BYTE;
    mcbExtFirmKey:                          LONGWORD;
    mabExtFirmKey:                          array[0..CM_BLOCKCIPHER_KEY_LEN-1] of BYTE;
    mulReserved:                            array[0..7] of LONGWORD;
end;

(***** CMSECUREDATA *****)
(*
 global flags also used for musPioType and musKeyExtType of CMSECUREDATA
*)
type TCMSECUREDATA = record
    mcmBaseCrypt:           TCMBASECRYPT;
    musPioType:             WORD;
    musExtType:             WORD;
    mabPioEncryptionKey:    array[0..CM_BLOCK_SIZE-1] of BYTE;
    mulReserve:             LONGWORD;
end;

(***** CMPIOCK *****)
(*
  global flags used in mflCtrl of CMPIOCK
*)
type TCMPIOCK = record
    mcmSecureData:              TCMSECUREDATA;
    mflCtrl:                    LONGWORD;
    mulFirmCode:                LONGWORD;
    mulProductCode:             LONGWORD;
    mulHiddenDataAccessCode:    LONGWORD;
    mcbExtFirmKey:              LONGWORD;
    mabExtFirmKey:              array[0..CM_BLOCKCIPHER_KEY_LEN-1] of BYTE;
end;

(***** CMCHIPINFO *****)
type TCMCHIPINFO = record
    mulFirmwareBuild:       LONGWORD;
    mulFirmwareBuildTop:    LONGWORD;
    mulMdfaLba:             LONGWORD;
    mulReserved:            LONGWORD;
    musChipType:            WORD;
    musSiliconRevision:     WORD;
    midFactory:             WORD;
    musProductYear:         WORD;
    musLotNumber:           WORD;
    midWafer:               WORD;
    midChipOnWafer:         WORD;
    musDowngradeCount:      WORD;
end;

(***** CMUSBCHIPINFO *****)
type TCMUSBCHIPINFO = record 
  musFirmwareMajor:   WORD;
  musFirmwareMinor:   WORD;
  mulFlashSize:       LONGWORD;
  mszNodeDescription: array[0..CM_MAX_STRING_LEN-1] of AnsiCHAR;
  mszNodes:           array[0..CM_MAX_STRING_LEN-1] of AnsiCHAR;
end;



(***** CMNETINFOCLUSTER *****)
type TCMNETINFOCLUSTER = record
  mulSerial:               LONGWORD;
  musMask:                 WORD;
  musProductItemRef:       WORD;
  mulFirmCode:             LONGWORD;
  mulProductCode:          LONGWORD;
  mulFeatureMap:           LONGWORD;
  mulUserLimitLicenses:    LONGWORD;
  mulNoUserLimitLicenses:  LONGWORD;
  mulExclusiveLicenses:    LONGWORD;
  mulStationShareLicenses: LONGWORD;
  mulUsedLicenses:         LONGWORD;
  mulFreeLicenses:         LONGWORD;
  mulTotalLicenses:        LONGWORD;
  mulLicenseQuantity:      LONGWORD;
  mulReserved1:            LONGWORD;
end;

(***** CMNETINFOUSER *****)
type TCMNETINFOUSER = record
  mulSerial:         LONGWORD;
  musMask:           WORD;
  musProductItemRef: WORD;
  mulFirmCode:       LONGWORD;
  mulProductCode:    LONGWORD;
  mulFeatureMap:     LONGWORD;
  mulID:             LONGWORD;
  mulAccessMode:     LONGWORD;
  mulCreationTime:   LONGWORD;
  mszClientIP:       array[0..31] of AnsiChar;
end;
(***** CMNETINFOUSER_EXT *****)
type TCMNETINFOUSER_EXT = record
  musMask:           WORD;
  mflCtrl:           WORD;
  mulSerial:         LONGWORD;
  mulProductItemRef: LONGWORD;
  mulFirmCode:       LONGWORD;
  mulProductCode:    LONGWORD;
  mulFeatureMap:     LONGWORD;
  mulID:             LONGWORD;
  mulAccessMode:     LONGWORD;
  mulLastAccessTime: LONGWORD;
  mulReserved2:      LONGWORD;
  mulReserved3:      LONGWORD;
  mulReserved4:      LONGWORD;
  mszClientAddress:  array[0..63] of AnsiChar;
  mcmCredential:     TCMCREDENTIAL;
end;

(***** CMINTERNALENTRYINFO *****)
type TCMINTERNALENTRYINFO = record
    musFirmItemReference:       WORD;
    musProductItemReference:    WORD;
    mulFirmItemType:            LONGWORD;
    mulFirmUpdateCounter:       LONGWORD;
    mulReserve:                 LONGWORD;
end;

(***** CMENTRYDATA *****)
(*
 global flags used for mflCtrl &  mflDependency of CMENTRYDATA
*)

type TCMENTRYDATA = record
    mflCtrl:        LONGWORD;
    mflDependency:  LONGWORD;
    mulReserve:     LONGWORD;
    mcbData:        LONGWORD;
    mabData:        array[0..2 * CM_MAX_STRING_LEN-1] of BYTE;
end;
(***** CMMEMINFO *****)
type TCMMEMINFO = record
    mcFree4ByteBlock:       WORD;
    mcFree8ByteBlock:       WORD;
    mcFree16ByteBlock:      WORD;
    mcFree32ByteBlock:      WORD;
    mcFree64ByteBlock:      WORD;
    mcFree128ByteBlock:     WORD;
    mcFree256ByteBlock:     WORD;
    mcFree512ByteBlock:     WORD;
end;

(***** CMMEMINFO2 *****)
type TCMMEMINFO2 = record
    mcFree4ByteBlock:       WORD;
    mcFree8ByteBlock:       WORD;
    mcFree16ByteBlock:      WORD;
    mcFree32ByteBlock:      WORD;
    mcFree64ByteBlock:      WORD;
    mcFree128ByteBlock:     WORD;
    mcFree256ByteBlock:     WORD;
    mcFree512ByteBlock:     WORD;
    mulReserved1:           LONGWORD;
    mulReserved2:           LONGWORD;
    mulReserved3:           LONGWORD;
    mulReserved4:           LONGWORD;
    mulTotalBytesFree:      LONGWORD;
    mulCapacity:            LONGWORD;
end;

(***** CMLICENSEINFO *****)
(*
  flags for mflCtrl in CMLICENSEINFO
*)
const CM_LICENSE_FILEBASED          = $00000001;
const CM_LICENSE_BOXBASED           = $00000002;
const CM_LICENSE_TRANSFERBASED      = $00000004;
const CM_LICENSE_FILEBASEDCREATE    = $00010000;
const CM_LICENSE_FIRMKEY            = $00020000;
const CM_LICENSE_PUBLICFIRMKEY      = $00040000;
const CM_LICENSE_FSBUPDATEKEY       = $00080000;
const CM_LICENSE_ENCRYPTED          = $00100000;
const CM_LICENSE_BOXBASEDFSB        = $00200000;

type TCMLICENSEINFO = record
    mflCtrl:            LONGWORD;
    mulFirmCode:        LONGWORD;
    midOem:             LONGWORD;
    mulFsbFirmCode:     LONGWORD;
    mulFsbProductCode:  LONGWORD;
    mulReserve:         LONGWORD;
    mszDescription:     array[0..CM_MAX_STRING_LEN-1] of AnsiCHAR;
    mszFirmItemText:    array [0..CM_MAX_STRING_LEN-1] of AnsiCHAR;
end;

(***** CMRESERVEFI *****)
type TCMRESERVEFI = record
    musFirmItemRef:     WORD;
    mabSessionId:       array[0..(2 * CM_SESSIONID_LEN)-1] of BYTE;
    mabReserve:         array[0..5] of BYTE;
end;

(***** CMSIGNEDTIME *****)
type TCMSIGNEDTIME = record
    mcmBoxTime:                     TCMBOXTIME;
    mabTrailingValidationBlock:     array[0..CM_TVB_LEN-1] of BYTE;
end;

(***** CMSYSTEM *****)
(*
  flags for midPlatform in CMSYSTEM
*)
const CM_SYSTEM_W95                 = $00000000;    // 4.00
const CM_SYSTEM_W98                 = $00000001;    // 4.10
const CM_SYSTEM_WME                 = $00000002;    // 4.90
const CM_SYSTEM_NT4                 = $00000003;    // 4.00
const CM_SYSTEM_W2K                 = $00000004;    // 5.00
const CM_SYSTEM_WXP                 = $00000005;    // 5.1
const CM_SYSTEM_W2003               = $00000006;    // 5.2
const CM_SYSTEM_VISTA               = $00000007;    // 6.0
const CM_SYSTEM_W2008               = $00000008;    // 6.0
const CM_SYSTEM_W7                  = $00000009;    // 6.1
const CM_SYSTEM_W2008R2             = $00000010;    // 6.1
const CM_SYSTEM_W8                  = $00000011;    // 6.2
const CM_SYSTEM_W2012               = $00000012;    // 6.2
const CM_SYSTEM_W2012R2             = $00000016;    // 6.3
const CM_SYSTEM_W81                 = $00000013;    // 6.3
const CM_SYSTEM_W10                 = $00000014;    // 10.0
const CM_SYSTEM_W2016               = $00000015;    // 16.0

const CM_SYSTEM_WINDOWS             = $00000000;
const CM_SYSTEM_MACOSX              = $00000100;
const CM_SYSTEM_SOLARIS             = $00000200;
const CM_SYSTEM_WIN_CE              = $00001000;
const CM_SYSTEM_EMBEDDED            = $00002000;
const CM_SYSTEM_LINUX               = $00010000;

const CM_SYSTEM_PLATFORM_MASK       = $000FFF00;
const CM_SYSTEM_VERSION_MASK        = $000000FF;
const CM_SYSTEM_INVALID_PLATFORM    = $FFFFFFFF;

const CM_SYSTEM_LITTLE_ENDIAN       = $00100000;
const CM_SYSTEM_BIG_ENDIAN          = $00200000;
const CM_SYSTEM_ENDIAN_ORDER_MASK   = $00300000;
type TCMSYSTEM = record
    midPlatform:                LONGWORD;
    mulSystemKernelVersion:     LONGWORD;
    mausIpAddress:              array[0..CM_IP_ADDRESS_LEN-1] of WORD;
    mszComputerName:            array[0..CM_MAX_STRING_LEN-1] of AnsiCHAR;
end;

const CM_SYSTEM_RUNNING_IN_VM      = $01000000;


(***** CMCOMMUNICATION *****)
(*
  flags for mulServerFeatures in CMCOMMUNICATION
*)
const CM_COMMUNICATION_LAN_SERVER        = $00000001;
const CM_COMMUNICATION_WAN_SERVER        = $00000002;
const CM_COMMUNICATION_REMOTE_FSB_ACCESS = $00000004;

const CM_API_COMM_MODE_SHARED_MEM        = $00000002;
const CM_API_COMM_MODE_TCPIP_IPV4        = $00000004;
const CM_API_COMM_MODE_TCPIP_IPV6        = $00000008;

type TCMCOMMUNICATION = record
    mulServerFeatures:        LONGWORD;
    musApiCommunicationMode:  WORD;
    mabReserved:              array[0..106-1] of BYTE;
    mszDomainName:            array[0..16-1] of AnsiCHAR;
    mszIpV4Address:           array[0..32-1] of AnsiCHAR;
    mszIpV6Address:           array[0..128-1] of AnsiCHAR;
    mszComputerName:          array[0..CM_MAX_STRING_LEN-1] of AnsiCHAR;
end;


(***** CMVERSION *****)
type TCMVERSION = record
    musVersion:     WORD;
    musSubVersion:  WORD;
    musBuild:       WORD;
    musCount:       WORD;
    musYear:        WORD;
    musMonth:       WORD;
    musDay:         WORD;
    musReserve:     WORD;
end;


(***** CMSECURITYVERSION *****)
type TCMSECURITYVERSION = record
  musVersion:    WORD;
  musSubVersion: WORD;
  musBuild:      WORD;
  musCount:      WORD;
  musYear:       WORD;
  musMonth:      WORD;
  musDay:        WORD;
  musType:       WORD;
  musReserved1:  WORD;
  musReserved2:  WORD;
  mulReserved1:  LONGWORD;
  mulReserved2:  LONGWORD;
  mulReserved3:  LONGWORD;
end;


(***** CMSYSTEMSTATUS *****)
type TCMSYSTEMSTATUS = record
  mflStatusFlags:   LONGWORD;
  mabReserved:      array[0..76-1] of BYTE;
end;

(*****
 definition of the mflStatusFlags flags (CMSYSTEMSTATUS / CM_GEI_SYSTEMSTATUS)
*****)
const CM_SYSTEMSTATUS_RUNNING_AS_SERVICE  = $00000001;
const CM_SYSTEMSTATUS_CMACT_ENABLED       = $00000002;
const CM_SYSTEMSTATUS_MSD_ENABLED         = $00000004;
const CM_SYSTEMSTATUS_HID_ENABLED         = $00000008;
const CM_SYSTEMSTATUS_CMACT_AVAILABLE     = $00000010;

(*****
 definition of the mbTransferType flags (CMLTHISTORY / CM_GEI_LTHISTORY)
*****)
const CM_HISTORY_TYPE_MOVE_COMPLETE          = 1;
const CM_HISTORY_TYPE_MOVE_UNITS             = 2;
const CM_HISTORY_TYPE_MOVE_LICENSES          = 3;
const CM_HISTORY_TYPE_BORROW_LOCAL_LICENSE   = 4;
const CM_HISTORY_TYPE_BORROW_COMPLETE        = 5;
const CM_HISTORY_TYPE_MERGE_UNITS            = 6;
const CM_HISTORY_TYPE_MERGE_LICENSES         = 7;

(*****
 definition of the mflStatus flags (CMLTHISTORY / CM_GEI_LTHISTORY)
*****)
const CM_HISTORY_STATUS_HIDDEN             = 0;
const CM_HISTORY_STATUS_IN_PUSH_TRANSIT    = 1;
const CM_HISTORY_STATUS_IN_RETURN_TRANSIT  = 2;
const CM_HISTORY_STATUS_IN_PULL_TRANSIT    = 3;
const CM_HISTORY_STATUS_ACTIVE             = 4;

(***** CMLTHISTORY *****)
type TCMLTHISTORY = record
  musIndex:                WORD;
  mbStatus:                BYTE;
  mbTransferType:          BYTE;
  mulUnitCounter:          LONGWORD;
  mulLicenseQuantity:      LONGWORD;
  mulReturnedQuantity:     LONGWORD;
  mcmTimeStamp:            TCMTIME;
  mcmBorrowExpirationTime: TCMTIME;
  mabTransferId:           array[0..9] of BYTE;
  mabConfirmedTransferId:  array[0..9] of BYTE;
  mulSerialNumber:         LONGWORD;
  mulLtUpdateCounter:      LONGWORD;
  musBoxMask:              WORD;
  mabReserved:             array[0..25] of BYTE;
end;

(*****
 definition of the mflFlags flags (CMLTTRANSFEROPTIONS / CM_GEI_LTTRANSFEROPTIONS)
*****)
const CM_TRANSFER_OPTIONS_MAY_BE_PULLED             = 1;
const CM_TRANSFER_OPTIONS_MAY_BE_RETURNED           = 2;
const CM_TRANSFER_OPTIONS_NO_FI_AT_TARGET_REQUIRED  = 4;

(*****
 definition of the mflTransferType flags (CMLTTRANSFEROPTIONS / CM_GEI_LTTRANSFEROPTIONS)
*****)
const CM_TRANSFER_TYPE_MOVE_COMPLETE          = 1;
const CM_TRANSFER_TYPE_MOVE_UNITS             = 2;
const CM_TRANSFER_TYPE_MOVE_LICENSES          = 3;
const CM_TRANSFER_TYPE_BORROW_LOCAL_LICENSE   = 4;
const CM_TRANSFER_TYPE_BORROW_COMPLETE        = 5;

(***** CMLTTRANSFEROPTIONS *****)
type TCMLTTRANSFEROPTIONS = record
  mbFlags:              BYTE;
  mbTransferType:       BYTE;
  mcbTargetIds:         BYTE;
  mcbLtkTargetIds:      BYTE;
  mabTargetIds:         array[0..111] of BYTE;
  mabLtkTargetIds:      array[0..111] of BYTE;
  mulMaxBorrowPeriod:   LONGWORD;
  musTransferDepth:     WORD;
  mabReserved:          array[0..85] of BYTE;
end;


(**********************
 2.) Special structures
***********************)

(****************************
 2.1.) Programming Structures
*****************************)

(***** CMCREATEITEM *****)
type TCMCREATEITEM = record
  (* must be set for all program commands *)
   mulFirmCode:             LONGWORD;
   mulFirmItemType:         LONGWORD;
   mcmBoxInfoUser:          TCMBOXINFO;
  (* must be set for all program commands except AddFi  *)
   mulFirmUpdateCounter:    LONGWORD;
  (* must be set for UpdatePi & DeletePi *)
   mulProductCode:          LONGWORD;
  (* must be set for BoxLock *)
   midOem:                  LONGWORD;
  (* must be set for ActFieldUpd *)
   mulFirmwareBuild:        LONGWORD;
end;

(***** CMCPIO_PRODUCTCODE *****)
(*
 global flags also used for mflTvbCtrl of CMCPIO_PRODUCTCODE
 additional flags for mflTvbCtrl of CMCPIO_PRODUCTCODE
*)
const CM_PIO_CHANGE_PC              = $00010000;

type TCMCPIO_PRODUCTCODE = record
   mflTvbCtrl:                  LONGWORD;
   musFirmItemReference:        WORD;
   musProductItemReference:     WORD;
   mulProductCode:              LONGWORD;
   mbMajorVersion:              BYTE;
   mbMinorVersion:              BYTE;
   musReserve:                  WORD;
end;

(***** CMCPIO_EXTPROTDATA *****)
type TCMCPIO_EXTPROTDATA = record
    musExtType:     WORD;
    mcbData:        WORD;
    mulReserve:     LONGWORD;
    (* variable length, max = 256 *)
    mabData:        array[0..CM_MAX_STRING_LEN-1] of BYTE;
end;

(***** CMCPIO_HIDDENDATA *****)
type TCMCPIO_HIDDENDATA = record
    musExtType:                 WORD;
    mcbTotal:                   WORD;
    mcbData:                    WORD;
    mabReserve:                 array[0..5] of BYTE;
    mulHiddenDataAccessCode:    LONGWORD;
    (* variable length, max = 256 *)
    mabData:                    array[0..CM_MAX_STRING_LEN-1] of BYTE ;
end;

(***** CMCPIO_PROTDATA *****)
type TCMCPIO_PROTDATA = record
    mcbData:        WORD;
    (* variable length, max = 256 *)
    mabData:        array[0..CM_MAX_STRING_LEN-1] of BYTE;
    mabReserve:     array[0..5] of BYTE ;
end;

(***** CMCPIO_SECRETDATA *****)
type TCMCPIO_SECRETDATA = record
    musExtType:     WORD;
    mcbTotal:       WORD;
    mcbData:        WORD;
    musReserve:     WORD;
    (* variable length, max = 256 *)
    mabData:        array[0..CM_MAX_STRING_LEN-1] of BYTE;
end;

(***** CMCPIO_TEXT *****)
type TCMCPIO_TEXT = record
    mcchText:       WORD;
    mabReserve:     array[0..5] of BYTE;
    (* variable length, max = 256 *)
    mausText:       array[0..CM_MAX_STRING_LEN-1] of WORD ;
end;

(***** CMCPIO_USERDATA *****)
type TCMCPIO_USERDATA = record
    mcbData:        WORD;
    mabReserve:     array[0..5] of BYTE;
    (* variable length, max = 256 *)
    mabData:        array[0..CM_MAX_STRING_LEN-1] of BYTE;
end;

(***** CMCPIO_MAINTENANCEPERIOD *****)
type TCMCPIO_MAINTENANCEPERIOD = record
  mcmStartPeriod:       TCMTIME;
  mcmEndPeriod:         TCMTIME;
end;

(***** CMPROGRAM_BOXCONTROL *****)
(*
  flags for mflCtrl in CMPROGRAM_BOXCONTROL
*)
const CM_BC_ABSOLUTE                = $0000;
const CM_BC_SWITCH                  = $0001;

type TCMPROGRAM_BOXCONTROL = record
    mflCtrl:            LONGWORD;
    musIndicatorFlags:  WORD;
    musReserve:         WORD;
end;

(***** CMPROGRAM_BOXLOCK *****)
(*
  flags for mflCtrl in CMPROGRAM_BOXLOCK
*)
const CM_BL_LOCK                    = $0000;
const CM_BL_UNLOCK                  = $0001;

type TCMPROGRAM_BOXLOCK = record
    mflCtrl:        LONGWORD;
    mulReserve:     LONGWORD;
    mabUserKey:     array[0..CM_BLOCKCIPHER_KEY_LEN-1] of BYTE;
end;

(***** CMPROGRAM_BOXPASSWORD *****)
type TCMPROGRAM_BOXPASSWORD = record
  mszOldPassword:    array[0..CM_MAX_PASSWORD_LEN-1] of BYTE;
  mszNewPassword:    array[0..CM_MAX_PASSWORD_LEN-1] of BYTE;
end;

(***** CMVALIDATE_DELETEFI *****)
type TCMVALIDATE_DELETEFI = record
    mflFiCtrl:                      LONGWORD;
    mulFirmCode:                    LONGWORD;
    mulSystemTime:                  LONGWORD;
    mulFirmUpdateCounter:           LONGWORD;
    mabTrailingValidationBlock:     array[0..CM_TVB_LEN-1] of BYTE;
end;

(* set 1 Byte alignment, only for programming & enabling structures *)
{$A-}

(***** CMPROGRAM_ADD_FIRMITEM *****)
(*
 global flags used for musFirmItemTypePlain
 & musFirmItemTypeEncrypted of CMPROGRAM_ADD_FIRMITEM
*)
type TCMPROGRAM_ADD_FIRMITEM = record
    (* plain members *)
    musFirmItemReference:       WORD;
    musFirmItemTypePlain:       WORD;
    mabPublicLicensorKey:       array[0..CM_PUBLIC_KEY_LEN-1] of BYTE;
    (* encrypted members *)
    musFirmItemTypeEncrypted:   WORD;
    musFirmAccessCounter:       WORD;
    mulFirmUpdateCounter:       LONGWORD;
    mulFirmPreciseTime:         LONGWORD;
    mulReserved:                LONGWORD;
    mabFirmKey:                 array[0..CM_BLOCKCIPHER_KEY_LEN-1] of BYTE;
    mabSessionId:               array[0..(2 * CM_SESSIONID_LEN)-1] of BYTE;
    (* plain members *)
    mcchText:                   WORD;
    (* variable length, max = 256 *)
    mausText:                   array[0..CM_MAX_STRING_LEN-1] of WORD;
end;

(***** CMPROGRAM_UPDATE_FIRMITEM *****)
(*
  flags for musCtrl in CMPROGRAM_UPDATE_FIRMITEM
*)
const CM_UFI_FAC                    = $0001;
const CM_UFI_FUC                    = $0002;
const CM_UFI_FPT                    = $0004;
const CM_UFI_TEXT                   = $0008;
const CM_UFI_MASK                   = $000f;

type TCMPROGRAM_UPDATE_FIRMITEM = record
    musFirmItemReference:   WORD;
    musCtrl:                WORD;
    musFirmAccessCounter:   WORD;
    mulFirmUpdateCounter:   LONGWORD;
    mulFirmPreciseTime:     LONGWORD;
    mcchText:               WORD;
    (* variable length, max = 256, expand structure on the stack *)
    mausText:               array[0..255] of WORD;
end;

(***** CMPROGRAM_DELETE_FIRMITEM *****)
type TCMPROGRAM_DELETE_FIRMITEM = record
    musFirmItemReference:           WORD;
    mabTrailingValidationBlock:     array[0..CM_TVB_LEN-1] of BYTE;
end;

(***** CMPROGRAM_ADD_PRODUCTITEM *****)
type TCMPROGRAM_ADD_PRODUCTITEM = record
    musFirmItemReference:               WORD;
    musProductItemSuccessorReference:   WORD;
    (* variable length, expand structure on the stack *)
    mabProductItemOptionBuffer:         array[0..1023] of BYTE;
end;

(***** CMPROGRAM_UPDATE_PRODUCTITEM *****)
(*
  flags for musCtrl set internally!!!
*)
type TCMPROGRAM_UPDATE_PRODUCTITEM = record
    musFirmItemReference:           WORD;
    musProductItemReference:        WORD;
    musCtrl:                        WORD;
    (* variable length, expand structure on the stack *)
    mabProductItemOptionBuffer:     array[0..1023] of BYTE;
end;

(***** CMPROGRAM_DELETE_PRODUCTITEM *****)
type TCMPROGRAM_DELETE_PRODUCTITEM = record
    musFirmItemReference:           WORD;
    musProductItemReference:        WORD;
    mabTrailingValidationBlock:     array[0..CM_TVB_LEN-1] of BYTE;
end;


(*************************
 2.2.) Enabling Structures
**************************)

(***** CMENABLING_SIMPLEPIN *****)
type TCMENABLING_SIMPLEPIN = record
    mcbEnableAccessCode:    BYTE;
    (* variable length, max = 16 *)
    mabEnableAccessCode:    array[0..CM_CHALLENGE_LEN-1] of BYTE;
end;

(***** CMENABLING_TIMEPIN *****)
type TCMENABLING_TIMEPIN = record
    mulDisableTime:         LONGWORD;
    mcbEnableAccessCode:    BYTE;
    mcchText:               WORD;
    (* variable length, AccessCode + Text added, expand structure on the stack *)
    mabBuffer:              array[0..1023] of BYTE;
end;

(***** CMENABLING_SIMPLEPIN_LIST *****)
type TCMENABLING_SIMPLEPIN_LIST = record
    mcbEnableAccessCode:    BYTE;
end;


(***** CMENABLING_TIMEPIN_LIST *****)
type TCMENABLING_TIMEPIN_LIST = record
    mulDisableTime:         LONGWORD;
    mcbEnableAccessCode:    BYTE;
    mcchText:               WORD;
    mausText:               array[0..CM_MAX_STRING_LEN-1] of WORD;
end;

(***** CMENABLING_ENABLEBLOCKITEM *****)
(*
  flags for musOption in CMENABLING_ENABLEBLOCKITEM
*)
const CM_EBI_VALID                  = $8000;
const CM_EBI_ENABLED                = $0000;
const CM_EBI_DISABLED               = $0001;
const CM_EBI_TEMPENABLED            = $0002;
const CM_EBI_ENABLING_MASK          = $0003;
const CM_EBI_EXPIRED                = $0100;

(*
  flags for mbType in CMENABLING_ENABLEBLOCKITEM
*)
const CM_EBI_SIMPLEPIN              = $0000;
const CM_EBI_TIMEPIN                = $0010;
(*
  constants for mulDisableTime
*)
const CM_EBI_NODISABLETIME          = $FFFFFFFF;


type TCMENABLING_ENABLEBLOCKITEM = record
    musOption:  WORD;
    mbIndex:    BYTE;
	
    case mbType: BYTE of
        CM_EBI_SIMPLEPIN:   (mcmSimplePin:  TCMENABLING_SIMPLEPIN;
		                     mabReserved: array[0..21] of BYTE;   );
        CM_EBI_TIMEPIN:     (mcmTimePin:    TCMENABLING_TIMEPIN;
		                     mabReserved1: array[0..21] of BYTE;);
end;

(***** CMENABLING_ENABLEBLOCKITEM_LIST *****)
type TCMENABLING_ENABLEBLOCKITEM_LIST = record
    musOption:  WORD;
    mbIndex:    BYTE;
    case mbType: BYTE of // mEnableType
        CM_EBI_SIMPLEPIN:   (mcmSimplePin:  TCMENABLING_SIMPLEPIN_LIST);
        CM_EBI_TIMEPIN:     (mcmTimePin:    TCMENABLING_TIMEPIN_LIST);
end;
(***** CMENABLING_ENABLELOOKUPENTRY *****)
(*
  flags for musOption in CMENABLING_ENABLELOOKUPENTRY
*)
const CM_ELUE_VALID                 = $8000;
const CM_ELUE_IFI                   = $0001;
const CM_ELUE_REQUIRED              = $0002;

(*
  flags for mbEnableLevel & mbDisableLevel in CMENABLING_ENABLELOOKUPENTRY
*)
const CM_ELUE_LOCATE                = $0000;
const CM_ELUE_READ                  = $0001;
const CM_ELUE_ENCRYPT               = $0003;
const CM_ELUE_UNITUSE               = $0005;
const CM_ELUE_MODIFY                = $0007;
const CM_ELUE_DETACH                = $00ff;

type TCMENABLING_ENABLELOOKUPENTRY = record
    musOption:              WORD;
    mbEnableBlockIndex:     BYTE;
    mbEnableLevel:          BYTE;
    mbDisableLevel:         BYTE;
    mbType:                 BYTE;
    musStatus:              WORD;
end;

(***** CMENABLING_WRITEADD *****)
type TCMENABLING_WRITEADD = record
    (* plain members *)
    mcbLength:              LONGWORD ;
    musFirmItemReference:   WORD;
    (* encrypted members *)
    mcmEnableBlockItem:     TCMENABLING_ENABLEBLOCKITEM;
end;

(***** CMENABLING_WRITEUPDATE *****)
(*
  flags for mbEnableBlockIndex in CMENABLING_WRITEUPDATE
*)
const CM_WU_FIRMKEY                =  $80;
(*
  flags for musCtrl in CMENABLING_WRITEUPDATE
*)
// Annotation to Enabling:
// the flag CM_WU_DISABLED has to be set if you want to enable, disable
// or temp enable an EBI.
// If the FirmItem is capable of temp enabling, CM_WU_TEMPENABLED has to be ored
// additional, but musn't if it doesn't.
const CM_WU_DISABLED                = $0001;
const CM_WU_TEMPENABLED             = $0002;
const CM_WU_ACCESSCODE              = $0004;
const CM_WU_DISABLETIME             = $0008;
const CM_WU_TEXT                    = $0010;
const CM_WU_IDENTITY                = $0020;
const CM_WU_FULL                    = $003f;

type TCMENABLING_WRITEUPDATE = record
    (* plain members *)
    mbEnableBlockIndex:     BYTE;
    (* encrypted members *)
    musCtrl:                WORD;
    mulFirmUpdateCounter:   LONGWORD;
    mcmEnableBlockItem:     TCMENABLING_ENABLEBLOCKITEM;
end;

(***** CMENABLING_WRITEATTACHDETACH *****)
type TCMENABLING_WRITEATTACHDETACH = record
    (* plain members *)
    mbEnableBlockIndex:         BYTE;
    (* encrypted members (32 Bytes) *)
    musFirmItemReference:       WORD;
    musProductItemReference:    WORD;
    mulFirmUpdateCounter:       LONGWORD;
    mcmEnableLookupEntry:       TCMENABLING_ENABLELOOKUPENTRY;
    mabTrailingValidationBlock: array[0..CM_TVB_LEN-1] of BYTE;
end;

(***** CMENABLING_WRITEDELETE *****)
type TCMENABLING_WRITEDELETE = record
    (* plain members *)
    musFirmItemReference:           WORD;
    mbEnableBlockIndex:             BYTE;
    mabTrailingValidationBlock:     array[0..CM_TVB_LEN-1] of BYTE;
end;

(* reset to original alignment *)
{$A+}

(***** CMENABLING_APPCONTEXT *****)
(*
  flags for mflCtrl in CMENABLING_APPCONTEXT
*)
const CM_AC_VALID                   = $8000;
const CM_AC_DISABLED                = $0001;
const CM_AC_TEMPENABLED             = $0002;

type TCMENABLING_APPCONTEXT = record
    mulFirmCode:            LONGWORD;
    mulProductCode:         LONGWORD;
    mcmBoxInfo:             TCMBOXINFO;
    mflCtrl:                LONGWORD;
    midEnableBlockItem:     WORD;
    musReserve:             WORD;
    mulFirmUpdateCounter:   LONGWORD;
    midIdentity:            LONGWORD;
    mszCompanyName:         array[0..CM_MAX_COMPANY_LEN-1] of AnsiCHAR;
end;

(***********************************
 2.3.) Remote Programming Structures
************************************)

type TCMSERIAL = record
    mulSerial:      LONGWORD;
    musMask:         WORD;
    musReserved:  WORD;
end;
(***********************************
 3.0.) CodeMeterAct Structures
************************************)

(*****
 definition of the mulPreferredActivationMethod flags (CMACTLICENSEINFO)
*****)
const CMACT_ACTIVATION_INVALID      = 0;
const CMACT_ACTIVATION_PHONE        = 1;
const CMACT_ACTIVATION_EMAIL        = 2;
const CMACT_ACTIVATION_PORTAL       = 3;
const CMACT_ACTIVATION_SERVICE      = 4;
const CMACT_ACTIVATION_FILE         = 5;

const CMACT_LO_ALLOW_VM             = $00000001;
const CMACT_LO_ALLOW_REIMPORT		= $00000002;
(*****
 for CmActLicenseControl( CM_GF_ACT_REMOVE, ... )
*****)
const CM_GF_ACT_UNLOAD_LICENSE      = 0;
const CM_GF_ACT_REMOVE_LICENSE      = 1;

const CMACT_MAX_LEN_PRODUCTNAME     = 64;
const CMACT_MAX_LEN_VENDORTEXT      = 128;
const CMACT_MAX_LEN_PRODUCT_SERIAL  = 128;
const CMACT_MAX_LEN_ACTIVATION_CODE = 64;
const CMACT_MAX_LEN_LICENSORDATA    = 4096;
const CMACT_MAX_LEN_PLUGIN_NAME     = 32;

const CMACT_LEN_PRODUCTIDMAJ        = 5;
const CMACT_LEN_CLIENTSECKEY        = 6;

const CMACT_LEN_NAMEHASH            = 20;
const CMACT_MAX_NUM_PRODUCT_DESCS   = 2000;
const CMACT_MAX_NUM_DIGESTS         = 4;

const CMACT_MAX_PLATFORMS           = 10;

const CMACT_LEN_HOSTINFOFINGERPRINT = 4;
const CMACT_LEN_HOSTINFONAME        = 24;

(***** CMACTPRODUCTDESCRIPTION (CmAct) *****)
type TCMACTPRODUCTDESCRIPTION = record
  mulProductCode:     LONGWORD;
  mulFeatureMask:     LONGWORD;
end;

(***** CMACTLICENSEINFO/ CMACTLICENSEINFO2 *****)
type CMACTLICENSEINFO2 = record
  musBoxMask: 						WORD;
  musReserved1:						WORD;
  mulSerialNumber:					LONGWORD;
  mulFirmCode:						LONGWORD;
  mulStatus:						LONGWORD;
  mflLicenseOptions:				LONGWORD;
  mszProductName:					array [0..CMACT_MAX_LEN_PRODUCTNAME-1] of BYTE;
  mszPluginName:					array [0..CMACT_MAX_LEN_PLUGIN_NAME-1] of BYTE;
  mabNameHash:						array [0..CMACT_LEN_NAMEHASH-1] of BYTE;
  mulTelephoneId:					LONGWORD;
  mszCmActId:						array [0..CMACT_LEN_PRODUCTIDMAJ-1] of BYTE;
  mbReserved2:						BYTE;
  musNumberOfProductDescriptions:	WORD;
  maProductDescriptions:			array [0..CMACT_MAX_NUM_PRODUCT_DESCS-1] of TCMACTPRODUCTDESCRIPTION;
  mszProductSerialNumber:			array [0..CMACT_MAX_LEN_PRODUCT_SERIAL-1] of BYTE;
  mabReserved3:						array [0..256-1] of BYTE;
end;

type TCMACTLICENSEINFO = record
  musBoxMask:                       WORD;
  musReserved1:                     WORD;
  mulSerialNumber:                  LONGWORD;
  mulFirmCode:                      LONGWORD;
  mulStatus:                        LONGWORD;
  mflLicenseOptions:                LONGWORD;
  mulReserved2:                     LONGWORD;
  mulReserved3:                     LONGWORD;
  // PHONE = 1, EMAIL = 2, PORTAL = 3, SERVICE = 4, FILE = 5
  mulPreferredActivationMethod:     LONGWORD;
  mszProductName:                   array [0..CMACT_MAX_LEN_PRODUCTNAME-1] of BYTE;
  mszProductNameExt:                array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorName:                    array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorPhone:                   array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorEMail:                   array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorWebPortal:               array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorWebService:              array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszPluginName:                    array [0..CMACT_MAX_LEN_PLUGIN_NAME-1] of BYTE;
  mabReserved3:                     array [0..96-1] of BYTE;
  mulProductIdMinor:                LONGWORD;
  mulReserved4:                     LONGWORD;
  mszProductIdMajor:                array [0..CMACT_LEN_PRODUCTIDMAJ-1] of BYTE;
  mbReserved1:                      BYTE;
  musNumberOfProductDescriptions:   WORD;
  maProductDescriptions:            array [0..CMACT_MAX_NUM_PRODUCT_DESCS-1] of TCMACTPRODUCTDESCRIPTION;
  mszProductSerialNumber:           array [0..CMACT_MAX_LEN_PRODUCT_SERIAL-1] of BYTE;
end;


(***** CMACTLICENSEDATA (CmAct) *****)
type TCMACTLICENSEDATA = record
  mflCtrl:                          LONGWORD;
  musBoxMask:                       WORD;
  mbSmartBindHeuristic:             BYTE;
  mbSmartBindRedundancyLevel:       BYTE;
  mulSerialNumber:                  LONGWORD;
  mulFirmCode:                      LONGWORD;
  mulBindingFlags:                  LONGWORD;
  mnNumberOfRequiredBindingFlags:   LONGWORD;
  mflLicenseOptions:                LONGWORD;
  mulGeneration:                    LONGWORD;
  mulReplacesGeneration:            LONGWORD;
  mabSymKeyPhone:                   array [0..CM_SYM_KEY_LEN-1] of BYTE;
  mabLicensorPubKey:                array [0..CM_PUBLIC_KEY_LEN-1] of BYTE;
  mabSigLicensorPubKey:             array [0..CM_SIGNATURE_LEN-1] of BYTE;
  mszProductName:                   array [0..CMACT_MAX_LEN_PRODUCTNAME-1] of BYTE;
  mulProductIdMinor:                LONGWORD;
  mszProductIdMajor:                array [0..CMACT_LEN_PRODUCTIDMAJ-1] of BYTE;
  mbReserved2:                      BYTE;
  musReserved4:                     WORD;
  mulPreferredActivationMethod:     LONGWORD;
  mszProductNameExt:                array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorName:                    array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorPhone:                   array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorEMail:                   array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorWebPortal:               array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszVendorWebService:              array [0..CMACT_MAX_LEN_VENDORTEXT-1] of BYTE;
  mszPluginName:                    array [0..CMACT_MAX_LEN_PLUGIN_NAME-1] of BYTE;
  mulCertifiedTime:                 LONGWORD;
  mabReserved6:                     array [0..88-1] of BYTE;
  musMinRequiredRuntimeVer:         WORD;
  musMinRequiredRuntimeSubVer:      WORD;
  musNumberOfProductDescriptions:   WORD;
  musReserved3:                     WORD;
  maProductDescriptions:            array [0..CMACT_MAX_NUM_PRODUCT_DESCS-1] of TCMACTPRODUCTDESCRIPTION;
  mabBoxTemplateKey:                array [0..CM_SYM_KEY_LEN-1] of BYTE;
  mabSymKeyBoxMemory:               array [0..CM_SYM_KEY_LEN-1] of BYTE;
  mabSymKeyDynData:                 array [0..CM_SYM_KEY_LEN-1] of BYTE;
  mulNumberOfPermittedPlatforms:    LONGWORD;
  mulPermittedPlatforms:            array [0..CMACT_MAX_PLATFORMS-1] of LONGWORD;// see flags for midPlatform in CMSYSTEM
  mulReserved5:                     LONGWORD;
end;

(***** CMACTDIGEST (CmAct) *****)
type TCMACTDIGEST = record
  musPaPuCount:     WORD;
  musDigestCount:   WORD; //!< no of digest contains at mabDigest
  mulReserved1:     LONGWORD;
  mulReserved2:     LONGWORD;
  mulReserved3:     LONGWORD;
  mabDigest:        array [0..CMACT_MAX_NUM_DIGESTS-1] of array [0..CM_DIGEST_LEN-1]of BYTE; //!< one or more digest
end;


(***** CMACTSIGNATURE (CmAct) *****)
type TCMACTSIGNATURE = record
  musPaPuCount:       WORD;
  musSignatureCount:  WORD;  //!< no of signatures contains at mabSignature
  mulReserved1:       LONGWORD;
  mulReserved2:       LONGWORD;
  mulReserved3:       LONGWORD;
 mabSignature:        array [0..CMACT_MAX_NUM_DIGESTS-1] of array [0..CM_SIGNATURE_LEN-1]of BYTE;//!< one or more signatures
end;


(***** CMACTACTIVATION (CmAct) *****)
type TCMACTACTIVATION = record
  mflCtrl:                LONGWORD;
  mszInstallationId:      array [0..CMACT_MAX_LEN_ACTIVATION_CODE-1] of BYTE;
  mszProductSerialNumber: array [0..CMACT_MAX_LEN_PRODUCT_SERIAL-1] of BYTE;
  mabSymKeyPhone:         array [0..CM_SYM_KEY_LEN-1] of BYTE;
  mabClientSecKey:        array [0..CMACT_LEN_CLIENTSECKEY-1] of BYTE;
  musReserved2:           WORD;
  musBoxMask:             WORD;
  musReserved1:           WORD;
  mulSerialNumber:        LONGWORD;
  mulProductIdMinor:      LONGWORD;
  mulGeneration:          LONGWORD;
  musPaPuCount:           WORD;
  mabReserved:            array [0..34-1] of BYTE;
end;

(***** CMACTREQUEST *****)
type TCMACTREQUEST = record
  mszProductSerialNumber:   array [0..CMACT_MAX_LEN_PRODUCT_SERIAL-1] of BYTE;
  mulProductSubType:        LONGWORD;
  mulReserved1:             LONGWORD;
  mabLicensorData:          array [0..CMACT_MAX_LEN_LICENSORDATA-1] of BYTE;
end;


(***** CMACTSYMKEY (CmAct) *****)
type TCMACTSYMKEY = record
  mabSymKey:            array [0..CM_SYM_KEY_LEN-1] of BYTE;
  mabEphemeralPoint:    array [0..CM_EPHEMERAL_POINT_LEN-1] of BYTE;
end;

(*****
 definition of the mulFileType flags (CMACTFILEINFO)
*****)
const CMACT_FILETYPE_LICENSEINFORMATIONFILE           = 1;
const CMACT_FILETYPE_LICENSEINFORMATIONFILE_BOXMEMORY = 2;
const CMACT_FILETYPE_LICENSEREQUESTFILE               = 3;
const CMACT_FILETYPE_LICENSEACTIVATIONFILE            = 4;
const CMACT_FILETYPE_LICENSEFILE                      = 5;
const CMACT_FILETYPE_LICENSEREQUESTFILE_BOXMEMORY     = 6;

(***** CMACTFILEINFO / CMACTFILEINFO2 (CmAct) *****)

type TCMACTFILEINFO2 = record
  mulFileType:                      LONGWORD;
  mulFirmCode:                      LONGWORD;
  mszProductName:                   array [0..CMACT_MAX_LEN_PRODUCTNAME-1] of BYTE;
  musBoxMask:                       WORD;
  musReserved1:                     WORD;
  mulSerialNumber:                  LONGWORD;
  mulTelephoneId:                   LONGWORD;
  mszCmActId:                       array [0..CMACT_LEN_PRODUCTIDMAJ-1] of BYTE;
  mbReserved2:                      BYTE;
  musReserved3:                     WORD;
  mulGeneration:                    LONGWORD;
  mszProductSerialNumber:           array [0..CMACT_MAX_LEN_PRODUCT_SERIAL-1] of BYTE;
  mabLicensorInfo:                  array [0..CMACT_MAX_LEN_LICENSORDATA-1] of BYTE;
  mulStatus:                        LONGWORD;
  mszPluginName:                    array [0..CMACT_MAX_LEN_PLUGIN_NAME-1] of BYTE;
  mflLicenseOptions:                LONGWORD;
  mulPlatform:                      LONGWORD;
  musNumberOfProductDescriptions:   WORD;
  musReserved4:                     WORD;
  mabNameHash:                      array [0..CMACT_LEN_NAMEHASH-1] of BYTE;
  maProductDescriptions:            array [0..CMACT_MAX_NUM_PRODUCT_DESCS-1] of TCMACTPRODUCTDESCRIPTION;
  mSymKeyBoxMemory:                 TCMACTSYMKEY;
  mSymKeyDynData:                   TCMACTSYMKEY;
  mszHostInfoName:                  array [0..CMACT_LEN_HOSTINFONAME-1] of BYTE;
  mausHostInfoFingerPrint:          array [0..CMACT_LEN_HOSTINFOFINGERPRINT-1] of WORD;
  mabReserved5:                     array [0..224-1] of BYTE;
end;

type TCMACTFILEINFO = record
  mulFileType:                      LONGWORD;
  mulFirmCode:                      LONGWORD;
  mszProductName:                   array [0..CMACT_MAX_LEN_PRODUCTNAME-1] of BYTE;
  musBoxMask:                       WORD;
  musReserved1:                     WORD;
  mulSerialNumber:                  LONGWORD;
  mulProductIdMinor:                LONGWORD;
  mszProductIdMajor:                array [0..CMACT_LEN_PRODUCTIDMAJ-1] of BYTE;
  mbReserved2:                      BYTE;
  musReserved3:                     WORD;
  mulGeneration:                    LONGWORD;
  mszProductSerialNumber:           array [0..CMACT_MAX_LEN_PRODUCT_SERIAL-1] of BYTE;
  mabLicensorInfo:                  array [0..CMACT_MAX_LEN_LICENSORDATA-1] of BYTE;
  mulStatus:                        LONGWORD;
  mszPluginName:                    array [0..CMACT_MAX_LEN_PLUGIN_NAME-1] of BYTE;
  mflLicenseOptions:                LONGWORD;
  mulPlatform:                      LONGWORD;
  musNumberOfProductDescriptions:   WORD;
  musReserved5:                     WORD;
  maProductDescriptions:            array [0..CMACT_MAX_NUM_PRODUCT_DESCS-1] of TCMACTPRODUCTDESCRIPTION;
  mSymKeyBoxMemory:                 TCMACTSYMKEY;
  mSymKeyDynData:                   TCMACTSYMKEY;
end;

(***** CMACTERRORINFO *****)
type TCMACTERRORINFO = record
  mulErrorCode:       LONGWORD;
  mulReserved1:       LONGWORD;
  mszAdditionalInfo:  array [0..512-1] of BYTE;
end;


(***********************************
 4.0.) Remote Update Structures
************************************)

(*
** for CMFAS.mflSelect
*)

const CMFAS_SELECT_MASK             = $0000000F;
const CMFAS_SELECT_WILDCARD         = $00000000;
const CMFAS_SELECT_SERIALNUMBER     = $00000001;
const CMFAS_SELECT_FIRMCODE         = $00000002;

const CMFAS_OPT_MASK                = $10000000;
const CMFAS_OPT_IGNORE              = $10000000;

(*
** for CMFAS.mulItemType
*)

const CMFAS_ITEMTYPE_LICENSE           = $00000001;
const CMFAS_ITEMTYPE_CMACT_LICENSE     = $80000001;
const CMFAS_ITEMTYPE_CMHW_LICENSE      = $40000001;
const CMFAS_ITEMTYPE_CMACTLT_LICENSE   = $20000001;
const CMFAS_ITEMTYPE_CMFIRM_WBC        = $00000002;
const CMFAS_ITEMTYPE_CMACT_FI_TEMPLATE = $80000004;

(***** CMFAS *****)
type TCMFAS  = record
  mflSelect   :       LONGWORD;
  mulItemType :       LONGWORD;

  // Serial number (CMFAS_CTL_SELECT_SERIALNUMBER)
  mulSerial   :       LONGWORD;
  musMask     :       WORD;
  musReserved1:       WORD;

  // FC (CMFAS_CTL_SELECT_FIRMCODE)
  mulFirmCode :       LONGWORD;

  mulReserved3:       array[0..19] of LONGWORD;

  // result
  mulResult   :       LONGWORD;

  mulReserved4:       array[0..9] of LONGWORD;
end; //CMFAS;


(***** CMDISCCONFIGURATION *****)
type TCM_DISC_CONFIGURATION = record
  mbMajorFirmwareRevision:      BYTE;
  mbMinorFirmwareRevision:      BYTE;
  musBytesPerSector:            WORD;
  mulLengthOfBlock0:            LONGWORD;
  mulLengthOfBlock1:            LONGWORD;
  mulLengthOfBlock2:            LONGWORD;
  mulLengthOfBlock3:            LONGWORD;

  mulFlashSize:                 LONGWORD;
  mulSerialNumber:              LONGWORD;
  mulEnablingStatus:            LONGWORD;
  
  mabReserved:       array[0..11] of BYTE;
end;

//***** CMDISCSTATUS *****/
type TCM_DISC_SECTOR = record
  mulNumberOfRequestedSectors:  LONGWORD;
  mulSectorOffset:              LONGWORD;
  mabReserved:                  array[0..55] of BYTE;
end;

//***** CMDISCSTATUS *****/
type TCM_DISC_STATUS = record
  mulErrorCode:                 LONGWORD;
  mulEnablingBits:              LONGWORD;
  mulDiscSectorsTotal:          LONGWORD;
  mulWriteOnceCount:            LONGWORD;
  mabReserved:                  array[0..63] of BYTE;
end;

// Flags for mbItemType of CM_ENABLE_CONTEXT
  const CM_EC_PRODUCTITEM     = $01;
  const CM_EC_FIRMITEM        = $02;
  const CM_EC_GLOBALITEM      = $04;

// musOption of CM_ENABLE_CONTEXT is the same as musStatus of CMENABLING_ENABLELOOKUPENTRY
//           is the same as musOption of CMENABLING_ENABLEBLOCKITEM
// mbType of CM_ENABLE_CONTEXT is the same as mbType of CMENABLING_ENABLEBLOCKITEM
// musFlags of CM_ENABLE_CONTEXT is the same as musOption of CMENABLING_ENABLELOOKUPENTRY
// mbEnableLevel und bDisableLevel entsprechen denen aus CMENABLING_ENABLELOOKUPENTRY

type TCM_ENABLE_CONTEXT = record
  mulFirmcode:                                LONGWORD;
  mulProductcode:                             LONGWORD;
  musOption:                                  WORD; //*enable / temp enable / disable*/
  mbIndex:                                    BYTE;
  mbType:                                     BYTE;
  mulDisableTime:                             LONGWORD;
  musText:                                    array[0..CM_MAX_STRING_LEN-1] of WORD;
  musFlags:                                   WORD;
  mbItemType:                                 BYTE;
  mcbEnableAccessCode:                        BYTE;
  mabEnableAccessCode:                        array[0..CM_CHALLENGE_LEN-1] of BYTE;
  mausEnablePassword:                         array[0..CM_MAX_PASSWORD_LEN-1] of WORD;
  mbEnableLevel:                              BYTE;
  mbDisableLevel:                             BYTE;
end;

(*****************************************************************************
 ************************* Functions predeclarations *************************
******************************************************************************)

type HCMSysEntry = POINTER;
type PTCMACCESS = ^TCMACCESS;
type PTCMACCESS2 = ^TCMACCESS2;
type PTCMCREDENTIAL = ^TCMCREDENTIAL;
type PTCMCRYPT = ^TCMCRYPT;
type PTCMCRYPT2 = ^TCMCRYPT2;
type PTCMCRYPTSIM = ^TCMCRYPTSIM;
type PTCMCRYPTSIM2 = ^TCMCRYPTSIM2;
type PTCMPIOCK = ^TCMPIOCK;
type PTCMSECUREDATA = ^TCMSECUREDATA;
type PTCMENTRYDATA = ^TCMENTRYDATA;
type PTCMSYSTEM = ^TCMSYSTEM;
type PTCMVERSION = ^TCMVERSION;
type PTCMBOXINFO = ^TCMBOXINFO;
type PTCMBOXENTRY = ^TCMBOXENTRY;
type PTCMBOXENTRY2 = ^TCMBOXENTRY2;
type PTCMLICENSEINFO = ^TCMLICENSEINFO;
type PTCMRESERVEFI = ^TCMRESERVEFI;
type PTCMSERIAL = ^TCMSERIAL;
type PTCMCREATEITEM = ^TCMCREATEITEM;
type PTCMENABLING_APPCONTEXT = ^TCMENABLING_APPCONTEXT;
type PTCMAUTHENTICATE = ^TCMAUTHENTICATE;
type PTCMSECURITYVERSION = ^TCMSECURITYVERSION;
type PTCMFAS = ^TCMFAS;

(*************************************
 1.) Access functions for CmContainers
**************************************)

(*****
 definition of CmAccess and the belonging options (flCtrl)
*****)
const CM_ACCESS_LOCAL               = $0000;
const CM_ACCESS_LAN                 = $0001;
const CM_ACCESS_LOCAL_LAN           = $0002;
const CM_ACCESS_LAN_LOCAL           = $0003;
const CM_ACCESS_LANWAN              = $0011;
const CM_ACCESS_LOCAL_LANWAN        = $0012;
const CM_ACCESS_LANWAN_LOCAL        = $0013;
const CM_ACCESS_CMDMASK             = $0013;

(*****
 definition of CmAccess
*****)
function CmAccess(flCtrl:   LONGWORD; pcmAcc:   PTCMACCESS): HCMSysEntry; cdecl; forward;

(*****
 definition of CmAccess2
*****)
function CmAccess2(flCtrl:  LONGWORD; pcmAcc: PTCMACCESS2): HCMSysEntry; cdecl; forward;

(*****
 definition of CmRelease
*****)
function CmRelease(hcmse: HCMSysEntry): INTEGER; cdecl; forward;

(**********************
 2.) Security functions
***********************)

(*****
 definition of CmCheckEvents and the belonging events (flEvents)
*****)
const  CM_CE_BOXREMOVED              = $0001;
const  CM_CE_BOXREPLACED             = $0002;
const  CM_CE_BOXADDED                = $0004;
const  CM_CE_NETWORKLOST             = $0008;
const  CM_CE_NETWORKREPLACED         = $0010;
const  CM_CE_ENTRYMODIFIED           = $0020;
const  CM_CE_THRESHOLD_UNITCOUNTER   = $0040;
const  CM_CE_THRESHOLD_EXPDATE       = $0080;
const  CM_CE_SERVER_TERMINATED       = $0100;
const  CM_CE_BOXENABLED              = $0200;
const  CM_CE_BOXDISABLED             = $0400;
const  CM_CE_ENTRYALTERED            = $000800;
const  CM_CE_RELEASE_EVENT           = $800000;

function CmCheckEvents(flEvents: LONGWORD): LONGWORD; cdecl; forward;

(*****
 definition of CmCrypt & CmCryptSim and the belonging options (flCtrl)
*****)
(* commands for direct encryption *)
const CM_CRYPT_DIRECT_ENC           = $0000;
const CM_CRYPT_DIRECT_DEC           = $0001;

(* commands for indirect encryption *)
const CM_CRYPT_STREAM               = $0003;
const CM_CRYPT_AES_ENC_ECB          = $0004;
const CM_CRYPT_AES_DEC_ECB          = $0005;
const CM_CRYPT_AES_ENC_CFB          = $0006;
const CM_CRYPT_AES_DEC_CFB          = $0007;
const CM_CRYPT_AES_ENC_CBC          = $0008;
const CM_CRYPT_AES_DEC_CBC          = $0009;

const CM_CRYPT_AES_ENC_CBC_DIRECT   = $000a;
const CM_CRYPT_AES_DEC_CBC_DIRECT   = $000b;
(* command mask for extracting the upper commands from other flags *)
const CM_CRYPT_CMDMASK              = $000f;
(* This flag can be or'ed with all upper commands for indirect encryption *)
const CM_CRYPT_AUTOKEY              = $0100;

(*****
 definition of CmCrypt
*****)
function CmCrypt(hcmse:     HCMSysEntry;
                 flCtrl:    LONGWORD;
                 pcmCrypt:  PTCMCRYPT;
                 pvDest:    POINTER;
                 cbDest:    LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmCryptSim
*****)
function CmCryptSim(hcmse:          HCMSysEntry;
                    flCtrl:         LONGWORD;
                    pcmCryptSim:    PTCMCRYPTSIM;
                    pvDest:         POINTER;
                    cbDest:         LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmCrypt2
*****)
function CmCrypt2(hcmse:      HCMSysEntry;
                  flCtrl:     LONGWORD;
                  pcmCrypt2:  PTCMCRYPT2;
                  pvDest:     POINTER;
                  cbDest:     LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmCryptSim2
*****)
function CmCryptSim2(hcmse:           HCMSysEntry;
                     flCtrl:          LONGWORD;
                     pcmCryptSim2:    PTCMCRYPTSIM2;
                     pvDest:          POINTER;
                     cbDest:          LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmCryptEcies
*****)
function CmCryptEcies(pbPublicKey:  PBYTE;
                      cbPublicKey:  LONGWORD;
                      pbData:       PBYTE;
                      cbData:       LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmCalcualtePioCoreKey
*****)
function CmCalculatePioCoreKey(hcmse:       HCMSysEntry;
                               pcmPioCK:    PTCMPIOCK;
                               pbPioCK:     PBYTE;
                               cbPioCK:     LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmGetSecureData
*****)
function CmGetSecureData(hcmse:         HCMSysEntry;
                         pcmSecureData: PTCMSECUREDATA;
                         pcmEntryData:  PTCMENTRYDATA): INTEGER; cdecl; forward;

(*****
 definition of CmGetSecureData
*****)
function CmGetPioDataKey(pabPiodkDest:  PBYTE;
                         cbPiodkDest:   LONGWORD;
                         pabPioCk:      PBYTE;
                         cbPioCk:       LONGWORD;
                         pabPioEk:      PBYTE;
                         cbPioEk:       LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmDecryptPioData
*****)
function CmDecryptPioData(pabDest:      PBYTE;
                          cbDest:       LONGWORD;
                          pabPiodkDest: PBYTE;
                          cbPiodkDest:  LONGWORD): INTEGER; cdecl; forward;

(************************************
 3.) CmContainer management functions
*************************************)

(*****
 definition of CmGetBoxContents and CmGetBoxContents2 and the belonging options (flCtrl)
*****)
const  CM_GBC_ALLENTRIES             = $0000;
const  CM_GBC_FI                     = $0001;
const  CM_GBC_BOX                    = $0002;
const  CM_GBC_USELOCALTIME           = $1000;

(*****
 definition of CmGetBoxContents
*****)
function CmGetBoxContents(hcmse:        HCMSysEntry;
                          flCtrl:       LONGWORD;
                          ulFirmCode:   LONGWORD;
                          pcmBoxInfo:   PTCMBOXINFO;
                          pcmBoxEntry:  PTCMBOXENTRY;
                          cbBoxEntry:   LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmGetBoxContents2
*****)
function CmGetBoxContents2(hcmse:        HCMSysEntry;
                          flCtrl:        LONGWORD;
                          ulFirmCode:    LONGWORD;
                          pcmBoxInfo:    PTCMBOXINFO;
                          pcmBoxEntry:   PTCMBOXENTRY2;
                          cbBoxEntry:    LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmGetBoxes and the belonging ports (idPort)
*****)
const  CM_GB_ALLPORTS                = $0000;
const  CM_GB_DONGLE					 = $0001;
const  CM_GB_USB                     = CM_GB_DONGLE;
const  CM_GB_SIM                     = $0002;
const  CM_GB_ACT                     = $0004;
const  CM_GB_PORT_MASK               = $000F;


function CmGetBoxes(hcmse:          HCMSysEntry;
                    idPort:         LONGWORD;
                    pcmBoxInfo:     PTCMBOXINFO;
                    cbBoxInfo:      LONGWORD): INTEGER; cdecl; forward;

const CM_SEC_LICENSOR = 2;

(*****
 definition of CmGetInfo and the belonging options (flCtrl)
*****)
const  CM_GEI_BOXCONTROL             = $0000;
const  CM_GEI_BOXINFO                = $0001;
const  CM_GEI_BOXSECURITY            = $0002;
const  CM_GEI_BOXTIME                = $0003;
const  CM_GEI_ENTRYDATA              = $0004;
const  CM_GEI_ENTRYINFO              = $0005;
const  CM_GEI_INTERNALENTRYINFO      = $0006;
const  CM_GEI_MEMINFO                = $0007;
const  CM_GEI_SIGNEDLIST             = $0008;
const  CM_GEI_SIGNEDTIME             = $0009;
const  CM_GEI_SYSTEM                 = $000a;
const  CM_GEI_VERSION                = $000b;
const  CM_GEI_ENABLEBLOCKITEMS       = $000c;
const  CM_GEI_ENABLELOOKUPITEMS_FI   = $000d;
const  CM_GEI_ENABLELOOKUPITEMS_PI   = $000e;
const  CM_GEI_CHIPINFO               = $000f;
const  CM_GEI_BOXSTATUS              = $0010;
const  CM_GEI_USBCHIPINFO            = $0011;
const  CM_GEI_NETINFO_CLUSTER        = $0012;
const  CM_GEI_NETINFO_USER           = $0013;
const  CM_GEI_CREDENTIAL             = $0014;
const  CM_GEI_SECURITYVERSION        = $0015;
const  CM_GEI_NETINFO_USER_EXT       = $0016;
const  CM_GEI_MEMINFO2               = $0017;
const  CM_GEI_ACT_LICENSE_INFO       = $0018;
const  CM_GEI_ACT_ERROR_INFO         = $0019;
const  CM_GEI_CMACTVERSION           = $0020;
const  CM_GEI_BORROWCLIENT           = $0030;
const  CM_GEI_BORROWDATA             = $0031;
const  CM_GEI_BORROWITEMS            = $0032;
const  CM_GEI_ENTRYINFO2             = $0033;
const  CM_GEI_ENABLEINFO             = $0034;
const  CM_GEI_ACT_LICENSE_INFO2      = $0035;
const  CM_GEI_SYSTEMSTATUS           = $0036;
const  CM_GEI_COMMUNICATION          = $0037;
const CM_GEI_LTHISTORY               = $0038;
const CM_GEI_LTTRANSFEROPTIONS       = $0039;

const  CM_GEI_CMDMASK                = $00ff;
const  CM_GEI_USELOCALTIME           = $1000;
const  CM_GEI_INDEXMASK              = $ff000000;

(*****
 definition of the BoxStatus flags (CM_GEI_BOXSTATUS)
*****)

const CM_BOXSTATUS_LOWMEMORY                  = $00000001;
const CM_BOXSTATUS_REPLUG                     = $00000002;
const CM_BOXSTATUS_HASFLASH                   = $00000004;
const CM_BOXSTATUS_ISCMACT                    = $00000008;
const CM_BOXSTATUS_REMOVABLE                  = $00000010;
const CM_BOXSTATUS_BATTERY_POWERED_CLOCK_USED = $00000020;
const CM_BOXSTATUS_USES_HID_COMMUNICATION     = $00000040;
const CM_BOXSTATUS_FEATURE_MASK               = $000000FF;

const CM_ACTSTATUS_FILE              = $00000100;
const CM_ACTSTATUS_LOADED            = $00000200;
const CM_ACTSTATUS_ACTIVATE_BY_CODE  = $00000400;
const CM_ACTSTATUS_ACTIVATE_BY_FILE  = $00000800;
const CM_ACTSTATUS_ACTIVE            = $00001000;
const CM_ACTSTATUS_PROGRAMMABLE      = $00002000;
const CM_ACTSTATUS_INVALID           = $00004000;
const CM_ACTSTATUS_BROKEN            = $00008000;
const CM_ACTSTATUS_PSN_REQUIRED      = $02000000;
const CM_ACTSTATUS_VM_DETECTED       = $04000000;
const CM_ACTSTATUS_BLACKLISTED       = $10000000;
  (* CM_ACTSTATUS_VM_DETECTED has two meanings: When returned by
     CM_GEI_BOXSTATUS it's an error condition; when returned by
     CM_GF_ACT_GETFILEINFO, the file was created in a VM (which
     was permitted) *)

const CM_BOXSTATUS_CMACT_MASK        = $1F00FF00;

const CM_BOXSTATUS_ENABLED           = $00000000;
const CM_BOXSTATUS_DISABLED          = $00010000;
const CM_BOXSTATUS_TEMPENABLED       = $00020000;
const CM_BOXSTATUS_NOENABLEITEMS     = $00040000;
const CM_BOXSTATUS_AMBIGUOUS         = $00080000;
const CM_BOXSTATUS_MASK              = $000f0000;

const CM_BOXSTATUS_STATE_FUM         = $00100000;
const CM_BOXSTATUS_STATE_LOCKED      = $00200000;
const CM_BOXSTATUS_STATE_MASK        = $00F00000;

(*****
 definition of CmGetInfo
*****)
function CmGetInfo(hcmse:   HCMSysEntry;
                   flCtrl:  LONGWORD;
                   pvDest:  POINTER;
                   cbDest:  LONGWORD): INTEGER; cdecl; forward;
(*****
 definition of CmGetLicenseInfo
*****)
function CmGetLicenseInfo(hcmse:                HCMSysEntry;
                          pcmLicenseInfo:       PTCMLICENSEINFO;
                          cbNumberOfLicenses:   LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmGetServers  and the belonging options (flCtrl)
*****)
const CM_GS_LIST                    = $0000;
const CM_GS_SINGLE_FIRST            = $0001;
const CM_GS_SINGLE                  = $0002;
const CM_GS_CMDMASK                 = $0003;

const CM_GS_IPADDR                  = $0000;
const CM_GS_NAME                    = $0010;
const CM_GS_ALL_SERVERS             = $0020;
const CM_GS_REMOTE_SERVERS_ONLY     = $0040;
const CM_GS_IPADDR_IPv6MAPPED       = $0080;
const CM_GS_INCLUDE_CMWAN_SERVERS   = $0100;


function CmGetServers(flCtrl:       LONGWORD;
                      pszServer:    PAnsiCHAR;
                      cbServer:     LONGWORD;
                      pnNumberOfServers:    PLONGWORD): INTEGER; cdecl; forward;

function CmReadProfilingEntry(hcmse:        HCMSysEntry;
                              flCtrl:       LONGWORD;
                              pszEntryName: PAnsiCHAR;
                              pszValue:     PAnsiCHAR;
                              cbValue:      LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmGetVersion
*****)
function CmGetVersion(hcmse: HCMSysEntry): LONGWORD; cdecl; forward;

(******************************
 4.) Error management functions
*******************************)

(*****
 definition of CmGetLastErrorCode
*****)
function CmGetLastErrorCode(): INTEGER; cdecl; forward;

(*****
 definition of CmGetLastErrorText/CmGetLastErrorText2 and the belonging options (flCtrl)
*****)
const CM_GLET_ERRORTEXT             = $0000;
const CM_GLET_DIALOG                = $0010;
const CM_GLET_MASK                  = $00FF;
const CM_GLET_LOCAL_ENCODING        = $0000;
const CM_GLET_UTF8_ENCODING         = $0100;
const CM_GLET_WCHAR_ENCODING        = $0200;
const CM_GLET_ENCODING_MASK         = $0F00;

function CmGetLastErrorText(flCtrl:         LONGWORD;
                            pszErrorText:   PAnsiCHAR;
                            cbErrorText:    LONGWORD): INTEGER; cdecl; forward;
function CmGetLastErrorText2(flCtrl: LONGWORD;
                             pvErrorText: POINTER;
                             cbErrorText: LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmSetLastErrorCode
*****)
procedure CmSetLastErrorCode(idError: INTEGER); cdecl; forward;

(*************************************
 5.) CmContainer programming functions
**************************************)

(*****
 definition of CmReserveFirmItem
  * global flags used for flCtrl
*****)
function CmReserveFirmItem(hcmse:           HCMSysEntry;
                           ulFirmCode:      LONGWORD;
                           pcmReserveFi:    PTCMRESERVEFI): INTEGER; cdecl; forward;

(*****
 definition of CmCreateProductItemOption and the belonging options (flCtrl)
*****)
(* flags specifing the PIO to add, update or delete *)
const CM_CPIO_PRODUCTCODE           = $00000000;
const CM_CPIO_FEATUREMAP            = $00000001;
const CM_CPIO_EXPTIME               = $00000002;
const CM_CPIO_ACTTIME               = $00000003;
const CM_CPIO_UNITCOUNTER           = $00000004;
const CM_CPIO_PROTDATA              = $00000005;
const CM_CPIO_EXTPROTDATA           = $00000006;
const CM_CPIO_HIDDENDATA            = $00000007;
const CM_CPIO_SECRETDATA            = $00000008;
const CM_CPIO_USERDATA              = $00000009;
const CM_CPIO_TEXT                  = $0000000a;
const CM_CPIO_DELETEALL             = $0000000b;
const CM_CPIO_CHANGEDEPENDENCY      = $0000000c;
const CM_CPIO_USAGEPERIOD           = $0000000d;
const CM_CPIO_MAINTENANCEPERIOD     = $0000000e;
const CM_CPIO_CMDMASK               = $0000000f;
(* flags combined only with CM_CPIO_PRODUCTCODE *)
const CM_CPIO_ADD                   = $00010000;
const CM_CPIO_UPDATE                = $00020000;
(* flag combined with any CM_CPIO_...-flag *)
const CM_CPIO_DELETE_PIO            = $00100000;
const CM_CPIO_RELATIVE              = $00200000;
(* flag combined with any CM_CPIO_...-flag but only called once altogether *)
const CM_CPIO_TERMINATE             = $00400000;

function CmCreateProductItemOption(hcmse:   HCMSysEntry;
                                   flCtrl:  LONGWORD;
                                   pvPio:   POINTER;
                                   cbPio:   LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmCreateSequence
  * global flags used for flCtrl
*****)
function CmCreateSequence(hcmse:            HCMSysEntry;
                          flCtrl:           LONGWORD;
                          pcmCreateItem:    PTCMCREATEITEM;
                          pvCtrl:           POINTER;
                          cbCtrl:           LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmProgram
  * global flags used for flCtrl
*****)
const CM_PROG_DEFRAGMEM             = $00010000;
const CM_PROG_MASTERPASSWORD        = $00020000;

function CmProgram(hcmse: HCMSysEntry;
                   flCtrl:      LONGWORD;
                   pvCtrl:      POINTER;
                   cbCtrl:      LONGWORD;
                   pvVerify:    POINTER;
                   cbVerify:    LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmValidateEntry
*****)
const CM_VAL_SIGNEDLIST             = $00000000;
const CM_VAL_SIGNEDTIME             = $00000001;
const CM_VAL_DELETE_FI              = $00000002;
const CM_VAL_CMDMASK                = $00000003;

function CmValidateEntry(hcmse:         HCMSysEntry;
                         flCtrl:        LONGWORD;
                         pcmBoxInfo:    PTCMBOXINFO;
                         pvValidate:    POINTER;
                         cbValidate:    LONGWORD): INTEGER; cdecl; forward;

(********************************
 6.) Remote Programming functions
*********************************)

(*****
 definition of CmGetRemoteContext/CmGetRemoteContext2/CmGetRemoteContextBuffer
*****)
const CM_RMT_OVERWRITE        = $00000000;
const CM_RMT_APPEND           = $00000001;
const CM_RMT_MASK             = $000000ff;
const CM_RMT_LOCAL_ENCODING   = $00000000;
const CM_RMT_UTF8_ENCODING    = $00000100;
const CM_RMT_WCHAR_ENCODING   = $00000200;
const CM_RMT_ENCODING_MASK    = $00000f00;

function CmGetRemoteContext(pszRacFile:   POINTER;
                            flCtrl:     LONGWORD;
                            hcmBox:     HCMSysEntry;
                            pulFirmCodes:  PLONGWORD;
                            cbFirmCodes:  LONGWORD): INTEGER; cdecl; forward;

function CmGetRemoteContext2(hcmBox: HCMSysEntry;
                             flCtrl: LONGWORD;
                             pvRaCFile: POINTER;
                             pulFirmCodes: PLONGWORD;
                             cbFirmCodes: LONGWORD): INTEGER; cdecl; forward;

function CmGetRemoteContextBuffer(hcmBox: HCMSysEntry;
                                  flCtrl: LONGWORD;
                                  pulFirmCodes: PLONGWORD;
                                  cbFirmCodes: LONGWORD;
                                  pvMemBuffer: POINTER;
                                  cbMemBuffer: LONGWORD;
								  pcbWritten: PLONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmSetRemoteUpdate/CmSetRemoteUpdate2/CmSetRemoteUpdateBuffer
*****)
function CmSetRemoteUpdate(pszRauFile:   POINTER;
                           hcmBox:    HCMSysEntry): INTEGER; cdecl; forward;

function CmSetRemoteUpdate2(hcmse: HCMSysEntry;
                            flCtrl: LONGWORD;
                            pszRauFile: POINTER): INTEGER; cdecl; forward;

function CmSetRemoteUpdateBuffer(hcmse: HCMSysEntry;
                                 flCtrl: LONGWORD;
                                 pvMemBuffer: POINTER;
                                 cmMemBuffer: LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmListRemoteUpdate/CmListRemoteUpdate2/CmListRemoteUpdateBuffer
*****)
function CmListRemoteUpdate(pszRauFile:  POINTER;
                            pcmSerials: POINTER;
                            cbSerials:   LONGWORD): INTEGER; cdecl; forward;

function CmListRemoteUpdate2(flCtrl: LONGWORD;
                             pvRauFile: POINTER;
                             pcmSerials: PTCMSERIAL;
                             cbSerials: LONGWORD): INTEGER; cdecl; forward;

function CmListRemoteUpdateBuffer(flCtrl: LONGWORD;
                                  pvMemBuffer: POINTER;
                                  cbMemBuffer: LONGWORD;
                                  pcmSerials: TCMSERIAL;
                                  cbSerials: LONGWORD): INTEGER; cdecl; forward;


(*****
 definition of CmExecuteRemoteUpdate
*****)

(*
** For flCtrl
*)

const CMFAS_CTL_CMD_MASK            = $00000003;
const CMFAS_CTL_CMD_LIST            = $00000000;
const CMFAS_CTL_CMD_UPDATE          = $00000001;
const CMFAS_CTL_CMD_UPDATE_EXISTING = $00000002;
const CMFAS_CTL_CMD_GET_COUNT       = $00000003;

const CMFAS_CTL_OPT_MASK            = $00000010;
const CMFAS_CTL_OPT_ABORT_ON_ERROR  = $00000010;

function CmExecuteRemoteUpdate( hcmSubSystem  :  HCMSysEntry ;
                                flCtrl        : LONGWORD;
                                pMemBuffer    : POINTER;
                                cbMemBuffer   : LONGWORD;
                                pCmFasSelect  : PTCMFAS;
                                cbCmFasSelect : LONGWORD;
                                pCmFasResult  : PTCMFAS;
                                cbCmFasResult : LONGWORD;
                                pcbCmFasResultCount: PLONGWORD): INTEGER; cdecl; forward;


(**********************
 7.) Enabling functions
***********************)

(*****
 definition of CmEnablingWriteApplicationKey and the belonging options (flCtrl)
*****)
const CM_EW_ADD                     = $0000;
const CM_EW_UPDATE                  = $0001;
const CM_EW_DELETE                  = $0002;
const CM_EW_ATTACH                  = $0003;
const CM_EW_DETACH                  = $0004;
const CM_EW_CMDMASK                 = $0007;

function CmEnablingWriteApplicationKey(hcmse:  HCMSysEntry;
                                       flCtrl: LONGWORD;
                                       pvCtrl: POINTER;
                                       cbCtrl: LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmEnablingGetApplicationContext
*****)
function CmEnablingGetApplicationContext(hcmse:         HCMSysEntry;
                                         pcmAppContext: PTCMENABLING_APPCONTEXT): INTEGER; cdecl; forward;

(*****
 definition of CmEnablingGetChallenge
*****)
function CmEnablingGetChallenge(hcmse:          HCMSysEntry;
                                pcmAppContext:  PTCMENABLING_APPCONTEXT;
                                pbChallenge:    PBYTE;
                                cbChallenge:    LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmEnablingSendResponse
*****)
function CmEnablingSendResponse(hcmse:          HCMSysEntry;
                                pcmAppContext:  PTCMENABLING_APPCONTEXT;
                                pbResponse:     PBYTE;
                                cbResponse:     LONGWORD): INTEGER; cdecl; forward;

(*****
 CmEnablingWithdrawAccessRights is obsolete since CM v5.20
*****)

(*******************************************************
 8.) Functions for time and date update in a CmContainer
********************************************************)

(*****
 definition of CmSetCertifiedTimeUpdate
*****)
function CmSetCertifiedTimeUpdate(hcmse:        HCMSysEntry;   pszCtcsServer: POINTER): INTEGER; cdecl; forward;

(****************************
 9.) Authentication functions
*****************************)

(*****
 definition of CmCalculateDigest
*****)
function CmCalculateDigest(pbInput:  Pointer;
         cbInput:  INTEGER;
         pbDigest:  PBYTE;
         cbDigest:  INTEGER): INTEGER; cdecl; forward;

(*****
 definition of CmCalculateSignature
*****)
function CmCalculateSignature(hcmse:                    HCMSysEntry;
                              pcmAuth:                   PTCMAUTHENTICATE;
                              pbSignature:    PBYTE;
                              cbSignature:    LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmGetPublicKey
*****)
function CmGetPublicKey(hcmse:          HCMSysEntry;
      pcmAuth:        PTCMAUTHENTICATE;
      pbPubKey:  PBYTE;
            cbPubKey:  LONGWORD): INTEGER; cdecl; forward;

(*****
 definition of CmValidateSignature
*****)
function CmValidateSignature(pcmAuth:           PTCMAUTHENTICATE;
                             pbSignature:  PBYTE;
           cbSignature:  LONGWORD;
           pbPubKey:    PBYTE;
           cbPubKey:    LONGWORD): INTEGER; cdecl; forward

(****************************
10.) Helper functions
*****************************)

(*****
 definition of CmConvertString, CmConvertTime, and the belonging options (flCtrl)
*****)
const CM_CONVERT_UTF8_TO_WCHAR      = $0001;
const CM_CONVERT_UTF8_TO_UCS2LE     = $0002;
const CM_CONVERT_UTF8_TO_ASCII      = $0003;
const CM_CONVERT_UTF8_TO_UTF16      = $0004;
const CM_CONVERT_UTF8_TO_LOCAL      = $0005;

const CM_CONVERT_WCHAR_TO_UCS2LE    = $0010;
const CM_CONVERT_WCHAR_TO_UTF8      = $0011;
const CM_CONVERT_WCHAR_TO_ASCII     = $0012;
const CM_CONVERT_WCHAR_TO_UTF16     = $0013;
const CM_CONVERT_WCHAR_TO_LOCAL     = $0014;

const CM_CONVERT_UCS2LE_TO_WCHAR    = $0020;
const CM_CONVERT_UCS2LE_TO_UTF8     = $0021;
const CM_CONVERT_UCS2LE_TO_ASCII    = $0022;
const CM_CONVERT_UCS2LE_TO_UTF16    = $0023;
const CM_CONVERT_UCS2LE_TO_LOCAL    = $0024;

const CM_CONVERT_ASCII_TO_WCHAR     = $0030;
const CM_CONVERT_ASCII_TO_UCS2LE    = $0031;
const CM_CONVERT_ASCII_TO_UTF8      = $0032;
const CM_CONVERT_ASCII_TO_UTF16     = $0033;
const CM_CONVERT_ASCII_TO_LOCAL     = $0034;

const CM_CONVERT_UTF16_TO_UTF8      = $0040;
const CM_CONVERT_UTF16_TO_UCS2LE    = $0041;
const CM_CONVERT_UTF16_TO_WCHAR     = $0042;
const CM_CONVERT_UTF16_TO_ASCII     = $0043;
const CM_CONVERT_UTF16_TO_LOCAL     = $0044;

const CM_CONVERT_LOCAL_TO_UTF8      = $0050;
const CM_CONVERT_LOCAL_TO_UCS2LE    = $0051;
const CM_CONVERT_LOCAL_TO_WCHAR     = $0052;
const CM_CONVERT_LOCAL_TO_ASCII     = $0053;
const CM_CONVERT_LOCAL_TO_UTF16     = $0054;

const CM_CONVERT_SECONDS_TO_CALENDAR = $0081;
const CM_CONVERT_CALENDAR_TO_SECONDS = $0082;

const CM_CONVERT_MASK               = $00FF;

function CmConvertString(flCtrl:        LONGWORD;
                         const pszSrc:  POINTER;
                         pszDst:        POINTER;
                         cbDst:          LONGWORD): INTEGER; cdecl; forward

function CmConvertTime(flCtrl:          LONGWORD;
                       VAR cmtime:      TCMTIME): INTEGER; cdecl; forward

(****************************
11.) CmAct License managment
*****************************)

const CM_GF_ACT_CREATE_LICENSE_INFO     = $0011;
const CM_GF_ACT_SETUP_LICENSE           = $0012;
const CM_GF_ACT_SETUP_LICENSE_STEP1     = $0013;
const CM_GF_ACT_SETUP_LICENSE_STEP2     = $0014;
const CM_GF_ACT_REGISTER                = $0015;
const CM_GF_ACT_UPDATE_LICENSE_DATA     = $0016;
const CM_GF_ACT_ACTIVATION_CODE         = $0017;
const CM_GF_ACT_LICENSE_BY_CODE         = $0018;
const CM_GF_ACT_REQUEST                 = $0019;
const CM_GF_ACT_CREATE_ACTIVATION_STEP1 = $001a;
const CM_GF_ACT_CREATE_ACTIVATION_STEP2 = $001b;
const CM_GF_ACT_CREATE_ACTIVATION_STEP3 = $001c;
const CM_GF_ACT_REMOVE                  = $001d;
const CM_GF_ACT_GETFILEINFO             = $001e;
const CM_GF_ACT_GET_INSTALLATION_ID     = $001f;
const CM_GF_ACT_SPLIT_INSTALLATION_ID   = $0020;
const CM_GF_ACT_GET_TEMPLATE_KEY        = $0021;
const CM_GF_ACT_SPLIT_ACTIVATION_CODE   = $0022;
const CM_GF_ACT_GETFILEINFO2			= $0023;
const CM_GF_ACT_CREATE_ACTIVATION_STEP2A= $0024;

const CM_GF_ACT_MASK                    = $007f;

function CmActLicenseControl(hcmse:         HCMSysEntry;
                             flCtrl:        LONGWORD;
                             const pvData:  POINTER;
                             cbData:        LONGWORD;
                             pvReturn:      POINTER;
                             cbReturn:      LONGWORD): INTEGER; cdecl; forward
                             
(****************************
12.) License Borrowing
*****************************)

function CmBorrow(hcmse:           HCMSysEntry;
                  flCtrl:          LONGWORD;
                  const pszServer: POINTER): INTEGER; cdecl; forward

(****************************
13.) Revalidation of boxes and licenses
*****************************)

function CmRevalidateBox(hcmse:    HCMSysEntry;
                         flCtrl:   LONGWORD): INTEGER; cdecl; forward

(****************************
14.) Secure Disc Handling
*****************************)

(*
** Enabling flags for CmSecureDisc feature
*)

const CM_SECURE_DISC_STATUS             = $00000200;
const CM_SECURE_DISC_READ               = $00000201;
const CM_SECURE_DISC_WRITE              = $00000202;
const CM_GET_DISC_CONFIGURATION         = $00000203;

const CM_SECURE_DISC_VERIFY_MASK        = $00030000;
(* These flags may be or'ed with CM_SECURE_DISC_WRITE. 'Auto' is the default *)
const CM_SECURE_DISC_VERIFY_ON          = $00010000;
const CM_SECURE_DISC_VERIFY_OFF         = $00020000;
const CM_SECURE_DISC_VERIFY_AUTO        = $00000000;


function CmSecureDiscRead(hcmse:          HCMSysEntry;
                          flCtrl:         LONGWORD;
                          status:         POINTER;
                          const sector:   POINTER;
                          data:           POINTER;
                          cbData:         LONGWORD): INTEGER; cdecl; forward

function CmSecureDiscWrite( hcmse:          HCMSysEntry;
                            flCtrl:         LONGWORD;
                            status:         POINTER;
                            const sector:   POINTER;
                            const data:     POINTER;
                            cbData:         LONGWORD): INTEGER; cdecl; forward

function CmExtendedDiscControl( hcmse:      HCMSysEntry;
                                flCtrl:     LONGWORD;
                                data:       POINTER;
                                cbData:     LONGWORD): INTEGER; cdecl; forward


(****************************
15.) License Transfer Global Definitions
*****************************)

(*
  flags for flCtrl of CmLtXyz() functions
*)
const CM_LT_FSB = 1;
const CM_LT_PUSH = 2;
const CM_LT_RETURN = 3;
const CM_LT_PULL = 4;
const CM_LT_RENEWBORROW = 5;
const CM_LT_CMDMASK_LOW = CM_LT_FSB or CM_LT_PUSH or CM_LT_RETURN or CM_LT_PULL or CM_LT_RENEWBORROW;
const CM_LT_INITPULL = $00001000;
const CM_LT_CMDMASK = CM_LT_CMDMASK_LOW or CM_LT_INITPULL;


(*
  flags for mflCtrl of CMLTREQUEST
*)
const CM_LTR_NORECEIPT = $00000100;

(***** CMLTREQUEST *****)
type TCMLTREQUEST = record
	mflCtrl: LONGWORD;
	mulFirmCode: LONGWORD;
	mabReserved: array[0..248-1] of BYTE;
end;

(*
  flags for mflCtrl of CMLTTRANSFER
*)
const CM_LTT_MOVECOMPLETE = 1;
const CM_LTT_MOVEUNITS = 2;
const CM_LTT_MOVELICENSES = 3;
const CM_LTT_BORROWLOCALLICENSE = 4;
const CM_LTT_BORROWCOMPLETE = 5;
const CM_LTT_CMDMASK = 7;

(***** CMLTTRANSFER *****)
type TCMLTTRANSFER = record
	mflCtrl: LONGWORD;
	mcUnitsToTransfer: LONGWORD;
	mcLicenseQuantityToTransfer: LONGWORD;
	mcmBorrowExpirationTime: TCMTIME;
	midPIOHistory: WORD;
	mabReserved: array[0..234-1] of BYTE;
end;

(*
  flags for flCtrl of CmLtCleanup()
*)
const CM_LTCU_DELETED = $00000001;
const CM_LTCU_DISABLED = $00000002;
const CM_LTCU_HIDDENHISTORY = $00000004;
const CM_LTCU_CONTAINER = $00000008;
const CM_LTCU_ALL = $ffffffff;

function CmLtCreateContext(hcmse: HCMSysEntry;
						   flCtrl: LONGWORD;
						   const pcmltRequest: POINTER;
						   const pContextForPull: POINTER;
						   cbContextForPull: LONGWORD;
						   pContext: POINTER;
						   cbContext: LONGWORD): INTEGER; cdecl; forward

function CmLtDoTransfer(hcmse: HCMSysEntry;
						flCtrl: LONGWORD;
						pcmltTransfer: POINTER;
						const pRequest: POINTER;
						cbRequest: LONGWORD;
						pUpdate: POINTER;
						cbUpdate: LONGWORD): INTEGER; cdecl; forward

function CmLtImportUpdate(hcmse: HCMSysEntry;
						  flCtrl: LONGWORD;
						  const pUpdate: POINTER;
						  cbUpdate: LONGWORD): INTEGER; cdecl; forward

function CmLtCreateReceipt(hcmse: HCMSysEntry;
						  flCtrl: LONGWORD;
						  const CMLTREQUEST: POINTER;
						  pAcknowledge: POINTER;
						  cbAcknowledge: LONGWORD): INTEGER; cdecl; forward
					
function CmLtConfirmTransfer(hcmse: HCMSysEntry;
							flCtrl: LONGWORD;
							const pAcknowledge: POINTER;
							cbAcknowledge: LONGWORD): INTEGER; cdecl; forward					

function CmLtCleanup(hcmse: HCMSysEntry;
							flCtrl: LONGWORD): INTEGER; cdecl; forward		

function CmLtLiveTransfer(hcmseFrom: HCMSysEntry;
							hcmseTo: HCMSysEntry;
							flCtrl: LONGWORD;
							const CMLTTRANSFER: POINTER): INTEGER; cdecl; forward
	
	
(****************************
16.) CmGetContainerInfo
*****************************)

function CmGetContainerInfo(hcmse: HCMSysEntry;
							const pQuery: POINTER;
							cbQuery: LONGWORD;
							const pCachecontrol: POINTER;
							cbCacheControl: LONGWORD;
							pvDest: POINTER;
							cbDest: LONGWORD): INTEGER; cdecl; forward
	
(* 
Other stuff
*)
								
function CmSetVersion(  major: Byte;
                        minor: Byte;
                        build: Integer): LONGWORD;
function CmGetMajorVersion(version: LONGWORD): Byte;
function CmGetMinorVersion(version: LONGWORD): Byte;
function CmGetBuildVersion(version: LONGWORD): Integer;



implementation
function CmAccess;                               external LIB index 1;
function CmAccess2;                              external LIB index 100;
function CmRelease;                              external LIB index 76;
function CmCheckEvents;                          external LIB index 15;
function CmCrypt;                                external LIB index 28;
function CmCrypt2;                               external LIB index 126;
function CmCryptSim;                             external LIB index 32;
function CmCryptSim2;                            external LIB index 128;
function CmCalculatePioCoreKey;                  external LIB index 9;
function CmGetSecureData;                        external LIB index 64;
function CmGetPioDataKey;                        external LIB index 58;
function CmDecryptPioData;                       external LIB index 34;
function CmGetBoxContents;                       external LIB index 46;
function CmGetBoxContents2;                      external LIB index 130;
function CmGetBoxes;                             external LIB index 48;
function CmGetInfo;                              external LIB index 50;
function CmGetLicenseInfo;                       external LIB index 56;
function CmGetServers;                           external LIB index 66;
function CmGetVersion;                           external LIB index 70;
function CmGetLastErrorCode;                     external LIB index 52;
function CmGetLastErrorText;                     external LIB index 54;
function CmGetLastErrorText2;                    external LIB index 102;
procedure CmSetLastErrorCode;                    external LIB index 82;
function CmReserveFirmItem;                      external LIB index 78;
function CmCreateProductItemOption;              external LIB index 22;
function CmCreateSequence;                       external LIB index 24;
function CmProgram;                              external LIB index 74;
function CmValidateEntry;                        external LIB index 86;
function CmGetRemoteContext;                     external LIB index 62;
function CmGetRemoteContextBuffer;               external LIB index 108;
function CmGetRemoteContext2;                    external LIB index 106;
function CmListRemoteUpdateBuffer;               external LIB index 116;
function CmSetRemoteUpdate;                      external LIB index 84;
function CmSetRemoteUpdateBuffer;                external LIB index 112;
function CmSetRemoteUpdate2;                     external LIB index 110;
function CmListRemoteUpdate;                     external LIB index 72;
function CmListRemoteUpdate2;                    external LIB index 114;
function CmEnablingGetApplicationContext;        external LIB index 36;
function CmEnablingGetChallenge;                 external LIB index 38;
function CmEnablingSendResponse;                 external LIB index 40;
function CmSetCertifiedTimeUpdate;               external LIB index 80;
function CmCalculateDigest;                      external LIB index 7;
function CmCalculateSignature;                   external LIB index 11;
function CmGetPublicKey;                         external LIB index 60;
function CmValidateSignature;                    external LIB index 88;
function CmEnablingWriteApplicationKey;          external LIB index 44;
function CmCryptEcies;                           external LIB index 29;
function CmConvertString;                        external LIB index 122;
function CmActLicenseControl;                    external LIB index 140;
function CmBorrow;                               external LIB index 142;
function CmRevalidateBox;                        external LIB index 150;
function CmExecuteRemoteUpdate;                  external LIB index 124;
function CmSecureDiscRead;                       external LIB index 160;
function CmSecureDiscWrite;                      external LIB index 162;
function CmExtendedDiscControl;                  external LIB index 164;
function CmReadProfilingEntry;                   external LIB index 180;
function CmLtCreateContext;                      external LIB index 200;
function CmLtDoTransfer;                         external LIB index 202;
function CmLtImportUpdate;                       external LIB index 204;
function CmLtCreateReceipt;                      external LIB index 206;
function CmLtConfirmTransfer;                    external LIB index 208;					
function CmLtCleanup;                            external LIB index 210;		
function CmLtLiveTransfer;                       external LIB index 212;
function CmGetContainerInfo;                     external LIB index 218;
function CmConvertTime;                          external LIB index 224;


function CmSetVersion(  major: Byte;
                        minor: Byte;
                        build: Integer): LONGWORD;
begin
  CmSetVersion := ((major And $FF) ShL 24) Or ((minor And $FF) ShL 16) Or (build And $FFFF);
end;

function CmGetMajorVersion(version: LONGWORD): Byte;
begin
  CmGetMajorVersion := ( (version ShR 24) And $FF );
end;

function CmGetMinorVersion(version: LONGWORD): Byte;
begin
  CmGetMinorVersion := ( (version ShR 16) And $FF );
end;

function CmGetBuildVersion(version: LONGWORD): Integer;
begin
  CmGetBuildVersion := ( version And $FFFF );
end;


end.
