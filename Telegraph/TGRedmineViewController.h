//
//  TGRedmineViewController.h
//  Telegraph
//
//  Created by HeadsAndHands on 22.09.2018.
//

#import <UIKit/UIKit.h>

#import <LegacyComponents/LegacyComponents.h>

@class TGPresentation;
@class TGRedmineDataManager;

@interface TGRedmineViewController : TGViewController <TGViewControllerNavigationBarAppearance, ASWatcher>

@property (nonatomic, strong, readonly) ASHandle *actionHandle;
@property (nonatomic, strong) TGPresentation *presentation;

@property (nonatomic, strong) TGRedmineDataManager *dataManager;

@property (nonatomic, strong) UITableView *tableView;

@end
