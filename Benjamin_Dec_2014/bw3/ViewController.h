//
//  ViewController.h
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>{    
}

@property (weak, nonatomic) IBOutlet UITextField *usertext;
@property (weak, nonatomic) IBOutlet UITextField *passtext;
- (IBAction)SignInbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *msgLogin;

@property (nonatomic, readonly) CGPoint StartPos;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UITextField *activeField;

- (IBAction)AddServersetting:(id)sender;

@end
