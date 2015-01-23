//
//  ServerSettingsVC.h
//  bw4
//
//  Created by Srinivas on 10/29/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerSettingsVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ServerAdd;

@property (weak, nonatomic) IBOutlet UITextField *WicId;
@property (nonatomic, readonly) CGPoint StartPos;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UITextField *activeField;

- (IBAction)saveServer:(id)sender;
- (IBAction)Cancel:(id)sender;

@end
