//
//  MineAddBankViewController.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/29/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "MineAddBankViewController.h"
#import "BankInformation.h"
#import <ActionSheetPicker.h>

@interface MineAddBankViewController () <ActionSheetCustomPickerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSArray *leftDataSource;
@property (nonatomic, strong) NSArray *rightDataSource;
@property (nonatomic, strong) NSMutableArray *tmpBankArray;
@property (nonatomic, strong) NSMutableArray *tmpPostArray;
@property (nonatomic, strong) NSMutableArray *tmpCredit_cooperativeArray;
@property (nonatomic, strong) NSMutableArray *tmpPeasant_associationArray;
@property (nonatomic, strong) NSMutableArray *tmpFisherman_associationArray;
@property (nonatomic, strong) BankInformation *selectedBank;
@property (nonatomic, strong) UITextField *bankTextField;
@property (nonatomic, strong) ActionSheetCustomPicker *picker;

@end

@implementation MineAddBankViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 20.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"新增銀行帳戶";
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
    
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"bank_info" ofType:@"json"];
    NSError * error;
    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if(error){
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    NSDictionary *bankDic = [NSJSONSerialization
                                     JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                     options:0 error:NULL];
    self.leftDataSource = @[@"銀行",@"郵局",@"信用合作社",@"農會",@"漁會"];
    
    self.tmpBankArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"bank"] allKeys]) {
        NSString *value = bankDic[@"bank"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [self.tmpBankArray addObject:bank];
    }

    self.tmpPostArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"post"] allKeys]) {
        NSString *value = bankDic[@"post"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [self.tmpPostArray addObject:bank];
    }
    
    self.tmpCredit_cooperativeArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"credit_cooperative"] allKeys]) {
        NSString *value = bankDic[@"credit_cooperative"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [self.tmpCredit_cooperativeArray addObject:bank];
    }
    
    self.tmpPeasant_associationArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"peasant_association"] allKeys]) {
        NSString *value = bankDic[@"peasant_association"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [self.tmpPeasant_associationArray addObject:bank];
    }
    
    self.tmpFisherman_associationArray = [NSMutableArray new];
    for (NSString *key in [bankDic[@"fisherman_association"] allKeys]) {
        NSString *value = bankDic[@"fisherman_association"][key];
        BankInformation *bank = [[BankInformation alloc] initWithId:key withName:value];
        [self.tmpFisherman_associationArray addObject:bank];
    }
    self.rightDataSource = [self.tmpBankArray copy];
    self.selectedBank = self.rightDataSource[0];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(40.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
    
    UILabel *uaernameLabel = [[UILabel alloc] init];
    uaernameLabel.textColor = [UIColor blackColor];
    uaernameLabel.font = [UIFont systemFontOfSize:10];
    uaernameLabel.text = @"請選擇付款銀行";
    [self.view addSubview:uaernameLabel];
    [uaernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.view addSubview:self.bankTextField];
    [self.bankTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uaernameLabel.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    [self.view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankTextField.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.height.equalTo(@0.5);
    }];
}


#pragma mark - private methods

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) textFieldTap {
    self.rightDataSource = nil;
    self.rightDataSource = [self.tmpBankArray copy];
    [self.picker showActionSheetPicker];
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - ActionSheetCustomPickerDelegate Optional's
/////////////////////////////////////////////////////////////////////////
- (void)configurePickerView:(UIPickerView *)pickerView{
    // Override default and hide selection indicator
    pickerView.showsSelectionIndicator = NO;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin{
    self.bankTextField.text = self.selectedBank.name;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource Implementation
/////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    // Returns
    switch (component) {
        case 0: return [self.leftDataSource count];
        case 1: return [self.rightDataSource count];
        default:break;
    }
    return 0;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark UIPickerViewDelegate Implementation
/////////////////////////////////////////////////////////////////////////

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component) {
        case 0: return SCREEN_WIDTH*2/5;
        case 1: return SCREEN_WIDTH*3/5;
        default:break;
    }
    
    return 0;
}
/*- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {
 return
 }
 */
// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0: return self.leftDataSource[(NSUInteger) row];
        case 1: return [self.rightDataSource[(NSUInteger) row] name];
        default:break;
    }
    return nil;
}

/////////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            self.rightDataSource = nil;
            if (row == 0) {
                self.rightDataSource = [self.tmpBankArray copy];
            }else if (row == 1){
                self.rightDataSource = [self.tmpPostArray copy];
            }else if (row == 2){
                self.rightDataSource = [self.tmpCredit_cooperativeArray copy];
            }else if (row == 3){
                self.rightDataSource = [self.tmpPeasant_associationArray copy];
            }else if (row == 4){
                self.rightDataSource = [self.tmpFisherman_associationArray copy];
            }
            [pickerView reloadComponent:1];
            self.selectedBank = self.rightDataSource[0];
            return;
        case 1:
            self.selectedBank = self.rightDataSource[(NSUInteger) row];
            return;
        default:break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.bankTextField) {
        [self textFieldTap];
        return NO;
    }
    return YES;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* label = (UILabel*)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont systemFontOfSize:14.0]];
    }
    NSString *string = nil;
    switch (component) {
        case 0:
            string = self.leftDataSource[(NSUInteger) row];
            break;
        case 1:
            string = [self.rightDataSource[(NSUInteger) row] name];
            break;
        default:
            break;
    }
    label.text = string;
    return label;
}

#pragma mark - getter and setter

- (UIButton *) backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
        [_backButton addTarget:self action:@selector(popToPreViewController) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UITextField *) bankTextField {
    if (!_bankTextField) {
        _bankTextField = [[UITextField alloc] init];
        _bankTextField.delegate = self;
        _bankTextField.keyboardType = UIKeyboardTypeDefault;
        _bankTextField.font = DEFAULFONT;
        _bankTextField.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        [_bankTextField setTintColor:DEFAULTCOLOR];
        _bankTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"請選擇付款銀行"
                                                                               attributes:@{NSForegroundColorAttributeName:
                                                                                                [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]}];
    }
    return _bankTextField;
}

- (ActionSheetCustomPicker *) picker {
    if (!_picker) {
        _picker = [[ActionSheetCustomPicker alloc] initWithTitle:@"請選擇付款銀行" delegate:self showCancelButton:YES origin:self.bankTextField initialSelections:@[@0, @0]];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"    確定    "  style:UIBarButtonItemStylePlain target:nil action:nil];
        [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName:DEFAULTTEXTCOLOR,NSFontAttributeName : [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        [_picker setDoneButton:doneButton];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"    取消    "  style:UIBarButtonItemStylePlain target:nil action:nil];
        [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName:DEFAULTTEXTCOLOR,NSFontAttributeName : [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        [_picker setCancelButton:cancelButton];
    }
    return _picker;
}

@end
