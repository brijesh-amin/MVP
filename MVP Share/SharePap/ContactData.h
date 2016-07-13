//
//  ContactData.h
//  Zobaze
//
//  Created by Mitul on 18/02/16.
//  Copyright © 2016 com.abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ContactData : NSObject


@property (strong ,nonatomic) NSString *contactId;
@property(strong , nonatomic) NSString *firstName;
@property(strong , nonatomic) NSString *lastName;
@property(strong , nonatomic) NSString *contact;
@property(strong , nonatomic) NSString *email;
@property(strong , nonatomic) UIImage *imgIco;

@end
