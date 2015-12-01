//
//  LayoutContainnerView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//


#import "LayoutContainerView.h"
#import "LayoutView.h"
#import "GridLayoutView.h"
#import "CommentModel.h"
#import "Constant.h"
@interface LayoutContainerView()

@property (nonatomic,strong) UILabel      *nameLabel;
@property (nonatomic,strong) UILabel      *addressLabel;
@property (nonatomic,strong) UIImageView  *headImageView;
@property (nonatomic,strong) UIButton     *likeButton;
@property (nonatomic,strong) CommentModel *model;

@end

@implementation LayoutContainerView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)updateWithModelArray:(NSMutableArray *)sortedArray{
    
    int i = 0;
    id lastView = nil;
    float lastH = 0;
    
    CommentModel *lastModel = [sortedArray lastObject];
    
    if(sortedArray.count > MaxOverlapNumber ){
       
        NSMutableArray *tempArray =[[NSMutableArray alloc] initWithArray:sortedArray];
        [tempArray removeObjectsInRange:NSMakeRange(sortedArray.count - MaxOverlapNumber, MaxOverlapNumber)];
        
        CGRect r = CGRectMake(44+ MaxOverlapNumber*OverlapSpace, 60 + MaxOverlapNumber*OverlapSpace, ScreenWidth - 44 -10 - 2*(MaxOverlapNumber * OverlapSpace),  0);
        GridLayoutView  *gridView =[[GridLayoutView alloc] initWithFrame:r andModelArray:tempArray];
        lastH = gridView.frame.size.height;
        [self addSubview:gridView];
        lastView = gridView;
       
        [sortedArray removeObjectsInRange:NSMakeRange(0, sortedArray.count - MaxOverlapNumber)];
  
    }
        
    for (CommentModel *model in sortedArray) {
       
        i = lastModel.floor.intValue - model.floor.intValue;
        
        CGRect r = CGRectMake(44+ i*OverlapSpace, 60 + i*OverlapSpace, ScreenWidth - 44 -10 - 2*(i * OverlapSpace), 0);
        CGSize sz = [model sizeWithConstrainedToSize:CGSizeMake(r.size.width-10, MAXFLOAT)];
        r.size.height = sz.height +lastH + 55;
        
        LayoutView *vi =[[LayoutView alloc] initWithFrame:r model:model parentView:lastView isLast:[lastModel isEqual: model]];
        
        lastH =  r.size.height;
        
        if (lastView) {
            [self insertSubview:vi belowSubview:lastView];
        }else{
            [self addSubview:vi];
        }
        lastView = vi;
    }
    
    self.frame = CGRectMake(0, 0,ScreenWidth, lastH+44);
    
    
}
-(instancetype)initWithModelArray:(NSArray *)model{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = CellBackgroundColor;
        NSMutableArray *ar =[NSMutableArray arrayWithArray:model];
        self.model = [ar lastObject];
        
        self.backgroundColor = CellBackgroundColor;
        
        _headImageView  =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        _headImageView.image =[UIImage imageNamed:@"head_default.png"];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.font = AddressFont;
        _addressLabel.textColor =[UIColor grayColor];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = NameFont;
        _nameLabel.textColor = NameColor;
        
        _nameLabel.text = self.model.name;
        _addressLabel.text = self.model.address;
        
        _likeButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setBackgroundImage:[UIImage imageNamed:@"like_btn.png"] forState:UIControlStateNormal];
        
        
        [self addSubview:_likeButton];
        [self addSubview:_headImageView];
        [self addSubview:_nameLabel];
        [self addSubview:_addressLabel];

        [self updateWithModelArray:ar];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(10, 10, 30, 30);
    _nameLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 4, 10 ,self.frame.size.width - 10, 34);
    _addressLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 4, 30 ,self.frame.size.width - 10, 34);
    _likeButton.frame =  CGRectMake(self.frame.size.width - 32, 14 ,17, 16);
}
@end
