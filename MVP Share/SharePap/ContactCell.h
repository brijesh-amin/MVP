//
//  ContactCell.h
//  MVP
//
//  Created by Darshan on 03/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactData.h"

@interface ContactCell : UICollectionViewCell
{
    
    IBOutlet UILabel *lblFname;
    IBOutlet UILabel *lblLname;
    IBOutlet UIImageView *imgProfile;
    
    IBOutlet UIButton *btnSelected;
}

-(void)setContacts:(NSMutableDictionary *)data;

-(void)setNormalContact:(NSMutableDictionary *)data;
-(void)setSelectedContact:(NSMutableDictionary *)data;

@end
