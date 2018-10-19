//
//  TGRedmineDetailedInfoViewController.m
//  Telegraph
//
//  Created by HeadsAndHands on 17.10.2018.
//

#import "TGRedmineDetailedInfoViewController.h"

#import "TGPresentation.h"

@interface TGRedmineDetailedInfoViewController ()

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *projectLabel;
@property (nonatomic) UILabel *statusLabel;
@property (nonatomic) UILabel *doneRatioLabel;
@property (nonatomic) UILabel *priorityLabel;
@property (nonatomic) UILabel *assignedLabel;
@property (nonatomic) UILabel *dateStartLabel;
@property (nonatomic) UILabel *dateEndLabel;
@property (nonatomic) UILabel *laborCostsLabel;
@property (nonatomic) UILabel *descriptionLabel;

@end

@implementation TGRedmineDetailedInfoViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self configurationView];
    }
    
    return self;
}

- (void)configurationView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.titleLabel = [self createLabel];
    self.projectLabel = [self createLabel];
    self.statusLabel = [self createLabel];
    self.doneRatioLabel = [self createLabel];
    self.priorityLabel = [self createLabel];
    self.assignedLabel = [self createLabel];
    self.dateStartLabel = [self createLabel];
    self.dateEndLabel = [self createLabel];
    self.laborCostsLabel = [self createLabel];
    self.descriptionLabel = [self createLabel];
    
    [scrollView addSubview:self.titleLabel];
    [scrollView addSubview:self.projectLabel];
    [scrollView addSubview:self.statusLabel];
    [scrollView addSubview:self.doneRatioLabel];
    [scrollView addSubview:self.priorityLabel];
    [scrollView addSubview:self.assignedLabel];
    [scrollView addSubview:self.dateStartLabel];
    [scrollView addSubview:self.dateEndLabel];
    [scrollView addSubview:self.laborCostsLabel];
    [scrollView addSubview:self.descriptionLabel];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"titleLabel": self.titleLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[projectLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"projectLabel": self.projectLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[statusLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"statusLabel": self.statusLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[doneRatioLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"doneRatioLabel": self.doneRatioLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[priorityLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"priorityLabel": self.priorityLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[assignedLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"assignedLabel": self.assignedLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[dateStartLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"dateStartLabel": self.dateStartLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[dateEndLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"dateEndLabel": self.dateEndLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[laborCostsLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"laborCostsLabel": self.laborCostsLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[descriptionLabel]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"descriptionLabel": self.descriptionLabel}]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-[projectLabel]-[statusLabel]-[doneRatioLabel]-[priorityLabel]-[assignedLabel]-[dateStartLabel]-[dateEndLabel]-[laborCostsLabel]-[descriptionLabel]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"titleLabel": self.titleLabel,
                                                                                 @"projectLabel": self.projectLabel,
                                                                                 @"statusLabel": self.statusLabel,
                                                                                 @"doneRatioLabel": self.doneRatioLabel,
                                                                                 @"priorityLabel": self.priorityLabel,
                                                                                 @"assignedLabel": self.assignedLabel,
                                                                                 @"dateStartLabel": self.dateStartLabel,
                                                                                 @"dateEndLabel": self.dateEndLabel,
                                                                                 @"laborCostsLabel": self.laborCostsLabel,
                                                                                 @"descriptionLabel": self.descriptionLabel}]];
    
    [self.view addSubview:scrollView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[scrollView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(scrollView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[scrollView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(scrollView)]];
}

- (void)setModel:(TGTaskModel *)model {
    _model = model;
    
    [self setTitleText: [NSString stringWithFormat:@"%@ #%li",self.model.tracker.name, self.model.id]];
    
    if (_model.subject != nil) {
        self.titleLabel.text = _model.subject;
    }
    if (_model.project.name != nil) {
        self.projectLabel.text = [NSString stringWithFormat:@"Проект: %@", _model.project.name];
    }
    if (_model.status.name != nil) {
        self.statusLabel.text = [NSString stringWithFormat:@"Статус: %@", _model.status.name];
    }
    self.doneRatioLabel.text = [NSString stringWithFormat:@"Выполнено: %li %%", _model.done_ratio];
    if (_model.priority.name != nil) {
        self.priorityLabel.text = [NSString stringWithFormat:@"Приоритет: %@", _model.priority.name];
    }
    if (_model.assigned_to.name != nil) {
        self.assignedLabel.text = [NSString stringWithFormat:@"Назначена: %@", _model.assigned_to.name];
    }
    if (_model.start_date != nil) {
        self.projectLabel.text = [NSString stringWithFormat:@"Дата начала: %@", _model.start_date];
    }
    if (_model.due_date != nil) {
        self.dateEndLabel.text = [NSString stringWithFormat:@"Дата окончания: %@", _model.due_date];
    }
    self.laborCostsLabel.text = [NSString stringWithFormat:@"Трудозатраты: %0.1f ч.", _model.spent_hours];
    if (_model.descriptionString != nil) {
        self.descriptionLabel.text = [NSString stringWithFormat:@"Описание: %@", _model.descriptionString];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _actionHandle = [[ASHandle alloc] initWithDelegate:self releaseOnMainThread:true];
}

- (void)loadView {
    [super loadView];
    [self setTitleText: [NSString stringWithFormat:@"%@ #%li",self.model.tracker.name, self.model.id]];
}

- (void)setPresentation:(TGPresentation *)presentation
{
    _presentation = presentation;
    
    self.view.backgroundColor = _presentation.pallete.backgroundColor;
}

- (void)dealloc
{
    [_actionHandle reset];
    [ActionStageInstance() removeWatcher:self];
}

- (UILabel *)createLabel {
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    
    return label;
}

@end
