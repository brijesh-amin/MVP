//
//  StaticClass.h
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#ifndef StaticClass_h
#define StaticClass_h

#define SHARED_APPDELEGATE [AppDelegate sharedAppDelegate]

//Color
#define appColor [UIColor colorWithRed:236.0/255.0 green:228.0/255.0 blue:108.0/255.0 alpha:1.0]
#define sideMenuSelectColor [UIColor colorWithRed:17.0/255.0 green:13.0/255.0 blue:10.0/255.0 alpha:1.0]
#define viewCircleColor [UIColor colorWithRed:164.0/255.0 green:158.0/255.0 blue:158.0/255.0 alpha:1.0]
#define appDefaultColor [UIColor colorWithRed:254.0/255.0 green:196.0/255.0 blue:14.0/255.0 alpha:1.0]
#define appTextColor [UIColor colorWithRed:255.0/255.0 green:228.0/255.0 blue:0.0/255.0 alpha:1.0]
#define tableColor [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]
#define appTextColor [UIColor colorWithRed:255.0/255.0 green:228.0/255.0 blue:0.0/255.0 alpha:1.0]

#define chartOrangeColor [UIColor colorWithRed:255.0/255.0 green:162.0/255.0 blue:0.0/255.0 alpha:1.0]
#define chartOrangeDarkColor [UIColor colorWithRed:255.0/255.0 green:196.0/255.0 blue:66.0/255.0 alpha:1.0]
#define chartOrangeLightColor [UIColor colorWithRed:255.0/255.0 green:126.0/255.0 blue:0.0/255.0 alpha:1.0]
#define chartGreenLightColor [UIColor colorWithRed:30.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0]
#define chartPinkColor [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:204.0/255.0 alpha:1.0]

#define chartSkyColor [UIColor colorWithRed:0.0/255.0 green:240.0/255.0 blue:255.0/255.0 alpha:1.0]

#define TITLE  @"Title"

#define provideAlert @"Alert !"
#define provideFailed @"Failed !"
#define provideCancel @"Cancel"
#define provideOk @"Ok"

#define DEVICETOKEN @"devicetoken"
#define USEREMAILID @"UserEmailID"
#define DEVICE_ID   @"Device_ID"
#define MSG_ID      @"Msg_ID"
#define PAPID       @"Pap_ID"
#define NAME        @"Name"

//Login
#define UserName @"Username"
#define Password @"Password"
#define Email_ID @"Email_ID"
#define provideUserName @"Please Enter UserName"
#define providePassword @"Please Enter password"

//Register
#define EMailID @"E-Mail ID"
#define CreatePassword @"Create Password"
#define ConfirmPassword @"Confirm Password"
#define MM @"MM"
#define DD @"DD"
#define YYYY @"YYYY"
#define provideCreatePassword @"Please Enter Create Password"
#define provideConfirmPassword @"Please Enter Confirm Password"
#define provideBothSame @"Please Enter Confirm Password and Create Password Same."
#define providePasswordStatus @"Password Must Contain At Least Six Characters."
#define provideDay @"Please Enter Day"
#define provideValidDay @"Please Enter Valid Day Or Two Degit Date."
#define provideDayNumber @"Please Enter Two Degit Date."
#define provideMonth @"Please Enter Month"
#define provideValidMonth @"Please Enter Valid Month Or Two Degit Month."
#define provideMonthNumber @"Please Enter Two Degit Month."
#define provideYear @"Please Enter Year"
#define provideYearNumber @"Please Enter Four Degit Year."
#define provideTermsAndCodition @"Please Select Terms And Condition."
#define provideEmaiID @"Please Enter EmaiID."
#define provideUserName @"Please Enter UserName"
#define provideValidEmail @"Please enter valid email."
#define provideGender @"Please Select Gender"
#define provideChestSize @"Please Select Chest Size"
#define provideWaistSize @"Please Select Waist Size"
#define provideColarSize @"Please Select Colar Size"
#define provideUKTopSize @"Please Select U.K Top Size"
#define provideUKBottomSize @"Please Select U.K Bottom Size"

//MyAccount
#define Name @"Name"
#define SendPapChatMsg @"Send Message"

//SharePap
#define TypeUrl @"Type url.. Here"
#define Attribute1 @"Attribute 1"
#define Attribute2 @"Attribute 2"
#define Attribute3 @"Attribute 3"
#define Attribute4 @"Attribute 4"
#define Attribute5 @"Attribute 5"

#define provideFeedbackMsg @"Enter Feedback."

#define Base_Url @"http://mahatmainfoware.com/iphoneAppServices/"

#define login_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"login.php"]
#define register_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"registeruser.php"]
#define getProfile_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"getprofile.php"]
#define updateProfile_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"updateprofile.php"]
#define profileImg_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"ProfileImage.php"]
#define getPap_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"getallpap.php"]
#define getRecievePap_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"getrecievepap.php"]
#define getFeedbackPap_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"getfeedback.php"]
#define feedbackPap_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"feedbackpap.php"]

#define anlytics_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"anlytics.php"]
#define trend_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"gettrending.php"]
#define forgot_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"forget.php"]
#define sharePap_Url [NSString stringWithFormat:@"%@%@",Base_Url,@"sharepap.php"]

#define serchk_Url [NSString stringWithFormat:@"%@%@",@"http://scimedtv.ncryptedprojects.com/webservice-nct/",@"search.php?"]

#define NOTIFICATION_CENTER_SWIPE @"swipenotification"


#endif /* StaticClass_h */
