//
//  TGStandartRedmineModel.m
//  Telegraph
//
//  Created by HeadsAndHands on 26.09.2018.
//

#import "TGStandartRedmineModel.h"

@implementation TGStandartRedmineModel

- (instancetype)initWithDictionaty:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if ([[dictionary objectForKey:@"id"] isKindOfClass: [NSNumber class]]) {
            self.id = [(NSNumber *) [dictionary objectForKey:@"id"] integerValue];
        }
        if ([[dictionary objectForKey:@"name"] isKindOfClass: [NSString class]]) {
            self.name = (NSString *) [dictionary objectForKey:@"name"];
        }
    }
    return self;
}

@end
