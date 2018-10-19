//
//  TGStandartRedmineModel.h
//  Telegraph
//
//  Created by HeadsAndHands on 26.09.2018.
//

#import <UIKit/UIKit.h>

@interface TGStandartRedmineModel: NSObject

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *name;

- (instancetype)initWithDictionaty:(NSDictionary *)dictionary;

@end
