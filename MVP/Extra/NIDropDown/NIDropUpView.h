//
//  NIDropUpView.h
//  MVP
//
//  Created by Darshan on 20/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropUpView;

@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropUpView *) sender;
@end

@interface NIDropUpView : UIViewController<UITableViewDelegate, UITableViewDataSource>

{
    NSString *animationDirection;
//    UIImageView *imgView;
}

//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblSelect;

@property (nonatomic, retain) id <NIDropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;

@property (nonatomic , strong) NSMutableArray *arrSelectList;

@property(nonatomic, strong) UIButton *btnSender;

-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)b :(CGFloat *)height :(NSMutableArray *)arr :(NSArray *)imgArr :(NSString *)direction;

@end
