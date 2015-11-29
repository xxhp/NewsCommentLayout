//
//  CommentModel.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        NSString *string =dic[@"f"];
        NSRange rang =[string rangeOfString:@"["];
        
        self.address =[string substringToIndex:rang.location];
        
        self.comment =dic[@"b"];
        
        rang =[string rangeOfString:@"["];
        NSInteger start = rang.location;
        rang =[string rangeOfString:@"]"];
        NSInteger end = rang.location;
       
        self.timeString =dic[@"t"];
        self.name = [string substringWithRange:NSMakeRange(start+1, end - start-1)];
       
    }
    return self;
    
}

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
//-(CGFloat)textHeight{
//    CGSize s = [self text:self.comment SizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000)];
//    return s.height;
//}
@end
