//
//  TableViewCellMessages.m
//  bw3
//
//  Created by Shirish Jaiswal on 7/24/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import "TableViewCellMessages.h"

@implementation TableViewCellMessages{
    UILabel *_uservalue;
    UILabel *_txvalue;
    UILabel *_sheetvalue;
    UILabel *_typeValue;
    UILabel *_commentValue;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        /*  CGRect userLableRectangle = CGRectMake(0, 5, 70, 15);
         UILabel *userLabel = [[UILabel alloc] initWithFrame:userLableRectangle];
         userLabel.textAlignment = NSTextAlignmentRight;
         userLabel.text = @"User:";
         userLabel.font  = [UIFont boldSystemFontOfSize:12];
         [self.contentView addSubview:userLabel]; */
        
        
        /*   CGRect txLableRectangle = CGRectMake(0, 20, 70, 15);
         UILabel *txLabel = [[UILabel alloc] initWithFrame:txLableRectangle];
         txLabel.textAlignment = NSTextAlignmentRight;
         txLabel.text = @"Date:";
         txLabel.font  = [UIFont boldSystemFontOfSize:12];
         [self.contentView addSubview:txLabel]; */
        
        
        
        //CGRect userValueRectangle = CGRectMake(25, 5, 280, 15);
        CGRect userValueRectangle = CGRectMake(60, 5, 280, 15);
        _uservalue = [[UILabel alloc]initWithFrame:userValueRectangle];
        _uservalue.font = [UIFont boldSystemFontOfSize:12];
        _uservalue.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_uservalue];
        
        
        //CGRect txsValueRectangle = CGRectMake(25, 20, 280, 15);
        CGRect txsValueRectangle = CGRectMake(60, 20, 280, 15);
        _txvalue = [[UILabel alloc]initWithFrame:txsValueRectangle];
        _txvalue.font = [UIFont systemFontOfSize:12];
        _txvalue.textColor = [UIColor redColor];
        _txvalue.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_txvalue];
        
        
        
        //CGRect sheetLableRectangle = CGRectMake(15, 36, 70, 15);
        CGRect sheetLableRectangle = CGRectMake(60, 36, 70, 15);
        UILabel *sheetLabel = [[UILabel alloc] initWithFrame:sheetLableRectangle];
        sheetLabel.textAlignment = NSTextAlignmentRight;
        sheetLabel.text = @"Worksheet:";
        sheetLabel.font  = [UIFont fontWithName:@"Arial-ItalicMT" size:12];
        sheetLabel.textColor = [UIColor darkGrayColor];
        sheetLabel.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:sheetLabel];
        
        
        //CGRect sheetValueRectangle = CGRectMake(90, 36, 100, 15);
        CGRect sheetValueRectangle = CGRectMake(135, 36, 100, 15);
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
        
        //CGRect commentValueRectangle = CGRectMake(25, 55, 280, 15);
        CGRect commentValueRectangle = CGRectMake(15, 60, 280, 15);
        _commentValue = [[UILabel alloc]initWithFrame:commentValueRectangle];
        _commentValue.font = [UIFont systemFontOfSize:12];
        _commentValue.textColor = [UIColor blueColor];
        _commentValue.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_commentValue];
        
        
        
        
        
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

-(void)setUser:(NSString *)usr{
    if(![usr isEqualToString:_user]){
        _user = [usr copy];
        _uservalue.text = _user;
    }
    
    /*  NSLog(@"%@ length:::%d",_user,[_user length]);
     if ([_user length]>45) {
     _uservalue.lineBreakMode = NSLineBreakByWordWrapping;
     _uservalue.numberOfLines = 0;
     [_uservalue setFrame:CGRectMake(25, 5, 280, 15)];
     [_txvalue setFrame:CGRectMake(25, 35, 280, 15)];
     [_commentValue setFrame:CGRectMake(25, 55, 280, 15)];
     [_uservalue sizeToFit];
     
     } */
}

-(void)setTx:(NSString *)tx{
    if (![tx isEqualToString:_tx]) {
        _tx = [tx copy];
        _txvalue.text = _tx;
    }
}

-(void)setSheet:(NSString *)sheet{
    if (![sheet isEqualToString:_sheet]) {
        _sheet = [sheet copy];
        _sheetvalue.text = _sheet;
    }
}

-(void)setType:(NSString *)type{
    if(![type isEqualToString:_type]){
        _type = [type copy];
        _typeValue.text = _type;
    }
    
}

-(void)setComment:(NSString *)comment{
    if(![comment isEqualToString:_comment]){
        _comment = [comment copy];
        _commentValue.text= _comment;
        
        _commentValue.lineBreakMode = NSLineBreakByWordWrapping;
        _commentValue.numberOfLines = 0;
        //[_commentValue setFrame:CGRectMake(25, 55, 280, 15)];
        [_commentValue setFrame:CGRectMake(15, 60, 280, 15)];
        [_commentValue sizeToFit];
        
        
    }
}
@end
