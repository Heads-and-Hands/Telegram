//
//  TGRedmineViewController.m
//  Telegraph
//
//  Created by HeadsAndHands on 22.09.2018.
//

#import "TGRedmineViewController.h"
#import "TGPresentation.h"

#import "TGRedmineDataManager.h"

#import "TGRedmineTableViewCell.h"

#import "TGRedmineDetailedInfoViewController.h"

@interface TGRedmineViewController () <UITableViewDelegate, UITableViewDataSource, TGRedmineDataManagerDelegate>

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (nonatomic) NSMutableArray *modelArray;
@property (nonatomic) BOOL isEndLoading;
@property (nonatomic) BOOL isLoading;

@end

@implementation TGRedmineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelArray = [NSMutableArray new];
    _isEndLoading = NO;
    _isLoading = NO;
    _dataManager = [[TGRedmineDataManager alloc] init];
    _dataManager.delegate = self;
    
    _actionHandle = [[ASHandle alloc] initWithDelegate:self releaseOnMainThread:true];
    
    _tableView = [[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    if (iosMajorVersion() >= 11)
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [UIColor blackColor];
    [_refreshControl addTarget:self action:@selector(beganRefreshing) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview: self.refreshControl];
    
    if (iosMajorVersion() >= 7) {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = _presentation.pallete.separatorColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0.0f, 80.0f, 0.0f, 0.0f);
    }
    
    _tableView.alwaysBounceVertical = true;
    _tableView.bounces = true;
    _tableView.backgroundColor = nil;
    _tableView.rowHeight = 100.0f;
    _tableView.opaque = false;
    
    [self.view addSubview:_tableView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeWidth
                                                              multiplier:1.0f
                                                                constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeHeight
                                                              multiplier:1.0f
                                                                constant:0.0f]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_isLoading && _modelArray.count == 0) {
        _isLoading = YES;
        [_dataManager requestTasksArrayWithOffset:_modelArray.count];
    }
}

- (void)loadView {
    [super loadView];
    [self setTitleText:TGLocalized(@"Redmine.TabTitle")];
}

- (void)setPresentation:(TGPresentation *)presentation
{
    _presentation = presentation;
    
    self.view.backgroundColor = _presentation.pallete.backgroundColor;
    _tableView.separatorColor = _presentation.pallete.separatorColor;
//    _placeholderLabel.textColor = _presentation.pallete.collectionMenuCommentColor;
    
//    for (UITableViewCell *cell in _tableView.visibleCells)
//    {
//        if ([cell isKindOfClass:[TGCallCell class]])
//            [(TGCallCell *)cell setPresentation:presentation];
//    }
}

- (void)dealloc
{
    [_actionHandle reset];
    [ActionStageInstance() removeWatcher:self];
}

- (void)beganRefreshing {
    if (!self.isLoading) {
        self.isLoading = YES;
        self.isEndLoading = NO;
        [self.dataManager requestTasksArrayWithOffset:0];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    TGRedmineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[TGRedmineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier];
    }
    cell.model = [self.modelArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TGRedmineDetailedInfoViewController *detailedInfoViewController = [[TGRedmineDetailedInfoViewController alloc] init];
    detailedInfoViewController.model = [self.modelArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailedInfoViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint contentOffset = scrollView.contentOffset;
    CGSize contentSize = scrollView.contentSize;
    CGSize scrollViewSize = scrollView.frame.size;
    
    if (contentOffset.y > contentSize.height - 2*scrollViewSize.height && !self.isLoading && !self.isEndLoading) {
        self.isLoading = YES;
        [self.dataManager requestTasksArrayWithOffset:self.modelArray.count];
    }
}


#pragma mark - TGRedmineDataManagerDelegate

- (void)addTasks:(NSArray *)tasksArray offset:(NSInteger)offset {
    self.isLoading = NO;
    [self.refreshControl endRefreshing];
    
    if (tasksArray.count == 0) {
        self.isEndLoading = YES;
        return;
    }
    
    if (offset == 0) {
        [self.modelArray removeAllObjects];
    }
    
    [self.modelArray addObjectsFromArray:tasksArray];
    [self.tableView reloadData];
}

- (void)loadingError:(NSString *)errorString {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:
                                TGLocalized(@"Common.Error") message:errorString preferredStyle:UIAlertControllerStyleActionSheet];
   
    UIAlertAction* actionReloading = [UIAlertAction actionWithTitle:TGLocalized(@"Common.Reloading") style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          if (self.refreshControl.refreshing) {
                                                              [self.dataManager requestTasksArrayWithOffset:0];
                                                          } else {
                                                              [self.dataManager requestTasksArrayWithOffset:self.modelArray.count];
                                                          }
                                                      }];
    UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:TGLocalized(@"Common.Cancel") style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             self.isLoading = NO;
                                                             [self.refreshControl endRefreshing];
                                                         }];
    
    [alert addAction:actionReloading];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
