//
//  ISLabel.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/26.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISLabel.h"

@implementation ISLabel 

+ (instancetype)labelWithDict:(NSDictionary *)dict {
    ISLabel *label      = [[self alloc] init];
    label.nLabelID      = dict[@"labelid"];
    label.szLabelName   = dict[@"labelname"];
    label.nType         = dict[@"labeltype"];
    label.szThumbnail   = dict[@"labelurl"];
    label.nParentID     = dict[@"parentid"];
    return label;
}

#pragma mark-NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.nLabelID forKey:@"Id"];
    [aCoder encodeObject:self.szLabelName forKey:@"name"];
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.nLabelID =  [aDecoder decodeObjectForKey:@"Id"];
        self.szLabelName =  [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end


@implementation ISBanner



@end
