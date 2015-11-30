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
    
    self.backgroundColor = CellBackgroundColor;
    
    int i = 0;
    id lastView = nil;
    float lastH = 0;
    
    CommentModel *last = [sortedArray lastObject];
    
    if(sortedArray.count > 5 ){
        
        CGRect r = CGRectMake(44+ 6*3, 60 + 6*3, [UIScreen mainScreen].bounds.size.width - 44 -10 - 2*(6 * 3),  0);
        GridLayoutView  *vie =[[GridLayoutView alloc] initWithFrame:r andModelArray:sortedArray];
        lastH = vie.frame.size.height;
        [self addSubview:vie];
        lastView = vie;
        
        i = 6;
        
        for (NSInteger j = sortedArray.count - 6; j< sortedArray.count; j++) {
            
            CommentModel *model =sortedArray[j];
            
            CGRect r = CGRectMake(44+ i*3, 60 + i*3, [UIScreen mainScreen].bounds.size.width - 44 -10 - 2*(i * 3),  0);
            
            CGSize sz =[model sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(r.size.width-10, 1000)];
            
            r.size.height = sz.height +lastH + 55;
            
            LayoutView *vi =[[LayoutView alloc] initWithFrame:r model:model parentView:lastView isLast:[last isEqual: model]];
            
            lastH =  r.size.height;
            
            if (lastView) {
                [self insertSubview:vi belowSubview:lastView];
            }else{
                [self addSubview:vi];
            }
            i --;
            lastView = vi;
            
        }
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, lastH+44);
        
    }else{
        
        for (CommentModel *model in sortedArray) {
            float h = 0;
            
            i = [last.floor intValue] - model.floor.intValue;
            
            CGRect r = CGRectMake(44+ i*3, 60 + i*3, [UIScreen mainScreen].bounds.size.width - 44 -10 - 2*(i * 3),  h);
            
            CGSize sz =[model sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(r.size.width-10, 1000)];
            
            r.size.height = sz.height +lastH + 55;
            
            LayoutView *vi =[[LayoutView alloc] initWithFrame:r model:model parentView:lastView isLast:[last isEqual: model]];
            
            lastH =  r.size.height;
            
            if (lastView) {
                [self insertSubview:vi belowSubview:lastView];
            }else{
                [self addSubview:vi];
            }
            
            lastView = vi;
        }
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, lastH+44);
    }
    
    _headImageView  =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    _headImageView.image =[UIImage imageNamed:@"head_default.png"];
    
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _addressLabel.font =[UIFont systemFontOfSize:12];
    _addressLabel.textColor =[UIColor grayColor];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font =[UIFont systemFontOfSize:14];
    _nameLabel.textColor = NameColor;
    

    _nameLabel.text = self.model.name;
    _addressLabel.text = self.model.address;
    
    _nameLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 4, 10 ,self.frame.size.width - 10, 34);
    _addressLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 4, 30 ,self.frame.size.width - 10, 34);

    _likeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _likeButton.frame =  CGRectMake(self.frame.size.width - 32, 14 ,17, 16);
    [_likeButton setBackgroundImage:[UIImage imageNamed:@"like_btn.png"] forState:UIControlStateNormal];
    
    [self addSubview:_likeButton];
    [self addSubview:_headImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_addressLabel];
    
}
-(instancetype)initWithModelArray:(NSArray *)model{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = CellBackgroundColor;
        NSMutableArray *ar =[NSMutableArray arrayWithArray:model];
        self.model = [ar lastObject];
        [self updateWithModelArray:ar];
        
    }
    return self;
}
@end
