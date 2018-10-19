//
//  TGRedmineDataManager.m
//  Telegraph
//
//  Created by HeadsAndHands on 24.09.2018.
//

#import "TGRedmineDataManager.h"

#import "TGTaskModel.h"

@interface TGRedmineDataManager ()

@end

@implementation TGRedmineDataManager

- (void)requestTasksArrayWithOffset:(NSInteger)offset {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    
    NSString *userDefaultsAddress = @"RedmineAddress";
    NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsAddress];
    
    NSString *userDefaultsApiKey = @"RedmineApiKey";
    NSString *apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsApiKey];
    
    if ([address length] < 1) {
        NSLog(@"Error: %@", TGLocalized(@"Redmine.ErrorAddress"));
        [self.delegate loadingError:TGLocalized(@"Redmine.ErrorAddress")];
        return;
    }
    
    if ([apiKey length] < 1) {
        NSLog(@"Error: %@", TGLocalized(@"Redmine.ErrorKey"));
        [self.delegate loadingError:TGLocalized(@"Redmine.ErrorKey")];
        return;
    }
    
    NSString *stringURL = [NSString stringWithFormat:@"%@/issues.json?assigned_to_id=me&set_filter=1&sort=priority&offset=%li&limit=30&key=%@", address, offset, apiKey];
    [request setURL:[NSURL URLWithString:stringURL]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if (error == nil) {
              NSError *err = nil;
              
              if (data!=nil) {
                  
                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
                  
                  if (err == nil) {
                      NSArray *issues = json[@"issues"];
                      NSMutableArray *result = [[NSMutableArray alloc] init];
                      
                      for (NSDictionary *dict in issues) {
                          [result insertObject:[[TGTaskModel alloc] initWithDictionaty:dict] atIndex:0];
                      }
                      
                      NSInteger offsetData = [(NSNumber *)json[@"offset"] integerValue];
                      
                      NSLog(@"OK");
                      [self.delegate addTasks:result offset:offsetData];
                  } else {
                      NSLog(@"Error: %@", err.localizedDescription);
                      [self.delegate loadingError:err.localizedDescription];
                  }
              }
          } else {
              NSLog(@"Error: %@", error.localizedDescription);
              [self.delegate loadingError:error.localizedDescription];
          }
      }] resume];
}

@end
