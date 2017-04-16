#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class MovierDCInterfaceSvc_ModuleHeader;
@class MovierDCInterfaceSvc_ModuleHeaderArray;
@class MovierDCInterfaceSvc_ModuleSegment;
@class MovierDCInterfaceSvc_ModuleSegmentArray;
@class MovierDCInterfaceSvc_VDCMusicHeader;
@class MovierDCInterfaceSvc_VDCMusicHeaderArr;
@class MovierDCInterfaceSvc_VDCMusicInfo;
@class MovierDCInterfaceSvc_VDCMusicInfoArr;
@class MovierDCInterfaceSvc_QueryCond;
@class MovierDCInterfaceSvc_ModuleStyle;
@class MovierDCInterfaceSvc_VDCModuleStyleArr;
@class MovierDCInterfaceSvc_TemplateCat;
@class MovierDCInterfaceSvc_VDCTemplateCatArr;
@class MovierDCInterfaceSvc_ModuleInfo;
@class MovierDCInterfaceSvc_VDCSession;
@class MovierDCInterfaceSvc_VDCOrderVideoMaterial;
@class MovierDCInterfaceSvc_VDCOrderMaterialArray;
@class MovierDCInterfaceSvc_VDCOrderVideoMaterialEx;
@class MovierDCInterfaceSvc_VDCOrderMaterialExArray;
@class MovierDCInterfaceSvc_VDCOrderForCreate;
@class MovierDCInterfaceSvc_VDCOrderForQuery;
@class MovierDCInterfaceSvc_VDCOrderForQueryArray;
@class MovierDCInterfaceSvc_VDCOrderForProcess;
@class MovierDCInterfaceSvc_VDCCustomerNotice;
@class MovierDCInterfaceSvc_VDCCustomerNoticeArray;
@class MovierDCInterfaceSvc_VDCPrivilegeInfo;
@class MovierDCInterfaceSvc_VDCPrivilegeInfoArray;
@class MovierDCInterfaceSvc_VDCOSSConfig;
@class MovierDCInterfaceSvc_VDCCustomerBaseInfo;
@class MovierDCInterfaceSvc_VDCCustomerInfo;
@class MovierDCInterfaceSvc_VDCCustomerInfoEx;
@class MovierDCInterfaceSvc_VDCThirdPartyAccount;
@class MovierDCInterfaceSvc_VDCThirdPartyAccountEx;
@class MovierDCInterfaceSvc_VDCThirdPartyAccountForWeChat;
@class MovierDCInterfaceSvc_VDCOrderIDArray;
@class MovierDCInterfaceSvc_VDCVideoLabel;
@class MovierDCInterfaceSvc_VDCVideoLabelArray;
@class MovierDCInterfaceSvc_VDCVideoLabelEx;
@class MovierDCInterfaceSvc_VDCVideoLabelExArray;
@class MovierDCInterfaceSvc_VDCVideoLabelEx2;
@class MovierDCInterfaceSvc_VDCVideoLabelEx2Array;
@class MovierDCInterfaceSvc_VDCBannerInfo;
@class MovierDCInterfaceSvc_VDCBannerInfoArray;
@class MovierDCInterfaceSvc_VDCBannerInfoEx;
@class MovierDCInterfaceSvc_VDCBannerInfoExArray;
@class MovierDCInterfaceSvc_VDCLabelForVideo;
@class MovierDCInterfaceSvc_VDCVideoInfo;
@class MovierDCInterfaceSvc_VDCVideoInfoArray;
@class MovierDCInterfaceSvc_VDCVideoInfoEx;
@class MovierDCInterfaceSvc_VDCVideoInfoExArray;
@class MovierDCInterfaceSvc_VDCFeedBack;
@class MovierDCInterfaceSvc_VDCCommentForCreate;
@class MovierDCInterfaceSvc_VDCCommentInfo;
@class MovierDCInterfaceSvc_VDCCommentInfoArray;
@class MovierDCInterfaceSvc_VDCCommentInfoArrayEnv;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTailC;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTailArray;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTailExC;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTailExArray;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTail;
@class MovierDCInterfaceSvc_vpVDCHeaderStyleC;
@class MovierDCInterfaceSvc_vpVDCHeaderStyleArray;
@class MovierDCInterfaceSvc_vpVDCFilterC;
@class MovierDCInterfaceSvc_vpVDCFilterArray;
@class MovierDCInterfaceSvc_vpVDCFilter;
@class MovierDCInterfaceSvc_vpVDCFilterStyleC;
@class MovierDCInterfaceSvc_vpVDCFilterStyleArray;
@class MovierDCInterfaceSvc_vpVDCSubtitleC;
@class MovierDCInterfaceSvc_vpVDCSubtitleArray;
@class MovierDCInterfaceSvc_vpVDCMusicC;
@class MovierDCInterfaceSvc_vpVDCMusicArray;
@class MovierDCInterfaceSvc_vpVDCMusic;
@class MovierDCInterfaceSvc_vpVDCMusicEx;
@class MovierDCInterfaceSvc_vpVDCMusicExEnv;
@class MovierDCInterfaceSvc_VDCMusic;
@class MovierDCInterfaceSvc_vpVDCMusicExArr;
@class MovierDCInterfaceSvc_vpQueryCond;
@class MovierDCInterfaceSvc_vpVDCOrderForCreate;
@class MovierDCInterfaceSvc_vpVDCOrderForCreateEx;
@class MovierDCInterfaceSvc_vpVDCOrderForProcess;
@class MovierDCInterfaceSvc_vpVDCOrderForProcessEnv;
@class MovierDCInterfaceSvc_vpVDCOrderForProcessEx;
@class MovierDCInterfaceSvc_IDArray;
@class MovierDCInterfaceSvc_AppVersion;
@class MovierDCInterfaceSvc_AppVersionEx;
@class MovierDCInterfaceSvc_AppVersionExArr;
@class MovierDCInterfaceSvc_vpVideoComment;
@class MovierDCInterfaceSvc_vpVideoCommentArr;
@class MovierDCInterfaceSvc_vpVideoCommentEx;
@class MovierDCInterfaceSvc_vpVideoCommentExArr;
@class MovierDCInterfaceSvc_VDCCustomerBaseInfoEx;
@class MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr;
@class MovierDCInterfaceSvc_VDCActivityInfo;
@class MovierDCInterfaceSvc_VDCActivityInfoArr;
@class MovierDCInterfaceSvc_StringArr;
@class MovierDCInterfaceSvc_VDCBeatInfo;
@class MovierDCInterfaceSvc_VDCBeatInfoArr;
@class MovierDCInterfaceSvc_VDCSpecialEffect;
@class MovierDCInterfaceSvc_VDCFriendInfo;
@class MovierDCInterfaceSvc_VDCFriendArr;
@class MovierDCInterfaceSvc_TelArr;
@class MovierDCInterfaceSvc_SearchRetForTelFriend;
@class MovierDCInterfaceSvc_SearchRetArr;
@class MovierDCInterfaceSvc_VDCNewUserScoreTask;
@class MovierDCInterfaceSvc_VDCMyScoreInshianCoin;
@class MovierDCInterfaceSvc_VDCMyScoreLog;
@class MovierDCInterfaceSvc_VDCMyScoreLogArr;
@class MovierDCInterfaceSvc_VDCDailyScoreTask;
@class MovierDCInterfaceSvc_VDCDailyScoreTaskArr;
@class MovierDCInterfaceSvc_VDCDeviceInfo;
@class MovierDCInterfaceSvc_VDCDeviceInfoEx;
@class MovierDCInterfaceSvc_VDCKeyValue;
@class MovierDCInterfaceSvc_VDCKeyValueArr;
@class MovierDCInterfaceSvc_VDCTopicsArr;
@class MovierDCInterfaceSvc_VDCVideoArr;
@class MovierDCInterfaceSvc_VDCIntArr;
@class MovierDCInterfaceSvc_VDCBannerArr;
@class MovierDCInterfaceSvc_VDCLabelArr;
@class MovierDCInterfaceSvc_VDCRecordArr;
@class MovierDCInterfaceSvc_getmodulelist;
@class MovierDCInterfaceSvc_ModuleHeaderArrayEnv;
@class MovierDCInterfaceSvc_gettotalmodulenum;
@class MovierDCInterfaceSvc_IntEnv;
@class MovierDCInterfaceSvc_getmodulelistex;
@class MovierDCInterfaceSvc_getmodulebyid;
@class MovierDCInterfaceSvc_ModuleInfoEnv;
@class MovierDCInterfaceSvc_getmodulebyname;
@class MovierDCInterfaceSvc_createmodule;
@class MovierDCInterfaceSvc_updatemodule;
@class MovierDCInterfaceSvc_querymodule;
@class MovierDCInterfaceSvc_getmodulebyorderid;
@class MovierDCInterfaceSvc_connectiontest;
@class MovierDCInterfaceSvc_registerusingemail;
@class MovierDCInterfaceSvc_registerusingtel;
@class MovierDCInterfaceSvc_registerusingthirdpartyaccount;
@class MovierDCInterfaceSvc_registerusingfullinfo;
@class MovierDCInterfaceSvc_login;
@class MovierDCInterfaceSvc_VDCSessionEnv;
@class MovierDCInterfaceSvc_loginex;
@class MovierDCInterfaceSvc_thirdpartylogin;
@class MovierDCInterfaceSvc_thirdpartygetsecret;
@class MovierDCInterfaceSvc_StringArrEnv;
@class MovierDCInterfaceSvc_getcustomerinfo;
@class MovierDCInterfaceSvc_VDCCustomerInfoEnv;
@class MovierDCInterfaceSvc_getcustomerinfoex;
@class MovierDCInterfaceSvc_getcustomerinfoex2;
@class MovierDCInterfaceSvc_VDCCustomerInfoExEnv;
@class MovierDCInterfaceSvc_updatecustomerinfo;
@class MovierDCInterfaceSvc_getossconfig;
@class MovierDCInterfaceSvc_VDCOSSConfigEnv;
@class MovierDCInterfaceSvc_getprivilegeinfo;
@class MovierDCInterfaceSvc_VDCPrivilegeInfoArrayEnv;
@class MovierDCInterfaceSvc_updateuserinfo;
@class MovierDCInterfaceSvc_activeuser;
@class MovierDCInterfaceSvc_logout;
@class MovierDCInterfaceSvc_getorder;
@class MovierDCInterfaceSvc_VDCOrderForProcessEnv;
@class MovierDCInterfaceSvc_vpgetorder;
@class MovierDCInterfaceSvc_vpVDCOrderForProcessExEnv;
@class MovierDCInterfaceSvc_ordercomplete;
@class MovierDCInterfaceSvc_orderprocessfail;
@class MovierDCInterfaceSvc_createorder;
@class MovierDCInterfaceSvc_vpcreateorder;
@class MovierDCInterfaceSvc_queryorderbyid;
@class MovierDCInterfaceSvc_VDCOrderForQueryEnv;
@class MovierDCInterfaceSvc_queryorders;
@class MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv;
@class MovierDCInterfaceSvc_queryordersbyidarr;
@class MovierDCInterfaceSvc_getordertotalnumbystatus;
@class MovierDCInterfaceSvc_queryordersbyorderstatus;
@class MovierDCInterfaceSvc_querynotice;
@class MovierDCInterfaceSvc_VDCCustomerNoticeArrayEnv;
@class MovierDCInterfaceSvc_querynoticebytype;
@class MovierDCInterfaceSvc_getmusicinfobyid;
@class MovierDCInterfaceSvc_VDCMusicInfoEnv;
@class MovierDCInterfaceSvc_getmusicinfobyname;
@class MovierDCInterfaceSvc_getmusicinfolist;
@class MovierDCInterfaceSvc_VDCMusicInfoArrEnv;
@class MovierDCInterfaceSvc_getvideolabeltotalnum;
@class MovierDCInterfaceSvc_getvideolabeltotalnumbyparentid;
@class MovierDCInterfaceSvc_getvideolabels;
@class MovierDCInterfaceSvc_VDCVideoLabelArrayEnv;
@class MovierDCInterfaceSvc_getvideolabelsbyparentid;
@class MovierDCInterfaceSvc_getvideolabelsex;
@class MovierDCInterfaceSvc_VDCVideoLabelEx2ArrayEnv;
@class MovierDCInterfaceSvc_getvideolabelsexbyparentid;
@class MovierDCInterfaceSvc_VDCVideoLabelExArrayEnv;
@class MovierDCInterfaceSvc_getvideototalbylabelid;
@class MovierDCInterfaceSvc_getvideototalbylabelname;
@class MovierDCInterfaceSvc_getvideobylabelid;
@class MovierDCInterfaceSvc_VDCVideoInfoArrayEnv;
@class MovierDCInterfaceSvc_getvideobylabelidex;
@class MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv;
@class MovierDCInterfaceSvc_getvideobylabelname;
@class MovierDCInterfaceSvc_praisevideobyid;
@class MovierDCInterfaceSvc_unpraisevideobyid;
@class MovierDCInterfaceSvc_increasevideoattr;
@class MovierDCInterfaceSvc_increasevideoattr4c;
@class MovierDCInterfaceSvc_praisevideobyname;
@class MovierDCInterfaceSvc_increasesharenumbyid;
@class MovierDCInterfaceSvc_increasesharenumbyname;
@class MovierDCInterfaceSvc_markfavoritebyid;
@class MovierDCInterfaceSvc_markfavoritebyname;
@class MovierDCInterfaceSvc_getfavoritevideototalnum;
@class MovierDCInterfaceSvc_getfavoritevideo;
@class MovierDCInterfaceSvc_getfavoritevideoex;
@class MovierDCInterfaceSvc_getmoduleallstyle;
@class MovierDCInterfaceSvc_VDCModuleStyleArrEnv;
@class MovierDCInterfaceSvc_getmoduletotalnumbystyle;
@class MovierDCInterfaceSvc_getmodulebystyle;
@class MovierDCInterfaceSvc_submitfeedback;
@class MovierDCInterfaceSvc_gettotalnumofvideoforhomepage;
@class MovierDCInterfaceSvc_getvideoforhomepage;
@class MovierDCInterfaceSvc_getvideoforhomepageex;
@class MovierDCInterfaceSvc_getvideobyorderidarr;
@class MovierDCInterfaceSvc_getvideobyorderidarrex;
@class MovierDCInterfaceSvc_getvideobyvideoidarr;
@class MovierDCInterfaceSvc_getvideobyvideoidarrex;
@class MovierDCInterfaceSvc_getosssignature;
@class MovierDCInterfaceSvc_VDCOSSSignatureEnv;
@class MovierDCInterfaceSvc_getvpelementtotalnum;
@class MovierDCInterfaceSvc_vpgetheaderstyletotalnum;
@class MovierDCInterfaceSvc_vpgetheaderstyle;
@class MovierDCInterfaceSvc_vpVDCHeaderStyleArrayEnv;
@class MovierDCInterfaceSvc_vpgettemplatecattotalnum;
@class MovierDCInterfaceSvc_vpgettemplatecat;
@class MovierDCInterfaceSvc_VDCTemplateCatArrEnv;
@class MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat;
@class MovierDCInterfaceSvc_vpgetheaderandtailbycat;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTailArrayEnv;
@class MovierDCInterfaceSvc_vpgetheaderandtail;
@class MovierDCInterfaceSvc_vpgetheaderandtailexbycat;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTailExArrayEnv;
@class MovierDCInterfaceSvc_vpgetheaderandtailex;
@class MovierDCInterfaceSvc_vpgetheaderandtailvisitcount;
@class MovierDCInterfaceSvc_vpincreaseheaderandtailvisitcount;
@class MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid;
@class MovierDCInterfaceSvc_vpVDCDefaultMusicAndSubtitleForStyle;
@class MovierDCInterfaceSvc_vpgetfilterstyletotalnum;
@class MovierDCInterfaceSvc_vpgetfilterstyle;
@class MovierDCInterfaceSvc_vpVDCFilterStyleArrayEnv;
@class MovierDCInterfaceSvc_vpgetfilter;
@class MovierDCInterfaceSvc_vpVDCFilterArrayEnv;
@class MovierDCInterfaceSvc_vpgetmusic;
@class MovierDCInterfaceSvc_vpVDCMusicArrayEnv;
@class MovierDCInterfaceSvc_vpgetsubtitle;
@class MovierDCInterfaceSvc_vpVDCSubtitleArrayEnv;
@class MovierDCInterfaceSvc_vpgetstylebyid;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTailEnv;
@class MovierDCInterfaceSvc_vpgetfilterbyid;
@class MovierDCInterfaceSvc_vpVDCFilterEnv;
@class MovierDCInterfaceSvc_vpgetmusicbyid;
@class MovierDCInterfaceSvc_vpVDCMusicEnv;
@class MovierDCInterfaceSvc_vpsearchonlinemusic;
@class MovierDCInterfaceSvc_vpVDCMusicExArrEnv;
@class MovierDCInterfaceSvc_vpgetsubtitlebyid;
@class MovierDCInterfaceSvc_vpVDCSubtitleEnv;
@class MovierDCInterfaceSvc_vpupdatevideosharestatus;
@class MovierDCInterfaceSvc_vpremovevideo;
@class MovierDCInterfaceSvc_vpgetfavouritestatus;
@class MovierDCInterfaceSvc_IDArrayEnv;
@class MovierDCInterfaceSvc_vpgetpraisestatus;
@class MovierDCInterfaceSvc_vpgetsubtitlemodelbyid;
@class MovierDCInterfaceSvc_StringEnv;
@class MovierDCInterfaceSvc_changepassword;
@class MovierDCInterfaceSvc_checktelnumusability;
@class MovierDCInterfaceSvc_checkemailusability;
@class MovierDCInterfaceSvc_resetpasswordusingtel;
@class MovierDCInterfaceSvc_resetpasswordusingemail;
@class MovierDCInterfaceSvc_getapplatestversion;
@class MovierDCInterfaceSvc_AppVersionEnv;
@class MovierDCInterfaceSvc_getappversion;
@class MovierDCInterfaceSvc_AppVersionExArrEnv;
@class MovierDCInterfaceSvc_userreport;
@class MovierDCInterfaceSvc_vpsubmitcomment;
@class MovierDCInterfaceSvc_vpgetcommenttotalnum;
@class MovierDCInterfaceSvc_vpgetcomment;
@class MovierDCInterfaceSvc_vpVideoCommentArrEnv;
@class MovierDCInterfaceSvc_vpgetcommentex;
@class MovierDCInterfaceSvc_vpVideoCommentExArrEnv;
@class MovierDCInterfaceSvc_vpremovecomment;
@class MovierDCInterfaceSvc_vpreportcomment;
@class MovierDCInterfaceSvc_createactivity;
@class MovierDCInterfaceSvc_removeactivity;
@class MovierDCInterfaceSvc_joinactivity;
@class MovierDCInterfaceSvc_quitactivity;
@class MovierDCInterfaceSvc_sendinvitebytelnum;
@class MovierDCInterfaceSvc_sendinvitebyemail;
@class MovierDCInterfaceSvc_removememberfromactivity;
@class MovierDCInterfaceSvc_changepassword4activity;
@class MovierDCInterfaceSvc_updatestoragecapacity;
@class MovierDCInterfaceSvc_getactivitymemberidlist;
@class MovierDCInterfaceSvc_getactivitymemberinfolist;
@class MovierDCInterfaceSvc_VDCCustomerBaseInfoExArrEnv;
@class MovierDCInterfaceSvc_getactivityinfo;
@class MovierDCInterfaceSvc_VDCActivityInfoEnv;
@class MovierDCInterfaceSvc_getactivitytotalnum;
@class MovierDCInterfaceSvc_getactivitylist;
@class MovierDCInterfaceSvc_VDCActivityInfoArrEnv;
@class MovierDCInterfaceSvc_reportactivity;
@class MovierDCInterfaceSvc_createorder4activity;
@class MovierDCInterfaceSvc_createfile4activity;
@class MovierDCInterfaceSvc_createfile4activityconfirm;
@class MovierDCInterfaceSvc_removefile4activity;
@class MovierDCInterfaceSvc_getactivitytotalnum4customer;
@class MovierDCInterfaceSvc_getactivitylist4customer;
@class MovierDCInterfaceSvc_updatecustomercapacity;
@class MovierDCInterfaceSvc_getcustomercapacity;
@class MovierDCInterfaceSvc_LONG64Env;
@class MovierDCInterfaceSvc_removevideofile;
@class MovierDCInterfaceSvc_searchuser;
@class MovierDCInterfaceSvc_searchvideo;
@class MovierDCInterfaceSvc_getbannertotalnum;
@class MovierDCInterfaceSvc_getbanner;
@class MovierDCInterfaceSvc_VDCBannerInfoArrayEnv;
@class MovierDCInterfaceSvc_getbannerex;
@class MovierDCInterfaceSvc_VDCBannerInfoExArrayEnv;
@class MovierDCInterfaceSvc_updatetelnum;
@class MovierDCInterfaceSvc_updatetelnumex;
@class MovierDCInterfaceSvc_vpcreateorderfollowexist;
@class MovierDCInterfaceSvc_vpcreateorderfollowexistex;
@class MovierDCInterfaceSvc_vpgettelnumsettingstatus;
@class MovierDCInterfaceSvc_registerusingthirdpartyaccountex;
@class MovierDCInterfaceSvc_registerusingthirdpartyaccount4wechat;
@class MovierDCInterfaceSvc_getpicbyheightandwidth;
@class MovierDCInterfaceSvc_getpicbyratioindex;
@class MovierDCInterfaceSvc_getcuponforgm;
@class MovierDCInterfaceSvc_getvideolabelexbylabelid;
@class MovierDCInterfaceSvc_VideoLabelExEnv;
@class MovierDCInterfaceSvc_getstylebyvideoid;
@class MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv;
@class MovierDCInterfaceSvc_getstylebylabelid;
@class MovierDCInterfaceSvc_getspecialeffectbyeffectsetid;
@class MovierDCInterfaceSvc_VDCSpecialEffectEnv;
@class MovierDCInterfaceSvc_getbeatinfoarrbybeatid;
@class MovierDCInterfaceSvc_VDCBeatInfoArrEnv;
@class MovierDCInterfaceSvc_getcategoryfortemplate;
@class MovierDCInterfaceSvc_share;
@class MovierDCInterfaceSvc_shareex;
@class MovierDCInterfaceSvc_updatethirdpartyaccount;
@class MovierDCInterfaceSvc_getnewuserscoretask;
@class MovierDCInterfaceSvc_VDCNewUserScoreTaskEnv;
@class MovierDCInterfaceSvc_gettelandthirdpartybindstatus;
@class MovierDCInterfaceSvc_VDCTelAndThirdPartyBindStatusEnv;
@class MovierDCInterfaceSvc_getmyscoreinshiancoin;
@class MovierDCInterfaceSvc_VDCMyScoreInshianCoinEnv;
@class MovierDCInterfaceSvc_getscorelog;
@class MovierDCInterfaceSvc_VDCMyScoreLogArrEnv;
@class MovierDCInterfaceSvc_getdailyscoretask;
@class MovierDCInterfaceSvc_VDCDailyScoreTaskArrEnv;
@class MovierDCInterfaceSvc_operatedevicelist;
@class MovierDCInterfaceSvc_sendprivatemessage;
@class MovierDCInterfaceSvc_systemnotice;
@class MovierDCInterfaceSvc_messagepushonoff;
@class MovierDCInterfaceSvc_follow;
@class MovierDCInterfaceSvc_unfollow;
@class MovierDCInterfaceSvc_getfollowlist;
@class MovierDCInterfaceSvc_VDCFriendArrEnv;
@class MovierDCInterfaceSvc_getfunslist;
@class MovierDCInterfaceSvc_getfriendlist;
@class MovierDCInterfaceSvc_getfriendamount;
@class MovierDCInterfaceSvc_getfriendrelation;
@class MovierDCInterfaceSvc_searchfriend;
@class MovierDCInterfaceSvc_searchtelfriend;
@class MovierDCInterfaceSvc_SearchRetArrEnv;
@class MovierDCInterfaceSvc_gethomepagebackground;
@class MovierDCInterfaceSvc_VDCHomePageBackgroundEnv;
@class MovierDCInterfaceSvc_checksession;
@class MovierDCInterfaceSvc_setvideoinfo;
@class MovierDCInterfaceSvc_getvideoinfo;
@class MovierDCInterfaceSvc_VDCKeyValueArrEnv;
@class MovierDCInterfaceSvc_getvideosbyuserid;
@class MovierDCInterfaceSvc_VDCVideoArrEnv;
@class MovierDCInterfaceSvc_addtopicsforvideo;
@class MovierDCInterfaceSvc_removetopicsforvideo;
@class MovierDCInterfaceSvc_gettopicsbyvideoid;
@class MovierDCInterfaceSvc_VDCTopicsArrEnv;
@class MovierDCInterfaceSvc_gettopicsbyparenttopic;
@class MovierDCInterfaceSvc_getvideosbytopicid;
@class MovierDCInterfaceSvc_releasevideo;
@class MovierDCInterfaceSvc_unreleasevideo;
@class MovierDCInterfaceSvc_atfriendbycustomeridarr;
@class MovierDCInterfaceSvc_searchtopics;
@class MovierDCInterfaceSvc_getuserinfo;
@class MovierDCInterfaceSvc_setuserinfo;
@class MovierDCInterfaceSvc_getbannerlist;
@class MovierDCInterfaceSvc_VDCBannerArrEnv;
@class MovierDCInterfaceSvc_getcollectvideos;
@class MovierDCInterfaceSvc_getlabelsbyparentid;
@class MovierDCInterfaceSvc_VDCLabelArrEnv;
@class MovierDCInterfaceSvc_getchallengetaskpraise;
@class MovierDCInterfaceSvc_VDCRecordArrEnv;
@class MovierDCInterfaceSvc_getchallengetaskview;
@class MovierDCInterfaceSvc_getorderbyid;
@class MovierDCInterfaceSvc_getvideoamountbyheaderandtailanddate;
@class MovierDCInterfaceSvc_getshareamountbylabelid;
@class MovierDCInterfaceSvc_getshareamountbyheaderandtailanddate;
@class MovierDCInterfaceSvc_telregister;
@class MovierDCInterfaceSvc_thirdpartyregister;
@class MovierDCInterfaceSvc_loginbyusername;
@class MovierDCInterfaceSvc_loginbythirdparty;
@class MovierDCInterfaceSvc_getvideosbylabelid;
@class MovierDCInterfaceSvc_getvideosbyvideoidarr;
@class MovierDCInterfaceSvc_searchvideosbykey;
@class MovierDCInterfaceSvc_getmusicbyid;
@class MovierDCInterfaceSvc_VDCMusicEnv;
@class MovierDCInterfaceSvc_getcommentsbyvideoid;
@class MovierDCInterfaceSvc_gettemplateidbyvideoid;
@class MovierDCInterfaceSvc_loginbyaccount;
@class MovierDCInterfaceSvc_qqregister;
@class MovierDCInterfaceSvc_weiboregister;
@class MovierDCInterfaceSvc_wechatregister;
@class MovierDCInterfaceSvc_getaccountbindstatus;
@class MovierDCInterfaceSvc_bindaccount;
@class MovierDCInterfaceSvc_getorderbytemplateid;
@class MovierDCInterfaceSvc_test1;
@class MovierDCInterfaceSvc_test2;
@class MovierDCInterfaceSvc_test3;
@class MovierDCInterfaceSvc_VDCKeyValueEnv;
@class MovierDCInterfaceSvc_gmlbs;
@class MovierDCInterfaceSvc_gmgetar;
@class MovierDCInterfaceSvc_gmcreateorderfollowexist;
@class MovierDCInterfaceSvc_gmcreateorder;
@class MovierDCInterfaceSvc_gmshare;
@class MovierDCInterfaceSvc_gmopenchest;
@class MovierDCInterfaceSvc_gmgetrealtimeawardinfo;
@class MovierDCInterfaceSvc_gmgetchest;
@class MovierDCInterfaceSvc_gmcardcompound;
@class MovierDCInterfaceSvc_gmgetvirtualcardbyuserid;
@class MovierDCInterfaceSvc_gmgetawardbyuserid;
@class MovierDCInterfaceSvc_gmgettokenamount;
@class MovierDCInterfaceSvc_gmgettokenexchangerule;
@class MovierDCInterfaceSvc_gmtokenexchange;
@class MovierDCInterfaceSvc_gettemplateavailable;
@class MovierDCInterfaceSvc_bcinsertuservideo;
@class MovierDCInterfaceSvc_getvideoidbyorderid;
@class MovierDCInterfaceSvc_getarawardnewyear;
@class MovierDCInterfaceSvc_addarawardnewyearreceiverinfo;
@interface MovierDCInterfaceSvc_ModuleHeader : NSObject {
	
/* elements */
	NSNumber * nModuleID;
	NSString * szModuleName;
	NSString * szModuleThumbnail;
	NSString * szModuleReference;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ModuleHeader *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nModuleID;
@property (retain) NSString * szModuleName;
@property (retain) NSString * szModuleThumbnail;
@property (retain) NSString * szModuleReference;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_ModuleHeaderArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ModuleHeaderArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_ModuleHeader *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_ModuleSegment : NSObject {
	
/* elements */
	NSNumber * nSegmentID;
	NSNumber * nModuleID;
	NSNumber * nOrder;
	NSNumber * nSegmentLength;
	NSNumber * nTransferID;
	NSNumber * nStart;
	NSNumber * nEnd;
	NSNumber * nFilterGroupID;
	NSString * szSubtitle;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ModuleSegment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nSegmentID;
@property (retain) NSNumber * nModuleID;
@property (retain) NSNumber * nOrder;
@property (retain) NSNumber * nSegmentLength;
@property (retain) NSNumber * nTransferID;
@property (retain) NSNumber * nStart;
@property (retain) NSNumber * nEnd;
@property (retain) NSNumber * nFilterGroupID;
@property (retain) NSString * szSubtitle;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_ModuleSegmentArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ModuleSegmentArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_ModuleSegment *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMusicHeader : NSObject {
	
/* elements */
	NSNumber * nMusicID;
	NSString * szMusicName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMusicHeader *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nMusicID;
@property (retain) NSString * szMusicName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMusicHeaderArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMusicHeaderArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCMusicHeader *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMusicInfo : NSObject {
	
/* elements */
	NSNumber * nMusicID;
	NSString * szMusicName;
	NSString * szMusicUrl;
	NSString * szThumbnailUrl;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMusicInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nMusicID;
@property (retain) NSString * szMusicName;
@property (retain) NSString * szMusicUrl;
@property (retain) NSString * szThumbnailUrl;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMusicInfoArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMusicInfoArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCMusicInfo *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_QueryCond : NSObject {
	
/* elements */
	NSString * szStyle;
	NSString * szModuleName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_QueryCond *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szStyle;
@property (retain) NSString * szModuleName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_ModuleStyle : NSObject {
	
/* elements */
	NSNumber * nStyleID;
	NSString * szStyleName;
	NSString * szThumbnail;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ModuleStyle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nStyleID;
@property (retain) NSString * szStyleName;
@property (retain) NSString * szThumbnail;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCModuleStyleArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCModuleStyleArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_ModuleStyle *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_TemplateCat : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szName;
	NSString * szThumbnail;
	NSString * szDesc;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_TemplateCat *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szName;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szDesc;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCTemplateCatArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCTemplateCatArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_TemplateCat *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_ModuleInfo : NSObject {
	
/* elements */
	NSNumber * nModuleID;
	NSString * szModuleName;
	NSString * szModuleStyle;
	NSNumber * nModuleType;
	NSNumber * nModuleLength;
	NSString * szModuleDec;
	NSNumber * nModuleHotIndex;
	NSString * szModuleThumbnail;
	NSNumber * nHeaderLen;
	NSNumber * nTailLen;
	NSNumber * nWidth;
	NSNumber * nHeight;
	NSNumber * nModuleFilterGroupID;
	NSNumber * nFrameRate;
	NSNumber * nShotMode;
	NSString * szModuleSubtitle;
	NSNumber * nSegNum;
	NSNumber * nBGmusicMode;
	NSNumber * nMinLength;
	NSString * szReference;
	NSString * szResUrl;
	MovierDCInterfaceSvc_ModuleSegmentArray * stSegArr;
	MovierDCInterfaceSvc_VDCMusicHeaderArr * stMusicArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ModuleInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nModuleID;
@property (retain) NSString * szModuleName;
@property (retain) NSString * szModuleStyle;
@property (retain) NSNumber * nModuleType;
@property (retain) NSNumber * nModuleLength;
@property (retain) NSString * szModuleDec;
@property (retain) NSNumber * nModuleHotIndex;
@property (retain) NSString * szModuleThumbnail;
@property (retain) NSNumber * nHeaderLen;
@property (retain) NSNumber * nTailLen;
@property (retain) NSNumber * nWidth;
@property (retain) NSNumber * nHeight;
@property (retain) NSNumber * nModuleFilterGroupID;
@property (retain) NSNumber * nFrameRate;
@property (retain) NSNumber * nShotMode;
@property (retain) NSString * szModuleSubtitle;
@property (retain) NSNumber * nSegNum;
@property (retain) NSNumber * nBGmusicMode;
@property (retain) NSNumber * nMinLength;
@property (retain) NSString * szReference;
@property (retain) NSString * szResUrl;
@property (retain) MovierDCInterfaceSvc_ModuleSegmentArray * stSegArr;
@property (retain) MovierDCInterfaceSvc_VDCMusicHeaderArr * stMusicArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCSession : NSObject {
	
/* elements */
	NSNumber * nSessionID;
	NSNumber * nCustomerID;
	NSString * szKey;
	NSString * szBucketName;
	NSString * szRootDir;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCSession *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nSessionID;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSString * szKey;
@property (retain) NSString * szBucketName;
@property (retain) NSString * szRootDir;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderVideoMaterial : NSObject {
	
/* elements */
	NSNumber * nOrderVideoMaterialID;
	NSString * szUrl;
	NSNumber * nIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderVideoMaterial *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nOrderVideoMaterialID;
@property (retain) NSString * szUrl;
@property (retain) NSNumber * nIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderMaterialArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderMaterialArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCOrderVideoMaterial *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderVideoMaterialEx : NSObject {
	
/* elements */
	NSNumber * nOrderVideoMaterialID;
	NSString * szUrl;
	NSNumber * nIndex;
	NSNumber * nStartPos;
	NSNumber * nEndPos;
	NSNumber * nOriginalVoice;
	NSNumber * nAngle;
	NSString * szSubtitle;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderVideoMaterialEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nOrderVideoMaterialID;
@property (retain) NSString * szUrl;
@property (retain) NSNumber * nIndex;
@property (retain) NSNumber * nStartPos;
@property (retain) NSNumber * nEndPos;
@property (retain) NSNumber * nOriginalVoice;
@property (retain) NSNumber * nAngle;
@property (retain) NSString * szSubtitle;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderMaterialExArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderMaterialExArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCOrderVideoMaterialEx *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderForCreate : NSObject {
	
/* elements */
	NSNumber * nModuleID;
	NSNumber * nVideoLength;
	NSNumber * nMusicType;
	NSNumber * nMusicID;
	NSString * szMusicURL;
	NSNumber * nMusicStart;
	NSNumber * nMusicEnd;
	NSString * szSubtitleURL;
	NSString * szVideoName;
	NSNumber * nVideoLabel;
	NSNumber * nShareType;
	MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderForCreate *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nModuleID;
@property (retain) NSNumber * nVideoLength;
@property (retain) NSNumber * nMusicType;
@property (retain) NSNumber * nMusicID;
@property (retain) NSString * szMusicURL;
@property (retain) NSNumber * nMusicStart;
@property (retain) NSNumber * nMusicEnd;
@property (retain) NSString * szSubtitleURL;
@property (retain) NSString * szVideoName;
@property (retain) NSNumber * nVideoLabel;
@property (retain) NSNumber * nShareType;
@property (retain) MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderForQuery : NSObject {
	
/* elements */
	NSNumber * nOrderID;
	NSNumber * nOrderStatus;
	NSString * szTime;
	NSString * szThumbnail;
	NSString * szURL;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderForQuery *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nOrderID;
@property (retain) NSNumber * nOrderStatus;
@property (retain) NSString * szTime;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szURL;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderForQueryArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderForQueryArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCOrderForQuery *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderForProcess : NSObject {
	
/* elements */
	NSNumber * nOrderID;
	NSNumber * nCustomerID;
	NSNumber * nModuleID;
	NSNumber * nVideoLength;
	NSNumber * nMusicType;
	NSNumber * nMusicID;
	NSString * szMusicURL;
	NSNumber * nMusicStart;
	NSNumber * nMusicEnd;
	NSString * szSubtitleURL;
	NSString * szDestURL;
	NSString * szThumbnail;
	NSString * szCustomerName;
	MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderForProcess *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nOrderID;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nModuleID;
@property (retain) NSNumber * nVideoLength;
@property (retain) NSNumber * nMusicType;
@property (retain) NSNumber * nMusicID;
@property (retain) NSString * szMusicURL;
@property (retain) NSNumber * nMusicStart;
@property (retain) NSNumber * nMusicEnd;
@property (retain) NSString * szSubtitleURL;
@property (retain) NSString * szDestURL;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szCustomerName;
@property (retain) MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerNotice : NSObject {
	
/* elements */
	NSNumber * nNoticeID;
	NSNumber * nCustomerID;
	NSNumber * nFresh;
	NSNumber * nNoticeType;
	NSString * szNoticeContent;
	NSString * szNoticeTime;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerNotice *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nNoticeID;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nFresh;
@property (retain) NSNumber * nNoticeType;
@property (retain) NSString * szNoticeContent;
@property (retain) NSString * szNoticeTime;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerNoticeArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerNoticeArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCCustomerNotice *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCPrivilegeInfo : NSObject {
	
/* elements */
	NSNumber * nPrivilegeID;
	NSNumber * nLevel;
	NSNumber * nMaxStorageSpace;
	NSNumber * nMinScore;
	NSNumber * nMaxScore;
	NSNumber * nMaxFileNum;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCPrivilegeInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nPrivilegeID;
@property (retain) NSNumber * nLevel;
@property (retain) NSNumber * nMaxStorageSpace;
@property (retain) NSNumber * nMinScore;
@property (retain) NSNumber * nMaxScore;
@property (retain) NSNumber * nMaxFileNum;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCPrivilegeInfoArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCPrivilegeInfoArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCPrivilegeInfo *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOSSConfig : NSObject {
	
/* elements */
	NSString * szID;
	NSString * szKey;
	NSString * szBucket;
	NSString * szEndpoint;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOSSConfig *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szID;
@property (retain) NSString * szKey;
@property (retain) NSString * szBucket;
@property (retain) NSString * szEndpoint;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerBaseInfo : NSObject {
	
/* elements */
	NSNumber * nGender;
	NSString * szLocationProvince;
	NSString * szLocationCity;
	NSString * szNickname;
	NSString * szSignature;
	NSString * szAcatar;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerBaseInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nGender;
@property (retain) NSString * szLocationProvince;
@property (retain) NSString * szLocationCity;
@property (retain) NSString * szNickname;
@property (retain) NSString * szSignature;
@property (retain) NSString * szAcatar;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerInfo : NSObject {
	
/* elements */
	NSNumber * nCustomerID;
	NSString * szCustomerName;
	NSNumber * nGender;
	NSNumber * nBirthdayY;
	NSNumber * nBirthdayM;
	NSNumber * nBirthdayD;
	NSString * szLocationProvince;
	NSString * szLocationCity;
	NSString * szTel;
	NSString * szEmail;
	NSString * szQQ;
	NSNumber * nPrivilege;
	NSNumber * nScore;
	NSNumber * nStatus;
	NSString * szRootDir;
	NSString * szBucketName;
	NSString * szPassword;
	NSString * szNickname;
	NSString * szSignature;
	NSString * szAcatar;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCustomerID;
@property (retain) NSString * szCustomerName;
@property (retain) NSNumber * nGender;
@property (retain) NSNumber * nBirthdayY;
@property (retain) NSNumber * nBirthdayM;
@property (retain) NSNumber * nBirthdayD;
@property (retain) NSString * szLocationProvince;
@property (retain) NSString * szLocationCity;
@property (retain) NSString * szTel;
@property (retain) NSString * szEmail;
@property (retain) NSString * szQQ;
@property (retain) NSNumber * nPrivilege;
@property (retain) NSNumber * nScore;
@property (retain) NSNumber * nStatus;
@property (retain) NSString * szRootDir;
@property (retain) NSString * szBucketName;
@property (retain) NSString * szPassword;
@property (retain) NSString * szNickname;
@property (retain) NSString * szSignature;
@property (retain) NSString * szAcatar;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerInfoEx : NSObject {
	
/* elements */
	NSNumber * nCustomerID;
	NSString * szCustomerName;
	NSNumber * nGender;
	NSNumber * nBirthdayY;
	NSNumber * nBirthdayM;
	NSNumber * nBirthdayD;
	NSString * szLocationProvince;
	NSString * szLocationCity;
	NSString * szTel;
	NSString * szEmail;
	NSString * szQQ;
	NSNumber * nPrivilege;
	NSNumber * nScore;
	NSNumber * nInshianCoin;
	NSNumber * nStatus;
	NSNumber * nScoreStatus;
	NSString * szRootDir;
	NSString * szBucketName;
	NSString * szPassword;
	NSString * szNickname;
	NSString * szSignature;
	NSString * szAvatar;
	NSString * szRegisterTime;
	NSString * szThirdPartyAccount;
	NSString * szThirdPartyAccountAlias;
	NSNumber * nThirdPartyType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerInfoEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCustomerID;
@property (retain) NSString * szCustomerName;
@property (retain) NSNumber * nGender;
@property (retain) NSNumber * nBirthdayY;
@property (retain) NSNumber * nBirthdayM;
@property (retain) NSNumber * nBirthdayD;
@property (retain) NSString * szLocationProvince;
@property (retain) NSString * szLocationCity;
@property (retain) NSString * szTel;
@property (retain) NSString * szEmail;
@property (retain) NSString * szQQ;
@property (retain) NSNumber * nPrivilege;
@property (retain) NSNumber * nScore;
@property (retain) NSNumber * nInshianCoin;
@property (retain) NSNumber * nStatus;
@property (retain) NSNumber * nScoreStatus;
@property (retain) NSString * szRootDir;
@property (retain) NSString * szBucketName;
@property (retain) NSString * szPassword;
@property (retain) NSString * szNickname;
@property (retain) NSString * szSignature;
@property (retain) NSString * szAvatar;
@property (retain) NSString * szRegisterTime;
@property (retain) NSString * szThirdPartyAccount;
@property (retain) NSString * szThirdPartyAccountAlias;
@property (retain) NSNumber * nThirdPartyType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCThirdPartyAccount : NSObject {
	
/* elements */
	NSString * szAccount;
	NSString * szPwd;
	NSNumber * nGender;
	NSString * szLocationProvince;
	NSString * szLocationCity;
	NSString * szNickName;
	NSString * szSignature;
	NSString * szAcatar;
	NSNumber * nThirdPartyType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCThirdPartyAccount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szAccount;
@property (retain) NSString * szPwd;
@property (retain) NSNumber * nGender;
@property (retain) NSString * szLocationProvince;
@property (retain) NSString * szLocationCity;
@property (retain) NSString * szNickName;
@property (retain) NSString * szSignature;
@property (retain) NSString * szAcatar;
@property (retain) NSNumber * nThirdPartyType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCThirdPartyAccountEx : NSObject {
	
/* elements */
	NSString * szAccount;
	NSString * szPwd;
	NSNumber * nGender;
	NSString * szLocationProvince;
	NSString * szLocationCity;
	NSString * szNickName;
	NSString * szSignature;
	NSString * szAcatar;
	NSString * szTelNum;
	NSString * szEmail;
	NSNumber * nThirdPartyType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCThirdPartyAccountEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szAccount;
@property (retain) NSString * szPwd;
@property (retain) NSNumber * nGender;
@property (retain) NSString * szLocationProvince;
@property (retain) NSString * szLocationCity;
@property (retain) NSString * szNickName;
@property (retain) NSString * szSignature;
@property (retain) NSString * szAcatar;
@property (retain) NSString * szTelNum;
@property (retain) NSString * szEmail;
@property (retain) NSNumber * nThirdPartyType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCThirdPartyAccountForWeChat : NSObject {
	
/* elements */
	NSString * szAccount;
	NSString * szAccountAlias;
	NSString * szPwd;
	NSNumber * nGender;
	NSString * szLocationProvince;
	NSString * szLocationCity;
	NSString * szNickName;
	NSString * szSignature;
	NSString * szAcatar;
	NSString * szTelNum;
	NSString * szEmail;
	NSNumber * nThirdPartyType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCThirdPartyAccountForWeChat *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szAccount;
@property (retain) NSString * szAccountAlias;
@property (retain) NSString * szPwd;
@property (retain) NSNumber * nGender;
@property (retain) NSString * szLocationProvince;
@property (retain) NSString * szLocationCity;
@property (retain) NSString * szNickName;
@property (retain) NSString * szSignature;
@property (retain) NSString * szAcatar;
@property (retain) NSString * szTelNum;
@property (retain) NSString * szEmail;
@property (retain) NSNumber * nThirdPartyType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderIDArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderIDArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(NSNumber *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabel : NSObject {
	
/* elements */
	NSNumber * nLabelID;
	NSString * szLabelName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabel *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nLabelID;
@property (retain) NSString * szLabelName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabelArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabelArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCVideoLabel *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabelEx : NSObject {
	
/* elements */
	NSNumber * nLabelID;
	NSString * szLabelName;
	NSNumber * nParentID;
	NSString * szThumbnail;
	NSNumber * nType;
	NSNumber * nVideoNum;
	NSString * szDescribe;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabelEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nLabelID;
@property (retain) NSString * szLabelName;
@property (retain) NSNumber * nParentID;
@property (retain) NSString * szThumbnail;
@property (retain) NSNumber * nType;
@property (retain) NSNumber * nVideoNum;
@property (retain) NSString * szDescribe;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabelExArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabelExArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCVideoLabelEx *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabelEx2 : NSObject {
	
/* elements */
	NSNumber * nLabelID;
	NSString * szLabelName;
	NSNumber * nParentID;
	NSString * szActivityStatus;
	NSString * szThumbnail;
	NSNumber * nType;
	NSString * szDescribe;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabelEx2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nLabelID;
@property (retain) NSString * szLabelName;
@property (retain) NSNumber * nParentID;
@property (retain) NSString * szActivityStatus;
@property (retain) NSString * szThumbnail;
@property (retain) NSNumber * nType;
@property (retain) NSString * szDescribe;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabelEx2Array : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabelEx2Array *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCVideoLabelEx2 *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBannerInfo : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szThumbnail;
	NSNumber * nType;
	NSNumber * nPara1;
	NSNumber * nPara2;
	NSString * szPara3;
	NSNumber * nLabelID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBannerInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szThumbnail;
@property (retain) NSNumber * nType;
@property (retain) NSNumber * nPara1;
@property (retain) NSNumber * nPara2;
@property (retain) NSString * szPara3;
@property (retain) NSNumber * nLabelID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBannerInfoArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBannerInfoArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCBannerInfo *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBannerInfoEx : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szThumbnail;
	NSNumber * nType;
	NSNumber * nPara1;
	NSNumber * nPara2;
	NSString * szPara3;
	MovierDCInterfaceSvc_VDCVideoLabelEx * stVideoLabelEx;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBannerInfoEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szThumbnail;
@property (retain) NSNumber * nType;
@property (retain) NSNumber * nPara1;
@property (retain) NSNumber * nPara2;
@property (retain) NSString * szPara3;
@property (retain) MovierDCInterfaceSvc_VDCVideoLabelEx * stVideoLabelEx;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBannerInfoExArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBannerInfoExArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCBannerInfoEx *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCLabelForVideo : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCLabelForVideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(NSNumber *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoInfo : NSObject {
	
/* elements */
	NSNumber * nVideoID;
	NSString * szVideoName;
	NSNumber * nOwnerID;
	NSString * szOwnerName;
	NSString * szAcatar;
	NSString * szVideoLabel;
	NSString * szCreateTime;
	NSString * szThumbnail;
	NSString * szReference;
	NSString * szSignature;
	NSNumber * nPraise;
	NSNumber * nShareNum;
	NSNumber * nFavoritesNum;
	NSNumber * nCommentsNum;
	NSNumber * nVideoStatus;
	NSNumber * nVideoShare;
	MovierDCInterfaceSvc_VDCLabelForVideo * stLabels;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoID;
@property (retain) NSString * szVideoName;
@property (retain) NSNumber * nOwnerID;
@property (retain) NSString * szOwnerName;
@property (retain) NSString * szAcatar;
@property (retain) NSString * szVideoLabel;
@property (retain) NSString * szCreateTime;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szReference;
@property (retain) NSString * szSignature;
@property (retain) NSNumber * nPraise;
@property (retain) NSNumber * nShareNum;
@property (retain) NSNumber * nFavoritesNum;
@property (retain) NSNumber * nCommentsNum;
@property (retain) NSNumber * nVideoStatus;
@property (retain) NSNumber * nVideoShare;
@property (retain) MovierDCInterfaceSvc_VDCLabelForVideo * stLabels;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoInfoArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoInfoArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCVideoInfo *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoInfoEx : NSObject {
	
/* elements */
	NSNumber * nVideoID;
	NSString * szVideoName;
	NSNumber * nOwnerID;
	NSString * szOwnerName;
	NSString * szAcatar;
	NSString * szVideoLabel;
	NSString * szCreateTime;
	NSString * szThumbnail;
	NSString * szReference;
	NSString * szSignature;
	NSNumber * nPraise;
	NSNumber * nShareNum;
	NSNumber * nFavoritesNum;
	NSNumber * nCommentsNum;
	NSNumber * nVideoStatus;
	NSNumber * nVideoShare;
	NSNumber * nVisitCount;
	MovierDCInterfaceSvc_VDCLabelForVideo * stLabels;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoInfoEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoID;
@property (retain) NSString * szVideoName;
@property (retain) NSNumber * nOwnerID;
@property (retain) NSString * szOwnerName;
@property (retain) NSString * szAcatar;
@property (retain) NSString * szVideoLabel;
@property (retain) NSString * szCreateTime;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szReference;
@property (retain) NSString * szSignature;
@property (retain) NSNumber * nPraise;
@property (retain) NSNumber * nShareNum;
@property (retain) NSNumber * nFavoritesNum;
@property (retain) NSNumber * nCommentsNum;
@property (retain) NSNumber * nVideoStatus;
@property (retain) NSNumber * nVideoShare;
@property (retain) NSNumber * nVisitCount;
@property (retain) MovierDCInterfaceSvc_VDCLabelForVideo * stLabels;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoInfoExArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoInfoExArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCVideoInfoEx *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCFeedBack : NSObject {
	
/* elements */
	NSNumber * nContactType;
	NSString * szContact;
	NSString * szContent;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCFeedBack *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nContactType;
@property (retain) NSString * szContact;
@property (retain) NSString * szContent;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCommentForCreate : NSObject {
	
/* elements */
	NSNumber * nVideoID;
	NSNumber * nReplyComment;
	NSString * szComment;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCommentForCreate *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nReplyComment;
@property (retain) NSString * szComment;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCommentInfo : NSObject {
	
/* elements */
	NSNumber * nCommentID;
	NSNumber * nCustomerID;
	NSNumber * nReplyComment;
	NSString * szCustomerName;
	NSString * szAvatar;
	NSString * szContent;
	NSString * szTime;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCommentInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCommentID;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nReplyComment;
@property (retain) NSString * szCustomerName;
@property (retain) NSString * szAvatar;
@property (retain) NSString * szContent;
@property (retain) NSString * szTime;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCommentInfoArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCommentInfoArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCCommentInfo *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCommentInfoArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCCommentInfoArray * stVDCCommentInfoArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCommentInfoArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCCommentInfoArray * stVDCCommentInfoArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTailC : NSObject {
	
/* elements */
	NSNumber * nID;
	NSNumber * nHeaderAndTailStyle;
	NSString * szName;
	NSString * szThumbnail;
	NSString * szReference;
	NSString * szCreateTime;
	NSString * szDesc;
	NSNumber * nHotIndex;
	NSString * szFit;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTailC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSNumber * nHeaderAndTailStyle;
@property (retain) NSString * szName;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szReference;
@property (retain) NSString * szCreateTime;
@property (retain) NSString * szDesc;
@property (retain) NSNumber * nHotIndex;
@property (retain) NSString * szFit;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTailArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTailArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVDCHeaderAndTailC *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTailExC : NSObject {
	
/* elements */
	NSNumber * nID;
	NSNumber * nHeaderAndTailStyle;
	NSString * szName;
	NSString * szThumbnail;
	NSString * szReference;
	NSString * szCreateTime;
	NSString * szDesc;
	NSNumber * nHotIndex;
	NSString * szFit;
	NSNumber * nDefaultMusic;
	NSNumber * nDefaultSubtitle;
	NSNumber * nVisitCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSNumber * nHeaderAndTailStyle;
@property (retain) NSString * szName;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szReference;
@property (retain) NSString * szCreateTime;
@property (retain) NSString * szDesc;
@property (retain) NSNumber * nHotIndex;
@property (retain) NSString * szFit;
@property (retain) NSNumber * nDefaultMusic;
@property (retain) NSNumber * nDefaultSubtitle;
@property (retain) NSNumber * nVisitCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTailExArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTailExArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTail : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szResUrl;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szResUrl;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderStyleC : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szName;
	NSString * szDesc;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderStyleC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szName;
@property (retain) NSString * szDesc;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderStyleArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderStyleArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVDCHeaderStyleC *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCFilterC : NSObject {
	
/* elements */
	NSNumber * nID;
	NSNumber * nFilterStyle;
	NSString * szName;
	NSString * szThumbnail;
	NSString * szReference;
	NSString * szCreateTime;
	NSString * szDesc;
	NSNumber * nHotIndex;
	NSNumber * nWidth;
	NSNumber * nHeight;
	NSNumber * nRecommendLen;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCFilterC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSNumber * nFilterStyle;
@property (retain) NSString * szName;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szReference;
@property (retain) NSString * szCreateTime;
@property (retain) NSString * szDesc;
@property (retain) NSNumber * nHotIndex;
@property (retain) NSNumber * nWidth;
@property (retain) NSNumber * nHeight;
@property (retain) NSNumber * nRecommendLen;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCFilterArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCFilterArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVDCFilterC *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCFilter : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szResUrl;
	NSNumber * nBeatID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCFilter *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szResUrl;
@property (retain) NSNumber * nBeatID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCFilterStyleC : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szName;
	NSString * szDesc;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCFilterStyleC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szName;
@property (retain) NSString * szDesc;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCFilterStyleArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCFilterStyleArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVDCFilterStyleC *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCSubtitleC : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szName;
	NSString * szUrl;
	NSString * szCreateTime;
	NSString * szThumbnail;
	NSNumber * nLength;
	NSString * szRecommend;
	NSString * szModel;
	NSString * szReference;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCSubtitleC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szName;
@property (retain) NSString * szUrl;
@property (retain) NSString * szCreateTime;
@property (retain) NSString * szThumbnail;
@property (retain) NSNumber * nLength;
@property (retain) NSString * szRecommend;
@property (retain) NSString * szModel;
@property (retain) NSString * szReference;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCSubtitleArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCSubtitleArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVDCSubtitleC *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusicC : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szName;
	NSString * szUrl;
	NSString * szDesc;
	NSString * szCreateTime;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusicC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szName;
@property (retain) NSString * szUrl;
@property (retain) NSString * szDesc;
@property (retain) NSString * szCreateTime;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusicArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusicArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVDCMusicC *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusic : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szUrl;
	NSString * szRhythmUrl;
	NSString * szRhythmLength;
	NSNumber * nRhythmID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusic *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szUrl;
@property (retain) NSString * szRhythmUrl;
@property (retain) NSString * szRhythmLength;
@property (retain) NSNumber * nRhythmID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusicEx : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szName;
	NSString * szUrl;
	NSString * szRhythmUrl;
	NSString * szRhythmLength;
	NSNumber * nRhythmID;
	NSNumber * nMusicType;
	NSString * szArtsit;
	NSString * szAlbum;
	NSNumber * nBPM;
	NSString * szTags;
	NSNumber * fLength;
	NSNumber * nYear;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusicEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szName;
@property (retain) NSString * szUrl;
@property (retain) NSString * szRhythmUrl;
@property (retain) NSString * szRhythmLength;
@property (retain) NSNumber * nRhythmID;
@property (retain) NSNumber * nMusicType;
@property (retain) NSString * szArtsit;
@property (retain) NSString * szAlbum;
@property (retain) NSNumber * nBPM;
@property (retain) NSString * szTags;
@property (retain) NSNumber * fLength;
@property (retain) NSNumber * nYear;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusicExEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCMusicEx * stMusicEx;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusicExEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCMusicEx * stMusicEx;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMusic : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szName;
	NSString * szUrl;
	NSNumber * nRhythmID;
	NSNumber * nMusicType;
	NSString * szArtsit;
	NSString * szAlbum;
	NSNumber * nBPM;
	NSString * szTags;
	NSNumber * fLength;
	NSNumber * nYear;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMusic *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szName;
@property (retain) NSString * szUrl;
@property (retain) NSNumber * nRhythmID;
@property (retain) NSNumber * nMusicType;
@property (retain) NSString * szArtsit;
@property (retain) NSString * szAlbum;
@property (retain) NSNumber * nBPM;
@property (retain) NSString * szTags;
@property (retain) NSNumber * fLength;
@property (retain) NSNumber * nYear;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusicExArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusicExArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVDCMusicEx *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpQueryCond : NSObject {
	
/* elements */
	NSNumber * nStyleID;
	NSNumber * nFilterID;
	NSNumber * nMusicID;
	NSNumber * nSubtitleID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpQueryCond *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nStyleID;
@property (retain) NSNumber * nFilterID;
@property (retain) NSNumber * nMusicID;
@property (retain) NSNumber * nSubtitleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCOrderForCreate : NSObject {
	
/* elements */
	NSNumber * nVideoLength;
	NSNumber * nHeaderAndTailID;
	NSNumber * nFilterID;
	NSNumber * nMusicID;
	NSNumber * nMusicStart;
	NSNumber * nMusicEnd;
	NSNumber * nSubtitleID;
	NSString * szCustomerSubtitle;
	NSString * szVideoName;
	NSNumber * nShareType;
	MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
	MovierDCInterfaceSvc_VDCLabelForVideo * stLabelForVideo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCOrderForCreate *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoLength;
@property (retain) NSNumber * nHeaderAndTailID;
@property (retain) NSNumber * nFilterID;
@property (retain) NSNumber * nMusicID;
@property (retain) NSNumber * nMusicStart;
@property (retain) NSNumber * nMusicEnd;
@property (retain) NSNumber * nSubtitleID;
@property (retain) NSString * szCustomerSubtitle;
@property (retain) NSString * szVideoName;
@property (retain) NSNumber * nShareType;
@property (retain) MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
@property (retain) MovierDCInterfaceSvc_VDCLabelForVideo * stLabelForVideo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCOrderForCreateEx : NSObject {
	
/* elements */
	NSNumber * nVideoLength;
	NSNumber * nHeaderAndTailID;
	NSNumber * nFilterID;
	NSNumber * nMusicID;
	NSNumber * nMusicStart;
	NSNumber * nMusicEnd;
	NSNumber * nSubtitleID;
	NSString * szCustomerSubtitle;
	NSString * szVideoName;
	NSString * szVideoDesc;
	NSNumber * nShareType;
	MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
	MovierDCInterfaceSvc_VDCLabelForVideo * stLabelForVideo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCOrderForCreateEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoLength;
@property (retain) NSNumber * nHeaderAndTailID;
@property (retain) NSNumber * nFilterID;
@property (retain) NSNumber * nMusicID;
@property (retain) NSNumber * nMusicStart;
@property (retain) NSNumber * nMusicEnd;
@property (retain) NSNumber * nSubtitleID;
@property (retain) NSString * szCustomerSubtitle;
@property (retain) NSString * szVideoName;
@property (retain) NSString * szVideoDesc;
@property (retain) NSNumber * nShareType;
@property (retain) MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
@property (retain) MovierDCInterfaceSvc_VDCLabelForVideo * stLabelForVideo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCOrderForProcess : NSObject {
	
/* elements */
	NSNumber * nOrderID;
	NSNumber * nCustomerID;
	NSNumber * nVideoLength;
	NSNumber * nHeaderAndTailID;
	NSNumber * nFilterID;
	NSNumber * nMusicID;
	NSNumber * nMusicStart;
	NSNumber * nMusicEnd;
	NSNumber * nSubtitleID;
	NSString * szCustomerSubtitle;
	NSString * szVideoName;
	NSString * szDestURL;
	NSString * szThumbnail;
	NSString * szCustomerName;
	MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
	NSNumber * nAppType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCOrderForProcess *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nOrderID;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nVideoLength;
@property (retain) NSNumber * nHeaderAndTailID;
@property (retain) NSNumber * nFilterID;
@property (retain) NSNumber * nMusicID;
@property (retain) NSNumber * nMusicStart;
@property (retain) NSNumber * nMusicEnd;
@property (retain) NSNumber * nSubtitleID;
@property (retain) NSString * szCustomerSubtitle;
@property (retain) NSString * szVideoName;
@property (retain) NSString * szDestURL;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szCustomerName;
@property (retain) MovierDCInterfaceSvc_VDCOrderMaterialArray * stMaterialArr;
@property (retain) NSNumber * nAppType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCOrderForProcessEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCOrderForProcess * stOrderForProcess;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCOrderForProcessEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCOrderForProcess * stOrderForProcess;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCOrderForProcessEx : NSObject {
	
/* elements */
	NSNumber * nOrderID;
	NSNumber * nCustomerID;
	NSNumber * nVideoLength;
	NSNumber * nHeaderAndTailID;
	NSNumber * nFilterID;
	NSNumber * nMusicID;
	NSNumber * nMusicStart;
	NSNumber * nMusicEnd;
	NSNumber * nSubtitleID;
	NSString * szCustomerSubtitle;
	NSString * szVideoName;
	NSString * szDestURL;
	NSString * szThumbnail;
	NSString * szCustomerName;
	MovierDCInterfaceSvc_VDCOrderMaterialExArray * stMaterialArr;
	NSNumber * nAppType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCOrderForProcessEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nOrderID;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nVideoLength;
@property (retain) NSNumber * nHeaderAndTailID;
@property (retain) NSNumber * nFilterID;
@property (retain) NSNumber * nMusicID;
@property (retain) NSNumber * nMusicStart;
@property (retain) NSNumber * nMusicEnd;
@property (retain) NSNumber * nSubtitleID;
@property (retain) NSString * szCustomerSubtitle;
@property (retain) NSString * szVideoName;
@property (retain) NSString * szDestURL;
@property (retain) NSString * szThumbnail;
@property (retain) NSString * szCustomerName;
@property (retain) MovierDCInterfaceSvc_VDCOrderMaterialExArray * stMaterialArr;
@property (retain) NSNumber * nAppType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_IDArray : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_IDArray *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(NSNumber *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_AppVersion : NSObject {
	
/* elements */
	NSString * szVersion;
	NSString * szDescription;
	NSString * szUrl;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_AppVersion *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szVersion;
@property (retain) NSString * szDescription;
@property (retain) NSString * szUrl;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_AppVersionEx : NSObject {
	
/* elements */
	NSString * szMainVersion;
	NSString * szSubVersion;
	NSString * szDescription;
	NSString * szUrl;
	NSString * szDigest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_AppVersionEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szMainVersion;
@property (retain) NSString * szSubVersion;
@property (retain) NSString * szDescription;
@property (retain) NSString * szUrl;
@property (retain) NSString * szDigest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_AppVersionExArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_AppVersionExArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_AppVersionEx *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVideoComment : NSObject {
	
/* elements */
	NSNumber * nCommentID;
	NSNumber * nCustomerID;
	NSNumber * nVideoID;
	NSNumber * nreplyComment;
	NSString * szNickname;
	NSString * szAvatar;
	NSString * szCreateTime;
	NSString * szContent;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVideoComment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCommentID;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nreplyComment;
@property (retain) NSString * szNickname;
@property (retain) NSString * szAvatar;
@property (retain) NSString * szCreateTime;
@property (retain) NSString * szContent;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVideoCommentArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVideoCommentArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVideoComment *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVideoCommentEx : NSObject {
	
/* elements */
	NSNumber * nCommentID;
	NSNumber * nCustomerID;
	NSNumber * nVideoID;
	NSNumber * nreplyComment;
	NSNumber * nDstCustomerID;
	NSString * szDstNickname;
	NSString * szNickname;
	NSString * szAvatar;
	NSString * szCreateTime;
	NSString * szContent;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVideoCommentEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCommentID;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nreplyComment;
@property (retain) NSNumber * nDstCustomerID;
@property (retain) NSString * szDstNickname;
@property (retain) NSString * szNickname;
@property (retain) NSString * szAvatar;
@property (retain) NSString * szCreateTime;
@property (retain) NSString * szContent;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVideoCommentExArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVideoCommentExArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_vpVideoCommentEx *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerBaseInfoEx : NSObject {
	
/* elements */
	NSNumber * nCustomerID;
	NSString * szNickname;
	NSString * szSignature;
	NSString * szAcatar;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerBaseInfoEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCustomerID;
@property (retain) NSString * szNickname;
@property (retain) NSString * szSignature;
@property (retain) NSString * szAcatar;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCCustomerBaseInfoEx *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCActivityInfo : NSObject {
	
/* elements */
	NSNumber * nActivityID;
	NSNumber * nOwnerID;
	NSString * szName;
	NSNumber * nlCapacity;
	NSNumber * nlUsedCapacity;
	NSString * szDesc;
	NSString * szIcon;
	NSNumber * nMemberTotal;
	NSString * szRootDir;
	NSNumber * nMaxMemberCount;
	NSNumber * nLastVersion;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCActivityInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nActivityID;
@property (retain) NSNumber * nOwnerID;
@property (retain) NSString * szName;
@property (retain) NSNumber * nlCapacity;
@property (retain) NSNumber * nlUsedCapacity;
@property (retain) NSString * szDesc;
@property (retain) NSString * szIcon;
@property (retain) NSNumber * nMemberTotal;
@property (retain) NSString * szRootDir;
@property (retain) NSNumber * nMaxMemberCount;
@property (retain) NSNumber * nLastVersion;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCActivityInfoArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCActivityInfoArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCActivityInfo *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_StringArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_StringArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(NSString *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBeatInfo : NSObject {
	
/* elements */
	NSNumber * nBeatID;
	NSNumber * fStart;
	NSNumber * fDuration;
	NSNumber * nSepcialEffectSet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBeatInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nBeatID;
@property (retain) NSNumber * fStart;
@property (retain) NSNumber * fDuration;
@property (retain) NSNumber * nSepcialEffectSet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBeatInfoArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBeatInfoArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCBeatInfo *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCSpecialEffect : NSObject {
	
/* elements */
	NSNumber * nID;
	NSString * szName;
	NSString * szAlias;
	NSNumber * fTimeRatio;
	NSNumber * fTimeSpan;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCSpecialEffect *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nID;
@property (retain) NSString * szName;
@property (retain) NSString * szAlias;
@property (retain) NSNumber * fTimeRatio;
@property (retain) NSNumber * fTimeSpan;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCFriendInfo : NSObject {
	
/* elements */
	NSNumber * nFriendFlag;
	NSNumber * nCustomerID;
	NSNumber * nVideoAmount;
	NSNumber * nCollectAmount;
	NSString * szAvatar;
	NSString * szNickName;
	NSString * szSignature;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCFriendInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nFriendFlag;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nVideoAmount;
@property (retain) NSNumber * nCollectAmount;
@property (retain) NSString * szAvatar;
@property (retain) NSString * szNickName;
@property (retain) NSString * szSignature;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCFriendArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCFriendArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCFriendInfo *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_TelArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_TelArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(NSString *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_SearchRetForTelFriend : NSObject {
	
/* elements */
	NSNumber * nFriendFlag;
	NSNumber * nCustomerID;
	NSString * szTelNum;
	NSString * szAvatar;
	NSString * szNickname;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_SearchRetForTelFriend *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nFriendFlag;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSString * szTelNum;
@property (retain) NSString * szAvatar;
@property (retain) NSString * szNickname;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_SearchRetArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_SearchRetArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_SearchRetForTelFriend *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCNewUserScoreTask : NSObject {
	
/* elements */
	NSNumber * nCustomerID;
	USBoolean * IsBindThirdPartyAccount;
	USBoolean * IsBindTel;
	USBoolean * HaveNickName;
	USBoolean * HaveAvatar;
	USBoolean * HaveBirthday;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCNewUserScoreTask *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCustomerID;
@property (retain) USBoolean * IsBindThirdPartyAccount;
@property (retain) USBoolean * IsBindTel;
@property (retain) USBoolean * HaveNickName;
@property (retain) USBoolean * HaveAvatar;
@property (retain) USBoolean * HaveBirthday;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMyScoreInshianCoin : NSObject {
	
/* elements */
	NSNumber * nCustomerID;
	NSNumber * nLevel;
	NSString * strLevelName;
	NSNumber * nAllScore;
	NSNumber * nTodayScore;
	NSNumber * nAllInshianCoin;
	NSNumber * nTodayInshianCoin;
	NSNumber * nMinScore;
	NSNumber * nMaxScore;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMyScoreInshianCoin *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nLevel;
@property (retain) NSString * strLevelName;
@property (retain) NSNumber * nAllScore;
@property (retain) NSNumber * nTodayScore;
@property (retain) NSNumber * nAllInshianCoin;
@property (retain) NSNumber * nTodayInshianCoin;
@property (retain) NSNumber * nMinScore;
@property (retain) NSNumber * nMaxScore;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMyScoreLog : NSObject {
	
/* elements */
	NSNumber * nCustomerID;
	NSNumber * nScoreActionID;
	NSNumber * nScore;
	NSNumber * nInshianCoin;
	NSString * szScoreActionName;
	NSString * szCreateDate;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMyScoreLog *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nScoreActionID;
@property (retain) NSNumber * nScore;
@property (retain) NSNumber * nInshianCoin;
@property (retain) NSString * szScoreActionName;
@property (retain) NSString * szCreateDate;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMyScoreLogArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMyScoreLogArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCMyScoreLog *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCDailyScoreTask : NSObject {
	
/* elements */
	NSNumber * nScoreActionID;
	NSNumber * nScore;
	NSNumber * nInshianCoin;
	NSString * szScoreActionName;
	NSString * szDesc;
	NSString * szThumbnailUrl;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCDailyScoreTask *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nScoreActionID;
@property (retain) NSNumber * nScore;
@property (retain) NSNumber * nInshianCoin;
@property (retain) NSString * szScoreActionName;
@property (retain) NSString * szDesc;
@property (retain) NSString * szThumbnailUrl;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCDailyScoreTaskArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCDailyScoreTaskArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCDailyScoreTask *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCDeviceInfo : NSObject {
	
/* elements */
	NSNumber * nClientType;
	NSString * szClientID;
	NSString * szDeviceToken;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCDeviceInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nClientType;
@property (retain) NSString * szClientID;
@property (retain) NSString * szDeviceToken;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCDeviceInfoEx : NSObject {
	
/* elements */
	NSNumber * nCustomerID;
	NSNumber * nClientType;
	NSString * szClientID;
	NSString * szDeviceToken;
	NSString * szLastTime;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCDeviceInfoEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nClientType;
@property (retain) NSString * szClientID;
@property (retain) NSString * szDeviceToken;
@property (retain) NSString * szLastTime;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCKeyValue : NSObject {
	
/* elements */
	NSString * szKey;
	NSString * szValue;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCKeyValue *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szKey;
@property (retain) NSString * szValue;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCKeyValueArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCKeyValueArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCKeyValue *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCTopicsArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCTopicsArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCKeyValueArr *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCKeyValueArr *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCIntArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCIntArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(NSNumber *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBannerArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBannerArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCKeyValueArr *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCLabelArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCLabelArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCKeyValueArr *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCRecordArr : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCRecordArr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(MovierDCInterfaceSvc_VDCKeyValueArr *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmodulelist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmodulelist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_ModuleHeaderArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_ModuleHeaderArray * stModuleHeaderArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ModuleHeaderArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_ModuleHeaderArray * stModuleHeaderArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gettotalmodulenum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gettotalmodulenum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_IntEnv : NSObject {
	
/* elements */
	NSNumber * nVal;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_IntEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVal;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmodulelistex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nStart;
	NSNumber * nEnd;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmodulelistex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nStart;
@property (retain) NSNumber * nEnd;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmodulebyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nModuleID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmodulebyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nModuleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_ModuleInfoEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_ModuleInfo * stModuleInfo;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ModuleInfoEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_ModuleInfo * stModuleInfo;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmodulebyname : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmodulebyname *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_createmodule : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_ModuleInfo * inmodule;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_createmodule *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_ModuleInfo * inmodule;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_updatemodule : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_ModuleInfo * inModuleInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_updatemodule *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_ModuleInfo * inModuleInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_querymodule : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_QueryCond * inQueryCond;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_querymodule *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_QueryCond * inQueryCond;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmodulebyorderid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOrderID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmodulebyorderid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOrderID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_connectiontest : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_connectiontest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_registerusingemail : NSObject {
	
/* elements */
	NSString * pszUserName;
	NSString * pszEmail;
	NSString * pszPassword;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_registerusingemail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszUserName;
@property (retain) NSString * pszEmail;
@property (retain) NSString * pszPassword;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_registerusingtel : NSObject {
	
/* elements */
	NSString * pszUserName;
	NSString * pszTel;
	NSString * pszPassword;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_registerusingtel *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszUserName;
@property (retain) NSString * pszTel;
@property (retain) NSString * pszPassword;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_registerusingthirdpartyaccount : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCThirdPartyAccount * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_registerusingthirdpartyaccount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCThirdPartyAccount * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_registerusingfullinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCCustomerInfo * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_registerusingfullinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCCustomerInfo * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_login : NSObject {
	
/* elements */
	NSString * pszUserName;
	NSString * pszPassword;
	USBoolean * bEncrypt;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_login *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszUserName;
@property (retain) NSString * pszPassword;
@property (retain) USBoolean * bEncrypt;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCSessionEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * session;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCSessionEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * session;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_loginex : NSObject {
	
/* elements */
	NSString * pszUserName;
	NSString * pszPassword;
	USBoolean * bEncrypt;
	NSNumber * nPlatform;
	NSString * pszMainVersion;
	NSString * pszSubVersion;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_loginex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszUserName;
@property (retain) NSString * pszPassword;
@property (retain) USBoolean * bEncrypt;
@property (retain) NSNumber * nPlatform;
@property (retain) NSString * pszMainVersion;
@property (retain) NSString * pszSubVersion;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_thirdpartylogin : NSObject {
	
/* elements */
	NSString * pszThirdPartyAccount;
	NSNumber * nThirdPartyType;
	NSString * pszToken;
	NSString * pszOpenID;
	NSNumber * nPlatform;
	NSString * pszMainVersion;
	NSString * pszSubVersion;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_thirdpartylogin *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszThirdPartyAccount;
@property (retain) NSNumber * nThirdPartyType;
@property (retain) NSString * pszToken;
@property (retain) NSString * pszOpenID;
@property (retain) NSNumber * nPlatform;
@property (retain) NSString * pszMainVersion;
@property (retain) NSString * pszSubVersion;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_thirdpartygetsecret : NSObject {
	
/* elements */
	NSString * pszThirdPartyAccount;
	NSNumber * nThirdPartyType;
	NSString * pszToken;
	NSString * pszOpenID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_thirdpartygetsecret *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszThirdPartyAccount;
@property (retain) NSNumber * nThirdPartyType;
@property (retain) NSString * pszToken;
@property (retain) NSString * pszOpenID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_StringArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_StringArr * stStringArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_StringArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_StringArr * stStringArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getcustomerinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getcustomerinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerInfoEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCCustomerInfo * stVDCCustomerInfo;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerInfoEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCCustomerInfo * stVDCCustomerInfo;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getcustomerinfoex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getcustomerinfoex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getcustomerinfoex2 : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getcustomerinfoex2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerInfoExEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCCustomerInfoEx * stVDCCustomerInfoEx;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerInfoExEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCCustomerInfoEx * stVDCCustomerInfoEx;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_updatecustomerinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCCustomerBaseInfo * info;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_updatecustomerinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCCustomerBaseInfo * info;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getossconfig : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getossconfig *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOSSConfigEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCOSSConfig * stVDCOSSConfig;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOSSConfigEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCOSSConfig * stVDCOSSConfig;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getprivilegeinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getprivilegeinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCPrivilegeInfoArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCPrivilegeInfoArray * stVDCPrivilegeInfoArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCPrivilegeInfoArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCPrivilegeInfoArray * stVDCPrivilegeInfoArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_updateuserinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCCustomerInfo * info;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_updateuserinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCCustomerInfo * info;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_activeuser : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszActivecode;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_activeuser *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszActivecode;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_logout : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_logout *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getorder : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getorder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderForProcessEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCOrderForProcess * stVDCOrderForProcess;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderForProcessEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCOrderForProcess * stVDCOrderForProcess;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetorder : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetorder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCOrderForProcessExEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCOrderForProcessEx * stOrderForProcess;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCOrderForProcessExEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCOrderForProcessEx * stOrderForProcess;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_ordercomplete : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOrderID;
	NSString * pszVideoResolution;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_ordercomplete *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOrderID;
@property (retain) NSString * pszVideoResolution;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_orderprocessfail : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOrderID;
	NSNumber * nErr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_orderprocessfail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOrderID;
@property (retain) NSNumber * nErr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_createorder : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCOrderForCreate * pOrder;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_createorder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCOrderForCreate * pOrder;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpcreateorder : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_vpVDCOrderForCreate * pvpOrder;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpcreateorder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_vpVDCOrderForCreate * pvpOrder;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_queryorderbyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_queryorderbyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderForQueryEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCOrderForQuery * stVDCOrderForQuery;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderForQueryEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCOrderForQuery * stVDCOrderForQuery;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_queryorders : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_queryorders *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCOrderForQueryArray * stVDCOrderForQueryArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOrderForQueryArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCOrderForQueryArray * stVDCOrderForQueryArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_queryordersbyidarr : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCOrderIDArray * orderidarr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_queryordersbyidarr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCOrderIDArray * orderidarr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getordertotalnumbystatus : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOrderStatus;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getordertotalnumbystatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOrderStatus;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_queryordersbyorderstatus : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOrderStatus;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_queryordersbyorderstatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOrderStatus;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_querynotice : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_querynotice *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerNoticeArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCCustomerNoticeArray * stVDCCustomerNoticeArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerNoticeArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCCustomerNoticeArray * stVDCCustomerNoticeArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_querynoticebytype : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nType;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_querynoticebytype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nType;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmusicinfobyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nMusicID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmusicinfobyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nMusicID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMusicInfoEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCMusicInfo * stVDCMusicInfo;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMusicInfoEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCMusicInfo * stVDCMusicInfo;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmusicinfobyname : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszMusicName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmusicinfobyname *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszMusicName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmusicinfolist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCMusicHeaderArr * inMusicHeaderArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmusicinfolist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCMusicHeaderArr * inMusicHeaderArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMusicInfoArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCMusicInfoArr * stVDCMusicInfoArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMusicInfoArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCMusicInfoArr * stVDCMusicInfoArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideolabeltotalnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideolabeltotalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideolabeltotalnumbyparentid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nParentID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideolabeltotalnumbyparentid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nParentID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideolabels : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideolabels *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabelArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCVideoLabelArray * stVDCVideoLabelArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabelArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCVideoLabelArray * stVDCVideoLabelArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideolabelsbyparentid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nParentID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideolabelsbyparentid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nParentID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideolabelsex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoLabelLocation;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideolabelsex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoLabelLocation;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabelEx2ArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCVideoLabelEx2Array * stVDCVideoLabelExArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabelEx2ArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCVideoLabelEx2Array * stVDCVideoLabelExArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideolabelsexbyparentid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nParentID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideolabelsexbyparentid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nParentID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoLabelExArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCVideoLabelExArray * stVDCVideoLabelExArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoLabelExArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCVideoLabelExArray * stVDCVideoLabelExArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideototalbylabelid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nLabelID;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideototalbylabelid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nLabelID;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideototalbylabelname : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pLabelName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideototalbylabelname *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pLabelName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideobylabelid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nLabelID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideobylabelid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nLabelID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoInfoArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCVideoInfoArray * stVDCVideoInfoArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoInfoArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCVideoInfoArray * stVDCVideoInfoArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideobylabelidex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nLabelID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideobylabelidex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nLabelID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCVideoInfoExArray * stVDCVideoInfoArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoInfoExArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCVideoInfoExArray * stVDCVideoInfoArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideobylabelname : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszLabelName;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideobylabelname *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszLabelName;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_praisevideobyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_praisevideobyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_unpraisevideobyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_unpraisevideobyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_increasevideoattr : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	NSString * pszAttrName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_increasevideoattr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) NSString * pszAttrName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_increasevideoattr4c : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	NSString * pszAttrName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_increasevideoattr4c *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) NSString * pszAttrName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_praisevideobyname : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszVideoName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_praisevideobyname *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszVideoName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_increasesharenumbyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_increasesharenumbyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_increasesharenumbyname : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszVideoName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_increasesharenumbyname *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszVideoName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_markfavoritebyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	USBoolean * bOp;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_markfavoritebyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) USBoolean * bOp;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_markfavoritebyname : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszVideoName;
	USBoolean * bOp;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_markfavoritebyname *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszVideoName;
@property (retain) USBoolean * bOp;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getfavoritevideototalnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getfavoritevideototalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getfavoritevideo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getfavoritevideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getfavoritevideoex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getfavoritevideoex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmoduleallstyle : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmoduleallstyle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCModuleStyleArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCModuleStyleArr * stModuleStyleArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCModuleStyleArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCModuleStyleArr * stModuleStyleArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmoduletotalnumbystyle : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nStyle;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmoduletotalnumbystyle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nStyle;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmodulebystyle : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nStyle;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmodulebystyle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nStyle;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_submitfeedback : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCFeedBack * feedback;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_submitfeedback *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCFeedBack * feedback;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gettotalnumofvideoforhomepage : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nCustomerID;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gettotalnumofvideoforhomepage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideoforhomepage : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nCustomerID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideoforhomepage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideoforhomepageex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nCustomerID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideoforhomepageex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nCustomerID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideobyorderidarr : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_IDArray * videoidarr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideobyorderidarr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_IDArray * videoidarr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideobyorderidarrex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_IDArray * videoidarr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideobyorderidarrex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_IDArray * videoidarr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideobyvideoidarr : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_IDArray * videoidarr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideobyvideoidarr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_IDArray * videoidarr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideobyvideoidarrex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_IDArray * videoidarr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideobyvideoidarrex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_IDArray * videoidarr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getosssignature : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * szContent;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getosssignature *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * szContent;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCOSSSignatureEnv : NSObject {
	
/* elements */
	NSString * szSignature;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCOSSSignatureEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szSignature;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvpelementtotalnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nType;
	MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvpelementtotalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nType;
@property (retain) MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetheaderstyletotalnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetheaderstyletotalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetheaderstyle : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetheaderstyle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderStyleArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCHeaderStyleArray * stHeaderStyleArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderStyleArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCHeaderStyleArray * stHeaderStyleArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgettemplatecattotalnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgettemplatecattotalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgettemplatecat : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgettemplatecat *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCTemplateCatArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCTemplateCatArr * stTemplateCatArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCTemplateCatArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCTemplateCatArr * stTemplateCatArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nTemplateCat;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nTemplateCat;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetheaderandtailbycat : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nTemplateCat;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetheaderandtailbycat *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nTemplateCat;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTailArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCHeaderAndTailArray * stHeaderAndTailArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTailArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCHeaderAndTailArray * stHeaderAndTailArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetheaderandtail : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetheaderandtail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetheaderandtailexbycat : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nTemplateCat;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetheaderandtailexbycat *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nTemplateCat;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTailExArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCHeaderAndTailExArray * stHeaderAndTailExArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTailExArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCHeaderAndTailExArray * stHeaderAndTailExArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetheaderandtailex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetheaderandtailex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetheaderandtailvisitcount : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetheaderandtailvisitcount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpincreaseheaderandtailvisitcount : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpincreaseheaderandtailvisitcount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nHeaderAndTailID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nHeaderAndTailID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCDefaultMusicAndSubtitleForStyle : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCMusicC * stMusic;
	MovierDCInterfaceSvc_vpVDCSubtitleC * stSubtitle;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCDefaultMusicAndSubtitleForStyle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCMusicC * stMusic;
@property (retain) MovierDCInterfaceSvc_vpVDCSubtitleC * stSubtitle;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetfilterstyletotalnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetfilterstyletotalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetfilterstyle : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetfilterstyle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCFilterStyleArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCFilterStyleArray * stFilterStyleArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCFilterStyleArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCFilterStyleArray * stFilterStyleArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetfilter : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetfilter *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCFilterArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCFilterArray * stFilterArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCFilterArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCFilterArray * stFilterArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetmusic : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetmusic *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusicArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCMusicArray * stMusicArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusicArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCMusicArray * stMusicArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetsubtitle : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetsubtitle *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_vpQueryCond * invpQueryCond;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCSubtitleArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCSubtitleArray * stSubtitleArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCSubtitleArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCSubtitleArray * stSubtitleArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetstylebyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nStyleID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetstylebyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nStyleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTailEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCHeaderAndTail * stHeaderAndTail;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTailEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCHeaderAndTail * stHeaderAndTail;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetfilterbyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nFilterID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetfilterbyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nFilterID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCFilterEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCFilter * stFilter;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCFilterEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCFilter * stFilter;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetmusicbyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nMusicID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetmusicbyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nMusicID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusicEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCMusic * stMusic;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusicEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCMusic * stMusic;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpsearchonlinemusic : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * szKeyWord;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpsearchonlinemusic *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * szKeyWord;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCMusicExArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCMusicExArr * stMusicExArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCMusicExArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCMusicExArr * stMusicExArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetsubtitlebyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nSubtitleID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetsubtitlebyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nSubtitleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCSubtitleEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCSubtitleC * stSubtitle;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCSubtitleEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCSubtitleC * stSubtitle;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpupdatevideosharestatus : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	USBoolean * bShare;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpupdatevideosharestatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) USBoolean * bShare;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpremovevideo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpremovevideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetfavouritestatus : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_IDArray * idarr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetfavouritestatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_IDArray * idarr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_IDArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_IDArray * stIDArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_IDArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_IDArray * stIDArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetpraisestatus : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_IDArray * idarr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetpraisestatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_IDArray * idarr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetsubtitlemodelbyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nSubtitleID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetsubtitlemodelbyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nSubtitleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_StringEnv : NSObject {
	
/* elements */
	NSString * szContent;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_StringEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * szContent;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_changepassword : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszNew;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_changepassword *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszNew;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_checktelnumusability : NSObject {
	
/* elements */
	NSString * pszTelnum;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_checktelnumusability *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszTelnum;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_checkemailusability : NSObject {
	
/* elements */
	NSString * pszEmail;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_checkemailusability *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszEmail;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_resetpasswordusingtel : NSObject {
	
/* elements */
	NSString * pszTel;
	NSString * pszCode;
	NSString * pszNewPwd;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_resetpasswordusingtel *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszTel;
@property (retain) NSString * pszCode;
@property (retain) NSString * pszNewPwd;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_resetpasswordusingemail : NSObject {
	
/* elements */
	NSString * pszEmail;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_resetpasswordusingemail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszEmail;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getapplatestversion : NSObject {
	
/* elements */
	NSNumber * nAppType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getapplatestversion *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nAppType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_AppVersionEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_AppVersion * stVersion;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_AppVersionEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_AppVersion * stVersion;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getappversion : NSObject {
	
/* elements */
	NSNumber * nAppType;
	NSString * pszMainVersion;
	NSString * pszSubVersion;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getappversion *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nAppType;
@property (retain) NSString * pszMainVersion;
@property (retain) NSString * pszSubVersion;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_AppVersionExArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_AppVersionExArr * stAppVersionExArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_AppVersionExArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_AppVersionExArr * stAppVersionExArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_userreport : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	NSNumber * nCategory;
	NSString * pszRemark;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_userreport *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nCategory;
@property (retain) NSString * pszRemark;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpsubmitcomment : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	NSNumber * nReplyComment;
	NSString * pszComment;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpsubmitcomment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nReplyComment;
@property (retain) NSString * pszComment;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetcommenttotalnum : NSObject {
	
/* elements */
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetcommenttotalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetcomment : NSObject {
	
/* elements */
	NSNumber * nVideoID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetcomment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVideoCommentArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVideoCommentArr * stVideoCommentArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVideoCommentArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVideoCommentArr * stVideoCommentArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgetcommentex : NSObject {
	
/* elements */
	NSNumber * nVideoID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgetcommentex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVideoCommentExArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVideoCommentExArr * stVideoCommentArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVideoCommentExArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVideoCommentExArr * stVideoCommentArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpremovecomment : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nCommentID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpremovecomment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nCommentID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpreportcomment : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nCommentID;
	NSNumber * nReportType;
	NSString * pszReason;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpreportcomment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nCommentID;
@property (retain) NSNumber * nReportType;
@property (retain) NSString * pszReason;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_createactivity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszName;
	NSString * pszSecret;
	NSNumber * nActivityCapacity;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_createactivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszName;
@property (retain) NSString * pszSecret;
@property (retain) NSNumber * nActivityCapacity;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_removeactivity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_removeactivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_joinactivity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	NSString * pszSecret;
	USBoolean * bEncrypted;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_joinactivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) NSString * pszSecret;
@property (retain) USBoolean * bEncrypted;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_quitactivity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_quitactivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_sendinvitebytelnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	MovierDCInterfaceSvc_StringArr * pTelnumArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_sendinvitebytelnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) MovierDCInterfaceSvc_StringArr * pTelnumArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_sendinvitebyemail : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	MovierDCInterfaceSvc_StringArr * pEmailArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_sendinvitebyemail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) MovierDCInterfaceSvc_StringArr * pEmailArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_removememberfromactivity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivity;
	NSNumber * nCusotmerID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_removememberfromactivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivity;
@property (retain) NSNumber * nCusotmerID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_changepassword4activity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	NSString * pszOldPWD;
	NSString * pszNewPWD;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_changepassword4activity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) NSString * pszOldPWD;
@property (retain) NSString * pszNewPWD;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_updatestoragecapacity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	NSNumber * nNewCapcity;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_updatestoragecapacity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) NSNumber * nNewCapcity;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getactivitymemberidlist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getactivitymemberidlist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getactivitymemberinfolist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getactivitymemberinfolist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCCustomerBaseInfoExArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr * stVDCCustomerBaseInfoExArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCCustomerBaseInfoExArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr * stVDCCustomerBaseInfoExArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getactivityinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getactivityinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCActivityInfoEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCActivityInfo * stVDCActivityInfo;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCActivityInfoEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCActivityInfo * stVDCActivityInfo;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getactivitytotalnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getactivitytotalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getactivitylist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getactivitylist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCActivityInfoArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCActivityInfoArr * stVDCActivityInfoArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCActivityInfoArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCActivityInfoArr * stVDCActivityInfoArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_reportactivity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	NSNumber * nType;
	NSString * pszComment;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_reportactivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) NSNumber * nType;
@property (retain) NSString * pszComment;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_createorder4activity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	MovierDCInterfaceSvc_vpVDCOrderForCreate * pvpOrder;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_createorder4activity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) MovierDCInterfaceSvc_vpVDCOrderForCreate * pvpOrder;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_createfile4activity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	NSString * pszFileKey;
	NSNumber * nFileSize;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_createfile4activity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) NSString * pszFileKey;
@property (retain) NSNumber * nFileSize;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_createfile4activityconfirm : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	NSString * pszFileKey;
	NSNumber * nProcessResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_createfile4activityconfirm *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) NSString * pszFileKey;
@property (retain) NSNumber * nProcessResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_removefile4activity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nActivityID;
	NSString * pszFileKey;
	NSNumber * nFileSize;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_removefile4activity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nActivityID;
@property (retain) NSString * pszFileKey;
@property (retain) NSNumber * nFileSize;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getactivitytotalnum4customer : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getactivitytotalnum4customer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getactivitylist4customer : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getactivitylist4customer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_updatecustomercapacity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nCapcity;
	NSString * pszAuthStr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_updatecustomercapacity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nCapcity;
@property (retain) NSString * pszAuthStr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getcustomercapacity : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getcustomercapacity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_LONG64Env : NSObject {
	
/* elements */
	NSNumber * nVal;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_LONG64Env *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVal;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_removevideofile : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszFileKey;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_removevideofile *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszFileKey;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_searchuser : NSObject {
	
/* elements */
	NSString * pszKeyWord;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_searchuser *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszKeyWord;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_searchvideo : NSObject {
	
/* elements */
	NSString * pszKeyWord;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_searchvideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * pszKeyWord;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getbannertotalnum : NSObject {
	
/* elements */
	NSNumber * nLabelID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getbannertotalnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nLabelID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getbanner : NSObject {
	
/* elements */
	NSNumber * nLabelID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getbanner *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nLabelID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBannerInfoArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCBannerInfoArray * stVDCBannerInfoArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBannerInfoArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCBannerInfoArray * stVDCBannerInfoArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getbannerex : NSObject {
	
/* elements */
	NSNumber * nLabelID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getbannerex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nLabelID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBannerInfoExArrayEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCBannerInfoExArray * stVDCBannerInfoExArray;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBannerInfoExArrayEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCBannerInfoExArray * stVDCBannerInfoExArray;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_updatetelnum : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszTel;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_updatetelnum *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszTel;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_updatetelnumex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszTel;
	NSString * pszPassword;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_updatetelnumex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszTel;
@property (retain) NSString * pszPassword;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpcreateorderfollowexist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	MovierDCInterfaceSvc_vpVDCOrderForCreate * pvpOrder;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpcreateorderfollowexist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) MovierDCInterfaceSvc_vpVDCOrderForCreate * pvpOrder;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpcreateorderfollowexistex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	MovierDCInterfaceSvc_vpVDCOrderForCreateEx * pvpOrder;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpcreateorderfollowexistex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) MovierDCInterfaceSvc_vpVDCOrderForCreateEx * pvpOrder;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpgettelnumsettingstatus : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpgettelnumsettingstatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_registerusingthirdpartyaccountex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCThirdPartyAccountEx * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_registerusingthirdpartyaccountex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCThirdPartyAccountEx * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_registerusingthirdpartyaccount4wechat : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCThirdPartyAccountForWeChat * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_registerusingthirdpartyaccount4wechat *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCThirdPartyAccountForWeChat * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getpicbyheightandwidth : NSObject {
	
/* elements */
	NSNumber * nRatioIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getpicbyheightandwidth *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nRatioIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getpicbyratioindex : NSObject {
	
/* elements */
	NSNumber * nRatioIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getpicbyratioindex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nRatioIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getcuponforgm : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getcuponforgm *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideolabelexbylabelid : NSObject {
	
/* elements */
	NSNumber * nLabelID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideolabelexbylabelid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nLabelID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VideoLabelExEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCVideoLabelEx * stVideoLabelEx;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VideoLabelExEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCVideoLabelEx * stVideoLabelEx;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getstylebyvideoid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getstylebyvideoid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_vpVDCHeaderAndTailExC * stHeaderAndTailEx;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_vpVDCHeaderAndTailExEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_vpVDCHeaderAndTailExC * stHeaderAndTailEx;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getstylebylabelid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nLabelID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getstylebylabelid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nLabelID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getspecialeffectbyeffectsetid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nSpecialEffectSetID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getspecialeffectbyeffectsetid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nSpecialEffectSetID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCSpecialEffectEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSpecialEffect * stSpecialEffect;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCSpecialEffectEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSpecialEffect * stSpecialEffect;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getbeatinfoarrbybeatid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nBeatID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getbeatinfoarrbybeatid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nBeatID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBeatInfoArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCBeatInfoArr * stBeatInfo;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBeatInfoArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCBeatInfoArr * stBeatInfo;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getcategoryfortemplate : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nTemplateID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getcategoryfortemplate *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nTemplateID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_share : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	NSNumber * nPlatform;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_share *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nPlatform;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_shareex : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	NSNumber * nPlatform;
	NSString * pszContent;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_shareex *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nPlatform;
@property (retain) NSString * pszContent;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_updatethirdpartyaccount : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszThirdPartyAccount;
	NSNumber * nThirdPartyType;
	NSString * pszThirdPartyAccountAlias;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_updatethirdpartyaccount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszThirdPartyAccount;
@property (retain) NSNumber * nThirdPartyType;
@property (retain) NSString * pszThirdPartyAccountAlias;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getnewuserscoretask : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getnewuserscoretask *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCNewUserScoreTaskEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCNewUserScoreTask * stNewUserScoreTask;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCNewUserScoreTaskEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCNewUserScoreTask * stNewUserScoreTask;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gettelandthirdpartybindstatus : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gettelandthirdpartybindstatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCTelAndThirdPartyBindStatusEnv : NSObject {
	
/* elements */
	USBoolean * IsBindTel;
	USBoolean * IsBindThirdPartyAccount;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCTelAndThirdPartyBindStatusEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * IsBindTel;
@property (retain) USBoolean * IsBindThirdPartyAccount;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmyscoreinshiancoin : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmyscoreinshiancoin *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMyScoreInshianCoinEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCMyScoreInshianCoin * stMyScoreInshianCoin;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMyScoreInshianCoinEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCMyScoreInshianCoin * stMyScoreInshianCoin;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getscorelog : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nDayCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getscorelog *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nDayCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMyScoreLogArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCMyScoreLogArr * stMyScoreLogArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMyScoreLogArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCMyScoreLogArr * stMyScoreLogArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getdailyscoretask : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getdailyscoretask *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCDailyScoreTaskArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCDailyScoreTaskArr * stDailyScoreTaskArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCDailyScoreTaskArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCDailyScoreTaskArr * stDailyScoreTaskArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_operatedevicelist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOperationType;
	MovierDCInterfaceSvc_VDCDeviceInfo * pDI;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_operatedevicelist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOperationType;
@property (retain) MovierDCInterfaceSvc_VDCDeviceInfo * pDI;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_sendprivatemessage : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nTargetCustomerID;
	NSString * pszMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_sendprivatemessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nTargetCustomerID;
@property (retain) NSString * pszMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_systemnotice : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszMessage;
	NSNumber * nLinkType;
	NSString * pszURL;
	NSNumber * nVideoLabel;
	NSNumber * nAppType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_systemnotice *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszMessage;
@property (retain) NSNumber * nLinkType;
@property (retain) NSString * pszURL;
@property (retain) NSNumber * nVideoLabel;
@property (retain) NSNumber * nAppType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_messagepushonoff : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * bitOnOff;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_messagepushonoff *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * bitOnOff;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_follow : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nFollowerID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_follow *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nFollowerID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_unfollow : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nFollowerID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_unfollow *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nFollowerID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getfollowlist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getfollowlist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCFriendArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCFriendArr * stFriendArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCFriendArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCFriendArr * stFriendArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getfunslist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getfunslist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getfriendlist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getfriendlist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getfriendamount : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nFriendType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getfriendamount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nFriendType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getfriendrelation : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nUserID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getfriendrelation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nUserID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_searchfriend : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * szSearchContent;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_searchfriend *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * szSearchContent;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_searchtelfriend : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_TelArr * stTelArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_searchtelfriend *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_TelArr * stTelArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_SearchRetArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_SearchRetArr * stSearchRet;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_SearchRetArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_SearchRetArr * stSearchRet;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gethomepagebackground : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gethomepagebackground *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCHomePageBackgroundEnv : NSObject {
	
/* elements */
	NSString * URL;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCHomePageBackgroundEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * URL;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_checksession : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_checksession *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_setvideoinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	MovierDCInterfaceSvc_VDCKeyValueArr * stKVArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_setvideoinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stKVArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideoinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideoinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCKeyValueArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stKV;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCKeyValueArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stKV;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideosbyuserid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nUserID;
	NSNumber * nShareType;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideosbyuserid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nUserID;
@property (retain) NSNumber * nShareType;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCVideoArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCVideoArr * stVArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCVideoArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCVideoArr * stVArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_addtopicsforvideo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	MovierDCInterfaceSvc_StringArr * stTopicNameArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_addtopicsforvideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) MovierDCInterfaceSvc_StringArr * stTopicNameArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_removetopicsforvideo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	MovierDCInterfaceSvc_VDCIntArr * stTopicIDArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_removetopicsforvideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) MovierDCInterfaceSvc_VDCIntArr * stTopicIDArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gettopicsbyvideoid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gettopicsbyvideoid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCTopicsArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCTopicsArr * stTArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCTopicsArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCTopicsArr * stTArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gettopicsbyparenttopic : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nParentID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gettopicsbyparenttopic *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nParentID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideosbytopicid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nTopicID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideosbytopicid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nTopicID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_releasevideo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_releasevideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_unreleasevideo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_unreleasevideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_atfriendbycustomeridarr : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	MovierDCInterfaceSvc_VDCIntArr * stCustomerIDArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_atfriendbycustomeridarr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) MovierDCInterfaceSvc_VDCIntArr * stCustomerIDArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_searchtopics : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * szSearchContent;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_searchtopics *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * szSearchContent;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getuserinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nUserID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getuserinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nUserID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_setuserinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_setuserinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getbannerlist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nCategory;
	NSNumber * nWhere;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getbannerlist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nCategory;
@property (retain) NSNumber * nWhere;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCBannerArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCBannerArr * stBArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCBannerArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCBannerArr * stBArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getcollectvideos : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nUserID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getcollectvideos *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nUserID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getlabelsbyparentid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nLabelID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getlabelsbyparentid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nLabelID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCLabelArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCLabelArr * stLArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCLabelArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCLabelArr * stLArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getchallengetaskpraise : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getchallengetaskpraise *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCRecordArrEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCRecordArr * stRArr;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCRecordArrEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCRecordArr * stRArr;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getchallengetaskview : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getchallengetaskview *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getorderbyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOrderID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getorderbyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOrderID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideoamountbyheaderandtailanddate : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nHeaderAndTailID;
	NSString * szDateStart;
	NSString * szDateEnd;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideoamountbyheaderandtailanddate *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nHeaderAndTailID;
@property (retain) NSString * szDateStart;
@property (retain) NSString * szDateEnd;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getshareamountbylabelid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nLabelID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getshareamountbylabelid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nLabelID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getshareamountbyheaderandtailanddate : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nHeaderAndTailID;
	NSString * szDateStart;
	NSString * szDateEnd;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getshareamountbyheaderandtailanddate *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nHeaderAndTailID;
@property (retain) NSString * szDateStart;
@property (retain) NSString * szDateEnd;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_telregister : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_telregister *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_thirdpartyregister : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_thirdpartyregister *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_loginbyusername : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_loginbyusername *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_loginbythirdparty : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_loginbythirdparty *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stUserInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideosbylabelid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nLabelID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideosbylabelid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nLabelID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideosbyvideoidarr : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCIntArr * stIDArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideosbyvideoidarr *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCIntArr * stIDArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_searchvideosbykey : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSString * pszKeyWord;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_searchvideosbykey *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSString * pszKeyWord;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getmusicbyid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nMusicID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getmusicbyid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nMusicID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCMusicEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCMusic * stMusic;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCMusicEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCMusic * stMusic;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getcommentsbyvideoid : NSObject {
	
/* elements */
	NSNumber * nVideoID;
	NSNumber * nOffset;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getcommentsbyvideoid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nOffset;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gettemplateidbyvideoid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gettemplateidbyvideoid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_loginbyaccount : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stAccountInfo;
	NSNumber * nAccountType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_loginbyaccount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stAccountInfo;
@property (retain) NSNumber * nAccountType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_qqregister : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stQQInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_qqregister *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stQQInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_weiboregister : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stWeiBoInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_weiboregister *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stWeiBoInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_wechatregister : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stWeChatInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_wechatregister *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stWeChatInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getaccountbindstatus : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getaccountbindstatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_bindaccount : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCKeyValueArr * stAccountInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_bindaccount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stAccountInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getorderbytemplateid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nTemplateID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getorderbytemplateid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nTemplateID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_test1 : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stKVArr;
	MovierDCInterfaceSvc_VDCKeyValue * stKV;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_test1 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stKVArr;
@property (retain) MovierDCInterfaceSvc_VDCKeyValue * stKV;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_test2 : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValueArr * stKVArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_test2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stKVArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_test3 : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValue * stKV;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_test3 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValue * stKV;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_VDCKeyValueEnv : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCKeyValue * stKV;
	NSNumber * nRet;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_VDCKeyValueEnv *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCKeyValue * stKV;
@property (retain) NSNumber * nRet;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmlbs : NSObject {
	
/* elements */
	NSNumber * x;
	NSNumber * y;
	NSNumber * radius;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmlbs *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * x;
@property (retain) NSNumber * y;
@property (retain) NSNumber * radius;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmgetar : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nType;
	MovierDCInterfaceSvc_VDCKeyValueArr * stReference;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmgetar *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nType;
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stReference;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmcreateorderfollowexist : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCKeyValueArr * stReference;
	MovierDCInterfaceSvc_VDCRecordArr * stMaterials;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmcreateorderfollowexist *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stReference;
@property (retain) MovierDCInterfaceSvc_VDCRecordArr * stMaterials;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmcreateorder : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCKeyValueArr * stReference;
	MovierDCInterfaceSvc_VDCRecordArr * stMaterials;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmcreateorder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCKeyValueArr * stReference;
@property (retain) MovierDCInterfaceSvc_VDCRecordArr * stMaterials;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmshare : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nVideoID;
	NSNumber * nPlatform;
	NSString * pszContent;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmshare *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nVideoID;
@property (retain) NSNumber * nPlatform;
@property (retain) NSString * pszContent;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmopenchest : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nChestLogID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmopenchest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nChestLogID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmgetrealtimeawardinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nCount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmgetrealtimeawardinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nCount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmgetchest : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nARLogID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmgetchest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nARLogID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmcardcompound : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	MovierDCInterfaceSvc_VDCIntArr * stCardIDArr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmcardcompound *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) MovierDCInterfaceSvc_VDCIntArr * stCardIDArr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmgetvirtualcardbyuserid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmgetvirtualcardbyuserid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmgetawardbyuserid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmgetawardbyuserid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmgettokenamount : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmgettokenamount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmgettokenexchangerule : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmgettokenexchangerule *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gmtokenexchange : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nTokenType;
	NSNumber * nAwardID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gmtokenexchange *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nTokenType;
@property (retain) NSNumber * nAwardID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_gettemplateavailable : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_gettemplateavailable *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_bcinsertuservideo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nUserID;
	NSNumber * nVideoID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_bcinsertuservideo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nUserID;
@property (retain) NSNumber * nVideoID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getvideoidbyorderid : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nOrderID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getvideoidbyorderid *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nOrderID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_getarawardnewyear : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_getarawardnewyear *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MovierDCInterfaceSvc_addarawardnewyearreceiverinfo : NSObject {
	
/* elements */
	MovierDCInterfaceSvc_VDCSession * in_;
	NSNumber * nID;
	NSString * pszReceiver;
	NSString * pszTel;
	NSString * pszLocation;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MovierDCInterfaceSvc_addarawardnewyearreceiverinfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) MovierDCInterfaceSvc_VDCSession * in_;
@property (retain) NSNumber * nID;
@property (retain) NSString * pszReceiver;
@property (retain) NSString * pszTel;
@property (retain) NSString * pszLocation;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "MovierDCInterfaceSvc.h"
@class MovierDCInterfaceBinding;
@interface MovierDCInterfaceSvc : NSObject {
	
}
+ (MovierDCInterfaceBinding *)MovierDCInterfaceBinding;
@end
@class MovierDCInterfaceBindingResponse;
@class MovierDCInterfaceBindingOperation;
@protocol MovierDCInterfaceBindingResponseDelegate <NSObject>
- (void) operation:(MovierDCInterfaceBindingOperation *)operation completedWithResponse:(MovierDCInterfaceBindingResponse *)response;
@end
@interface MovierDCInterfaceBinding : NSObject <MovierDCInterfaceBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(MovierDCInterfaceBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (MovierDCInterfaceBindingResponse *)getmodulelistUsingBody:(MovierDCInterfaceSvc_getmodulelist *)aBody ;
- (void)getmodulelistAsyncUsingBody:(MovierDCInterfaceSvc_getmodulelist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gettotalmodulenumUsingBody:(MovierDCInterfaceSvc_gettotalmodulenum *)aBody ;
- (void)gettotalmodulenumAsyncUsingBody:(MovierDCInterfaceSvc_gettotalmodulenum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmodulelistexUsingBody:(MovierDCInterfaceSvc_getmodulelistex *)aBody ;
- (void)getmodulelistexAsyncUsingBody:(MovierDCInterfaceSvc_getmodulelistex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmodulebyidUsingBody:(MovierDCInterfaceSvc_getmodulebyid *)aBody ;
- (void)getmodulebyidAsyncUsingBody:(MovierDCInterfaceSvc_getmodulebyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmodulebynameUsingBody:(MovierDCInterfaceSvc_getmodulebyname *)aBody ;
- (void)getmodulebynameAsyncUsingBody:(MovierDCInterfaceSvc_getmodulebyname *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)createmoduleUsingBody:(MovierDCInterfaceSvc_createmodule *)aBody ;
- (void)createmoduleAsyncUsingBody:(MovierDCInterfaceSvc_createmodule *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)updatemoduleUsingBody:(MovierDCInterfaceSvc_updatemodule *)aBody ;
- (void)updatemoduleAsyncUsingBody:(MovierDCInterfaceSvc_updatemodule *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)querymoduleUsingBody:(MovierDCInterfaceSvc_querymodule *)aBody ;
- (void)querymoduleAsyncUsingBody:(MovierDCInterfaceSvc_querymodule *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmodulebyorderidUsingBody:(MovierDCInterfaceSvc_getmodulebyorderid *)aBody ;
- (void)getmodulebyorderidAsyncUsingBody:(MovierDCInterfaceSvc_getmodulebyorderid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)connectiontestUsingBody:(MovierDCInterfaceSvc_connectiontest *)aBody ;
- (void)connectiontestAsyncUsingBody:(MovierDCInterfaceSvc_connectiontest *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)registerusingemailUsingBody:(MovierDCInterfaceSvc_registerusingemail *)aBody ;
- (void)registerusingemailAsyncUsingBody:(MovierDCInterfaceSvc_registerusingemail *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)registerusingtelUsingBody:(MovierDCInterfaceSvc_registerusingtel *)aBody ;
- (void)registerusingtelAsyncUsingBody:(MovierDCInterfaceSvc_registerusingtel *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)registerusingthirdpartyaccountUsingBody:(MovierDCInterfaceSvc_registerusingthirdpartyaccount *)aBody ;
- (void)registerusingthirdpartyaccountAsyncUsingBody:(MovierDCInterfaceSvc_registerusingthirdpartyaccount *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)registerusingfullinfoUsingBody:(MovierDCInterfaceSvc_registerusingfullinfo *)aBody ;
- (void)registerusingfullinfoAsyncUsingBody:(MovierDCInterfaceSvc_registerusingfullinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)loginUsingBody:(MovierDCInterfaceSvc_login *)aBody ;
- (void)loginAsyncUsingBody:(MovierDCInterfaceSvc_login *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)loginexUsingBody:(MovierDCInterfaceSvc_loginex *)aBody ;
- (void)loginexAsyncUsingBody:(MovierDCInterfaceSvc_loginex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)thirdpartyloginUsingBody:(MovierDCInterfaceSvc_thirdpartylogin *)aBody ;
- (void)thirdpartyloginAsyncUsingBody:(MovierDCInterfaceSvc_thirdpartylogin *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)thirdpartygetsecretUsingBody:(MovierDCInterfaceSvc_thirdpartygetsecret *)aBody ;
- (void)thirdpartygetsecretAsyncUsingBody:(MovierDCInterfaceSvc_thirdpartygetsecret *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getcustomerinfoUsingBody:(MovierDCInterfaceSvc_getcustomerinfo *)aBody ;
- (void)getcustomerinfoAsyncUsingBody:(MovierDCInterfaceSvc_getcustomerinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getcustomerinfoexUsingBody:(MovierDCInterfaceSvc_getcustomerinfoex *)aBody ;
- (void)getcustomerinfoexAsyncUsingBody:(MovierDCInterfaceSvc_getcustomerinfoex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getcustomerinfoex2UsingBody:(MovierDCInterfaceSvc_getcustomerinfoex2 *)aBody ;
- (void)getcustomerinfoex2AsyncUsingBody:(MovierDCInterfaceSvc_getcustomerinfoex2 *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)updatecustomerinfoUsingBody:(MovierDCInterfaceSvc_updatecustomerinfo *)aBody ;
- (void)updatecustomerinfoAsyncUsingBody:(MovierDCInterfaceSvc_updatecustomerinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getossconfigUsingBody:(MovierDCInterfaceSvc_getossconfig *)aBody ;
- (void)getossconfigAsyncUsingBody:(MovierDCInterfaceSvc_getossconfig *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getprivilegeinfoUsingBody:(MovierDCInterfaceSvc_getprivilegeinfo *)aBody ;
- (void)getprivilegeinfoAsyncUsingBody:(MovierDCInterfaceSvc_getprivilegeinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)updateuserinfoUsingBody:(MovierDCInterfaceSvc_updateuserinfo *)aBody ;
- (void)updateuserinfoAsyncUsingBody:(MovierDCInterfaceSvc_updateuserinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)activeuserUsingBody:(MovierDCInterfaceSvc_activeuser *)aBody ;
- (void)activeuserAsyncUsingBody:(MovierDCInterfaceSvc_activeuser *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)logoutUsingBody:(MovierDCInterfaceSvc_logout *)aBody ;
- (void)logoutAsyncUsingBody:(MovierDCInterfaceSvc_logout *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getorderUsingBody:(MovierDCInterfaceSvc_getorder *)aBody ;
- (void)getorderAsyncUsingBody:(MovierDCInterfaceSvc_getorder *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetorderUsingBody:(MovierDCInterfaceSvc_vpgetorder *)aBody ;
- (void)vpgetorderAsyncUsingBody:(MovierDCInterfaceSvc_vpgetorder *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)ordercompleteUsingBody:(MovierDCInterfaceSvc_ordercomplete *)aBody ;
- (void)ordercompleteAsyncUsingBody:(MovierDCInterfaceSvc_ordercomplete *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)orderprocessfailUsingBody:(MovierDCInterfaceSvc_orderprocessfail *)aBody ;
- (void)orderprocessfailAsyncUsingBody:(MovierDCInterfaceSvc_orderprocessfail *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)createorderUsingBody:(MovierDCInterfaceSvc_createorder *)aBody ;
- (void)createorderAsyncUsingBody:(MovierDCInterfaceSvc_createorder *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpcreateorderUsingBody:(MovierDCInterfaceSvc_vpcreateorder *)aBody ;
- (void)vpcreateorderAsyncUsingBody:(MovierDCInterfaceSvc_vpcreateorder *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)queryorderbyidUsingBody:(MovierDCInterfaceSvc_queryorderbyid *)aBody ;
- (void)queryorderbyidAsyncUsingBody:(MovierDCInterfaceSvc_queryorderbyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)queryordersUsingBody:(MovierDCInterfaceSvc_queryorders *)aBody ;
- (void)queryordersAsyncUsingBody:(MovierDCInterfaceSvc_queryorders *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)queryordersbyidarrUsingBody:(MovierDCInterfaceSvc_queryordersbyidarr *)aBody ;
- (void)queryordersbyidarrAsyncUsingBody:(MovierDCInterfaceSvc_queryordersbyidarr *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getordertotalnumbystatusUsingBody:(MovierDCInterfaceSvc_getordertotalnumbystatus *)aBody ;
- (void)getordertotalnumbystatusAsyncUsingBody:(MovierDCInterfaceSvc_getordertotalnumbystatus *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)queryordersbyorderstatusUsingBody:(MovierDCInterfaceSvc_queryordersbyorderstatus *)aBody ;
- (void)queryordersbyorderstatusAsyncUsingBody:(MovierDCInterfaceSvc_queryordersbyorderstatus *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)querynoticeUsingBody:(MovierDCInterfaceSvc_querynotice *)aBody ;
- (void)querynoticeAsyncUsingBody:(MovierDCInterfaceSvc_querynotice *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)querynoticebytypeUsingBody:(MovierDCInterfaceSvc_querynoticebytype *)aBody ;
- (void)querynoticebytypeAsyncUsingBody:(MovierDCInterfaceSvc_querynoticebytype *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmusicinfobyidUsingBody:(MovierDCInterfaceSvc_getmusicinfobyid *)aBody ;
- (void)getmusicinfobyidAsyncUsingBody:(MovierDCInterfaceSvc_getmusicinfobyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmusicinfobynameUsingBody:(MovierDCInterfaceSvc_getmusicinfobyname *)aBody ;
- (void)getmusicinfobynameAsyncUsingBody:(MovierDCInterfaceSvc_getmusicinfobyname *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmusicinfolistUsingBody:(MovierDCInterfaceSvc_getmusicinfolist *)aBody ;
- (void)getmusicinfolistAsyncUsingBody:(MovierDCInterfaceSvc_getmusicinfolist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideolabeltotalnumUsingBody:(MovierDCInterfaceSvc_getvideolabeltotalnum *)aBody ;
- (void)getvideolabeltotalnumAsyncUsingBody:(MovierDCInterfaceSvc_getvideolabeltotalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideolabeltotalnumbyparentidUsingBody:(MovierDCInterfaceSvc_getvideolabeltotalnumbyparentid *)aBody ;
- (void)getvideolabeltotalnumbyparentidAsyncUsingBody:(MovierDCInterfaceSvc_getvideolabeltotalnumbyparentid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideolabelsUsingBody:(MovierDCInterfaceSvc_getvideolabels *)aBody ;
- (void)getvideolabelsAsyncUsingBody:(MovierDCInterfaceSvc_getvideolabels *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideolabelsbyparentidUsingBody:(MovierDCInterfaceSvc_getvideolabelsbyparentid *)aBody ;
- (void)getvideolabelsbyparentidAsyncUsingBody:(MovierDCInterfaceSvc_getvideolabelsbyparentid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideolabelsexUsingBody:(MovierDCInterfaceSvc_getvideolabelsex *)aBody ;
- (void)getvideolabelsexAsyncUsingBody:(MovierDCInterfaceSvc_getvideolabelsex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideolabelsexbyparentidUsingBody:(MovierDCInterfaceSvc_getvideolabelsexbyparentid *)aBody ;
- (void)getvideolabelsexbyparentidAsyncUsingBody:(MovierDCInterfaceSvc_getvideolabelsexbyparentid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideototalbylabelidUsingBody:(MovierDCInterfaceSvc_getvideototalbylabelid *)aBody ;
- (void)getvideototalbylabelidAsyncUsingBody:(MovierDCInterfaceSvc_getvideototalbylabelid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideototalbylabelnameUsingBody:(MovierDCInterfaceSvc_getvideototalbylabelname *)aBody ;
- (void)getvideototalbylabelnameAsyncUsingBody:(MovierDCInterfaceSvc_getvideototalbylabelname *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideobylabelidUsingBody:(MovierDCInterfaceSvc_getvideobylabelid *)aBody ;
- (void)getvideobylabelidAsyncUsingBody:(MovierDCInterfaceSvc_getvideobylabelid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideobylabelidexUsingBody:(MovierDCInterfaceSvc_getvideobylabelidex *)aBody ;
- (void)getvideobylabelidexAsyncUsingBody:(MovierDCInterfaceSvc_getvideobylabelidex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideobylabelnameUsingBody:(MovierDCInterfaceSvc_getvideobylabelname *)aBody ;
- (void)getvideobylabelnameAsyncUsingBody:(MovierDCInterfaceSvc_getvideobylabelname *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)praisevideobyidUsingBody:(MovierDCInterfaceSvc_praisevideobyid *)aBody ;
- (void)praisevideobyidAsyncUsingBody:(MovierDCInterfaceSvc_praisevideobyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)unpraisevideobyidUsingBody:(MovierDCInterfaceSvc_unpraisevideobyid *)aBody ;
- (void)unpraisevideobyidAsyncUsingBody:(MovierDCInterfaceSvc_unpraisevideobyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)increasevideoattrUsingBody:(MovierDCInterfaceSvc_increasevideoattr *)aBody ;
- (void)increasevideoattrAsyncUsingBody:(MovierDCInterfaceSvc_increasevideoattr *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)increasevideoattr4cUsingBody:(MovierDCInterfaceSvc_increasevideoattr4c *)aBody ;
- (void)increasevideoattr4cAsyncUsingBody:(MovierDCInterfaceSvc_increasevideoattr4c *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)praisevideobynameUsingBody:(MovierDCInterfaceSvc_praisevideobyname *)aBody ;
- (void)praisevideobynameAsyncUsingBody:(MovierDCInterfaceSvc_praisevideobyname *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)increasesharenumbyidUsingBody:(MovierDCInterfaceSvc_increasesharenumbyid *)aBody ;
- (void)increasesharenumbyidAsyncUsingBody:(MovierDCInterfaceSvc_increasesharenumbyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)increasesharenumbynameUsingBody:(MovierDCInterfaceSvc_increasesharenumbyname *)aBody ;
- (void)increasesharenumbynameAsyncUsingBody:(MovierDCInterfaceSvc_increasesharenumbyname *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)markfavoritebyidUsingBody:(MovierDCInterfaceSvc_markfavoritebyid *)aBody ;
- (void)markfavoritebyidAsyncUsingBody:(MovierDCInterfaceSvc_markfavoritebyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)markfavoritebynameUsingBody:(MovierDCInterfaceSvc_markfavoritebyname *)aBody ;
- (void)markfavoritebynameAsyncUsingBody:(MovierDCInterfaceSvc_markfavoritebyname *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getfavoritevideototalnumUsingBody:(MovierDCInterfaceSvc_getfavoritevideototalnum *)aBody ;
- (void)getfavoritevideototalnumAsyncUsingBody:(MovierDCInterfaceSvc_getfavoritevideototalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getfavoritevideoUsingBody:(MovierDCInterfaceSvc_getfavoritevideo *)aBody ;
- (void)getfavoritevideoAsyncUsingBody:(MovierDCInterfaceSvc_getfavoritevideo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getfavoritevideoexUsingBody:(MovierDCInterfaceSvc_getfavoritevideoex *)aBody ;
- (void)getfavoritevideoexAsyncUsingBody:(MovierDCInterfaceSvc_getfavoritevideoex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmoduleallstyleUsingBody:(MovierDCInterfaceSvc_getmoduleallstyle *)aBody ;
- (void)getmoduleallstyleAsyncUsingBody:(MovierDCInterfaceSvc_getmoduleallstyle *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmoduletotalnumbystyleUsingBody:(MovierDCInterfaceSvc_getmoduletotalnumbystyle *)aBody ;
- (void)getmoduletotalnumbystyleAsyncUsingBody:(MovierDCInterfaceSvc_getmoduletotalnumbystyle *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmodulebystyleUsingBody:(MovierDCInterfaceSvc_getmodulebystyle *)aBody ;
- (void)getmodulebystyleAsyncUsingBody:(MovierDCInterfaceSvc_getmodulebystyle *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)submitfeedbackUsingBody:(MovierDCInterfaceSvc_submitfeedback *)aBody ;
- (void)submitfeedbackAsyncUsingBody:(MovierDCInterfaceSvc_submitfeedback *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gettotalnumofvideoforhomepageUsingBody:(MovierDCInterfaceSvc_gettotalnumofvideoforhomepage *)aBody ;
- (void)gettotalnumofvideoforhomepageAsyncUsingBody:(MovierDCInterfaceSvc_gettotalnumofvideoforhomepage *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideoforhomepageUsingBody:(MovierDCInterfaceSvc_getvideoforhomepage *)aBody ;
- (void)getvideoforhomepageAsyncUsingBody:(MovierDCInterfaceSvc_getvideoforhomepage *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideoforhomepageexUsingBody:(MovierDCInterfaceSvc_getvideoforhomepageex *)aBody ;
- (void)getvideoforhomepageexAsyncUsingBody:(MovierDCInterfaceSvc_getvideoforhomepageex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideobyorderidarrUsingBody:(MovierDCInterfaceSvc_getvideobyorderidarr *)aBody ;
- (void)getvideobyorderidarrAsyncUsingBody:(MovierDCInterfaceSvc_getvideobyorderidarr *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideobyorderidarrexUsingBody:(MovierDCInterfaceSvc_getvideobyorderidarrex *)aBody ;
- (void)getvideobyorderidarrexAsyncUsingBody:(MovierDCInterfaceSvc_getvideobyorderidarrex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideobyvideoidarrUsingBody:(MovierDCInterfaceSvc_getvideobyvideoidarr *)aBody ;
- (void)getvideobyvideoidarrAsyncUsingBody:(MovierDCInterfaceSvc_getvideobyvideoidarr *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideobyvideoidarrexUsingBody:(MovierDCInterfaceSvc_getvideobyvideoidarrex *)aBody ;
- (void)getvideobyvideoidarrexAsyncUsingBody:(MovierDCInterfaceSvc_getvideobyvideoidarrex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getosssignatureUsingBody:(MovierDCInterfaceSvc_getosssignature *)aBody ;
- (void)getosssignatureAsyncUsingBody:(MovierDCInterfaceSvc_getosssignature *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvpelementtotalnumUsingBody:(MovierDCInterfaceSvc_getvpelementtotalnum *)aBody ;
- (void)getvpelementtotalnumAsyncUsingBody:(MovierDCInterfaceSvc_getvpelementtotalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetheaderstyletotalnumUsingBody:(MovierDCInterfaceSvc_vpgetheaderstyletotalnum *)aBody ;
- (void)vpgetheaderstyletotalnumAsyncUsingBody:(MovierDCInterfaceSvc_vpgetheaderstyletotalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetheaderstyleUsingBody:(MovierDCInterfaceSvc_vpgetheaderstyle *)aBody ;
- (void)vpgetheaderstyleAsyncUsingBody:(MovierDCInterfaceSvc_vpgetheaderstyle *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgettemplatecattotalnumUsingBody:(MovierDCInterfaceSvc_vpgettemplatecattotalnum *)aBody ;
- (void)vpgettemplatecattotalnumAsyncUsingBody:(MovierDCInterfaceSvc_vpgettemplatecattotalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgettemplatecatUsingBody:(MovierDCInterfaceSvc_vpgettemplatecat *)aBody ;
- (void)vpgettemplatecatAsyncUsingBody:(MovierDCInterfaceSvc_vpgettemplatecat *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetheaderandtailtotalbycatUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat *)aBody ;
- (void)vpgetheaderandtailtotalbycatAsyncUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetheaderandtailbycatUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailbycat *)aBody ;
- (void)vpgetheaderandtailbycatAsyncUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailbycat *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetheaderandtailUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtail *)aBody ;
- (void)vpgetheaderandtailAsyncUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtail *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetheaderandtailexbycatUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailexbycat *)aBody ;
- (void)vpgetheaderandtailexbycatAsyncUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailexbycat *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetheaderandtailexUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailex *)aBody ;
- (void)vpgetheaderandtailexAsyncUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetheaderandtailvisitcountUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailvisitcount *)aBody ;
- (void)vpgetheaderandtailvisitcountAsyncUsingBody:(MovierDCInterfaceSvc_vpgetheaderandtailvisitcount *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpincreaseheaderandtailvisitcountUsingBody:(MovierDCInterfaceSvc_vpincreaseheaderandtailvisitcount *)aBody ;
- (void)vpincreaseheaderandtailvisitcountAsyncUsingBody:(MovierDCInterfaceSvc_vpincreaseheaderandtailvisitcount *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetdefaultmusicandsubtitlebyheaderandtailidUsingBody:(MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid *)aBody ;
- (void)vpgetdefaultmusicandsubtitlebyheaderandtailidAsyncUsingBody:(MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetfilterstyletotalnumUsingBody:(MovierDCInterfaceSvc_vpgetfilterstyletotalnum *)aBody ;
- (void)vpgetfilterstyletotalnumAsyncUsingBody:(MovierDCInterfaceSvc_vpgetfilterstyletotalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetfilterstyleUsingBody:(MovierDCInterfaceSvc_vpgetfilterstyle *)aBody ;
- (void)vpgetfilterstyleAsyncUsingBody:(MovierDCInterfaceSvc_vpgetfilterstyle *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetfilterUsingBody:(MovierDCInterfaceSvc_vpgetfilter *)aBody ;
- (void)vpgetfilterAsyncUsingBody:(MovierDCInterfaceSvc_vpgetfilter *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetmusicUsingBody:(MovierDCInterfaceSvc_vpgetmusic *)aBody ;
- (void)vpgetmusicAsyncUsingBody:(MovierDCInterfaceSvc_vpgetmusic *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetsubtitleUsingBody:(MovierDCInterfaceSvc_vpgetsubtitle *)aBody ;
- (void)vpgetsubtitleAsyncUsingBody:(MovierDCInterfaceSvc_vpgetsubtitle *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetstylebyidUsingBody:(MovierDCInterfaceSvc_vpgetstylebyid *)aBody ;
- (void)vpgetstylebyidAsyncUsingBody:(MovierDCInterfaceSvc_vpgetstylebyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetfilterbyidUsingBody:(MovierDCInterfaceSvc_vpgetfilterbyid *)aBody ;
- (void)vpgetfilterbyidAsyncUsingBody:(MovierDCInterfaceSvc_vpgetfilterbyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetmusicbyidUsingBody:(MovierDCInterfaceSvc_vpgetmusicbyid *)aBody ;
- (void)vpgetmusicbyidAsyncUsingBody:(MovierDCInterfaceSvc_vpgetmusicbyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpsearchonlinemusicUsingBody:(MovierDCInterfaceSvc_vpsearchonlinemusic *)aBody ;
- (void)vpsearchonlinemusicAsyncUsingBody:(MovierDCInterfaceSvc_vpsearchonlinemusic *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetsubtitlebyidUsingBody:(MovierDCInterfaceSvc_vpgetsubtitlebyid *)aBody ;
- (void)vpgetsubtitlebyidAsyncUsingBody:(MovierDCInterfaceSvc_vpgetsubtitlebyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpupdatevideosharestatusUsingBody:(MovierDCInterfaceSvc_vpupdatevideosharestatus *)aBody ;
- (void)vpupdatevideosharestatusAsyncUsingBody:(MovierDCInterfaceSvc_vpupdatevideosharestatus *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpremovevideoUsingBody:(MovierDCInterfaceSvc_vpremovevideo *)aBody ;
- (void)vpremovevideoAsyncUsingBody:(MovierDCInterfaceSvc_vpremovevideo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetfavouritestatusUsingBody:(MovierDCInterfaceSvc_vpgetfavouritestatus *)aBody ;
- (void)vpgetfavouritestatusAsyncUsingBody:(MovierDCInterfaceSvc_vpgetfavouritestatus *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetpraisestatusUsingBody:(MovierDCInterfaceSvc_vpgetpraisestatus *)aBody ;
- (void)vpgetpraisestatusAsyncUsingBody:(MovierDCInterfaceSvc_vpgetpraisestatus *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetsubtitlemodelbyidUsingBody:(MovierDCInterfaceSvc_vpgetsubtitlemodelbyid *)aBody ;
- (void)vpgetsubtitlemodelbyidAsyncUsingBody:(MovierDCInterfaceSvc_vpgetsubtitlemodelbyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)changepasswordUsingBody:(MovierDCInterfaceSvc_changepassword *)aBody ;
- (void)changepasswordAsyncUsingBody:(MovierDCInterfaceSvc_changepassword *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)checktelnumusabilityUsingBody:(MovierDCInterfaceSvc_checktelnumusability *)aBody ;
- (void)checktelnumusabilityAsyncUsingBody:(MovierDCInterfaceSvc_checktelnumusability *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)checkemailusabilityUsingBody:(MovierDCInterfaceSvc_checkemailusability *)aBody ;
- (void)checkemailusabilityAsyncUsingBody:(MovierDCInterfaceSvc_checkemailusability *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)resetpasswordusingtelUsingBody:(MovierDCInterfaceSvc_resetpasswordusingtel *)aBody ;
- (void)resetpasswordusingtelAsyncUsingBody:(MovierDCInterfaceSvc_resetpasswordusingtel *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)resetpasswordusingemailUsingBody:(MovierDCInterfaceSvc_resetpasswordusingemail *)aBody ;
- (void)resetpasswordusingemailAsyncUsingBody:(MovierDCInterfaceSvc_resetpasswordusingemail *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getapplatestversionUsingBody:(MovierDCInterfaceSvc_getapplatestversion *)aBody ;
- (void)getapplatestversionAsyncUsingBody:(MovierDCInterfaceSvc_getapplatestversion *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getappversionUsingBody:(MovierDCInterfaceSvc_getappversion *)aBody ;
- (void)getappversionAsyncUsingBody:(MovierDCInterfaceSvc_getappversion *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)userreportUsingBody:(MovierDCInterfaceSvc_userreport *)aBody ;
- (void)userreportAsyncUsingBody:(MovierDCInterfaceSvc_userreport *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpsubmitcommentUsingBody:(MovierDCInterfaceSvc_vpsubmitcomment *)aBody ;
- (void)vpsubmitcommentAsyncUsingBody:(MovierDCInterfaceSvc_vpsubmitcomment *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetcommenttotalnumUsingBody:(MovierDCInterfaceSvc_vpgetcommenttotalnum *)aBody ;
- (void)vpgetcommenttotalnumAsyncUsingBody:(MovierDCInterfaceSvc_vpgetcommenttotalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetcommentUsingBody:(MovierDCInterfaceSvc_vpgetcomment *)aBody ;
- (void)vpgetcommentAsyncUsingBody:(MovierDCInterfaceSvc_vpgetcomment *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgetcommentexUsingBody:(MovierDCInterfaceSvc_vpgetcommentex *)aBody ;
- (void)vpgetcommentexAsyncUsingBody:(MovierDCInterfaceSvc_vpgetcommentex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpremovecommentUsingBody:(MovierDCInterfaceSvc_vpremovecomment *)aBody ;
- (void)vpremovecommentAsyncUsingBody:(MovierDCInterfaceSvc_vpremovecomment *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpreportcommentUsingBody:(MovierDCInterfaceSvc_vpreportcomment *)aBody ;
- (void)vpreportcommentAsyncUsingBody:(MovierDCInterfaceSvc_vpreportcomment *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)createactivityUsingBody:(MovierDCInterfaceSvc_createactivity *)aBody ;
- (void)createactivityAsyncUsingBody:(MovierDCInterfaceSvc_createactivity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)removeactivityUsingBody:(MovierDCInterfaceSvc_removeactivity *)aBody ;
- (void)removeactivityAsyncUsingBody:(MovierDCInterfaceSvc_removeactivity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)joinactivityUsingBody:(MovierDCInterfaceSvc_joinactivity *)aBody ;
- (void)joinactivityAsyncUsingBody:(MovierDCInterfaceSvc_joinactivity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)quitactivityUsingBody:(MovierDCInterfaceSvc_quitactivity *)aBody ;
- (void)quitactivityAsyncUsingBody:(MovierDCInterfaceSvc_quitactivity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)sendinvitebytelnumUsingBody:(MovierDCInterfaceSvc_sendinvitebytelnum *)aBody ;
- (void)sendinvitebytelnumAsyncUsingBody:(MovierDCInterfaceSvc_sendinvitebytelnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)sendinvitebyemailUsingBody:(MovierDCInterfaceSvc_sendinvitebyemail *)aBody ;
- (void)sendinvitebyemailAsyncUsingBody:(MovierDCInterfaceSvc_sendinvitebyemail *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)removememberfromactivityUsingBody:(MovierDCInterfaceSvc_removememberfromactivity *)aBody ;
- (void)removememberfromactivityAsyncUsingBody:(MovierDCInterfaceSvc_removememberfromactivity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)changepassword4activityUsingBody:(MovierDCInterfaceSvc_changepassword4activity *)aBody ;
- (void)changepassword4activityAsyncUsingBody:(MovierDCInterfaceSvc_changepassword4activity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)updatestoragecapacityUsingBody:(MovierDCInterfaceSvc_updatestoragecapacity *)aBody ;
- (void)updatestoragecapacityAsyncUsingBody:(MovierDCInterfaceSvc_updatestoragecapacity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getactivitymemberidlistUsingBody:(MovierDCInterfaceSvc_getactivitymemberidlist *)aBody ;
- (void)getactivitymemberidlistAsyncUsingBody:(MovierDCInterfaceSvc_getactivitymemberidlist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getactivitymemberinfolistUsingBody:(MovierDCInterfaceSvc_getactivitymemberinfolist *)aBody ;
- (void)getactivitymemberinfolistAsyncUsingBody:(MovierDCInterfaceSvc_getactivitymemberinfolist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getactivityinfoUsingBody:(MovierDCInterfaceSvc_getactivityinfo *)aBody ;
- (void)getactivityinfoAsyncUsingBody:(MovierDCInterfaceSvc_getactivityinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getactivitytotalnumUsingBody:(MovierDCInterfaceSvc_getactivitytotalnum *)aBody ;
- (void)getactivitytotalnumAsyncUsingBody:(MovierDCInterfaceSvc_getactivitytotalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getactivitylistUsingBody:(MovierDCInterfaceSvc_getactivitylist *)aBody ;
- (void)getactivitylistAsyncUsingBody:(MovierDCInterfaceSvc_getactivitylist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)reportactivityUsingBody:(MovierDCInterfaceSvc_reportactivity *)aBody ;
- (void)reportactivityAsyncUsingBody:(MovierDCInterfaceSvc_reportactivity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)createorder4activityUsingBody:(MovierDCInterfaceSvc_createorder4activity *)aBody ;
- (void)createorder4activityAsyncUsingBody:(MovierDCInterfaceSvc_createorder4activity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)createfile4activityUsingBody:(MovierDCInterfaceSvc_createfile4activity *)aBody ;
- (void)createfile4activityAsyncUsingBody:(MovierDCInterfaceSvc_createfile4activity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)createfile4activityconfirmUsingBody:(MovierDCInterfaceSvc_createfile4activityconfirm *)aBody ;
- (void)createfile4activityconfirmAsyncUsingBody:(MovierDCInterfaceSvc_createfile4activityconfirm *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)removefile4activityUsingBody:(MovierDCInterfaceSvc_removefile4activity *)aBody ;
- (void)removefile4activityAsyncUsingBody:(MovierDCInterfaceSvc_removefile4activity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getactivitytotalnum4customerUsingBody:(MovierDCInterfaceSvc_getactivitytotalnum4customer *)aBody ;
- (void)getactivitytotalnum4customerAsyncUsingBody:(MovierDCInterfaceSvc_getactivitytotalnum4customer *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getactivitylist4customerUsingBody:(MovierDCInterfaceSvc_getactivitylist4customer *)aBody ;
- (void)getactivitylist4customerAsyncUsingBody:(MovierDCInterfaceSvc_getactivitylist4customer *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)updatecustomercapacityUsingBody:(MovierDCInterfaceSvc_updatecustomercapacity *)aBody ;
- (void)updatecustomercapacityAsyncUsingBody:(MovierDCInterfaceSvc_updatecustomercapacity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getcustomercapacityUsingBody:(MovierDCInterfaceSvc_getcustomercapacity *)aBody ;
- (void)getcustomercapacityAsyncUsingBody:(MovierDCInterfaceSvc_getcustomercapacity *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)removevideofileUsingBody:(MovierDCInterfaceSvc_removevideofile *)aBody ;
- (void)removevideofileAsyncUsingBody:(MovierDCInterfaceSvc_removevideofile *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)searchuserUsingBody:(MovierDCInterfaceSvc_searchuser *)aBody ;
- (void)searchuserAsyncUsingBody:(MovierDCInterfaceSvc_searchuser *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)searchvideoUsingBody:(MovierDCInterfaceSvc_searchvideo *)aBody ;
- (void)searchvideoAsyncUsingBody:(MovierDCInterfaceSvc_searchvideo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getbannertotalnumUsingBody:(MovierDCInterfaceSvc_getbannertotalnum *)aBody ;
- (void)getbannertotalnumAsyncUsingBody:(MovierDCInterfaceSvc_getbannertotalnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getbannerUsingBody:(MovierDCInterfaceSvc_getbanner *)aBody ;
- (void)getbannerAsyncUsingBody:(MovierDCInterfaceSvc_getbanner *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getbannerexUsingBody:(MovierDCInterfaceSvc_getbannerex *)aBody ;
- (void)getbannerexAsyncUsingBody:(MovierDCInterfaceSvc_getbannerex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)updatetelnumUsingBody:(MovierDCInterfaceSvc_updatetelnum *)aBody ;
- (void)updatetelnumAsyncUsingBody:(MovierDCInterfaceSvc_updatetelnum *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)updatetelnumexUsingBody:(MovierDCInterfaceSvc_updatetelnumex *)aBody ;
- (void)updatetelnumexAsyncUsingBody:(MovierDCInterfaceSvc_updatetelnumex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpcreateorderfollowexistUsingBody:(MovierDCInterfaceSvc_vpcreateorderfollowexist *)aBody ;
- (void)vpcreateorderfollowexistAsyncUsingBody:(MovierDCInterfaceSvc_vpcreateorderfollowexist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpcreateorderfollowexistexUsingBody:(MovierDCInterfaceSvc_vpcreateorderfollowexistex *)aBody ;
- (void)vpcreateorderfollowexistexAsyncUsingBody:(MovierDCInterfaceSvc_vpcreateorderfollowexistex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)vpgettelnumsettingstatusUsingBody:(MovierDCInterfaceSvc_vpgettelnumsettingstatus *)aBody ;
- (void)vpgettelnumsettingstatusAsyncUsingBody:(MovierDCInterfaceSvc_vpgettelnumsettingstatus *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)registerusingthirdpartyaccountexUsingBody:(MovierDCInterfaceSvc_registerusingthirdpartyaccountex *)aBody ;
- (void)registerusingthirdpartyaccountexAsyncUsingBody:(MovierDCInterfaceSvc_registerusingthirdpartyaccountex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)registerusingthirdpartyaccount4wechatUsingBody:(MovierDCInterfaceSvc_registerusingthirdpartyaccount4wechat *)aBody ;
- (void)registerusingthirdpartyaccount4wechatAsyncUsingBody:(MovierDCInterfaceSvc_registerusingthirdpartyaccount4wechat *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getpicbyheightandwidthUsingBody:(MovierDCInterfaceSvc_getpicbyheightandwidth *)aBody ;
- (void)getpicbyheightandwidthAsyncUsingBody:(MovierDCInterfaceSvc_getpicbyheightandwidth *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getpicbyratioindexUsingBody:(MovierDCInterfaceSvc_getpicbyratioindex *)aBody ;
- (void)getpicbyratioindexAsyncUsingBody:(MovierDCInterfaceSvc_getpicbyratioindex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getcuponforgmUsingBody:(MovierDCInterfaceSvc_getcuponforgm *)aBody ;
- (void)getcuponforgmAsyncUsingBody:(MovierDCInterfaceSvc_getcuponforgm *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideolabelexbylabelidUsingBody:(MovierDCInterfaceSvc_getvideolabelexbylabelid *)aBody ;
- (void)getvideolabelexbylabelidAsyncUsingBody:(MovierDCInterfaceSvc_getvideolabelexbylabelid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getstylebyvideoidUsingBody:(MovierDCInterfaceSvc_getstylebyvideoid *)aBody ;
- (void)getstylebyvideoidAsyncUsingBody:(MovierDCInterfaceSvc_getstylebyvideoid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getstylebylabelidUsingBody:(MovierDCInterfaceSvc_getstylebylabelid *)aBody ;
- (void)getstylebylabelidAsyncUsingBody:(MovierDCInterfaceSvc_getstylebylabelid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getspecialeffectbyeffectsetidUsingBody:(MovierDCInterfaceSvc_getspecialeffectbyeffectsetid *)aBody ;
- (void)getspecialeffectbyeffectsetidAsyncUsingBody:(MovierDCInterfaceSvc_getspecialeffectbyeffectsetid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getbeatinfoarrbybeatidUsingBody:(MovierDCInterfaceSvc_getbeatinfoarrbybeatid *)aBody ;
- (void)getbeatinfoarrbybeatidAsyncUsingBody:(MovierDCInterfaceSvc_getbeatinfoarrbybeatid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getcategoryfortemplateUsingBody:(MovierDCInterfaceSvc_getcategoryfortemplate *)aBody ;
- (void)getcategoryfortemplateAsyncUsingBody:(MovierDCInterfaceSvc_getcategoryfortemplate *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)shareUsingBody:(MovierDCInterfaceSvc_share *)aBody ;
- (void)shareAsyncUsingBody:(MovierDCInterfaceSvc_share *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)shareexUsingBody:(MovierDCInterfaceSvc_shareex *)aBody ;
- (void)shareexAsyncUsingBody:(MovierDCInterfaceSvc_shareex *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)updatethirdpartyaccountUsingBody:(MovierDCInterfaceSvc_updatethirdpartyaccount *)aBody ;
- (void)updatethirdpartyaccountAsyncUsingBody:(MovierDCInterfaceSvc_updatethirdpartyaccount *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getnewuserscoretaskUsingBody:(MovierDCInterfaceSvc_getnewuserscoretask *)aBody ;
- (void)getnewuserscoretaskAsyncUsingBody:(MovierDCInterfaceSvc_getnewuserscoretask *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gettelandthirdpartybindstatusUsingBody:(MovierDCInterfaceSvc_gettelandthirdpartybindstatus *)aBody ;
- (void)gettelandthirdpartybindstatusAsyncUsingBody:(MovierDCInterfaceSvc_gettelandthirdpartybindstatus *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmyscoreinshiancoinUsingBody:(MovierDCInterfaceSvc_getmyscoreinshiancoin *)aBody ;
- (void)getmyscoreinshiancoinAsyncUsingBody:(MovierDCInterfaceSvc_getmyscoreinshiancoin *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getscorelogUsingBody:(MovierDCInterfaceSvc_getscorelog *)aBody ;
- (void)getscorelogAsyncUsingBody:(MovierDCInterfaceSvc_getscorelog *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getdailyscoretaskUsingBody:(MovierDCInterfaceSvc_getdailyscoretask *)aBody ;
- (void)getdailyscoretaskAsyncUsingBody:(MovierDCInterfaceSvc_getdailyscoretask *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)operatedevicelistUsingBody:(MovierDCInterfaceSvc_operatedevicelist *)aBody ;
- (void)operatedevicelistAsyncUsingBody:(MovierDCInterfaceSvc_operatedevicelist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)sendprivatemessageUsingBody:(MovierDCInterfaceSvc_sendprivatemessage *)aBody ;
- (void)sendprivatemessageAsyncUsingBody:(MovierDCInterfaceSvc_sendprivatemessage *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)systemnoticeUsingBody:(MovierDCInterfaceSvc_systemnotice *)aBody ;
- (void)systemnoticeAsyncUsingBody:(MovierDCInterfaceSvc_systemnotice *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)messagepushonoffUsingBody:(MovierDCInterfaceSvc_messagepushonoff *)aBody ;
- (void)messagepushonoffAsyncUsingBody:(MovierDCInterfaceSvc_messagepushonoff *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)followUsingBody:(MovierDCInterfaceSvc_follow *)aBody ;
- (void)followAsyncUsingBody:(MovierDCInterfaceSvc_follow *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)unfollowUsingBody:(MovierDCInterfaceSvc_unfollow *)aBody ;
- (void)unfollowAsyncUsingBody:(MovierDCInterfaceSvc_unfollow *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getfollowlistUsingBody:(MovierDCInterfaceSvc_getfollowlist *)aBody ;
- (void)getfollowlistAsyncUsingBody:(MovierDCInterfaceSvc_getfollowlist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getfunslistUsingBody:(MovierDCInterfaceSvc_getfunslist *)aBody ;
- (void)getfunslistAsyncUsingBody:(MovierDCInterfaceSvc_getfunslist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getfriendlistUsingBody:(MovierDCInterfaceSvc_getfriendlist *)aBody ;
- (void)getfriendlistAsyncUsingBody:(MovierDCInterfaceSvc_getfriendlist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getfriendamountUsingBody:(MovierDCInterfaceSvc_getfriendamount *)aBody ;
- (void)getfriendamountAsyncUsingBody:(MovierDCInterfaceSvc_getfriendamount *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getfriendrelationUsingBody:(MovierDCInterfaceSvc_getfriendrelation *)aBody ;
- (void)getfriendrelationAsyncUsingBody:(MovierDCInterfaceSvc_getfriendrelation *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)searchfriendUsingBody:(MovierDCInterfaceSvc_searchfriend *)aBody ;
- (void)searchfriendAsyncUsingBody:(MovierDCInterfaceSvc_searchfriend *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)searchtelfriendUsingBody:(MovierDCInterfaceSvc_searchtelfriend *)aBody ;
- (void)searchtelfriendAsyncUsingBody:(MovierDCInterfaceSvc_searchtelfriend *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gethomepagebackgroundUsingBody:(MovierDCInterfaceSvc_gethomepagebackground *)aBody ;
- (void)gethomepagebackgroundAsyncUsingBody:(MovierDCInterfaceSvc_gethomepagebackground *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)checksessionUsingBody:(MovierDCInterfaceSvc_checksession *)aBody ;
- (void)checksessionAsyncUsingBody:(MovierDCInterfaceSvc_checksession *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)setvideoinfoUsingBody:(MovierDCInterfaceSvc_setvideoinfo *)aBody ;
- (void)setvideoinfoAsyncUsingBody:(MovierDCInterfaceSvc_setvideoinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideoinfoUsingBody:(MovierDCInterfaceSvc_getvideoinfo *)aBody ;
- (void)getvideoinfoAsyncUsingBody:(MovierDCInterfaceSvc_getvideoinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideosbyuseridUsingBody:(MovierDCInterfaceSvc_getvideosbyuserid *)aBody ;
- (void)getvideosbyuseridAsyncUsingBody:(MovierDCInterfaceSvc_getvideosbyuserid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)addtopicsforvideoUsingBody:(MovierDCInterfaceSvc_addtopicsforvideo *)aBody ;
- (void)addtopicsforvideoAsyncUsingBody:(MovierDCInterfaceSvc_addtopicsforvideo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)removetopicsforvideoUsingBody:(MovierDCInterfaceSvc_removetopicsforvideo *)aBody ;
- (void)removetopicsforvideoAsyncUsingBody:(MovierDCInterfaceSvc_removetopicsforvideo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gettopicsbyvideoidUsingBody:(MovierDCInterfaceSvc_gettopicsbyvideoid *)aBody ;
- (void)gettopicsbyvideoidAsyncUsingBody:(MovierDCInterfaceSvc_gettopicsbyvideoid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gettopicsbyparenttopicUsingBody:(MovierDCInterfaceSvc_gettopicsbyparenttopic *)aBody ;
- (void)gettopicsbyparenttopicAsyncUsingBody:(MovierDCInterfaceSvc_gettopicsbyparenttopic *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideosbytopicidUsingBody:(MovierDCInterfaceSvc_getvideosbytopicid *)aBody ;
- (void)getvideosbytopicidAsyncUsingBody:(MovierDCInterfaceSvc_getvideosbytopicid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)releasevideoUsingBody:(MovierDCInterfaceSvc_releasevideo *)aBody ;
- (void)releasevideoAsyncUsingBody:(MovierDCInterfaceSvc_releasevideo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)unreleasevideoUsingBody:(MovierDCInterfaceSvc_unreleasevideo *)aBody ;
- (void)unreleasevideoAsyncUsingBody:(MovierDCInterfaceSvc_unreleasevideo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)atfriendbycustomeridarrUsingBody:(MovierDCInterfaceSvc_atfriendbycustomeridarr *)aBody ;
- (void)atfriendbycustomeridarrAsyncUsingBody:(MovierDCInterfaceSvc_atfriendbycustomeridarr *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)searchtopicsUsingBody:(MovierDCInterfaceSvc_searchtopics *)aBody ;
- (void)searchtopicsAsyncUsingBody:(MovierDCInterfaceSvc_searchtopics *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getuserinfoUsingBody:(MovierDCInterfaceSvc_getuserinfo *)aBody ;
- (void)getuserinfoAsyncUsingBody:(MovierDCInterfaceSvc_getuserinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)setuserinfoUsingBody:(MovierDCInterfaceSvc_setuserinfo *)aBody ;
- (void)setuserinfoAsyncUsingBody:(MovierDCInterfaceSvc_setuserinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getbannerlistUsingBody:(MovierDCInterfaceSvc_getbannerlist *)aBody ;
- (void)getbannerlistAsyncUsingBody:(MovierDCInterfaceSvc_getbannerlist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getcollectvideosUsingBody:(MovierDCInterfaceSvc_getcollectvideos *)aBody ;
- (void)getcollectvideosAsyncUsingBody:(MovierDCInterfaceSvc_getcollectvideos *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getlabelsbyparentidUsingBody:(MovierDCInterfaceSvc_getlabelsbyparentid *)aBody ;
- (void)getlabelsbyparentidAsyncUsingBody:(MovierDCInterfaceSvc_getlabelsbyparentid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getchallengetaskpraiseUsingBody:(MovierDCInterfaceSvc_getchallengetaskpraise *)aBody ;
- (void)getchallengetaskpraiseAsyncUsingBody:(MovierDCInterfaceSvc_getchallengetaskpraise *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getchallengetaskviewUsingBody:(MovierDCInterfaceSvc_getchallengetaskview *)aBody ;
- (void)getchallengetaskviewAsyncUsingBody:(MovierDCInterfaceSvc_getchallengetaskview *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getorderbyidUsingBody:(MovierDCInterfaceSvc_getorderbyid *)aBody ;
- (void)getorderbyidAsyncUsingBody:(MovierDCInterfaceSvc_getorderbyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideoamountbyheaderandtailanddateUsingBody:(MovierDCInterfaceSvc_getvideoamountbyheaderandtailanddate *)aBody ;
- (void)getvideoamountbyheaderandtailanddateAsyncUsingBody:(MovierDCInterfaceSvc_getvideoamountbyheaderandtailanddate *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getshareamountbylabelidUsingBody:(MovierDCInterfaceSvc_getshareamountbylabelid *)aBody ;
- (void)getshareamountbylabelidAsyncUsingBody:(MovierDCInterfaceSvc_getshareamountbylabelid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getshareamountbyheaderandtailanddateUsingBody:(MovierDCInterfaceSvc_getshareamountbyheaderandtailanddate *)aBody ;
- (void)getshareamountbyheaderandtailanddateAsyncUsingBody:(MovierDCInterfaceSvc_getshareamountbyheaderandtailanddate *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)telregisterUsingBody:(MovierDCInterfaceSvc_telregister *)aBody ;
- (void)telregisterAsyncUsingBody:(MovierDCInterfaceSvc_telregister *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)thirdpartyregisterUsingBody:(MovierDCInterfaceSvc_thirdpartyregister *)aBody ;
- (void)thirdpartyregisterAsyncUsingBody:(MovierDCInterfaceSvc_thirdpartyregister *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)loginbyusernameUsingBody:(MovierDCInterfaceSvc_loginbyusername *)aBody ;
- (void)loginbyusernameAsyncUsingBody:(MovierDCInterfaceSvc_loginbyusername *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)loginbythirdpartyUsingBody:(MovierDCInterfaceSvc_loginbythirdparty *)aBody ;
- (void)loginbythirdpartyAsyncUsingBody:(MovierDCInterfaceSvc_loginbythirdparty *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideosbylabelidUsingBody:(MovierDCInterfaceSvc_getvideosbylabelid *)aBody ;
- (void)getvideosbylabelidAsyncUsingBody:(MovierDCInterfaceSvc_getvideosbylabelid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideosbyvideoidarrUsingBody:(MovierDCInterfaceSvc_getvideosbyvideoidarr *)aBody ;
- (void)getvideosbyvideoidarrAsyncUsingBody:(MovierDCInterfaceSvc_getvideosbyvideoidarr *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)searchvideosbykeyUsingBody:(MovierDCInterfaceSvc_searchvideosbykey *)aBody ;
- (void)searchvideosbykeyAsyncUsingBody:(MovierDCInterfaceSvc_searchvideosbykey *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getmusicbyidUsingBody:(MovierDCInterfaceSvc_getmusicbyid *)aBody ;
- (void)getmusicbyidAsyncUsingBody:(MovierDCInterfaceSvc_getmusicbyid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getcommentsbyvideoidUsingBody:(MovierDCInterfaceSvc_getcommentsbyvideoid *)aBody ;
- (void)getcommentsbyvideoidAsyncUsingBody:(MovierDCInterfaceSvc_getcommentsbyvideoid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gettemplateidbyvideoidUsingBody:(MovierDCInterfaceSvc_gettemplateidbyvideoid *)aBody ;
- (void)gettemplateidbyvideoidAsyncUsingBody:(MovierDCInterfaceSvc_gettemplateidbyvideoid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)loginbyaccountUsingBody:(MovierDCInterfaceSvc_loginbyaccount *)aBody ;
- (void)loginbyaccountAsyncUsingBody:(MovierDCInterfaceSvc_loginbyaccount *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)qqregisterUsingBody:(MovierDCInterfaceSvc_qqregister *)aBody ;
- (void)qqregisterAsyncUsingBody:(MovierDCInterfaceSvc_qqregister *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)weiboregisterUsingBody:(MovierDCInterfaceSvc_weiboregister *)aBody ;
- (void)weiboregisterAsyncUsingBody:(MovierDCInterfaceSvc_weiboregister *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)wechatregisterUsingBody:(MovierDCInterfaceSvc_wechatregister *)aBody ;
- (void)wechatregisterAsyncUsingBody:(MovierDCInterfaceSvc_wechatregister *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getaccountbindstatusUsingBody:(MovierDCInterfaceSvc_getaccountbindstatus *)aBody ;
- (void)getaccountbindstatusAsyncUsingBody:(MovierDCInterfaceSvc_getaccountbindstatus *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)bindaccountUsingBody:(MovierDCInterfaceSvc_bindaccount *)aBody ;
- (void)bindaccountAsyncUsingBody:(MovierDCInterfaceSvc_bindaccount *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getorderbytemplateidUsingBody:(MovierDCInterfaceSvc_getorderbytemplateid *)aBody ;
- (void)getorderbytemplateidAsyncUsingBody:(MovierDCInterfaceSvc_getorderbytemplateid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)test1UsingBody:(MovierDCInterfaceSvc_test1 *)aBody ;
- (void)test1AsyncUsingBody:(MovierDCInterfaceSvc_test1 *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)test2UsingBody:(MovierDCInterfaceSvc_test2 *)aBody ;
- (void)test2AsyncUsingBody:(MovierDCInterfaceSvc_test2 *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)test3UsingBody:(MovierDCInterfaceSvc_test3 *)aBody ;
- (void)test3AsyncUsingBody:(MovierDCInterfaceSvc_test3 *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmlbsUsingBody:(MovierDCInterfaceSvc_gmlbs *)aBody ;
- (void)gmlbsAsyncUsingBody:(MovierDCInterfaceSvc_gmlbs *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmgetarUsingBody:(MovierDCInterfaceSvc_gmgetar *)aBody ;
- (void)gmgetarAsyncUsingBody:(MovierDCInterfaceSvc_gmgetar *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmcreateorderfollowexistUsingBody:(MovierDCInterfaceSvc_gmcreateorderfollowexist *)aBody ;
- (void)gmcreateorderfollowexistAsyncUsingBody:(MovierDCInterfaceSvc_gmcreateorderfollowexist *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmcreateorderUsingBody:(MovierDCInterfaceSvc_gmcreateorder *)aBody ;
- (void)gmcreateorderAsyncUsingBody:(MovierDCInterfaceSvc_gmcreateorder *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmshareUsingBody:(MovierDCInterfaceSvc_gmshare *)aBody ;
- (void)gmshareAsyncUsingBody:(MovierDCInterfaceSvc_gmshare *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmopenchestUsingBody:(MovierDCInterfaceSvc_gmopenchest *)aBody ;
- (void)gmopenchestAsyncUsingBody:(MovierDCInterfaceSvc_gmopenchest *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmgetrealtimeawardinfoUsingBody:(MovierDCInterfaceSvc_gmgetrealtimeawardinfo *)aBody ;
- (void)gmgetrealtimeawardinfoAsyncUsingBody:(MovierDCInterfaceSvc_gmgetrealtimeawardinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmgetchestUsingBody:(MovierDCInterfaceSvc_gmgetchest *)aBody ;
- (void)gmgetchestAsyncUsingBody:(MovierDCInterfaceSvc_gmgetchest *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmcardcompoundUsingBody:(MovierDCInterfaceSvc_gmcardcompound *)aBody ;
- (void)gmcardcompoundAsyncUsingBody:(MovierDCInterfaceSvc_gmcardcompound *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmgetvirtualcardbyuseridUsingBody:(MovierDCInterfaceSvc_gmgetvirtualcardbyuserid *)aBody ;
- (void)gmgetvirtualcardbyuseridAsyncUsingBody:(MovierDCInterfaceSvc_gmgetvirtualcardbyuserid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmgetawardbyuseridUsingBody:(MovierDCInterfaceSvc_gmgetawardbyuserid *)aBody ;
- (void)gmgetawardbyuseridAsyncUsingBody:(MovierDCInterfaceSvc_gmgetawardbyuserid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmgettokenamountUsingBody:(MovierDCInterfaceSvc_gmgettokenamount *)aBody ;
- (void)gmgettokenamountAsyncUsingBody:(MovierDCInterfaceSvc_gmgettokenamount *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmgettokenexchangeruleUsingBody:(MovierDCInterfaceSvc_gmgettokenexchangerule *)aBody ;
- (void)gmgettokenexchangeruleAsyncUsingBody:(MovierDCInterfaceSvc_gmgettokenexchangerule *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gmtokenexchangeUsingBody:(MovierDCInterfaceSvc_gmtokenexchange *)aBody ;
- (void)gmtokenexchangeAsyncUsingBody:(MovierDCInterfaceSvc_gmtokenexchange *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)gettemplateavailableUsingBody:(MovierDCInterfaceSvc_gettemplateavailable *)aBody ;
- (void)gettemplateavailableAsyncUsingBody:(MovierDCInterfaceSvc_gettemplateavailable *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)bcinsertuservideoUsingBody:(MovierDCInterfaceSvc_bcinsertuservideo *)aBody ;
- (void)bcinsertuservideoAsyncUsingBody:(MovierDCInterfaceSvc_bcinsertuservideo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getvideoidbyorderidUsingBody:(MovierDCInterfaceSvc_getvideoidbyorderid *)aBody ;
- (void)getvideoidbyorderidAsyncUsingBody:(MovierDCInterfaceSvc_getvideoidbyorderid *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)getarawardnewyearUsingBody:(MovierDCInterfaceSvc_getarawardnewyear *)aBody ;
- (void)getarawardnewyearAsyncUsingBody:(MovierDCInterfaceSvc_getarawardnewyear *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
- (MovierDCInterfaceBindingResponse *)addarawardnewyearreceiverinfoUsingBody:(MovierDCInterfaceSvc_addarawardnewyearreceiverinfo *)aBody ;
- (void)addarawardnewyearreceiverinfoAsyncUsingBody:(MovierDCInterfaceSvc_addarawardnewyearreceiverinfo *)aBody  delegate:(id<MovierDCInterfaceBindingResponseDelegate>)responseDelegate;
@end
@interface MovierDCInterfaceBindingOperation : NSOperation {
	MovierDCInterfaceBinding *binding;
	MovierDCInterfaceBindingResponse *response;
	id<MovierDCInterfaceBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) MovierDCInterfaceBinding *binding;
@property (readonly) MovierDCInterfaceBindingResponse *response;
@property (nonatomic, assign) id<MovierDCInterfaceBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate;
@end
@interface MovierDCInterfaceBinding_getmodulelist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmodulelist * Body;
}
@property (retain) MovierDCInterfaceSvc_getmodulelist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmodulelist *)aBody
;
@end
@interface MovierDCInterfaceBinding_gettotalmodulenum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gettotalmodulenum * Body;
}
@property (retain) MovierDCInterfaceSvc_gettotalmodulenum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gettotalmodulenum *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmodulelistex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmodulelistex * Body;
}
@property (retain) MovierDCInterfaceSvc_getmodulelistex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmodulelistex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmodulebyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmodulebyid * Body;
}
@property (retain) MovierDCInterfaceSvc_getmodulebyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmodulebyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmodulebyname : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmodulebyname * Body;
}
@property (retain) MovierDCInterfaceSvc_getmodulebyname * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmodulebyname *)aBody
;
@end
@interface MovierDCInterfaceBinding_createmodule : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_createmodule * Body;
}
@property (retain) MovierDCInterfaceSvc_createmodule * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_createmodule *)aBody
;
@end
@interface MovierDCInterfaceBinding_updatemodule : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_updatemodule * Body;
}
@property (retain) MovierDCInterfaceSvc_updatemodule * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_updatemodule *)aBody
;
@end
@interface MovierDCInterfaceBinding_querymodule : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_querymodule * Body;
}
@property (retain) MovierDCInterfaceSvc_querymodule * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_querymodule *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmodulebyorderid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmodulebyorderid * Body;
}
@property (retain) MovierDCInterfaceSvc_getmodulebyorderid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmodulebyorderid *)aBody
;
@end
@interface MovierDCInterfaceBinding_connectiontest : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_connectiontest * Body;
}
@property (retain) MovierDCInterfaceSvc_connectiontest * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_connectiontest *)aBody
;
@end
@interface MovierDCInterfaceBinding_registerusingemail : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_registerusingemail * Body;
}
@property (retain) MovierDCInterfaceSvc_registerusingemail * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_registerusingemail *)aBody
;
@end
@interface MovierDCInterfaceBinding_registerusingtel : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_registerusingtel * Body;
}
@property (retain) MovierDCInterfaceSvc_registerusingtel * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_registerusingtel *)aBody
;
@end
@interface MovierDCInterfaceBinding_registerusingthirdpartyaccount : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_registerusingthirdpartyaccount * Body;
}
@property (retain) MovierDCInterfaceSvc_registerusingthirdpartyaccount * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_registerusingthirdpartyaccount *)aBody
;
@end
@interface MovierDCInterfaceBinding_registerusingfullinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_registerusingfullinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_registerusingfullinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_registerusingfullinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_login : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_login * Body;
}
@property (retain) MovierDCInterfaceSvc_login * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_login *)aBody
;
@end
@interface MovierDCInterfaceBinding_loginex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_loginex * Body;
}
@property (retain) MovierDCInterfaceSvc_loginex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_loginex *)aBody
;
@end
@interface MovierDCInterfaceBinding_thirdpartylogin : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_thirdpartylogin * Body;
}
@property (retain) MovierDCInterfaceSvc_thirdpartylogin * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_thirdpartylogin *)aBody
;
@end
@interface MovierDCInterfaceBinding_thirdpartygetsecret : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_thirdpartygetsecret * Body;
}
@property (retain) MovierDCInterfaceSvc_thirdpartygetsecret * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_thirdpartygetsecret *)aBody
;
@end
@interface MovierDCInterfaceBinding_getcustomerinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getcustomerinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_getcustomerinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getcustomerinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getcustomerinfoex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getcustomerinfoex * Body;
}
@property (retain) MovierDCInterfaceSvc_getcustomerinfoex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getcustomerinfoex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getcustomerinfoex2 : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getcustomerinfoex2 * Body;
}
@property (retain) MovierDCInterfaceSvc_getcustomerinfoex2 * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getcustomerinfoex2 *)aBody
;
@end
@interface MovierDCInterfaceBinding_updatecustomerinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_updatecustomerinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_updatecustomerinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_updatecustomerinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getossconfig : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getossconfig * Body;
}
@property (retain) MovierDCInterfaceSvc_getossconfig * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getossconfig *)aBody
;
@end
@interface MovierDCInterfaceBinding_getprivilegeinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getprivilegeinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_getprivilegeinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getprivilegeinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_updateuserinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_updateuserinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_updateuserinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_updateuserinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_activeuser : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_activeuser * Body;
}
@property (retain) MovierDCInterfaceSvc_activeuser * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_activeuser *)aBody
;
@end
@interface MovierDCInterfaceBinding_logout : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_logout * Body;
}
@property (retain) MovierDCInterfaceSvc_logout * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_logout *)aBody
;
@end
@interface MovierDCInterfaceBinding_getorder : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getorder * Body;
}
@property (retain) MovierDCInterfaceSvc_getorder * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getorder *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetorder : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetorder * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetorder * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetorder *)aBody
;
@end
@interface MovierDCInterfaceBinding_ordercomplete : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_ordercomplete * Body;
}
@property (retain) MovierDCInterfaceSvc_ordercomplete * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_ordercomplete *)aBody
;
@end
@interface MovierDCInterfaceBinding_orderprocessfail : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_orderprocessfail * Body;
}
@property (retain) MovierDCInterfaceSvc_orderprocessfail * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_orderprocessfail *)aBody
;
@end
@interface MovierDCInterfaceBinding_createorder : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_createorder * Body;
}
@property (retain) MovierDCInterfaceSvc_createorder * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_createorder *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpcreateorder : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpcreateorder * Body;
}
@property (retain) MovierDCInterfaceSvc_vpcreateorder * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpcreateorder *)aBody
;
@end
@interface MovierDCInterfaceBinding_queryorderbyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_queryorderbyid * Body;
}
@property (retain) MovierDCInterfaceSvc_queryorderbyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_queryorderbyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_queryorders : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_queryorders * Body;
}
@property (retain) MovierDCInterfaceSvc_queryorders * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_queryorders *)aBody
;
@end
@interface MovierDCInterfaceBinding_queryordersbyidarr : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_queryordersbyidarr * Body;
}
@property (retain) MovierDCInterfaceSvc_queryordersbyidarr * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_queryordersbyidarr *)aBody
;
@end
@interface MovierDCInterfaceBinding_getordertotalnumbystatus : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getordertotalnumbystatus * Body;
}
@property (retain) MovierDCInterfaceSvc_getordertotalnumbystatus * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getordertotalnumbystatus *)aBody
;
@end
@interface MovierDCInterfaceBinding_queryordersbyorderstatus : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_queryordersbyorderstatus * Body;
}
@property (retain) MovierDCInterfaceSvc_queryordersbyorderstatus * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_queryordersbyorderstatus *)aBody
;
@end
@interface MovierDCInterfaceBinding_querynotice : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_querynotice * Body;
}
@property (retain) MovierDCInterfaceSvc_querynotice * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_querynotice *)aBody
;
@end
@interface MovierDCInterfaceBinding_querynoticebytype : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_querynoticebytype * Body;
}
@property (retain) MovierDCInterfaceSvc_querynoticebytype * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_querynoticebytype *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmusicinfobyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmusicinfobyid * Body;
}
@property (retain) MovierDCInterfaceSvc_getmusicinfobyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmusicinfobyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmusicinfobyname : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmusicinfobyname * Body;
}
@property (retain) MovierDCInterfaceSvc_getmusicinfobyname * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmusicinfobyname *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmusicinfolist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmusicinfolist * Body;
}
@property (retain) MovierDCInterfaceSvc_getmusicinfolist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmusicinfolist *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideolabeltotalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideolabeltotalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideolabeltotalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideolabeltotalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideolabeltotalnumbyparentid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideolabeltotalnumbyparentid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideolabeltotalnumbyparentid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideolabeltotalnumbyparentid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideolabels : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideolabels * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideolabels * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideolabels *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideolabelsbyparentid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideolabelsbyparentid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideolabelsbyparentid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideolabelsbyparentid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideolabelsex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideolabelsex * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideolabelsex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideolabelsex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideolabelsexbyparentid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideolabelsexbyparentid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideolabelsexbyparentid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideolabelsexbyparentid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideototalbylabelid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideototalbylabelid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideototalbylabelid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideototalbylabelid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideototalbylabelname : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideototalbylabelname * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideototalbylabelname * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideototalbylabelname *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideobylabelid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideobylabelid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideobylabelid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideobylabelid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideobylabelidex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideobylabelidex * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideobylabelidex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideobylabelidex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideobylabelname : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideobylabelname * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideobylabelname * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideobylabelname *)aBody
;
@end
@interface MovierDCInterfaceBinding_praisevideobyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_praisevideobyid * Body;
}
@property (retain) MovierDCInterfaceSvc_praisevideobyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_praisevideobyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_unpraisevideobyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_unpraisevideobyid * Body;
}
@property (retain) MovierDCInterfaceSvc_unpraisevideobyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_unpraisevideobyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_increasevideoattr : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_increasevideoattr * Body;
}
@property (retain) MovierDCInterfaceSvc_increasevideoattr * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_increasevideoattr *)aBody
;
@end
@interface MovierDCInterfaceBinding_increasevideoattr4c : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_increasevideoattr4c * Body;
}
@property (retain) MovierDCInterfaceSvc_increasevideoattr4c * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_increasevideoattr4c *)aBody
;
@end
@interface MovierDCInterfaceBinding_praisevideobyname : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_praisevideobyname * Body;
}
@property (retain) MovierDCInterfaceSvc_praisevideobyname * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_praisevideobyname *)aBody
;
@end
@interface MovierDCInterfaceBinding_increasesharenumbyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_increasesharenumbyid * Body;
}
@property (retain) MovierDCInterfaceSvc_increasesharenumbyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_increasesharenumbyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_increasesharenumbyname : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_increasesharenumbyname * Body;
}
@property (retain) MovierDCInterfaceSvc_increasesharenumbyname * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_increasesharenumbyname *)aBody
;
@end
@interface MovierDCInterfaceBinding_markfavoritebyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_markfavoritebyid * Body;
}
@property (retain) MovierDCInterfaceSvc_markfavoritebyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_markfavoritebyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_markfavoritebyname : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_markfavoritebyname * Body;
}
@property (retain) MovierDCInterfaceSvc_markfavoritebyname * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_markfavoritebyname *)aBody
;
@end
@interface MovierDCInterfaceBinding_getfavoritevideototalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getfavoritevideototalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_getfavoritevideototalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getfavoritevideototalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_getfavoritevideo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getfavoritevideo * Body;
}
@property (retain) MovierDCInterfaceSvc_getfavoritevideo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getfavoritevideo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getfavoritevideoex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getfavoritevideoex * Body;
}
@property (retain) MovierDCInterfaceSvc_getfavoritevideoex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getfavoritevideoex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmoduleallstyle : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmoduleallstyle * Body;
}
@property (retain) MovierDCInterfaceSvc_getmoduleallstyle * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmoduleallstyle *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmoduletotalnumbystyle : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmoduletotalnumbystyle * Body;
}
@property (retain) MovierDCInterfaceSvc_getmoduletotalnumbystyle * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmoduletotalnumbystyle *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmodulebystyle : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmodulebystyle * Body;
}
@property (retain) MovierDCInterfaceSvc_getmodulebystyle * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmodulebystyle *)aBody
;
@end
@interface MovierDCInterfaceBinding_submitfeedback : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_submitfeedback * Body;
}
@property (retain) MovierDCInterfaceSvc_submitfeedback * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_submitfeedback *)aBody
;
@end
@interface MovierDCInterfaceBinding_gettotalnumofvideoforhomepage : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gettotalnumofvideoforhomepage * Body;
}
@property (retain) MovierDCInterfaceSvc_gettotalnumofvideoforhomepage * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gettotalnumofvideoforhomepage *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideoforhomepage : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideoforhomepage * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideoforhomepage * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideoforhomepage *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideoforhomepageex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideoforhomepageex * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideoforhomepageex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideoforhomepageex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideobyorderidarr : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideobyorderidarr * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideobyorderidarr * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideobyorderidarr *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideobyorderidarrex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideobyorderidarrex * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideobyorderidarrex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideobyorderidarrex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideobyvideoidarr : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideobyvideoidarr * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideobyvideoidarr * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideobyvideoidarr *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideobyvideoidarrex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideobyvideoidarrex * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideobyvideoidarrex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideobyvideoidarrex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getosssignature : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getosssignature * Body;
}
@property (retain) MovierDCInterfaceSvc_getosssignature * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getosssignature *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvpelementtotalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvpelementtotalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_getvpelementtotalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvpelementtotalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetheaderstyletotalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetheaderstyletotalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetheaderstyletotalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetheaderstyletotalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetheaderstyle : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetheaderstyle * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetheaderstyle * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetheaderstyle *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgettemplatecattotalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgettemplatecattotalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgettemplatecattotalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgettemplatecattotalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgettemplatecat : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgettemplatecat * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgettemplatecat * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgettemplatecat *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetheaderandtailtotalbycat : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetheaderandtailtotalbycat *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetheaderandtailbycat : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetheaderandtailbycat * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetheaderandtailbycat * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetheaderandtailbycat *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetheaderandtail : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetheaderandtail * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetheaderandtail * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetheaderandtail *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetheaderandtailexbycat : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetheaderandtailexbycat * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetheaderandtailexbycat * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetheaderandtailexbycat *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetheaderandtailex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetheaderandtailex * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetheaderandtailex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetheaderandtailex *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetheaderandtailvisitcount : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetheaderandtailvisitcount * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetheaderandtailvisitcount * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetheaderandtailvisitcount *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpincreaseheaderandtailvisitcount : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpincreaseheaderandtailvisitcount * Body;
}
@property (retain) MovierDCInterfaceSvc_vpincreaseheaderandtailvisitcount * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpincreaseheaderandtailvisitcount *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetdefaultmusicandsubtitlebyheaderandtailid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetdefaultmusicandsubtitlebyheaderandtailid *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetfilterstyletotalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetfilterstyletotalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetfilterstyletotalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetfilterstyletotalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetfilterstyle : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetfilterstyle * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetfilterstyle * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetfilterstyle *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetfilter : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetfilter * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetfilter * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetfilter *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetmusic : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetmusic * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetmusic * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetmusic *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetsubtitle : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetsubtitle * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetsubtitle * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetsubtitle *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetstylebyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetstylebyid * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetstylebyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetstylebyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetfilterbyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetfilterbyid * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetfilterbyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetfilterbyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetmusicbyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetmusicbyid * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetmusicbyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetmusicbyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpsearchonlinemusic : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpsearchonlinemusic * Body;
}
@property (retain) MovierDCInterfaceSvc_vpsearchonlinemusic * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpsearchonlinemusic *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetsubtitlebyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetsubtitlebyid * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetsubtitlebyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetsubtitlebyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpupdatevideosharestatus : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpupdatevideosharestatus * Body;
}
@property (retain) MovierDCInterfaceSvc_vpupdatevideosharestatus * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpupdatevideosharestatus *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpremovevideo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpremovevideo * Body;
}
@property (retain) MovierDCInterfaceSvc_vpremovevideo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpremovevideo *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetfavouritestatus : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetfavouritestatus * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetfavouritestatus * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetfavouritestatus *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetpraisestatus : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetpraisestatus * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetpraisestatus * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetpraisestatus *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetsubtitlemodelbyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetsubtitlemodelbyid * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetsubtitlemodelbyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetsubtitlemodelbyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_changepassword : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_changepassword * Body;
}
@property (retain) MovierDCInterfaceSvc_changepassword * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_changepassword *)aBody
;
@end
@interface MovierDCInterfaceBinding_checktelnumusability : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_checktelnumusability * Body;
}
@property (retain) MovierDCInterfaceSvc_checktelnumusability * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_checktelnumusability *)aBody
;
@end
@interface MovierDCInterfaceBinding_checkemailusability : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_checkemailusability * Body;
}
@property (retain) MovierDCInterfaceSvc_checkemailusability * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_checkemailusability *)aBody
;
@end
@interface MovierDCInterfaceBinding_resetpasswordusingtel : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_resetpasswordusingtel * Body;
}
@property (retain) MovierDCInterfaceSvc_resetpasswordusingtel * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_resetpasswordusingtel *)aBody
;
@end
@interface MovierDCInterfaceBinding_resetpasswordusingemail : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_resetpasswordusingemail * Body;
}
@property (retain) MovierDCInterfaceSvc_resetpasswordusingemail * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_resetpasswordusingemail *)aBody
;
@end
@interface MovierDCInterfaceBinding_getapplatestversion : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getapplatestversion * Body;
}
@property (retain) MovierDCInterfaceSvc_getapplatestversion * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getapplatestversion *)aBody
;
@end
@interface MovierDCInterfaceBinding_getappversion : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getappversion * Body;
}
@property (retain) MovierDCInterfaceSvc_getappversion * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getappversion *)aBody
;
@end
@interface MovierDCInterfaceBinding_userreport : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_userreport * Body;
}
@property (retain) MovierDCInterfaceSvc_userreport * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_userreport *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpsubmitcomment : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpsubmitcomment * Body;
}
@property (retain) MovierDCInterfaceSvc_vpsubmitcomment * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpsubmitcomment *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetcommenttotalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetcommenttotalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetcommenttotalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetcommenttotalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetcomment : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetcomment * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetcomment * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetcomment *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgetcommentex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgetcommentex * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgetcommentex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgetcommentex *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpremovecomment : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpremovecomment * Body;
}
@property (retain) MovierDCInterfaceSvc_vpremovecomment * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpremovecomment *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpreportcomment : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpreportcomment * Body;
}
@property (retain) MovierDCInterfaceSvc_vpreportcomment * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpreportcomment *)aBody
;
@end
@interface MovierDCInterfaceBinding_createactivity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_createactivity * Body;
}
@property (retain) MovierDCInterfaceSvc_createactivity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_createactivity *)aBody
;
@end
@interface MovierDCInterfaceBinding_removeactivity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_removeactivity * Body;
}
@property (retain) MovierDCInterfaceSvc_removeactivity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_removeactivity *)aBody
;
@end
@interface MovierDCInterfaceBinding_joinactivity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_joinactivity * Body;
}
@property (retain) MovierDCInterfaceSvc_joinactivity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_joinactivity *)aBody
;
@end
@interface MovierDCInterfaceBinding_quitactivity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_quitactivity * Body;
}
@property (retain) MovierDCInterfaceSvc_quitactivity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_quitactivity *)aBody
;
@end
@interface MovierDCInterfaceBinding_sendinvitebytelnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_sendinvitebytelnum * Body;
}
@property (retain) MovierDCInterfaceSvc_sendinvitebytelnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_sendinvitebytelnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_sendinvitebyemail : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_sendinvitebyemail * Body;
}
@property (retain) MovierDCInterfaceSvc_sendinvitebyemail * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_sendinvitebyemail *)aBody
;
@end
@interface MovierDCInterfaceBinding_removememberfromactivity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_removememberfromactivity * Body;
}
@property (retain) MovierDCInterfaceSvc_removememberfromactivity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_removememberfromactivity *)aBody
;
@end
@interface MovierDCInterfaceBinding_changepassword4activity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_changepassword4activity * Body;
}
@property (retain) MovierDCInterfaceSvc_changepassword4activity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_changepassword4activity *)aBody
;
@end
@interface MovierDCInterfaceBinding_updatestoragecapacity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_updatestoragecapacity * Body;
}
@property (retain) MovierDCInterfaceSvc_updatestoragecapacity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_updatestoragecapacity *)aBody
;
@end
@interface MovierDCInterfaceBinding_getactivitymemberidlist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getactivitymemberidlist * Body;
}
@property (retain) MovierDCInterfaceSvc_getactivitymemberidlist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getactivitymemberidlist *)aBody
;
@end
@interface MovierDCInterfaceBinding_getactivitymemberinfolist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getactivitymemberinfolist * Body;
}
@property (retain) MovierDCInterfaceSvc_getactivitymemberinfolist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getactivitymemberinfolist *)aBody
;
@end
@interface MovierDCInterfaceBinding_getactivityinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getactivityinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_getactivityinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getactivityinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getactivitytotalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getactivitytotalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_getactivitytotalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getactivitytotalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_getactivitylist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getactivitylist * Body;
}
@property (retain) MovierDCInterfaceSvc_getactivitylist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getactivitylist *)aBody
;
@end
@interface MovierDCInterfaceBinding_reportactivity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_reportactivity * Body;
}
@property (retain) MovierDCInterfaceSvc_reportactivity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_reportactivity *)aBody
;
@end
@interface MovierDCInterfaceBinding_createorder4activity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_createorder4activity * Body;
}
@property (retain) MovierDCInterfaceSvc_createorder4activity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_createorder4activity *)aBody
;
@end
@interface MovierDCInterfaceBinding_createfile4activity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_createfile4activity * Body;
}
@property (retain) MovierDCInterfaceSvc_createfile4activity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_createfile4activity *)aBody
;
@end
@interface MovierDCInterfaceBinding_createfile4activityconfirm : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_createfile4activityconfirm * Body;
}
@property (retain) MovierDCInterfaceSvc_createfile4activityconfirm * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_createfile4activityconfirm *)aBody
;
@end
@interface MovierDCInterfaceBinding_removefile4activity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_removefile4activity * Body;
}
@property (retain) MovierDCInterfaceSvc_removefile4activity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_removefile4activity *)aBody
;
@end
@interface MovierDCInterfaceBinding_getactivitytotalnum4customer : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getactivitytotalnum4customer * Body;
}
@property (retain) MovierDCInterfaceSvc_getactivitytotalnum4customer * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getactivitytotalnum4customer *)aBody
;
@end
@interface MovierDCInterfaceBinding_getactivitylist4customer : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getactivitylist4customer * Body;
}
@property (retain) MovierDCInterfaceSvc_getactivitylist4customer * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getactivitylist4customer *)aBody
;
@end
@interface MovierDCInterfaceBinding_updatecustomercapacity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_updatecustomercapacity * Body;
}
@property (retain) MovierDCInterfaceSvc_updatecustomercapacity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_updatecustomercapacity *)aBody
;
@end
@interface MovierDCInterfaceBinding_getcustomercapacity : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getcustomercapacity * Body;
}
@property (retain) MovierDCInterfaceSvc_getcustomercapacity * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getcustomercapacity *)aBody
;
@end
@interface MovierDCInterfaceBinding_removevideofile : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_removevideofile * Body;
}
@property (retain) MovierDCInterfaceSvc_removevideofile * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_removevideofile *)aBody
;
@end
@interface MovierDCInterfaceBinding_searchuser : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_searchuser * Body;
}
@property (retain) MovierDCInterfaceSvc_searchuser * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_searchuser *)aBody
;
@end
@interface MovierDCInterfaceBinding_searchvideo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_searchvideo * Body;
}
@property (retain) MovierDCInterfaceSvc_searchvideo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_searchvideo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getbannertotalnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getbannertotalnum * Body;
}
@property (retain) MovierDCInterfaceSvc_getbannertotalnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getbannertotalnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_getbanner : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getbanner * Body;
}
@property (retain) MovierDCInterfaceSvc_getbanner * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getbanner *)aBody
;
@end
@interface MovierDCInterfaceBinding_getbannerex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getbannerex * Body;
}
@property (retain) MovierDCInterfaceSvc_getbannerex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getbannerex *)aBody
;
@end
@interface MovierDCInterfaceBinding_updatetelnum : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_updatetelnum * Body;
}
@property (retain) MovierDCInterfaceSvc_updatetelnum * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_updatetelnum *)aBody
;
@end
@interface MovierDCInterfaceBinding_updatetelnumex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_updatetelnumex * Body;
}
@property (retain) MovierDCInterfaceSvc_updatetelnumex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_updatetelnumex *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpcreateorderfollowexist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpcreateorderfollowexist * Body;
}
@property (retain) MovierDCInterfaceSvc_vpcreateorderfollowexist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpcreateorderfollowexist *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpcreateorderfollowexistex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpcreateorderfollowexistex * Body;
}
@property (retain) MovierDCInterfaceSvc_vpcreateorderfollowexistex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpcreateorderfollowexistex *)aBody
;
@end
@interface MovierDCInterfaceBinding_vpgettelnumsettingstatus : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_vpgettelnumsettingstatus * Body;
}
@property (retain) MovierDCInterfaceSvc_vpgettelnumsettingstatus * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_vpgettelnumsettingstatus *)aBody
;
@end
@interface MovierDCInterfaceBinding_registerusingthirdpartyaccountex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_registerusingthirdpartyaccountex * Body;
}
@property (retain) MovierDCInterfaceSvc_registerusingthirdpartyaccountex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_registerusingthirdpartyaccountex *)aBody
;
@end
@interface MovierDCInterfaceBinding_registerusingthirdpartyaccount4wechat : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_registerusingthirdpartyaccount4wechat * Body;
}
@property (retain) MovierDCInterfaceSvc_registerusingthirdpartyaccount4wechat * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_registerusingthirdpartyaccount4wechat *)aBody
;
@end
@interface MovierDCInterfaceBinding_getpicbyheightandwidth : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getpicbyheightandwidth * Body;
}
@property (retain) MovierDCInterfaceSvc_getpicbyheightandwidth * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getpicbyheightandwidth *)aBody
;
@end
@interface MovierDCInterfaceBinding_getpicbyratioindex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getpicbyratioindex * Body;
}
@property (retain) MovierDCInterfaceSvc_getpicbyratioindex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getpicbyratioindex *)aBody
;
@end
@interface MovierDCInterfaceBinding_getcuponforgm : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getcuponforgm * Body;
}
@property (retain) MovierDCInterfaceSvc_getcuponforgm * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getcuponforgm *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideolabelexbylabelid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideolabelexbylabelid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideolabelexbylabelid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideolabelexbylabelid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getstylebyvideoid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getstylebyvideoid * Body;
}
@property (retain) MovierDCInterfaceSvc_getstylebyvideoid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getstylebyvideoid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getstylebylabelid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getstylebylabelid * Body;
}
@property (retain) MovierDCInterfaceSvc_getstylebylabelid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getstylebylabelid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getspecialeffectbyeffectsetid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getspecialeffectbyeffectsetid * Body;
}
@property (retain) MovierDCInterfaceSvc_getspecialeffectbyeffectsetid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getspecialeffectbyeffectsetid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getbeatinfoarrbybeatid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getbeatinfoarrbybeatid * Body;
}
@property (retain) MovierDCInterfaceSvc_getbeatinfoarrbybeatid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getbeatinfoarrbybeatid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getcategoryfortemplate : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getcategoryfortemplate * Body;
}
@property (retain) MovierDCInterfaceSvc_getcategoryfortemplate * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getcategoryfortemplate *)aBody
;
@end
@interface MovierDCInterfaceBinding_share : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_share * Body;
}
@property (retain) MovierDCInterfaceSvc_share * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_share *)aBody
;
@end
@interface MovierDCInterfaceBinding_shareex : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_shareex * Body;
}
@property (retain) MovierDCInterfaceSvc_shareex * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_shareex *)aBody
;
@end
@interface MovierDCInterfaceBinding_updatethirdpartyaccount : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_updatethirdpartyaccount * Body;
}
@property (retain) MovierDCInterfaceSvc_updatethirdpartyaccount * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_updatethirdpartyaccount *)aBody
;
@end
@interface MovierDCInterfaceBinding_getnewuserscoretask : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getnewuserscoretask * Body;
}
@property (retain) MovierDCInterfaceSvc_getnewuserscoretask * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getnewuserscoretask *)aBody
;
@end
@interface MovierDCInterfaceBinding_gettelandthirdpartybindstatus : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gettelandthirdpartybindstatus * Body;
}
@property (retain) MovierDCInterfaceSvc_gettelandthirdpartybindstatus * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gettelandthirdpartybindstatus *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmyscoreinshiancoin : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmyscoreinshiancoin * Body;
}
@property (retain) MovierDCInterfaceSvc_getmyscoreinshiancoin * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmyscoreinshiancoin *)aBody
;
@end
@interface MovierDCInterfaceBinding_getscorelog : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getscorelog * Body;
}
@property (retain) MovierDCInterfaceSvc_getscorelog * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getscorelog *)aBody
;
@end
@interface MovierDCInterfaceBinding_getdailyscoretask : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getdailyscoretask * Body;
}
@property (retain) MovierDCInterfaceSvc_getdailyscoretask * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getdailyscoretask *)aBody
;
@end
@interface MovierDCInterfaceBinding_operatedevicelist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_operatedevicelist * Body;
}
@property (retain) MovierDCInterfaceSvc_operatedevicelist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_operatedevicelist *)aBody
;
@end
@interface MovierDCInterfaceBinding_sendprivatemessage : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_sendprivatemessage * Body;
}
@property (retain) MovierDCInterfaceSvc_sendprivatemessage * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_sendprivatemessage *)aBody
;
@end
@interface MovierDCInterfaceBinding_systemnotice : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_systemnotice * Body;
}
@property (retain) MovierDCInterfaceSvc_systemnotice * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_systemnotice *)aBody
;
@end
@interface MovierDCInterfaceBinding_messagepushonoff : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_messagepushonoff * Body;
}
@property (retain) MovierDCInterfaceSvc_messagepushonoff * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_messagepushonoff *)aBody
;
@end
@interface MovierDCInterfaceBinding_follow : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_follow * Body;
}
@property (retain) MovierDCInterfaceSvc_follow * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_follow *)aBody
;
@end
@interface MovierDCInterfaceBinding_unfollow : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_unfollow * Body;
}
@property (retain) MovierDCInterfaceSvc_unfollow * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_unfollow *)aBody
;
@end
@interface MovierDCInterfaceBinding_getfollowlist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getfollowlist * Body;
}
@property (retain) MovierDCInterfaceSvc_getfollowlist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getfollowlist *)aBody
;
@end
@interface MovierDCInterfaceBinding_getfunslist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getfunslist * Body;
}
@property (retain) MovierDCInterfaceSvc_getfunslist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getfunslist *)aBody
;
@end
@interface MovierDCInterfaceBinding_getfriendlist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getfriendlist * Body;
}
@property (retain) MovierDCInterfaceSvc_getfriendlist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getfriendlist *)aBody
;
@end
@interface MovierDCInterfaceBinding_getfriendamount : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getfriendamount * Body;
}
@property (retain) MovierDCInterfaceSvc_getfriendamount * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getfriendamount *)aBody
;
@end
@interface MovierDCInterfaceBinding_getfriendrelation : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getfriendrelation * Body;
}
@property (retain) MovierDCInterfaceSvc_getfriendrelation * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getfriendrelation *)aBody
;
@end
@interface MovierDCInterfaceBinding_searchfriend : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_searchfriend * Body;
}
@property (retain) MovierDCInterfaceSvc_searchfriend * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_searchfriend *)aBody
;
@end
@interface MovierDCInterfaceBinding_searchtelfriend : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_searchtelfriend * Body;
}
@property (retain) MovierDCInterfaceSvc_searchtelfriend * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_searchtelfriend *)aBody
;
@end
@interface MovierDCInterfaceBinding_gethomepagebackground : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gethomepagebackground * Body;
}
@property (retain) MovierDCInterfaceSvc_gethomepagebackground * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gethomepagebackground *)aBody
;
@end
@interface MovierDCInterfaceBinding_checksession : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_checksession * Body;
}
@property (retain) MovierDCInterfaceSvc_checksession * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_checksession *)aBody
;
@end
@interface MovierDCInterfaceBinding_setvideoinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_setvideoinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_setvideoinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_setvideoinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideoinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideoinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideoinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideoinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideosbyuserid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideosbyuserid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideosbyuserid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideosbyuserid *)aBody
;
@end
@interface MovierDCInterfaceBinding_addtopicsforvideo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_addtopicsforvideo * Body;
}
@property (retain) MovierDCInterfaceSvc_addtopicsforvideo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_addtopicsforvideo *)aBody
;
@end
@interface MovierDCInterfaceBinding_removetopicsforvideo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_removetopicsforvideo * Body;
}
@property (retain) MovierDCInterfaceSvc_removetopicsforvideo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_removetopicsforvideo *)aBody
;
@end
@interface MovierDCInterfaceBinding_gettopicsbyvideoid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gettopicsbyvideoid * Body;
}
@property (retain) MovierDCInterfaceSvc_gettopicsbyvideoid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gettopicsbyvideoid *)aBody
;
@end
@interface MovierDCInterfaceBinding_gettopicsbyparenttopic : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gettopicsbyparenttopic * Body;
}
@property (retain) MovierDCInterfaceSvc_gettopicsbyparenttopic * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gettopicsbyparenttopic *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideosbytopicid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideosbytopicid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideosbytopicid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideosbytopicid *)aBody
;
@end
@interface MovierDCInterfaceBinding_releasevideo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_releasevideo * Body;
}
@property (retain) MovierDCInterfaceSvc_releasevideo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_releasevideo *)aBody
;
@end
@interface MovierDCInterfaceBinding_unreleasevideo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_unreleasevideo * Body;
}
@property (retain) MovierDCInterfaceSvc_unreleasevideo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_unreleasevideo *)aBody
;
@end
@interface MovierDCInterfaceBinding_atfriendbycustomeridarr : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_atfriendbycustomeridarr * Body;
}
@property (retain) MovierDCInterfaceSvc_atfriendbycustomeridarr * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_atfriendbycustomeridarr *)aBody
;
@end
@interface MovierDCInterfaceBinding_searchtopics : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_searchtopics * Body;
}
@property (retain) MovierDCInterfaceSvc_searchtopics * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_searchtopics *)aBody
;
@end
@interface MovierDCInterfaceBinding_getuserinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getuserinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_getuserinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getuserinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_setuserinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_setuserinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_setuserinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_setuserinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getbannerlist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getbannerlist * Body;
}
@property (retain) MovierDCInterfaceSvc_getbannerlist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getbannerlist *)aBody
;
@end
@interface MovierDCInterfaceBinding_getcollectvideos : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getcollectvideos * Body;
}
@property (retain) MovierDCInterfaceSvc_getcollectvideos * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getcollectvideos *)aBody
;
@end
@interface MovierDCInterfaceBinding_getlabelsbyparentid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getlabelsbyparentid * Body;
}
@property (retain) MovierDCInterfaceSvc_getlabelsbyparentid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getlabelsbyparentid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getchallengetaskpraise : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getchallengetaskpraise * Body;
}
@property (retain) MovierDCInterfaceSvc_getchallengetaskpraise * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getchallengetaskpraise *)aBody
;
@end
@interface MovierDCInterfaceBinding_getchallengetaskview : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getchallengetaskview * Body;
}
@property (retain) MovierDCInterfaceSvc_getchallengetaskview * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getchallengetaskview *)aBody
;
@end
@interface MovierDCInterfaceBinding_getorderbyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getorderbyid * Body;
}
@property (retain) MovierDCInterfaceSvc_getorderbyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getorderbyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideoamountbyheaderandtailanddate : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideoamountbyheaderandtailanddate * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideoamountbyheaderandtailanddate * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideoamountbyheaderandtailanddate *)aBody
;
@end
@interface MovierDCInterfaceBinding_getshareamountbylabelid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getshareamountbylabelid * Body;
}
@property (retain) MovierDCInterfaceSvc_getshareamountbylabelid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getshareamountbylabelid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getshareamountbyheaderandtailanddate : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getshareamountbyheaderandtailanddate * Body;
}
@property (retain) MovierDCInterfaceSvc_getshareamountbyheaderandtailanddate * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getshareamountbyheaderandtailanddate *)aBody
;
@end
@interface MovierDCInterfaceBinding_telregister : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_telregister * Body;
}
@property (retain) MovierDCInterfaceSvc_telregister * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_telregister *)aBody
;
@end
@interface MovierDCInterfaceBinding_thirdpartyregister : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_thirdpartyregister * Body;
}
@property (retain) MovierDCInterfaceSvc_thirdpartyregister * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_thirdpartyregister *)aBody
;
@end
@interface MovierDCInterfaceBinding_loginbyusername : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_loginbyusername * Body;
}
@property (retain) MovierDCInterfaceSvc_loginbyusername * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_loginbyusername *)aBody
;
@end
@interface MovierDCInterfaceBinding_loginbythirdparty : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_loginbythirdparty * Body;
}
@property (retain) MovierDCInterfaceSvc_loginbythirdparty * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_loginbythirdparty *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideosbylabelid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideosbylabelid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideosbylabelid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideosbylabelid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideosbyvideoidarr : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideosbyvideoidarr * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideosbyvideoidarr * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideosbyvideoidarr *)aBody
;
@end
@interface MovierDCInterfaceBinding_searchvideosbykey : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_searchvideosbykey * Body;
}
@property (retain) MovierDCInterfaceSvc_searchvideosbykey * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_searchvideosbykey *)aBody
;
@end
@interface MovierDCInterfaceBinding_getmusicbyid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getmusicbyid * Body;
}
@property (retain) MovierDCInterfaceSvc_getmusicbyid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getmusicbyid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getcommentsbyvideoid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getcommentsbyvideoid * Body;
}
@property (retain) MovierDCInterfaceSvc_getcommentsbyvideoid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getcommentsbyvideoid *)aBody
;
@end
@interface MovierDCInterfaceBinding_gettemplateidbyvideoid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gettemplateidbyvideoid * Body;
}
@property (retain) MovierDCInterfaceSvc_gettemplateidbyvideoid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gettemplateidbyvideoid *)aBody
;
@end
@interface MovierDCInterfaceBinding_loginbyaccount : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_loginbyaccount * Body;
}
@property (retain) MovierDCInterfaceSvc_loginbyaccount * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_loginbyaccount *)aBody
;
@end
@interface MovierDCInterfaceBinding_qqregister : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_qqregister * Body;
}
@property (retain) MovierDCInterfaceSvc_qqregister * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_qqregister *)aBody
;
@end
@interface MovierDCInterfaceBinding_weiboregister : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_weiboregister * Body;
}
@property (retain) MovierDCInterfaceSvc_weiboregister * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_weiboregister *)aBody
;
@end
@interface MovierDCInterfaceBinding_wechatregister : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_wechatregister * Body;
}
@property (retain) MovierDCInterfaceSvc_wechatregister * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_wechatregister *)aBody
;
@end
@interface MovierDCInterfaceBinding_getaccountbindstatus : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getaccountbindstatus * Body;
}
@property (retain) MovierDCInterfaceSvc_getaccountbindstatus * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getaccountbindstatus *)aBody
;
@end
@interface MovierDCInterfaceBinding_bindaccount : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_bindaccount * Body;
}
@property (retain) MovierDCInterfaceSvc_bindaccount * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_bindaccount *)aBody
;
@end
@interface MovierDCInterfaceBinding_getorderbytemplateid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getorderbytemplateid * Body;
}
@property (retain) MovierDCInterfaceSvc_getorderbytemplateid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getorderbytemplateid *)aBody
;
@end
@interface MovierDCInterfaceBinding_test1 : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_test1 * Body;
}
@property (retain) MovierDCInterfaceSvc_test1 * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_test1 *)aBody
;
@end
@interface MovierDCInterfaceBinding_test2 : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_test2 * Body;
}
@property (retain) MovierDCInterfaceSvc_test2 * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_test2 *)aBody
;
@end
@interface MovierDCInterfaceBinding_test3 : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_test3 * Body;
}
@property (retain) MovierDCInterfaceSvc_test3 * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_test3 *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmlbs : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmlbs * Body;
}
@property (retain) MovierDCInterfaceSvc_gmlbs * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmlbs *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmgetar : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmgetar * Body;
}
@property (retain) MovierDCInterfaceSvc_gmgetar * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmgetar *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmcreateorderfollowexist : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmcreateorderfollowexist * Body;
}
@property (retain) MovierDCInterfaceSvc_gmcreateorderfollowexist * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmcreateorderfollowexist *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmcreateorder : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmcreateorder * Body;
}
@property (retain) MovierDCInterfaceSvc_gmcreateorder * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmcreateorder *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmshare : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmshare * Body;
}
@property (retain) MovierDCInterfaceSvc_gmshare * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmshare *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmopenchest : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmopenchest * Body;
}
@property (retain) MovierDCInterfaceSvc_gmopenchest * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmopenchest *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmgetrealtimeawardinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmgetrealtimeawardinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_gmgetrealtimeawardinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmgetrealtimeawardinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmgetchest : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmgetchest * Body;
}
@property (retain) MovierDCInterfaceSvc_gmgetchest * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmgetchest *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmcardcompound : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmcardcompound * Body;
}
@property (retain) MovierDCInterfaceSvc_gmcardcompound * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmcardcompound *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmgetvirtualcardbyuserid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmgetvirtualcardbyuserid * Body;
}
@property (retain) MovierDCInterfaceSvc_gmgetvirtualcardbyuserid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmgetvirtualcardbyuserid *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmgetawardbyuserid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmgetawardbyuserid * Body;
}
@property (retain) MovierDCInterfaceSvc_gmgetawardbyuserid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmgetawardbyuserid *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmgettokenamount : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmgettokenamount * Body;
}
@property (retain) MovierDCInterfaceSvc_gmgettokenamount * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmgettokenamount *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmgettokenexchangerule : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmgettokenexchangerule * Body;
}
@property (retain) MovierDCInterfaceSvc_gmgettokenexchangerule * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmgettokenexchangerule *)aBody
;
@end
@interface MovierDCInterfaceBinding_gmtokenexchange : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gmtokenexchange * Body;
}
@property (retain) MovierDCInterfaceSvc_gmtokenexchange * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gmtokenexchange *)aBody
;
@end
@interface MovierDCInterfaceBinding_gettemplateavailable : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_gettemplateavailable * Body;
}
@property (retain) MovierDCInterfaceSvc_gettemplateavailable * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_gettemplateavailable *)aBody
;
@end
@interface MovierDCInterfaceBinding_bcinsertuservideo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_bcinsertuservideo * Body;
}
@property (retain) MovierDCInterfaceSvc_bcinsertuservideo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_bcinsertuservideo *)aBody
;
@end
@interface MovierDCInterfaceBinding_getvideoidbyorderid : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getvideoidbyorderid * Body;
}
@property (retain) MovierDCInterfaceSvc_getvideoidbyorderid * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getvideoidbyorderid *)aBody
;
@end
@interface MovierDCInterfaceBinding_getarawardnewyear : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_getarawardnewyear * Body;
}
@property (retain) MovierDCInterfaceSvc_getarawardnewyear * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_getarawardnewyear *)aBody
;
@end
@interface MovierDCInterfaceBinding_addarawardnewyearreceiverinfo : MovierDCInterfaceBindingOperation {
	MovierDCInterfaceSvc_addarawardnewyearreceiverinfo * Body;
}
@property (retain) MovierDCInterfaceSvc_addarawardnewyearreceiverinfo * Body;
- (id)initWithBinding:(MovierDCInterfaceBinding *)aBinding delegate:(id<MovierDCInterfaceBindingResponseDelegate>)aDelegate
	Body:(MovierDCInterfaceSvc_addarawardnewyearreceiverinfo *)aBody
;
@end
@interface MovierDCInterfaceBinding_envelope : NSObject {
}
+ (MovierDCInterfaceBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface MovierDCInterfaceBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
