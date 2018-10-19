//
//  TGRedmineDetailedInfoViewController.h
//  Telegraph
//
//  Created by HeadsAndHands on 17.10.2018.
//

#import <UIKit/UIKit.h>
#import <LegacyComponents/LegacyComponents.h>

#import "TGTaskModel.h"

@class TGPresentation;
@class TGRedmineDataManager;

@interface TGRedmineDetailedInfoViewController : TGViewController <TGViewControllerNavigationBarAppearance, ASWatcher>

@property (nonatomic, strong, readonly) ASHandle *actionHandle;
@property (nonatomic, strong) TGPresentation *presentation;

@property (nonatomic) TGTaskModel *model;

@end
