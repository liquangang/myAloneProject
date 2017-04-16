
//
//  main.m
//  M-Cut
//
//  Created by Crab shell on 12/21/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include "MovierDCInterfaceSvc.h"
#import "GlobalVars.h"
#import "StockData.h"
#import "SoapOperation.h"

NSString *_szEndPoint = soapURL;

sqlite3 *contactDB;
NSString *databasePath;
int orderStatus;
int orderCurrent;
int global;
NSString *namenick;
NSString *szEmails;
NSString *szPersonalSignature;
int dissession;
NSString *state;
NSString *city;
NSString *finish;
NSString *captionedite;
float downloadprogress;
StockData* stockForKVO;


int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        stockForKVO = [[StockData alloc] init];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
