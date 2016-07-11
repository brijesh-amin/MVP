//
//  ContactListView.m
//  MVP
//
//  Created by Darshan on 03/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ContactListView.h"
#import "ContactData.h"

#define GROUP_ONE   @"groupone"
#define GROUP_TWO   @"grouptwo"
#define GROUP_THREE @"groupthree"

#define GROUP_NAME_ONE   @"groupnameone"
#define GROUP_NAME_TWO   @"groupnametwo"
#define GROUP_NAME_THREE @"groupnamethree"


@interface ContactListView ()

@end

@implementation ContactListView

@synthesize grouptype;
@synthesize btnSend;
@synthesize btnCancel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrContact =[[NSMutableArray alloc]init];
    [arrContact addObjectsFromArray:[self getAllContactsfromContact]];
    
    arrSelected =[[NSMutableArray alloc]init];

    [tblList reloadData];
    
    btnSend.layer.cornerRadius = 15.0f;
    btnCancel.layer.cornerRadius = 15.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrContact count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdenti = @"ContactListCell";
    
    ContactListCell *cell = (ContactListCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactListCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    NSMutableDictionary *contact =[arrContact objectAtIndex:indexPath.row];
    if([arrSelected containsObject:contact]){
        [cell setSelectedData:contact];
    }else{
        [cell setNormalData:contact];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *contact =[arrContact objectAtIndex:indexPath.row];
    if([arrSelected containsObject:contact]){
        [arrSelected removeObject:contact];
    }else{
        [arrSelected addObject:contact];
    }
    [tblList reloadData];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)onClickSaveGroup:(id)sender
{
    if ([txtGroupName.text length] == 0) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Alert !"
                                      message:@"Please Enter Group Name"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSString *strgroupName =txtGroupName.text;
    if(strgroupName.length == 0){
        NSLog(@"Please enter group name");
        
        return;
    }
    if([arrSelected count]  == 0){
        
        NSLog(@"pleae select contact to add in group");
        return;
    }
    
    NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
    
    NSArray *arr =[NSArray arrayWithArray:(NSArray*)arrSelected];
    
    if(grouptype == Group_One){
        

        [userDefault setObject:arr forKey:GROUP_ONE];
        [userDefault setObject:strgroupName forKey:GROUP_NAME_ONE];
        
    }else if(grouptype == Group_Two){
        
        [userDefault setObject:arr forKey:GROUP_TWO];
        [userDefault setObject:strgroupName forKey:GROUP_NAME_TWO];
        
    }else if(grouptype == Group_Three){
        [userDefault setObject:arr forKey:GROUP_THREE];
        [userDefault setObject:strgroupName forKey:GROUP_NAME_THREE];
    }
    [userDefault synchronize];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickCancelBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *)getAllContactsfromContact {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    CFErrorRef *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    __block BOOL accessGranted = NO;
    
    if (&ABAddressBookRequestAccessWithCompletion != NULL){
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else{
        accessGranted = YES;
    }
    if (accessGranted){
        // If the app is authorized to access the first time then add the contact
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
        
        for (int i=0; i<numberOfPeople; i++){
            CFStringRef phone;
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
            CFStringRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
            NSString *userName = @"NoName";
            
            userName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            userName = [userName stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            ABMutableMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            CFIndex phoneNumberCount = ABMultiValueGetCount( phoneNumbers );
            
            phone = nil;
            
            for ( CFIndex ind= 0; ind<phoneNumberCount; ind++ ){
                CFStringRef phoneNumberLabel = ABMultiValueCopyLabelAtIndex( phoneNumbers, ind);
                CFStringRef phoneNumberValue = ABMultiValueCopyValueAtIndex( phoneNumbers, ind);
                if (phoneNumberLabel != nil){
                    CFStringCompareFlags compareOptions  =  kCFCompareCaseInsensitive ;
                    if(CFStringCompare(phoneNumberLabel, CFSTR("mobile"),compareOptions)){
                        phone = phoneNumberValue;
                    }
                    phone = phoneNumberValue;
                    CFStringCompareFlags compareOptionss  =  kCFCompareCaseInsensitive ;
                    if(!CFStringCompare(phone, CFSTR("1-800-MY-APPLE"),compareOptionss)){
                        continue;
                    }
                    /*
                    ContactData *contactData =  [[ContactData alloc]init];
                    contactData.firstName = userName;
                    contactData.lastName = [userName lowercaseString];
                    contactData.contact =[NSString stringWithFormat:@"%@", phone];
                    contactData.email = [NSString stringWithFormat:@"%@" ,email];
                     */
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    
                    [dict setObject:userName forKey:@"firstName"];
                    [dict setObject:userName forKey:@"lastName"];
                    [dict setObject:[NSString stringWithFormat:@"%@", phone] forKey:@"contact"];
                    [dict setObject:[NSString stringWithFormat:@"%@" ,email] forKey:@"email"];
                    
                    [result addObject:dict];
                }
                break;
            }
        }
    }
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
