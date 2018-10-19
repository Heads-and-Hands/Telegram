//
//  TGRedmineDataManager.h
//  Telegraph
//
//  Created by HeadsAndHands on 24.09.2018.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol TGRedmineDataManagerDelegate;

@interface TGRedmineDataManager : NSObject

@property (nonatomic) id<TGRedmineDataManagerDelegate> delegate;

- (void)requestTasksArrayWithOffset:(NSInteger)offset;

@end

@protocol TGRedmineDataManagerDelegate <NSObject>

- (void)addTasks:(NSArray *)tasksArray offset:(NSInteger)offset;
- (void)loadingError:(NSString *)errorString;

@end
