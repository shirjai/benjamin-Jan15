//
//  WBookCell.m
//  bw4
//
//  Created by Srinivas on 10/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "WBookCell.h"

@implementation WBookCell
/*
{

    UILabel *WorkbookNamevalue;
    UILabel *decValue;
    UILabel *lastSubmitvalue;
    UILabel *lastrefreshvalue;
    
}
 */
@synthesize WorkbookName = _WorkbookName;
@synthesize Desc = _Desc;
@synthesize lastSubmit=_lastSubmit;
@synthesize LastRefresh=_LastRefresh;

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //if (self) {
     //   NSArray *niba = [[NSBundle mainBundle] loadNibNamed:@"WBookCell" owner:self options:nil];
       // self =[niba objectAtIndex:0];
   // }
    
}       

        /*
              
        
        CGRect userValueRectangle = CGRectMake(25, 5, 280, 15);
        WorkbookNamevalue = [[UILabel alloc]initWithFrame:userValueRectangle];
        WorkbookNamevalue.font = [UIFont boldSystemFontOfSize:12];
        WorkbookNamevalue.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:WorkbookNamevalue];
        
        CGRect sheetLableRectangle = CGRectMake(15, 20, 70, 15);
        UILabel *sheetLabel = [[UILabel alloc] initWithFrame:sheetLableRectangle];
        sheetLabel.textAlignment = NSTextAlignmentRight;
        sheetLabel.text = @"Description:";
        sheetLabel.font  = [UIFont fontWithName:@"Arial-ItalicMT" size:12];
        sheetLabel.textColor = [UIColor darkGrayColor];
        sheetLabel.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:sheetLabel];
        
        CGRect txsValueRectangle = CGRectMake(90, 20, 280, 35);
        decValue = [[UILabel alloc]initWithFrame:txsValueRectangle];
        decValue.font = [UIFont systemFontOfSize:12];
        decValue.textColor = [UIColor redColor];
        decValue.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:decValue];
        
        
        /*
        CGRect sheetLableRectangle = CGRectMake(15, 36, 70, 15);
        UILabel *sheetLabel = [[UILabel alloc] initWithFrame:sheetLableRectangle];
        sheetLabel.textAlignment = NSTextAlignmentRight;
        sheetLabel.text = @"Worksheet:";
        sheetLabel.font  = [UIFont fontWithName:@"Arial-ItalicMT" size:12];
        sheetLabel.textColor = [UIColor darkGrayColor];
        sheetLabel.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:sheetLabel];
        
        
        CGRect sheetValueRectangle = CGRectMake(90, 36, 100, 15);
        _sheetvalue = [[UILabel alloc]initWithFrame:sheetValueRectangle];
        _sheetvalue.font = [UIFont systemFontOfSize:12];
        _sheetvalue.font  = [UIFont fontWithName:@"Arial-ItalicMT" size:12];
        _sheetvalue.textColor = [UIColor darkGrayColor];
        _sheetvalue.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_sheetvalue];
        
        
        
        CGRect typeValueRectangle = CGRectMake(200, 36, 220, 15);
        _typeValue = [[UILabel alloc]initWithFrame:typeValueRectangle];
        _typeValue.font = [UIFont systemFontOfSize:12];
        _typeValue.font  = [UIFont fontWithName:@"Arial-ItalicMT" size:12];
        _typeValue.textColor = [UIColor darkGrayColor];
        _typeValue.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_typeValue];
        
        CGRect commentValueRectangle = CGRectMake(25, 55, 280, 15);
        _commentValue = [[UILabel alloc]initWithFrame:commentValueRectangle];
        _commentValue.font = [UIFont systemFontOfSize:12];
        _commentValue.textColor = [UIColor blueColor];
        _commentValue.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_commentValue];
        
        */
        
        
        
        /*   CGRect typeLableRectangle = CGRectMake(0, 50, 70, 15);
         UILabel *typeLabel = [[UILabel alloc] initWithFrame:typeLableRectangle];
         typeLabel.textAlignment = NSTextAlignmentRight;
         typeLabel.text = @"Type:";
         typeLabel.font  = [UIFont boldSystemFontOfSize:12];
         [self.contentView addSubview:typeLabel]; */
        
        /*   CGRect commentLableRectangle = CGRectMake(0, 65, 70, 15);
         UILabel *commentLabel = [[UILabel alloc] initWithFrame:commentLableRectangle];
         commentLabel.textAlignment = NSTextAlignmentRight;
         commentLabel.text = @"Comment:";
         commentLabel.font  = [UIFont boldSystemFontOfSize:12];
         [self.contentView addSubview:commentLabel]; */
     /*
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setWorkbookName:(NSString *)WorkbookName:(NSString *)Wb{
    if(![Wb isEqualToString:WorkbookName]){
        WorkbookName = [Wb copy];
        WorkbookNamevalue.text = WorkbookName;
    }
    
}

-(void)setDesc:(NSString *)Desc:(NSString *)De{
    if (![De isEqualToString:Desc]) {
        Desc = [De copy];
        decValue.text = Desc;
    }
}

-(void)setLastRefresh:(NSString *)LastRefresh:(NSString *)LR{
    if (![LR isEqualToString:LastRefresh]) {
        LastRefresh = [LR copy];
        lastrefreshvalue.text = LastRefresh;
    }
}

-(void)setLastSubmit:(NSString *)lastSubmit:(NSString *)LS{
    if(![LS isEqualToString:lastSubmit]){
        lastSubmit = [LS copy];
        lastSubmitvalue.text = lastSubmit;
    }
    
}
/*
-(void)setComment:(NSString *)comment{
    if(![comment isEqualToString:_comment]){
        _comment = [comment copy];
        _commentValue.text= _comment;
        
        _commentValue.lineBreakMode = NSLineBreakByWordWrapping;
        _commentValue.numberOfLines = 0;
        [_commentValue setFrame:CGRectMake(25, 55, 280, 15)];
        [_commentValue sizeToFit];
        
        
    }
}
 */
@end