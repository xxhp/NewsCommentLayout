//
//  LayoutContainnerView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//


#import "LayoutContainerView.h"
#import "LayoutView.h"
#import "GridLayoutView.h"
#import "CommentModel.h"
#import "Constant.h"
@interface LayoutContainerView()

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIButton *likeButton;
@property(nonatomic,strong)CommentModel *model;
@end

@implementation LayoutContainerView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (CGSize)text:(NSString *)string SizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize;
    
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    textSize = [string boundingRectWithSize:CGSizeMake(size.width, 0)
                                    options:\
                NSStringDrawingTruncatesLastVisibleLine |
                NSStringDrawingUsesLineFragmentOrigin |
                NSStringDrawingUsesFontLeading
                                 attributes:attribute
                                    context:nil].size;
    //            textSize.height = ceil(textSize.height);
    //            textSize.width = ceil(textSize.width);
    
    
    return textSize;
}
-(void)update:(NSMutableArray *)sortedArray{
    
    self.backgroundColor = CellBackgroundColor;

    int i = 0;
  
    id lastView = nil;
    float lastH = 0;
    CommentModel *last = [sortedArray lastObject];
    
    if(sortedArray.count > 4 ){
        
         CGRect r = CGRectMake(44+ 5*3, 60 + 5*3, [UIScreen mainScreen].bounds.size.width - 44 -10 - 2*(5 * 3),  0);
         GridLayoutView  *vie =[[GridLayoutView alloc] initWithFrame:r andInfo:sortedArray];
        lastH = vie.frame.size.height;
        [self addSubview:vie];
        lastView = vie;
        i = 4;
        for (NSInteger j = sortedArray.count - 4; j< sortedArray.count; j++) {
            
            CommentModel *model =sortedArray[j];
            
            CGRect r = CGRectMake(44+ i*3, 60 + i*3, [UIScreen mainScreen].bounds.size.width - 44 -10 - 2*(i * 3),  0);
            
            CGSize sz =[self text: model.comment SizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(r.size.width-10, 1000)];
            
            r.size.height = sz.height +lastH + 55;
            
            LayoutView *vi =[[LayoutView alloc] initWithFrame:r andInfo:model andParentView:lastView isLast:[last isEqual: model]];
            vi.container = self;
            vi.isLastFloor = [last isEqual: model];
            lastH =  r.size.height;
            model.view = vi;
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
        
        CGSize sz =[self text: model.comment SizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(r.size.width-10, 1000)];
       
        r.size.height = sz.height +lastH + 55;
      
        LayoutView *vi =[[LayoutView alloc] initWithFrame:r andInfo:model andParentView:lastView isLast:[last isEqual: model]];
        vi.container = self;
        
        lastH =  r.size.height;
        model.view = vi;
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
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentLabel.numberOfLines =0;
    _commentLabel.font =[UIFont systemFontOfSize:14];
    _nameLabel.text = self.model.name;
    _nameLabel.font =[UIFont systemFontOfSize:14];
    _commentLabel.text = self.model.comment;
    _nameLabel.textColor = NameColor;
    
    _nameLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 4, 10 ,self.frame.size.width - 10, 34);
    
    _addressLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 4, 30 ,self.frame.size.width - 10, 34);
    _addressLabel.textColor =[UIColor grayColor];
    _addressLabel.text = self.model.address;

    
    _likeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _likeButton.frame =  CGRectMake(self.frame.size.width - 32, 14 ,17, 16);
    [_likeButton setBackgroundImage:[UIImage imageNamed:@"like_btn.png"] forState:UIControlStateNormal];
    
    [self addSubview:_likeButton];
    
    [self addSubview:_headImageView];
    [self addSubview:_nameLabel];
    
    [self addSubview:_addressLabel];
    
}
-(instancetype)initWithModels:(NSArray *)model{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor =[UIColor colorWithRed:244./255. green:244./255 blue:244./255 alpha:1];
        NSMutableArray *ar =[NSMutableArray arrayWithArray:model];
        self.model = [ar lastObject];
        [self update:ar];
        
    }
    return self;
}
@end
