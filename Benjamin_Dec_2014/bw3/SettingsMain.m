//
//  SettingsMain.m
//  bw3
//
//  Created by Srinivas on 9/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "SettingsMain.h"
#import "Database.h"
#import "MainVC.h"

@interface SettingsMain ()
{
    NSMutableArray *Name;
    NSMutableArray *Hierarchy;
    NSMutableArray *expand;
    NSMutableArray *Type;
    NSMutableArray *Value;
}

@end

@implementation SettingsMain

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
    [[self SettingsM]setDelegate:self];
    [[self SettingsM]setDataSource:self];
    
    Name = [[NSMutableArray alloc]init];
    Hierarchy = [[NSMutableArray alloc]init];
    expand = [[NSMutableArray alloc]init];
    Type = [[NSMutableArray alloc]init];
    Value = [[NSMutableArray alloc]init];
    
    
    
    NSMutableArray *SettingSection = [[NSMutableArray alloc]init];
    SettingSection = [NSMutableArray arrayWithObjects:@"Account Settings",@"Module Settings",@"Data Connection Settings",@"Display Settings", nil];
    
      
    //--------------------------Account Settings-------------
    [Name addObject:@"Account Settings"];
    [Hierarchy addObject:@"0"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"http://pa.boardwalktech.com/bw_internal"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"http://pa.boardwalktech.com/bw_internal_dev"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"http://pa.boardwalktech.com/bw_internal"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Add Server"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"1"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Server Name"];
    [Hierarchy addObject:@"2D"];
    [expand addObject:@"0"];
    [Type addObject:@"TextBox"];
    [Value addObject:@""];
    
    [Name addObject:@"User Name"];
    [Hierarchy addObject:@"2D"];
    [expand addObject:@"0"];
    [Type addObject:@"CheckBox"];
    [Value addObject:@""];
    
    [Name addObject:@"Password"];
    [Hierarchy addObject:@"2D"];
    [expand addObject:@"0"];
    [Type addObject:@"TextBox"];
    [Value addObject:@""];
   
    //--------------------------Module Settings-------------
    [Name addObject:@"Module Settings"];
    [Hierarchy addObject:@"0"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Messages"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Alert"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@"CheckBox"];
    [Value addObject:@""];
    
    [Name addObject:@"Workbooks"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    
    //--------------------------Data Connection Settings-------------
    [Name addObject:@"Data Connection Settings"];
    [Hierarchy addObject:@"0"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Max number of rows to fetch"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Auto Refresh"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Refresh Settings"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Submit Settings"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    
    
    //--------------------------Display Settings-------------
    [Name addObject:@"Display Settings"];
    [Hierarchy addObject:@"0"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Show new data only"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
    
    [Name addObject:@"Hide user communication"];
    [Hierarchy addObject:@"1"];
    [expand addObject:@"0"];
    [Type addObject:@""];
    [Value addObject:@""];
     
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //something here
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0 green:143.0/255.0 blue:220.0/255.0 alpha:1.0]];
    
    //self.navigationItem.backBarButtonItem.tintColor = [UIColor redColor];
    
}

- (IBAction)backAction:(id)sender {
    
    MainVC *MVC = [[MainVC alloc] initWithNibName:nil bundle:nil];
    
    
    MVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self.navigationController pushViewController:MVC animated:YES];
    [self presentViewController:MVC animated:YES completion:nil];
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int Returncount = 0;
    for(int i=0;i<[Hierarchy count];i++)
    {
        if([[Hierarchy objectAtIndex:i] isEqualToString:@"0"])
        {
            Returncount = Returncount + 1;
        }
    }
    return Returncount;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int sectionCount = 0;
    int returnrowcount = 0;
    int total = [Hierarchy count];
    for(int i = 0;i<[Hierarchy count];i++)
    {
        
        if(section == sectionCount-1)
        {
            returnrowcount=returnrowcount+1;
            if(i == total-1)
            {
                returnrowcount=returnrowcount+1;
            }
        }
        
        if([[Hierarchy objectAtIndex:i] isEqualToString: @"0" ])
        {
            sectionCount = sectionCount+1;
        }
        
    }
    returnrowcount = returnrowcount-1;
    
    return returnrowcount;

}
 


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int indexcell = 0;
    int sectionCount = 0;
    NSString *cellname;
    NSString *celltype;
    NSString *cellexpand;
    NSString *cellHierarchy;
    int returnrowcount = 0;
  //  UITableViewCell *wbcell = [self.SettingsM cellForRowAtIndexPath:indexPath];
    
    for(int i = 0;i<[Hierarchy count];i++)
    {
        
        if(indexPath.section == sectionCount-1)
        {
            
            if(returnrowcount == indexPath.row)
            {
                cellname = [Name objectAtIndex:i];
                celltype = [Type objectAtIndex:i];
                cellexpand = [expand objectAtIndex:i];
                cellHierarchy = [Hierarchy objectAtIndex:i];
                indexcell = i;
            }
            returnrowcount=returnrowcount+1;
            
        }
        
        if([[Hierarchy objectAtIndex:i] isEqualToString: @"0" ])
        {
            sectionCount = sectionCount+1;
        }
        
    }
    
    if([cellHierarchy isEqualToString:@"2D"])
    {
       // wbcell.hidden = YES;
        return 0.0;
    }
    else
    {
        //wbcell.hidden = NO;
        return 44.0;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
 
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *ip = [self.SettingsM indexPathForCell:(UITableViewCell *)[(UIView *)[textField superview] superview]];
    int s = ip.section;
    int r = ip.row;
    
    int indexcell = 0;
    int sectionCount = 0;
    NSString *cellname = @"";
    NSString *celltype = @"";
    NSString *cellexpand = @"";
    NSString *cellHierarchy = @"";
    int returnrowcount = 0;
    for(int i = 0;i<[Hierarchy count];i++)
    {
        
        if(s == sectionCount-1)
        {
            
            if(returnrowcount == r)
            {
                cellname = [Name objectAtIndex:i];
                celltype = [Type objectAtIndex:i];
                cellexpand = [expand objectAtIndex:i];
                cellHierarchy = [Hierarchy objectAtIndex:i];
                indexcell = i;
            }
            returnrowcount=returnrowcount+1;
            
            
        }
        
        if([[Hierarchy objectAtIndex:i] isEqualToString: @"0" ])
        {
            sectionCount = sectionCount+1;
        }
        
    }
    
    if([celltype isEqualToString:@"TextBox"]|[celltype isEqualToString:@"CheckBox"])
    {
        [Value setObject:textField.text atIndexedSubscript:indexcell];
        NSLog(textField.text);
    }

  
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    int sectionCount = 0;
    NSString *returnheaderName = 0;
    for(int i = 0;i<[Hierarchy count];i++)
    {
        if([[Hierarchy objectAtIndex:i] isEqualToString: @"0" ])
        {
            sectionCount = sectionCount+1;
            if(section == sectionCount-1)
            {
                returnheaderName = [Name objectAtIndex:i];
            }
        }
        
    }
    
    
    return returnheaderName;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int x = indexPath.row;
    int y = indexPath.section;
    
    UITextField *textField = nil;
    UISwitch *Switch = nil;
    
    int indexcell = 0;
    int sectionCount = 0;
    NSString *cellname = @"";
    NSString *celltype = @"";
    NSString *cellexpand = @"";
    NSString *cellHierarchy = @"";
    NSString *cellval = @"";
    int returnrowcount = 0;
    for(int i = 0;i<[Hierarchy count];i++)
    {
        
        if(indexPath.section == sectionCount-1)
        {
            
            if(returnrowcount == indexPath.row)
            {
                cellname = [Name objectAtIndex:i];
                celltype = [Type objectAtIndex:i];
                cellexpand = [expand objectAtIndex:i];
                cellHierarchy = [Hierarchy objectAtIndex:i];
                cellval = [Value objectAtIndex:i];
                indexcell = i;
            }
            returnrowcount=returnrowcount+1;
            
            
        }
        
        if([[Hierarchy objectAtIndex:i] isEqualToString: @"0" ])
        {
            sectionCount = sectionCount+1;
        }
        
    }
    
    UITableViewCell *WBCell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    NSString *celltext = WBCell.textLabel.text;
    if(!([cellname isEqualToString:celltext]))
    {
        WBCell = nil;
    }
    
    if(!WBCell)
    {
        WBCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
        
        
        
        if([celltype isEqualToString:@"TextBox"])
        {
            WBCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
            WBCell.textLabel.text = cellname;
            if([cellHierarchy isEqualToString:@"1"])
            {
                WBCell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold"	 size:18.0];
            }
            else
            {
                WBCell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBoldItalic"	 size:12.0];
            }
            textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, WBCell.contentView.frame.size.width - 110 - 10.0, WBCell.contentView.frame.size.height - 10 - 10.0)];
            textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            textField.placeholder = @"example@email.com";
            textField.tag = 1000;
            textField.delegate = self;
            if([cellval length]>0)
            {
                textField.text = cellval;
            }
            [WBCell.contentView addSubview:textField];
            
        }
        else if([celltype isEqualToString:@"CheckBox"])
        {
            WBCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
            WBCell.textLabel.text = cellname;
            if([cellHierarchy isEqualToString:@"1"])
            {
                WBCell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold"	 size:18.0];
            }
            else
            {
                WBCell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBoldItalic"	 size:12.0];
            }
            textField = [[UITextField alloc] initWithFrame:CGRectMake(250, 10, WBCell.contentView.frame.size.width - 110 - 10.0, WBCell.contentView.frame.size.height - 10 - 10.0)];
            textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            textField.placeholder = @"Y/N";
            //[textField setBorderStyle:UITextBorderStyleLine];
            //Switch.tag = 1001;
            textField.delegate= self;
            if([cellval length]>0)
            {
                textField.text = cellval;
            }
            
             
            [WBCell.contentView addSubview:textField];

            
        }
    
        else
        {
            WBCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
            WBCell.textLabel.text = cellname;
            WBCell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold"	 size:18.0];
            if([cellexpand isEqualToString:@"1"])
            {
                WBCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            else
            {
                WBCell.accessoryType = UITableViewCellAccessoryNone;
                
            }
        }
        

        
    }
    
    //WBCell.textLabel.text = cellname;
    return WBCell;
}

/*
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int x = indexPath.row;
    int y = indexPath.section;
    UITextField *textField = nil;
    int indexcell = 0;
    int sectionCount = 0;
    NSString *cellname;
    NSString *celltype;
    NSString *cellexpand;
    NSString *cellHierarchy;
    int returnrowcount = 0;
    for(int i = 0;i<[Hierarchy count];i++)
    {
        
        if(indexPath.section == sectionCount-1)
        {
            
            if(returnrowcount == indexPath.row)
            {
                cellname = [Name objectAtIndex:i];
                celltype = [Type objectAtIndex:i];
                cellexpand = [expand objectAtIndex:i];
                cellHierarchy = [Hierarchy objectAtIndex:i];
                indexcell = i;
            }
            returnrowcount=returnrowcount+1;
            
            
        }
        
        if([[Hierarchy objectAtIndex:i] isEqualToString: @"0" ])
        {
            sectionCount = sectionCount+1;
        }
        
    }
    returnrowcount = returnrowcount-1;
    
    
    UITableViewCell *WBCell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    if(!WBCell)
    {
        WBCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
        if([celltype isEqualToString:@"TextBox"])
        {
            WBCell.textLabel.text = cellname;
            WBCell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBoldItalic"	 size:12.0];
            
            textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, WBCell.contentView.frame.size.width - 110 - 10.0, WBCell.contentView.frame.size.height - 10 - 10.0)];
            textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            textField.placeholder = @"example@email.com";
            [WBCell.contentView addSubview:textField];
            
        }
        else
        {
            //WBCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
            if([cellexpand isEqualToString:@"1"])
            {
                WBCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            else
            {
                WBCell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            
            if([cellHierarchy isEqualToString:@"2A"])
            {
                WBCell.textLabel.text = cellname;
                WBCell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBoldItalic"	 size:12.0];
            }
            else
            {
                WBCell.textLabel.text = cellname;
                WBCell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold"	 size:18.0];
            }
            
        }
        

    }

    //WBCell = [[UITableViewCell alloc]init];
    
    
   
    
        
    return WBCell;
}
 
 */



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int sectionCount = 0;
    int indexcell;
    int returnrowcount = 0;
    for(int i = 0;i<[Hierarchy count];i++)
    {
        
        if(indexPath.section == sectionCount-1)
        {
            if([[Hierarchy objectAtIndex:i] isEqualToString:@"2A"] || [[Hierarchy objectAtIndex:i] isEqualToString:@"1"])
            {
                if(returnrowcount == indexPath.row)
                {
                    indexcell = i;
                }
                returnrowcount=returnrowcount+1;
            }
        }
        
        if([[Hierarchy objectAtIndex:i] isEqualToString: @"0" ])
        {
            sectionCount = sectionCount+1;
        }
        
    }
    
    if([[Hierarchy objectAtIndex:indexcell] isEqualToString:@"1"])
    {
    
        NSString *stop = @"no";
    
        while([stop isEqualToString:@"no"])
        {
            if([[Hierarchy objectAtIndex:indexcell] isEqualToString :@"2D"])
            {
                [Hierarchy setObject:@"2A" atIndexedSubscript:indexcell];
            }
            else if([[Hierarchy objectAtIndex:indexcell] isEqualToString :@"2A"])
            {
                [Hierarchy setObject:@"2D" atIndexedSubscript:indexcell];
            }
            indexcell = indexcell + 1;
            if([[Hierarchy objectAtIndex:indexcell] isEqualToString:@"0"] || [[Hierarchy objectAtIndex:indexcell]   isEqualToString:@"1"])
                {
                    stop = @"yes";
                }
        }
        [[self SettingsM] reloadData];
    }

}
 

- (IBAction)SaveClick:(id)sender
{
    Database *db = [[Database alloc]init];
    NSString *pretext = @"Settings+";
    NSString *pname;
    NSString *pvale;
    for(int i=0;i<[Hierarchy count];i++)
    {
        pname = [NSString stringWithFormat:@"%@%@", pretext,[Name objectAtIndex:i]];
        pvale = [Value objectAtIndex:i];
        [db UpdateProperties:pname :pvale];
    }
    
}

- (IBAction)BackClick:(id)sender
{
    MainVC *MVC = [[MainVC alloc] initWithNibName:nil bundle:nil];
    
    
    MVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self.navigationController pushViewController:MVC animated:YES];
    [self presentViewController:MVC animated:YES completion:nil];
}

@end
