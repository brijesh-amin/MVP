//
//  AttributCell.m
//  MVP
//
//  Created by Darshan on 05/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AttributCell.h"

@implementation AttributCell

@synthesize txtAttribut;
@synthesize closeBtnDelegate;
@synthesize index;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    txtAttribut.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribut.leftView = [self getTextFieldRightAndLeftView];
    txtAttribut.rightView = [self getTextFieldRightAndLeftView];
    txtAttribut.leftViewMode = UITextFieldViewModeAlways;
    txtAttribut.rightViewMode = UITextFieldViewModeAlways;
    txtAttribut.layer.cornerRadius = 5.0f;
    txtAttribut.layer.borderWidth = 1.0f;
    txtAttribut.layer.borderColor = [UIColor whiteColor].CGColor;
}

-(UIView*)getTextFieldRightAndLeftView
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    return paddingView;
}

- (IBAction)onClickCloseBtn:(UIButton *)sender {
    
    if (closeBtnDelegate && [closeBtnDelegate respondsToSelector:@selector(closeBtnAtindex:)]) {
        [closeBtnDelegate closeBtnAtindex:index];
    }
}

#pragma mark -
#pragma mark - TEXT FILED DELEGATE

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [textField resignFirstResponder];
    if(closeBtnDelegate && [closeBtnDelegate respondsToSelector:@selector(resingKeyBoard)]){
        [closeBtnDelegate resingKeyBoard];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(closeBtnDelegate && [closeBtnDelegate respondsToSelector:@selector(setTableScrollWithIndex:)]){
        [closeBtnDelegate setTableScrollWithIndex:index];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
