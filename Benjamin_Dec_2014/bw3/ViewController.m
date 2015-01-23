//
//  ViewController.m
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "ViewController.h"
#import "UserLogin.h"
#import "MainVC.h"
#import "WIC.h"
#import "SettingsMain.h"
#import "Updates.h"
#import "ServerSettingsVC.h"
#import "AppDelegate.h"
#import "Database.h"
#import "BwCuboid.h"
#import "Cuboid.h"
#import "Refresh.h"
#import "LinkImport.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize StartPos;
@synthesize scrollView;
@synthesize activeField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.usertext.delegate = self;
    self.passtext.delegate = self;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}



// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}
 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignInbutton:(id)sender {
    
   // SettingsMain *SM = [[SettingsMain alloc]init];
    //[self presentViewController:SM animated:YES completion:nil];
    //----test all updates
    //Updates *upd = [[Updates alloc]init];
    //int tblid = 2000259;
    //[upd MissingupdatesApi:tblid];
    
    //link import
   // Cuboid *CUB = [[Cuboid alloc]init];
    //Database *db = [[Database alloc]init];
    //LinkImport *LI = [[LinkImport alloc]init];
    //CUB = [LI LinkImportApi:2000283];
    
    
     
   // BwCuboid *BWC = [db Getcuboid:2000283];
   // [CUB SetCuboid:BWC];
    
    //refresh
    //Refresh *ref = [[Refresh alloc]init];
    //CUB = [ref RefreshAPI:2000283 :1];
    
    //BWC = [db Getcuboid:2000283];
    //CUB = [[Cuboid alloc]init];
    //[CUB SetCuboid:BWC];

    
    
    
    UserLogin *UL = [UserLogin alloc];
    NSString *loginResult = [NSString alloc];
    loginResult = [UL authenticateuser:self.usertext.text :self.passtext.text];
    
    
    if([loginResult isEqualToString: @"Success"])
    {
        
        
        WIC *wic = [WIC alloc];
        NSString *res = [wic SetWIC];
        if([res isEqualToString:@"Success"])
        {
            [self.msgLogin setHidden:YES];
            MainVC *MVC = [[MainVC alloc]init];
            [self presentViewController:MVC animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"WIC Error" message:@"Something went wrong with the workbook information cuboid please correct the value and try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alt show];
            ServerSettingsVC *SSVC = [[ServerSettingsVC alloc]init];
            [self presentViewController:SSVC animated:YES completion:nil];
        }
    }
    else
    {
        [self.msgLogin setHidden:NO];
        [self.usertext setText:@""];
        [self.passtext setText:@""];
    }
    
    
    
}



- (IBAction)AddServersetting:(id)sender
{
    ServerSettingsVC *SSVC = [[ServerSettingsVC alloc]init];
    [self presentViewController:SSVC animated:YES completion:nil];

}



@end
