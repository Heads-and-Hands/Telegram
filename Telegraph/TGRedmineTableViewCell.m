//
//  TGRedmineTableViewCell.m
//  Telegraph
//
//  Created by HeadsAndHands on 25.09.2018.
//

#import "TGRedmineTableViewCell.h"
#import "TGTaskModel.h"

@interface TGRedmineTableViewCell()

@property (nonatomic) UIView *typeView;
@property (nonatomic) UILabel *numberLabel;
@property (nonatomic) UILabel *projectLabel;
@property (nonatomic) UILabel *subjectLabel;

@end

@implementation TGRedmineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.clipsToBounds = true;
        
        _typeView = [UIView new];
        _typeView.translatesAutoresizingMaskIntoConstraints = NO;
        _typeView.backgroundColor = [UIColor clearColor];
        
        _numberLabel = [self createLabel];
        _projectLabel = [self createLabel];
        _subjectLabel = [self createLabel];
        
        [self addSubview:_typeView];
        [self addSubview:_numberLabel];
        [self addSubview:_projectLabel];
        [self addSubview:_subjectLabel];
        
        NSDictionary *metrics = @{
            @"widthTypeView" : @10,
            @"verticalIndent" : @5,
            @"horizontalIndent" : @10,
            @"widthNumberLabel" : @70,
            @"widthProjectLabel" : @100
        };
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_typeView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_typeView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(verticalIndent)-[_numberLabel]-(verticalIndent)-|"
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:NSDictionaryOfVariableBindings(_numberLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(verticalIndent)-[_projectLabel]-(verticalIndent)-|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:NSDictionaryOfVariableBindings(_projectLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(verticalIndent)-[_subjectLabel]-(verticalIndent)-|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:NSDictionaryOfVariableBindings(_subjectLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_typeView(widthTypeView)]-(horizontalIndent)-[_numberLabel(widthNumberLabel)]-(horizontalIndent)-[_projectLabel(widthProjectLabel)]-(horizontalIndent)-[_subjectLabel]-(horizontalIndent)-|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:NSDictionaryOfVariableBindings(_typeView,
                                                                                                            _numberLabel,
                                                                                                            _projectLabel,
                                                                                                            _subjectLabel)]];
    }
    return self;
}

- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = false;
    label.numberOfLines = 0;
    
    
    return label;
}

- (void)dealloc {
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TGTaskModel *)model {
    _model = model;
    
    _numberLabel.text = [NSString stringWithFormat:@"#%i", model.id];
    _projectLabel.text = model.project.name;
    _subjectLabel.text = model.subject;
    
    UIColor *color = [UIColor clearColor];
    switch (model.tracker.id) {
        case 1:
            color = [UIColor redColor];
            break;
        case 2:
            color = [UIColor greenColor];
            break;
        case 6:
            color = [UIColor blueColor];
            break;
        case 10:
            color = [UIColor yellowColor];
            break;
        case 11:
            color = [UIColor purpleColor];
            break;
            
        default:
            break;
    }
    _typeView.backgroundColor = color;
}

@end
