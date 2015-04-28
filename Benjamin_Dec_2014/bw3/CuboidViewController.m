    //
//  CuboidViewController.m
//  collectionViewStudy
//
//  Created by Shirish Jaiswal on 10/31/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import "CuboidViewController.h"

// import the custom cell
#import "CellViewController.h"

#import "LinkImport.h"
#import "Refresh.h"
#import "common.h"
#import "Database.h"
#import "ExternalQuery.h"
#import "CuboidHandler.h"

#import "CellViewLayout.h"


@interface CuboidViewController ()<UICollectionViewDelegate, UICollectionViewDataSource//>
,UICollectionViewDelegateFlowLayout,UITextViewDelegate>
{
    UIRefreshControl *refreshControlObj;
}

  //  @property (strong, nonatomic) IBOutlet UICollectionView *CuboidCollectionView;
    @property (nonatomic, strong) NSString* cubCellValue;

    /** pinch gesture**/
    @property (nonatomic, strong) UIPinchGestureRecognizer *gesture;
    /** pinch gesture**/

@end


@implementation CuboidViewController


@synthesize watchArray,cubCellValue;

/** pinch gesture min and max zoom **/
const CGFloat kScaleLower = 1.0;
const CGFloat kScaleUpper = 3.5;
/** pinch gesture**/

CellViewController *selectedCell;
NSIndexPath *prevCellIndexPath;
NSIndexPath *selectedCellIndexPath;
NSMutableDictionary *dictChanges;
Boolean didValChange = false;
Boolean didValSaved = false;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = self.CuboidName; //@"Cuboid";
        dictChanges = [[NSMutableDictionary alloc] init];
        
      //  _CuboidCollectionView = self.CuboidCollectionView;
      //  _CuboidCollectionView.dataSource = self;
      //  _CuboidCollectionView.delegate = self;
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    refreshControlObj = [[UIRefreshControl alloc]init];
    [refreshControlObj addTarget:self action:@selector(refreshWatch) forControlEvents:UIControlEventValueChanged];
    [self.CuboidCollectionView addSubview:refreshControlObj];
    
    [self.CuboidCollectionView registerClass:[CellViewController class] forCellWithReuseIdentifier:@"CuboidCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(submitData:)];
    
    [self registerForKeyboardNotifications];
    
    
    /** pinch gesture**/
    
   // self.fitCells = NO;
   // self.animatedZooming = NO;
    self.scale = 1.0;           //(kScaleUpper + kScaleLower)/2.0;
    
    self.gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didReceivePinchGesture:)];
    [self.CuboidCollectionView addGestureRecognizer:self.gesture];
    
    
    /** pinch gesture**/
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //[self.watchCollectionView reloadData];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_logo.png"]];
 

    
    // Configure layout
    //UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //[flowLayout setItemSize:CGSizeMake(150, 55)];
    //[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //[self.watchCollectionView setCollectionViewLayout:flowLayout];


    
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
    
  /*
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
   
    }*/
    
    
    
}


-(void) keyboardDidHide: (NSNotification *)notif{
    
    
    NSDictionary* info = [notif userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    /*
     CGRect viewFrame = self.view.frame;
     viewFrame.size.height += keyboardSize.height; */
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.CuboidCollectionView.contentInset.top, 0.0, 0.0, 0.0);
    
    
    self.CuboidCollectionView.contentInset = contentInsets;
    self.CuboidCollectionView.scrollIndicatorInsets = contentInsets;
    
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    self.title = self.CuboidName;
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
	// important to reload data when view is redrawn
    [self.CuboidCollectionView reloadItemsAtIndexPaths:[self.CuboidCollectionView indexPathsForVisibleItems]];
	[self.CuboidCollectionView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Collection View Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //NSLog(@"numberOfSectionsInCollectionView:%d",[watchArray count]);
    return [watchArray count];
    //return 30;//[watchArray count];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"[watchArray[section] count]:%d",[watchArray[section] count]);
    return [watchArray[section] count];
    //return 3;//[watchMasterArray count];
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CellViewController *cell = (CellViewController *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CuboidCell" forIndexPath:indexPath];

    
   // commented for scroll view to set at top by default
   /* cell.contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight);
    cell.contentView.translatesAutoresizingMaskIntoConstraints = YES; */
    
   //cell.cellLabel.frame=CGRectMake(12, 13, 98, 0);
    
    //cell.cellLabel.text=watchArray[indexPath.section][indexPath.row];
    //cell.watchCellValue = [[UITextView alloc] initWithFrame:cell.bounds];
    
  
    //cell.watchCellValue.textAlignment = NSTextAlignmentLeft;
    
    
   // cell.watchCellValue.textColor = [UIColor redColor];
    //NSLog(@"cellValue at Section%d Row%d = %@",indexPath.section,indexPath.row, cell.cellLabel.text);
    
    //[cell.layer setBorderWidth:1.0f];
    //[cell.layer setBorderColor:[UIColor blackColor].CGColor];
    
    cell.watchCellValue.text = watchArray[indexPath.section][indexPath.row];
    cell.watchCellValue.backgroundColor = [UIColor clearColor];
    cell.watchCellValue.delegate = self;    

    
    //cell.watchCellValue.lineBreakMode=NSLineBreakByWordWrapping;
    //cell.cellLabel.preferredMaxLayoutWidth = CGRectGetWidth(collectionView.bounds);
   // [cell.watchCellValue  setNumberOfLines:0];
    
    //CGSize textSize=CGSizeMake(100, 100);
    
    //textSize = [watchArray[indexPath.section][indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    
    //[cell.cellLabel sizeThatFits:textSize];
    
   // [cell.watchCellValue sizeToFit];

    
    
   // NSLog(@"value ::::: %@",cell.watchCellValue.text);
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //if(!didValChange){
        selectedCell = (CellViewController *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CuboidCell" forIndexPath:indexPath];
    
        selectedCellIndexPath = indexPath;

        
       // didValSaved = false;
        
        NSLog(@"previous display value ::::: %@",selectedCell.watchCellValue.text);
        NSLog(@"stored array value ::::: %@",watchArray[indexPath.section][indexPath.row]);
    
    
      //  NSLog(@"indexPath.section ::::: %ld",(long)indexPath.section);
      //  NSLog(@"row ::::: %ld",(long)indexPath.row);
    
        //[cell.watchCellValue shouldChangeTextInRange:];
   // }
    //else
    //    didChange = false;
}

/*

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Main use of the scale property
    CGFloat scaledWidth = 50 * self.scale;
    if (self.fitCells) {
        NSInteger cols = floor(320 / scaledWidth);
        CGFloat totalSpacingSize = 10 * (cols - 1); // 10 is defined in the xib
        CGFloat fittedWidth = (320 - totalSpacingSize) / cols;
        return CGSizeMake(fittedWidth, fittedWidth);
    } else {
        return CGSizeMake(scaledWidth, scaledWidth);
    }
    
     return CGSizeMake(50 * self.scale, 50 * self.scale);
}

*/
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Inside didHighlightItemAtIndexPath");
}


#pragma mark - Accessors
- (void)setScale:(CGFloat)scale
{
    // Make sure it doesn't go out of bounds
    if (scale < kScaleLower)
    {
        _scale = kScaleLower;
    }
    else if (scale > kScaleUpper)
    {
        _scale = kScaleUpper;
    }
    else
    {
        _scale = scale;
    }
}


#pragma mark - Gesture Recognizers
- (void)didReceivePinchGesture:(UIPinchGestureRecognizer*)gesture
{
    /*
    
    double newCellSize = [self.CuboidCollectionView.collectionViewLayout cellSize] * gesture.scale;
    newCellSize = MIN(newCellSize, 100);
    newCellSize = MAX(newCellSize, 15);
    
    [(IMMapViewLayout *)self.CuboidCollectionView.collectionViewLayout setCellSize:newCellSize];
    [self.CuboidCollectionView.collectionViewLayout invalidateLayout];
    */
    
    CellViewLayout *gridLayout = (CellViewLayout *)self.CuboidCollectionView.collectionViewLayout;
    
    
    static CGFloat scaleStart;
    

    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        scaleStart = self.scale ;
        NSLog(@"scaleStart::%f",scaleStart);
        
        // disable scroll when pinch has started
        self.CuboidCollectionView.scrollEnabled = NO;
        
        
        //gridLayout.itemSize = initialCellSize;
        return;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        
        
        //[gridLayout setItemHt:gridLayout.itemHt * gesture.scale];
        //if (gesture.scale > 1.0)
        self.scale = scaleStart * gesture.scale ;
        [gridLayout setCellFontSize:(gridLayout.cellFontSize * _scale )];
        

        NSLog(@"gesture.scale:%f",gesture.scale);
        NSLog(@"gridLayout.scale:%f self.scale:%f",gridLayout.itemWidth,_scale);
        NSLog(@"new width= %f",(gridLayout.itemWidth * _scale));
        
        //[gridLayout setItemWidth:35.0  * _scale];
        //[gridLayout setItemHt:40.0 * _scale];
        
        [gridLayout setItemWidth:gridLayout.initItemWidth * _scale];
        //[gridLayout setItemHt:gridLayout.initItemHt * _scale];
        
/*
        if (gesture.scale > 1.0){
            gesture.scale = 1.25;
            [gridLayout setItemWidth:40.0 * gesture.scale];
            [gridLayout setItemHt:35.0 * gesture.scale];
            //[gridLayout setNumberOfColumns:7];
        }
        if (gesture.scale < 1.0) {
            gesture.scale = 1.0;
            [gridLayout setItemWidth:40.0 * gesture.scale];
            [gridLayout setItemHt:35.0 * gesture.scale];
            //[gridLayout setNumberOfColumns:8];
        }

 
                                            */
        
        [gridLayout invalidateLayout];
        
        //[gridLayout prepareLayout];
        //[gridLayout collectionViewContentSize];
        //[gridLayout layoutAttributesForElementsInRect:CGRectMake(0, -568, 320, 1136)];
    }
    else if ((gesture.state == UIGestureRecognizerStateEnded) || (gesture.state == UIGestureRecognizerStateCancelled))
    {
        // enable scrolling after pinch is completed
        self.CuboidCollectionView.scrollEnabled = YES;
    }
    //[self.CuboidCollectionView reloadData];
    
    /*
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        // Take an snapshot of the initial scale
        scaleStart = self.scale;
        return;
    }
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        // Apply the scale of the gesture to get the new scale
        self.scale = scaleStart * gesture.scale;
        
        if (self.animatedZooming)
        {
            // Animated zooming (remove and re-add the gesture recognizer to prevent updates during the animation)
            [self.CuboidCollectionView removeGestureRecognizer:self.gesture];
            UICollectionViewFlowLayout *newLayout = [[UICollectionViewFlowLayout alloc] init];
            [self.CuboidCollectionView setCollectionViewLayout:newLayout animated:YES completion:^(BOOL finished) {
                [self.CuboidCollectionView addGestureRecognizer:self.gesture];
            }];
        }
        else
        {
            // Invalidate layout
            [self.CuboidCollectionView.collectionViewLayout invalidateLayout];
        }
        
    } */
    
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [self.CuboidCollectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - textView Methods
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    NSLog(@"Inside textViewDidBEGINEditing");
    

    //enable scrolling for textview for cell editing
   // textView.scrollEnabled = true;
   //  NSLog(@"@@@@ textView.scrollEnabled=%d @@@@@",textView.scrollEnabled);
    //as the didSelectIndexPath is invoked before textViewDidEndEditing
    
    
    prevCellIndexPath = selectedCellIndexPath;
    
   // NSIndexPath *indexPath = [self.CuboidCollectionView indexPathForCell:self];
    //[collectionView.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    //cubCellValue = watchArray[indexPath.section][indexPath.row];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveNotes:)];
    
}


- (void)textViewDidChange:(UITextView *)textView{
    didValChange= true;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    // NSLog(@"Inside textViewDidChange: Check For Changes");
    
    if (didValChange) {
        NSLog(@"Inside textViewDidChange: Changes Identified");
        NSLog(@"textView.text=%@",textView.text);
        
        //NSIndexPath *indexPath = [self.CuboidCollectionView indexPathForCell:selectedCell];
        //[self.CuboidCollectionView.delegate collectionView:self.CuboidCollectionView didSelectItemAtIndexPath:indexPath];
        
        long sectionIndex   = prevCellIndexPath.section;
        long rowIndex       = prevCellIndexPath.row;
        NSString *colHdr    = watchArray[0][rowIndex];
        
        NSLog(@"previous value=%@",watchArray[sectionIndex][rowIndex]);
        
        watchArray[sectionIndex][rowIndex] = textView.text;
        NSString *val = [NSString stringWithFormat:@"%@:%@",colHdr,(NSString *)textView.text];
        
        [dictChanges setObject:val forKey:watchArray[sectionIndex][0]];
        
        didValSaved = true;

    }
    else
        NSLog(@"Inside textViewDidChange: NO Changes Identified");
    
    didValChange = false;
    
   // CGPoint cursorPosition = [textView caretRectForPosition:textView.selectedTextRange.start].origin;
   //     CGPoint cursorPosition = [textView caretRectForPosition:textView.selectedTextRange.start].origin;
    
   // CGPoint cursorPosition = CGPointMake(self.CuboidCollectionView.center.x + self.CuboidCollectionView.contentOffset.x,self.CuboidCollectionView.center.y + self.CuboidCollectionView.contentOffset.y);
   // CGPoint cursorPosition= [self.CuboidCollectionView convertRect:cell.frame toView:self.view].origin;
    
   // UICollectionViewCell *collectionViewCell = [[CellViewController alloc]init];
    //NSIndexPath *indexPath = (NSIndexPath *)[self.CuboidCollectionView indexPathForItemAtPoint:cursorPosition];
    //UICollectionView *collectionView = (UICollectionView*)self.superview;
    
    //[collectionView.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    //NSLog(@"watchArray[indexPath.section][indexPath.row]=%@",watchArray[indexPath.section][indexPath.row]);
    //cubCellValue = watchArray[indexPath.section][indexPath.row];
    
}

# pragma mark Boardwalk Methods

-(IBAction)submitData:(id)sender{
    
    // to dismiss keyboard
    [self.view endEditing:YES];
    [selectedCell.watchCellValue resignFirstResponder];
    
    // disable scrolling for textview
    selectedCell.watchCellValue.scrollEnabled = false;
    
    if (didValSaved) {
        [CuboidHandler submitNotes:dictChanges];
        [self.CuboidCollectionView reloadData];
        didValSaved = false;
    }


    
    //NSIndexPath *indexPath = [self.CuboidCollectionView indexPathForCell:self];
    //[collectionView.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];

    
    /*
     NSLog(@"notesDetailTextView.text:%@",notesDetailTextView.text);
     //  if (![notesDetailTextView.text isEqualToString:notesText] && notesText != nil) {
     //      [self saveAddedNotes];
     //  }
     
     if (CuboidCollectionView.isFirstResponder) {
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNotes:)];
     [notesDetailTextView resignFirstResponder];
     //return;
     }
     self.navigationItem.rightBarButtonItem.enabled = NO; */
    //[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)refreshWatch
{

    NSLog(@"Inside Refresh Watch Tag Value cuboid");
    
    //get watch properties
    NSDictionary *propDict = [common loadValuesfromPropertiesFile:@"CuboidProperties"];
    
    //assign query id
  /*  NSString *queryId = [propDict objectForKey:@"queryId"];//@"68";
    //assign tagValue cuboid id

    
    ExternalQuery *extQueryObj = [[ExternalQuery alloc] init];
    NSString *requestBuffer = [extQueryObj getExternalData :intWatchTagValId :@" " :queryId :@" "];
    NSArray *response = [extQueryObj ExtractResponseExternalData :requestBuffer];
    
    if (response == nil) {
        NSLog(@"Error in updating Tag Cuboid");
    } */
    
    NSLog(@"Refresh Cell Changes");
    Refresh *refreshObj = [[Refresh alloc]init];
    Cuboid *cubWatch = [[Cuboid alloc] init];
    
    int intWatchTagValId = [[propDict objectForKey:@"tableId"] intValue];//2000284;
    cubWatch = [refreshObj RefreshAPI:intWatchTagValId:1];
    
    NSString *rowColName        = [propDict objectForKey:@"rowIdKey"];
    NSString *strTagColName     = [propDict objectForKey:@"tagValCol"];
    NSString *strValColName     = [propDict objectForKey:@"valCol"];
    NSString *strTimeColName    = [propDict objectForKey:@"timeStampCol"];
    NSString *strUserColName    = [propDict objectForKey:@"userColName"];
    NSString *strCubColName    = [propDict objectForKey:@"cubColName"];
    NSMutableString *strOnDemandParam = [[propDict objectForKey:@"dynamicQuery"] mutableCopy];     
    NSArray *arrSelColNames = [NSArray arrayWithObjects: strTagColName, strValColName, strTimeColName, rowColName, nil];
    
    if([[cubWatch GetRow] count])
    {
        NSMutableArray *mutArrCellChnge = [cubWatch GetRow];

        
        //re-arrange data in watch format and get it in an array
        mutArrCellChnge = [common prepareDataFromBuffer:mutArrCellChnge ColNames:arrSelColNames RowIdCol:rowColName];
        
        // assuming postion for cols as 1:Tag Name;2:Value;3:Timestamp, 4:RowId
        for(int cellCnt=0; cellCnt < [mutArrCellChnge count]; cellCnt++)
        {
            NSDictionary *eachCell = mutArrCellChnge[cellCnt];
            for(int watchArrCnt=0; watchArrCnt < [watchArray count]; watchArrCnt++)
            {
                NSMutableArray *eachRowArr = watchArray[watchArrCnt];
                if([(NSString *)[eachCell objectForKey:rowColName]isEqualToString:eachRowArr[3]])
                {
                    for( NSString *aKey in [eachCell allKeys] )
                    {
                        if([aKey isEqualToString:strTagColName])
                            watchArray[watchArrCnt][0] = (NSString *)[eachCell objectForKey:aKey];
                        if([aKey isEqualToString:strValColName])
                            watchArray[watchArrCnt][1] = (NSString *)[eachCell objectForKey:aKey];
                        if([aKey isEqualToString:strTimeColName])
                        {
                            NSString *time = (NSString *)[eachCell objectForKey:aKey];
                            watchArray[watchArrCnt][2]  = [common dateFromExcelSerialDate:[time doubleValue]];
                            //watchArray[watchArrCnt][2] = (NSString *)[eachCell objectForKey:aKey];
                        }
                        
                    }
                }
                    
            }
        }
        
    }
    
    NSLog(@"Remove absent Rows");
/** Delete Row Logic to be uncommented when server side code ready**/
    
    /*
    Database *DB = [[Database alloc]init];
    NSArray *presentRows = [[DB Getcuboid:intMsgCuboidId] GetRowIds];
    
    NSMutableArray *watchArrayRowIds = [[NSMutableArray alloc] init];
        
    [watchArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSMutableArray *eachRowArr, NSUInteger idx, BOOL *stop) {
            //if([eachRowArr[3] isKindOfClass:[NSNumber class]])
    if(![eachRowArr[3] isEqualToString:@"RowId"])
        [watchArrayRowIds addObject:eachRowArr[3]];
    }];
        
    [watchArrayRowIds removeObjectsInArray:presentRows];
        
    if([watchArrayRowIds count])
    {
        for(int i=0; i < [watchArray count]; i++)
        {
            NSMutableArray *eachRowArr = watchArray[i];
            if([watchArrayRowIds containsObject:eachRowArr[3]])
                [watchArray removeObjectAtIndex:i];
        }
    } */


    NSLog(@"Refresh New Rows");
    NSDictionary *newRows = (NSDictionary *)[cubWatch getNewRows] ;
    
    if ([newRows count])
    {
        
        NSLog(@"Data returned from server");
        
        
        NSMutableArray *mutarrNewRows =[cubWatch GetRow];
        //NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
        
        //re-arrange data in watch format and get it in an array
        mutarrNewRows = [common prepareDataFromBuffer:mutarrNewRows ColNames:arrSelColNames RowIdCol:@"RowId"];
        
        // add data        
        NSPredicate *predicate = nil;
        NSString *col1 = nil;
        NSString *col2 = nil;
        NSString *col3 = nil;
        NSString *strRowId = nil;
        
        for(NSMutableDictionary *mutdictRow in mutarrNewRows)
        {
            NSMutableArray *arrRow = [[NSMutableArray alloc] init];
            for (NSString *key in mutdictRow)
            {
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strTagColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col1 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strValColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col2 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strTimeColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                {
                    col3 = [mutdictRow valueForKey:key];
                    col3 = [common dateFromExcelSerialDate:[col3 doubleValue]];
                }
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", rowColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    strRowId = [mutdictRow valueForKey:key];
                
            }
            
            [arrRow addObject:col1];
            [arrRow addObject:col2];
            [arrRow addObject:col3];
            [arrRow addObject:strRowId];
            
            
           [newRows enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL* stop) {
               
               NSLog(@"%@ => %@", key, value);
               NSString *prevRowId = (NSString *)key;
               NSString *newRowId = (NSString *)value;
               
               if([newRowId isEqualToString:[NSString stringWithFormat:@"%@",arrRow[3]]])
                {
                    Boolean exit = 0;
                    for(NSArray *eachRow in watchArray)
                    {
                        if([prevRowId isEqualToString:@"-1"])
                        {
                            int prevRowIndex = [watchArray indexOfObject:eachRow];
                            [watchArray insertObject:arrRow atIndex:prevRowIndex +1];
                            exit = 1;
                        }
                        if([[NSString stringWithFormat:@"%@",eachRow[3]]isEqualToString:prevRowId])
                        {
                            int prevRowIndex = [watchArray indexOfObject:eachRow];
                            [watchArray insertObject:arrRow atIndex:prevRowIndex +1];
                            exit = 1;
                            
                        }
                        if(exit == 1)
                            break;
                    }
                }
               
               
            }];
            
        }
        
        
        
    }
    else{
        NSLog(@"No changes from the cloud");
    }
    [self.CuboidCollectionView reloadData];
    NSLog(@"Reload Data Done");
    [refreshControlObj endRefreshing];
    NSLog(@"Refresh Ends");
}



#pragma mark – UICollectionViewDelegateFlowLayout

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSString *cellData = watchArray[indexPath.section][indexPath.row];
    
  //  return [watchArray[indexPath.section][indexPath.row] sizeWithAttributes:nil];
    
    return CGSizeMake(100, 100);
    
} */
    


@end
