//
//  CommentModel.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(instancetype)initWithDict:(NSDictionary *)dic{
    
    if (self = [super init]) {
        NSString *string =dic[@"f"];
        NSRange rang =[string rangeOfString:@"["];
        
        self.address =[string substringToIndex:rang.location];
        
        self.comment =dic[@"b"];
        
        rang =[string rangeOfString:@"["];
        NSInteger start = rang.location;
        rang =[string rangeOfString:@"]"];
        NSInteger end = rang.location;
       
        self.name = [string substringWithRange:NSMakeRange(start+1, end - start-1)];
        self.timeString =dic[@"t"];
        
    }
    return self;
    
}
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize textSize         = [self.comment boundingRectWithSize:CGSizeMake(size.width, 0)
                                                 options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                              attributes:attribute
                                                 context:nil].size;
    return textSize;
}
@end
