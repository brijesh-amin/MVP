//
//  NIDropUpView.m
//  MVP
//
//  Created by Darshan on 20/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "NIDropUpView.h"
#import "QuartzCore/QuartzCore.h"
#import "NIDropUpCell.h"

@interface NIDropUpView ()

@end

@implementation NIDropUpView

//UITableView
@synthesize tblSelect;

//NSMutableArray
@synthesize arrSelectList;

@synthesize delegate;
@synthesize animationDirection;
@synthesize btnSender;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (id)showDropDown:(UIButton *)b :(CGFloat *)height :(NSMutableArray *)arr :(NSArray *)imgArr :(NSString *)direction {
    btnSender = b;
    animationDirection = direction;
    
    if (self) {
        // Initialization code
        CGRect btn = b.frame;
//        self.list = [NSArray arrayWithArray:arr];
        
        arrSelectList = [[NSMutableArray alloc] init];
        
        arrSelectList = [NSMutableArray arrayWithArray:arr];
        
        if ([direction isEqualToString:@"up"]) {
            self.view.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.view.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.view.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.view.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.view.layer.masksToBounds = NO;
        self.view.layer.cornerRadius = 8;
        self.view.layer.shadowRadius = 5;
        self.view.layer.shadowOpacity = 0.5;
        
        tblSelect.frame = CGRectMake(0, 0, btn.size.width, 0);
        tblSelect.delegate = self;
        tblSelect.dataSource = self;
        tblSelect.layer.cornerRadius = 5;
        
        tblSelect.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        tblSelect.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tblSelect.separatorColor = [UIColor grayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.view.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.view.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        }
        
        [UIView commitAnimations];
//        [b.superview addSubview:self];
        
//        tblSelect.frame = CGRectMake(0, 0, btn.size.width, *height);
//        [self addSubview:tblSelect];
    }
    return self;
}

-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
        self.view.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.view.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    tblSelect.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrSelectList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdenti = @"ChatImageCell";
    
    NIDropUpCell *cell = (NIDropUpCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NIDropUpCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
//    if ([self.imageList count] == [self.list count]) {
//        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        cell.imageView.image = [imageList objectAtIndex:indexPath.row];
//    } else if ([self.imageList count] > [self.list count]) {
//        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        if (indexPath.row < [imageList count]) {
//            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
//        }
//    } else if ([self.imageList count] < [self.list count]) {
//        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        if (indexPath.row < [imageList count]) {
//            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
//        }
//    }
    
    cell.lblTitle.text =[arrSelectList objectAtIndex:indexPath.row];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:btnSender];
    
//    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
//    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
//    
//    for (UIView *subview in btnSender.subviews) {
//        if ([subview isKindOfClass:[UIImageView class]]) {
//            [subview removeFromSuperview];
//        }
//    }
//    imgView.image = c.imageView.image;
//    imgView = [[UIImageView alloc] initWithImage:c.imageView.image];
//    imgView.frame = CGRectMake(5, 5, 25, 25);
//    [btnSender addSubview:imgView];
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate niDropDownDelegateMethod:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
