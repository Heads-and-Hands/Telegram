//
//  TGTaskModel.m
//  Telegraph
//
//  Created by HeadsAndHands on 24.09.2018.
//

#import "TGTaskModel.h"

@implementation TGTaskModel

- (instancetype)initWithDictionaty:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if ([[dictionary objectForKey:@"id"] isKindOfClass: [NSNumber class]]) {
            self.id = [(NSNumber *) [dictionary objectForKey:@"id"] integerValue];
        }
        NSDictionary *dict;
        if ([[dictionary objectForKey:@"project"] isKindOfClass: [NSDictionary class]]) {
            dict = (NSDictionary *) [dictionary objectForKey:@"project"];
            self.project = [[TGStandartRedmineModel alloc] initWithDictionaty:dict];
        }
        if ([[dictionary objectForKey:@"tracker"] isKindOfClass: [NSDictionary class]]) {
            dict = (NSDictionary *) [dictionary objectForKey:@"tracker"];
            self.tracker = [[TGStandartRedmineModel alloc] initWithDictionaty:dict];
        }
        if ([[dictionary objectForKey:@"status"] isKindOfClass: [NSDictionary class]]) {
            dict = (NSDictionary *) [dictionary objectForKey:@"status"];
            self.status = [[TGStandartRedmineModel alloc] initWithDictionaty:dict];
        }
        if ([[dictionary objectForKey:@"priority"] isKindOfClass: [NSDictionary class]]) {
            dict = (NSDictionary *) [dictionary objectForKey:@"priority"];
            self.priority = [[TGStandartRedmineModel alloc] initWithDictionaty:dict];
        }
        if ([[dictionary objectForKey:@"author"] isKindOfClass: [NSDictionary class]]) {
            dict = (NSDictionary *) [dictionary objectForKey:@"author"];
            self.author = [[TGStandartRedmineModel alloc] initWithDictionaty:dict];
        }
        if ([[dictionary objectForKey:@"assigned_to"] isKindOfClass: [NSDictionary class]]) {
            dict = (NSDictionary *) [dictionary objectForKey:@"assigned_to"];
            self.assigned_to = [[TGStandartRedmineModel alloc] initWithDictionaty:dict];
        }
        if ([[dictionary objectForKey:@"subject"] isKindOfClass: [NSString class]]) {
            self.subject = (NSString *) [dictionary objectForKey:@"subject"];
        }
        if ([[dictionary objectForKey:@"description"] isKindOfClass: [NSString class]]) {
            self.descriptionString = (NSString *) [dictionary objectForKey:@"description"];
        }
        if ([[dictionary objectForKey:@"start_date"] isKindOfClass: [NSString class]]) {
            self.start_date = (NSString *) [dictionary objectForKey:@"start_date"];
        }
        if ([[dictionary objectForKey:@"due_date"] isKindOfClass: [NSString class]]) {
            self.due_date = (NSString *) [dictionary objectForKey:@"due_date"];
        }
        if ([[dictionary objectForKey:@"spent_hours"] isKindOfClass: [NSNumber class]]) {
            self.spent_hours = [(NSNumber *) [dictionary objectForKey:@"spent_hours"] floatValue];
        }
        if ([[dictionary objectForKey:@"done_ratio"] isKindOfClass: [NSNumber class]]) {
            self.done_ratio = [(NSNumber *) [dictionary objectForKey:@"done_ratio"] integerValue];
        }
        if ([[dictionary objectForKey:@"custom_fields"] isKindOfClass: [NSArray class]]) {
            self.custom_fields = (NSArray *) [dictionary objectForKey:@"custom_fields"];
        }
        if ([[dictionary objectForKey:@"created_on"] isKindOfClass: [NSString class]]) {
            self.created_on = (NSString *) [dictionary objectForKey:@"created_on"];
        }
        if ([[dictionary objectForKey:@"updated_on"] isKindOfClass: [NSString class]]) {
            self.updated_on = (NSString *) [dictionary objectForKey:@"updated_on"];
        }
    }
    return self;
}

@end
