//
//  ContactListView.h
//  MVP
//
//  Created by Darshan on 03/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "ContactListCell.h"

typedef enum {
    Group_One,
    Group_Two,
    Group_Three,
    
} GroupType;

@interface ContactListView : UIViewController
{
    IBOutlet UITableView *tblList;
    NSMutableArray *arrContact;
    
    NSMutableArray *arrSelected;
    IBOutlet UITextField *txtGroupName;
}
@property (nonatomic)GroupType grouptype;

@property (nonatomic , strong) IBOutlet UIButton *btnSend;
@property (nonatomic , strong) IBOutlet UIButton *btnCancel;

@end
