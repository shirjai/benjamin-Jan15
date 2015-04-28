//
//  MainVC.m
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "MainVC.h"
#import "workbookclass.h"
#import "SettingsMain.h"
#import "viewMsgs.h"
#import "AppDelegate.h"
#import "LinkImport.h"
#import "NotesHandler.h"
#import "watchHandler.h"

/*demo purpose*/ // shirish 1/7/2015
#import "CuboidHandler.h"


@interface MainVC ()

@end

@implementation MainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Wb:(id)sender
{
    workbookclass *WBC = [[workbookclass alloc]init];
    
    UINavigationController *navTblView = [[UINavigationController alloc] initWithRootViewController:WBC];
    [navTblView setViewControllers:[NSArray arrayWithObject:self]];
    
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    appDelegate.window.rootViewController = navTblView;
    
    NSLog(@"%@",self.navigationController);
    
    [self.navigationController pushViewController:WBC animated:YES];
    
    NSLog(@"%@",self.navigationController);
    
    //[self presentViewController:WBC animated:YES completion:nil];
}

- (IBAction)Settings:(id)sender
{
    SettingsMain *SM = [[SettingsMain alloc]init];
    [self presentViewController:SM animated:YES completion:nil];
}

- (IBAction)msgs:(id)sender
{
    //int imsgId = 2000273;
    NSInteger *IntMsgId = 2000281;//2000277;
    
    
    LinkImport *linkImportMsg = [LinkImport alloc];
    Cuboid *cubMsg = [[Cuboid alloc] init];
    cubMsg = [linkImportMsg LinkImportApi:IntMsgId];
    
    viewMsgs *viewMsgsObj = [[viewMsgs alloc] initWithNibName:nil bundle:nil];
    viewMsgsObj.msgCubId = IntMsgId;
    
    
    if (cubMsg != Nil)
    {
        NSLog(@"Data returned from server");
        
        NSMutableArray *rowArray =[cubMsg GetRow];
        NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
        cubmsgs = [viewMsgsObj loadMessages:rowArray :@"linkImport"];
        
        // msgs.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        //[self presentViewController:msgs animated:YES completion:nil];
        
        
        //UINavigationController *navCMsgs = [[UINavigationController alloc] init];
        
        UINavigationController *navCMsgs = [[UINavigationController alloc] initWithRootViewController:viewMsgsObj];
        [navCMsgs setViewControllers:[NSArray arrayWithObject:self]];
        
        
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        appDelegate.window.rootViewController = navCMsgs;
        
        NSLog(@"%@",self.navigationController);
        
        [self.navigationController pushViewController:viewMsgsObj animated:YES];
        
        NSLog(@"%@",self.navigationController);
        
        viewMsgsObj.msgs   = [[NSMutableArray alloc]init];
        [[viewMsgsObj msgs] addObjectsFromArray:cubmsgs];
        
        //    [viewtest msgs] = [cubmsgs mutableCopy];
        
        //    [[viewtest msgs]:cubmsgs,nil] ;
        
        
        //[viewtest msgs] = cubmsgs;
        
        
    }
    else{
        NSLog(@"No data returned from server");
    }
    
}




- (IBAction)Notes:(id)sender
{
    NotesHandler *notesHandlerObj = [[NotesHandler alloc] init];
    
    //[self.navigationController setViewControllers:[NSArray arrayWithObject:self]];
    
    // send the mainVC obj to the noteshandler to launch notes module
    [notesHandlerObj loadBenjaminNotes:self];

}

- (IBAction)watch:(id)sender {
    
    watchHandler *watchHandlerObj = [[watchHandler alloc] init];
    
    // send the mainVC obj to the noteshandler to launch notes module
    NSArray *watchRowArray = [watchHandlerObj loadBenjaminWatch];
    
    // navigate to watch interface
    [watchHandlerObj callBenjaminWatch:self :watchRowArray];
}

/*demo purpose*/ // shirish 1/7/2015
- (IBAction)cuboid:(id)sender {
    
    CuboidHandler *cubHandlerObj = [[CuboidHandler alloc] init];
    
    // send the mainVC obj to the noteshandler to launch notes module
    NSArray *cubRowArray = [cubHandlerObj loadBenjaminCuboid :@"2000268"];
    
    // navigate to watch interface
    [cubHandlerObj callBenjaminCuboid:self :cubRowArray :@"Cuboid"];
    
}

@end
