//
//  NotesDetailsViewController.m
//  bw3
//
//  Created by Shirish Jaiswal on 9/24/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import "NotesDetailsViewController.h"
#import "NotesHandler.h"
#import "common.h"


@interface NotesDetailsViewController ()

@property (nonatomic, strong) NSString* notesText;



@end

@implementation NotesDetailsViewController


//@synthesize notesScrollView;
@synthesize notesDetailTextView,notesDetailArray,notesDetailDict,notesText;
NSTimer *caretVisibilityTimer = nil;
CGRect oldRect ;
CGRect cursorRect;

#pragma mark - tableview delegate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    /** uncomment for ios6**/
    // self.notesDetailTextView = [[notesDetail alloc] initWithFrame:self.view.bounds];
    // [self.view addSubview:notesDetailTextView];
    /** uncomment for ios6**/
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [notesDetailTextView setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    notesDetailTextView.delegate = self;
    
    //  notesScrollView.contentSize = self.view.frame.size;
    
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEditNotes:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNotes:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.notesDetailTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.notesDetailTextView.layoutManager.allowsNonContiguousLayout = NO;    //ios7 bug fix
    [self registerForKeyboardNotifications];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.notesDetailDict != nil){
        notesDetailTextView.text = [notesDetailDict objectForKey:@"NotesVal"];
        
    }
    // to display the text if it is greater than the UITextview size
    //notesScrollView.frame = self.view.frame;
    notesDetailTextView.frame = self.view.frame;
    
    //set the title for the detailed text view with size limited till first new line character
    NSString *note = [common getSubstring:notesDetailTextView.text defineStartChar:@"" defineEndChar:@"\n"];
    self.navigationItem.title = note;
    
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if (self.navigationItem.rightBarButtonItem.enabled == YES) {
        if (![notesDetailTextView.text isEqualToString:notesText] && notesText != nil) {
            [self saveAddedNotes];
        }
    }
    
    
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    NSLog(@"Inside textViewDidChangeSelection");
    
    
}


/*- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
 
 NSLog(@"Inside textviewediting :%@:",text);
 if ([text length] == 0) {
 return NO;
 }
 else
 return YES;
 
 } */

/*
 - (void)textViewDidBeginEditing:(UITextView *)textView
 {
 oldRect  = [self.notesDetailTextView caretRectForPosition:self.notesDetailTextView.selectedTextRange.end];
 
 
 caretVisibilityTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(scrollCaretToVisible) userInfo:nil repeats:YES];
 
 
 }
 
 */
/*
 - (void)textViewDidEndEditing:(UITextView *)textView
 {
 [caretVisibilityTimer invalidate];
 caretVisibilityTimer = nil;
 }*/

/*
 - (void)scrollCaretToVisible
 {
 //This is where the cursor is at.
 CGRect caretRect = [self.notesDetailTextView caretRectForPosition:self.notesDetailTextView.selectedTextRange.end];
 
 
 // Convert into the correct coordinate system
 caretRect = [self.view convertRect:caretRect fromView:self.notesDetailTextView];
 
 // get the keyboard start position
 if(CGRectEqualToRect(caretRect, oldRect))
 return;
 
 oldRect = caretRect;
 
 // get the keyboard start position
 
 //This is the visible rect of the textview.
 CGRect visibleRect = self.notesDetailTextView.bounds;
 
 visibleRect.size.height -= (self.notesDetailTextView.contentInset.top + self.notesDetailTextView.contentInset.bottom);
 
 visibleRect.origin.y = self.notesDetailTextView.contentOffset.y;
 
 //We will scroll only if the caret falls outside of the visible rect.
 if(!CGRectContainsRect(visibleRect, caretRect))
 {
 // Work out how much the scroll position would have to change by to make the cursor visible
 CGFloat diff = (caretRect.origin.y + caretRect.size.height) - (visibleRect.origin.y + visibleRect.size.height);
 
 // If diff < 0 then this isn't to do with the iOS7 bug, so ignore
 if (diff > 0) {
 // Scroll just enough to bring the cursor back into view
 CGPoint newOffset = self.notesDetailTextView.contentOffset;
 newOffset.y += diff;
 [self.notesDetailTextView setContentOffset:newOffset animated:NO];
 }
 }
 }
 */


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    NSLog(@"Inside textViewShouldBeginEditing");
    notesText = notesDetailTextView.text;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveNotes:)];
    return YES;
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSLog(@" inside willShowViewController");
    
}



// to fix the bug while editing the last line behing the keyboard doesnt show up.
- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"Inside TextViewDidChange");
    
    CGRect line = [textView caretRectForPosition:textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height
    - (
       textView.contentOffset.y
       + textView.bounds.size.height
       - textView.contentInset.bottom
       //- textView.contentInset.top
       );
    if ( overflow > 0 ) {
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated: or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
}



-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //[self.notesScrollView layoutIfNeeded];
    //self.notesScrollView.contentSize = self.notesDetailTextView.bounds.size;
}

- (void)registerForKeyboardNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
                                                 name: UIKeyboardDidHideNotification object:nil];
}

-(void) keyboardDidShow: (NSNotification *)notif{
    
    //get keyboard size
    
    NSDictionary *info = [notif userInfo];
    NSValue *value  = [info objectForKey:UIKeyboardFrameEndUserInfoKey];// UIKeyboardFrameEndUserInfoKey - ios6
    CGSize keyboardSize = [value CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(notesDetailTextView.contentInset.top, 0.0, keyboardSize.height, 0.0);
    //UIEdgeInsets contentInsets =   self.notesDetailTextView.contentInset;
    //contentInsets.bottom += [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    // If active text is hidden by keyboard, scroll it so it's visible
    CGRect viewFrame = self.view.frame;
    viewFrame.size.height -= (keyboardSize.height) + notesDetailTextView.contentInset.top + 10;
    //+ (self.navigationController.navigationBar.frame.size.height)
    
    cursorRect = [notesDetailTextView caretRectForPosition:notesDetailTextView.selectedTextRange.end];
    
    notesDetailTextView.contentInset = contentInsets;
    notesDetailTextView.scrollIndicatorInsets = contentInsets;
    
    //resize the scroll view
    if (!CGRectContainsPoint(viewFrame, cursorRect.origin)) {
        //[notesDetailTextView scrollRectToVisible:cursorRect animated:YES];
        
        CGRect line = [notesDetailTextView caretRectForPosition:notesDetailTextView.selectedTextRange.start];
        CGFloat overflow = line.origin.y + line.size.height
        - ( notesDetailTextView.contentOffset.y
           + notesDetailTextView.bounds.size.height
           - notesDetailTextView.contentInset.bottom
           //- notesDetailTextView.contentInset.top
           );
        if ( overflow > 0 ) {
            // Scroll caret to visible area
            CGPoint offset = notesDetailTextView.contentOffset;
            offset.y += overflow ;//+ 7; // leave 7 pixels margin
            // Cannot animate with setContentOffset:animated: or caret will not appear
            [UIView animateWithDuration:.2 animations:^{
                [notesDetailTextView setContentOffset:offset];
            }];
        }
    }
    
    
    
}


-(void) keyboardDidHide: (NSNotification *)notif{
    
    
    NSDictionary* info = [notif userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    /*
     CGRect viewFrame = self.view.frame;
     viewFrame.size.height += keyboardSize.height; */
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(notesDetailTextView.contentInset.top, 0.0, 0.0, 0.0);
    
    
    notesDetailTextView.contentInset = contentInsets;
    notesDetailTextView.scrollIndicatorInsets = contentInsets;
    
    
    //notesScrollView.contentInset = contentInsets;
    //notesScrollView.scrollIndicatorInsets = contentInsets;
    
    
    //resize the scroll view
    //  if (!CGRectContainsPoint(viewFrame, cursorRect.origin)) {
    //      [notesScrollView scrollRectToVisible:viewFrame animated:YES];
    //  }
    
    
    
    //if (!keyboardVisible) {
    //NSLog(@"Keyboard is already hidden. Ignoring notification.");
    //	return;
    //}
    
    
    
}







#pragma mark - Benjamin custom methods

-(IBAction)cancelEditNotes:(id)sender{
    UIAlertView *cancelAlert = [[UIAlertView alloc] initWithTitle:@"Unsaved Changes!!" message:@"Close Without Saving?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [cancelAlert show];
}


-(IBAction)saveNotes:(id)sender{
    
    NSLog(@"notesDetailTextView.text:%@",notesDetailTextView.text);
    if (![notesDetailTextView.text isEqualToString:notesText] && notesText != nil) {
        [self saveAddedNotes];
    }
    
    if (notesDetailTextView.isFirstResponder) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNotes:)];
        [notesDetailTextView resignFirstResponder];
        //return;
    }
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //[self dismissViewControllerAnimated:YES completion:nil];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"Return to Editing Notes");
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)saveAddedNotes{
    
    NSDateFormatter *DateFormat = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [DateFormat setLocale:posix];
    
    [DateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *strNoteTimestamp = [DateFormat stringFromDate:[NSDate date]];
    //[DateFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSMutableDictionary *newNote = [[NSMutableDictionary alloc] init];
    
    //get notes properties
    NSDictionary *propDict = [NotesHandler loadValuesfromProperties];
    
    //assign notes properties
    NSString *rowKey = [propDict objectForKey:@"rowIdKey"];;
    NSString *timestampCol = [propDict objectForKey:@"timeColName"];
    NSString *valCol = [propDict objectForKey:@"valueColName"];
    
    if (!notesDetailDict) {
        [newNote setValue:@"-1" forKey:rowKey];
    }
    else{
        [newNote setValue:[notesDetailDict objectForKey:rowKey]  forKey:rowKey];
    }
    [newNote setValue:notesDetailTextView.text forKey:valCol];
    [newNote setObject:strNoteTimestamp forKey:timestampCol];
    
    if (notesDetailArray == nil) {
        notesDetailArray = [NSMutableArray alloc];
    }
    
    // to update an existing note,remove and then add
    if(self.notesDetailDict != nil){
        [notesDetailArray removeObject:notesDetailDict];
        //self.notesDetailArray = nil; //This will release our reference too
        
    }
    
    [notesDetailArray addObject:newNote];
    
    //sort notes
    NSSortDescriptor *notesSorter = [[NSSortDescriptor alloc] initWithKey:timestampCol ascending:NO selector:@selector(compare:)];
    [notesDetailArray sortUsingDescriptors:[NSArray arrayWithObject:notesSorter]];
    
    //submit notes to the server
    [NotesHandler submitNotes :newNote];
    
    //set the title for new note or modify the title if changed
    NSString *currentNoteTitle = self.navigationItem.title;
    NSString *newNoteTitle = [common getSubstring:notesDetailTextView.text defineStartChar:@"" defineEndChar:@"\n"];
    
    if (![currentNoteTitle isEqualToString:newNoteTitle]) {
        self.navigationItem.title = newNoteTitle;
        
    }
    notesDetailTextView.delegate = self;
}

// fix for crash happening due to scroll
- (void)dealloc {
    [notesDetailTextView setDelegate:nil];
}



@end
