//
//  NotesTableViewController.m
//  bw3
//
//  Created by Shirish Jaiswal on 9/23/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import "NotesTableViewController.h"
#import "NotesDetailsViewController.h"
#import "AppDelegate.h"
#import "NotesHandler.h"
#import "common.h"


@interface NotesTableViewController ()

@end

@implementation NotesTableViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Notes";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.rightBarButtonItem = self.notesAddBtn;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:143/255.0 green:156/255.0 blue:26/255.0 alpha:1.0];
    // [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    //[self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.NotesRootArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get notes properties file
    NSDictionary *propDict = [NotesHandler loadValuesfromProperties];
    
    //get notes metdata from properties
    NSString *timestampCol = [propDict objectForKey:@"timeColName"];
    NSString *valCol = [propDict objectForKey:@"valueColName"];
    
    
    static NSString *cellIdentifier = @"NotesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                                                            //forIndexPath:indexPath];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                                 
    }
    cell.textLabel.text = [[self.NotesRootArray objectAtIndex:indexPath.row] objectForKey:valCol];
                             
    //NSDateFormatter *DateFormat = [[NSDateFormatter alloc] init];
   // NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
   // [DateFormat setLocale:posix];

   // [DateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
   // //[DateFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSString *notesStringFormat = [[self.NotesRootArray objectAtIndex:indexPath.row] objectForKey:timestampCol];
    
  //  NSDate *NotesTimestamp = [DateFormat dateFromString:notesStringFormat] ;
    
  //  cell.detailTextLabel.text = [DateFormat stringFromDate:NotesTimestamp];
    
    cell.detailTextLabel.text = notesStringFormat;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    
    return cell;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
	// important to reload data when view is redrawn
	[self.tableView reloadData];
}


- (IBAction)notesAddBtnPressed:(id)sender {
    
    NotesDetailsViewController *notesDetailsViewCtrl = [[NotesDetailsViewController alloc] initWithNibName:@"NotesDetailsViewController" bundle:nil];
    
    //UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:notesDetailsViewCtrl];
    
    notesDetailsViewCtrl.notesDetailArray = self.NotesRootArray;
    //[self presentViewController:navCtrl animated:YES completion:nil];
    
    // get the pagecurl transition style
    CATransition* transition = [common getViewTransistionStylePageCurl];
    
    [self.navigationController.view.layer addAnimation:transition
                                               forKey:kCATransition];
    
    [self.navigationController pushViewController:notesDetailsViewCtrl animated:NO];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Create the next view controller.
    NotesDetailsViewController *notesDetailViewController = [[NotesDetailsViewController alloc] initWithNibName:@"NotesDetailsViewController" bundle:nil];
    
    // Navigation logic
   // UINavigationController *navCntrl = [[UINavigationController alloc] initWithRootViewController:notesDetailViewController];
    
    notesDetailViewController.notesDetailArray = self.NotesRootArray;
    notesDetailViewController.notesDetailDict = [self.NotesRootArray objectAtIndex:indexPath.row];
    
    
    
     [self.navigationController pushViewController:notesDetailViewController animated:YES];

    // Pass the selected object to the new view controller
    // Push the view controller.
    //[self presentViewController:navCntrl animated:YES completion:nil];
    
   
}


@end
