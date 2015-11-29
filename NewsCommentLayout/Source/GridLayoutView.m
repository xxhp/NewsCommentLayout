//
//  GridLayoutView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//

#import "GridLayoutView.h"
#import "Constant.h"
@implementation GridLayoutView
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
    
    
    
    return textSize;
}
- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSArray *)sortedArray
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth = LayoutBordWidth;
        
        self.layer.borderColor = LayoutBordColor.CGColor;
        
        self.backgroundColor = LayoutBackgroundColor;
        
        
        float lastH = 0;
        for (int i = 0;i<sortedArray.count - 4;i++) {
            CommentModel *model = sortedArray[i];
            
            CGSize sz =[self text: model.comment SizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.frame.size.width-10, 1000)];
            
            UILabel * _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5+lastH,frame.size.width - 10, 34)];
            _nameLabel.font =[UIFont systemFontOfSize:12];
            _nameLabel.textColor = NameColor;
            UILabel*  _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _nameLabel.frame.origin.y+5+_nameLabel.frame.size.height ,frame.size.width - 10, sz.height+20)];
            _commentLabel.numberOfLines =0;
            _commentLabel.font =[UIFont systemFontOfSize:14];
            
            UILabel* _floorLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.frame.size.width - 15,5+lastH ,15, 34)];
            _floorLabel.font =[UIFont systemFontOfSize:12];
            
            _floorLabel.textColor =[UIColor grayColor];
            
            
            UILabel* _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            
            _addressLabel.frame = CGRectMake(5, 5+lastH+20,frame.size.width - 10, 34);
            _addressLabel.textColor =[UIColor grayColor];
            _addressLabel.text = model.address;
            _addressLabel.font = [UIFont systemFontOfSize:12];
            
            [self addSubview:_nameLabel];
            [self addSubview:_addressLabel];
            [self addSubview:_commentLabel];
            [self addSubview:_floorLabel];
            _nameLabel.text =  model.name;
            _commentLabel.text = model.comment;
            _floorLabel.text = model.floor;
            
            
            CGRect r = CGRectMake(0,_commentLabel.frame.origin.y+_commentLabel.frame.size.height, self.bounds.size.width,  0.6);
            
            //        lastH = r.size.height;
            UIView *vi =[[UIView alloc] initWithFrame:r];
            vi.backgroundColor = [UIColor colorWithRed:215./255. green:215./255 blue:191./255 alpha:1];
            if (i != sortedArray.count -5) {
                [self addSubview:vi];
                ;
            }
            lastH = r.origin.y
            ;
        }
        CGRect fr = frame;
        fr.size.height = lastH;
        self.frame = fr;
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
