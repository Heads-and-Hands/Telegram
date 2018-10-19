//
//  TGTaskModel.h
//  Telegraph
//
//  Created by HeadsAndHands on 24.09.2018.
//

#import <UIKit/UIKit.h>

#import "TGStandartRedmineModel.h"

@interface TGTaskModel: NSObject

@property (nonatomic) NSInteger id;
@property (nonatomic) TGStandartRedmineModel *project;
@property (nonatomic) TGStandartRedmineModel *tracker;
@property (nonatomic) TGStandartRedmineModel *status;
@property (nonatomic) TGStandartRedmineModel *priority;
@property (nonatomic) TGStandartRedmineModel *author;
@property (nonatomic) TGStandartRedmineModel *assigned_to;
@property (nonatomic) NSString *subject;
@property (nonatomic) NSString *descriptionString;
@property (nonatomic) NSString *start_date;
@property (nonatomic) NSString *due_date;
@property (nonatomic) NSInteger done_ratio;
@property (nonatomic) CGFloat spent_hours;
@property (nonatomic) NSArray *custom_fields;
@property (nonatomic) NSString *created_on;
@property (nonatomic) NSString *updated_on;

- (instancetype)initWithDictionaty:(NSDictionary *)dictionary;

@end
