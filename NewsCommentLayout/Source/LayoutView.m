//
//  LayoutView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//

#import "LayoutView.h"
#import "LayoutContainerView.h"
#import "Constant.h"
@interface LayoutView()

@property (nonatomic,strong) CommentModel *model;
@property (nonatomic,strong) UILabel      *nameLabel;
@property (nonatomic,strong) UILabel      *floorLabel;
@property (nonatomic,strong) UILabel      *commentLabel;
@property (nonatomic,strong) UILabel      *addressLabel;
@property (nonatomic,assign) UIView       *parent;
@property (nonatomic,assign) BOOL         isLastFloor;

@end

@implementation LayoutView

- (instancetype)initWithFrame:(CGRect)frame model:(CommentModel *)amodel parentView:(UIView*)p isLast:(BOOL)isLast
{
    if (self = [super initWithFrame:frame]) {
        self.isLastFloor = isLast;
        self.parent = p;
        self.model = amodel;
        if (!self.isLastFloor) {
            self.layer.borderWidth = LayoutBordWidth;
            self.layer.borderColor = LayoutBordColor.CGColor;
            self.backgroundColor = LayoutBackgroundColor;
        }
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = self.model.name;
        _nameLabel.font = NameFont;
        _nameLabel.textColor = NameColor;
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor =[UIColor grayColor];
        _addressLabel.text = self.model.address;
        _addressLabel.font = AddressFont;
        
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.numberOfLines =0;
        _commentLabel.font = CommentFont;
        _commentLabel.text = self.model.comment;
        
       
        _floorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _floorLabel.font = AddressFont;
        _floorLabel.text = self.model.floor;
        _floorLabel.textColor =[UIColor grayColor];
        
        _nameLabel.frame = CGRectMake(5, self.parent.frame.size.height ,self.frame.size.width - 10, 34);
        _addressLabel.frame = CGRectMake(_nameLabel.frame.origin.x, self.parent.frame.size.height + 20 ,self.frame.size.width - 10, 34);
        _floorLabel.frame = CGRectMake(self.frame.size.width - 15, self.parent.frame.size.height +5 ,15, 34);
        _commentLabel.frame =  CGRectMake(5, self.parent.frame.size.height+40 ,self.frame.size.width - 10,self.frame.size.height - self.parent.frame.size.height - 40);
       

        [self addSubview:_nameLabel];
        [self addSubview:_addressLabel];
        [self addSubview:_commentLabel];
        [self addSubview:_floorLabel];
        
        if (self.isLastFloor) {
            _nameLabel.hidden = YES;
            _addressLabel.hidden = YES;
            _floorLabel.hidden = YES;
            _commentLabel.frame = CGRectMake(5, self.parent.frame.size.height+5 ,self.frame.size.width - 10,self.frame.size.height - self.parent.frame.size.height - 40);
        }
        
    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
