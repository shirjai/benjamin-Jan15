//
//  workbookclass.m
//  bw3
//
//  Created by Srinivas on 8/26/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "workbookclass.h"
#import "WBclass.h"
#import "MainVC.h"
#import "workbookCell.h"
#import "wbdetailVC.h"
#import "AppDelegate.h"

@interface workbookclass ()
{
    NSMutableArray *WorkbookNames;
}

@end

@implementation workbookclass

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
    [[self WBList]setDelegate:self];
    [[self WBList]setDataSource:self];
    
    
    WorkbookNames = [[NSMutableArray alloc]init];
    WBclass *WBC = [[WBclass alloc]init];
    WorkbookNames = [WBC getworkbooks];
    self.navigationItem.title = @"WorkBooks";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
  //  return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [WorkbookNames count];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 75;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    workbookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workbookCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"workbookCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.wbname.text = [WorkbookNames objectAtIndex:indexPath.row];
    cell.desc.text = @"Description:";
    //cell.submit.text = @"Last Submit: 04.30 Pm, 10 july 2013 ";
    //cell.refresh.text = @"Last Refresh: 04.30 Pm, 10 july 2013 ";
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int x = indexPath.row;
    NSLog(@"-----------Selected WorkBook Name-----------------");
    NSLog([WorkbookNames objectAtIndex:x]);
    wbdetailVC *WBDVC = [[wbdetailVC alloc]init];
    WBDVC.wb = [WorkbookNames objectAtIndex:x];
    
    [self.navigationController pushViewController:WBDVC animated:YES];
    
}

/*

- (IBAction)BackClick:(id)sender
{
    MainVC *MVC = [[MainVC alloc] initWithNibName:nil bundle:nil];
    
    
    MVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self.navigationController pushViewController:MVC animated:YES];
    [self presentViewController:MVC animated:YES completion:nil];
}
 */
@end
