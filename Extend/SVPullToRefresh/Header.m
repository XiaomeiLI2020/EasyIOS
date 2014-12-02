//
//  Header.m
//  mcapp
//
//  Created by zhuchao on 14/11/21.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "Header.h"
@implementation Header

- (id)initWithFrame:(CGRect)frame with:(UIScrollView *)scrollView{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)resetScrollViewContentInset:(UIScrollView *)scrollView {
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.top = scrollView.pullToRefreshView.originalTopInset;
    [self setScrollViewContentInset:currentInsets scrollView:scrollView];
}

- (void)setScrollViewContentInsetForLoading:(UIScrollView *)scrollView {
    CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.top = MIN(offset, scrollView.pullToRefreshView.originalTopInset + scrollView.pullToRefreshView.bounds.size.height);
    [self setScrollViewContentInset:currentInsets scrollView:scrollView];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset scrollView:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         scrollView.contentInset = contentInset;
                     }
                     completion:nil];
}

-(void)pullContentOffset:(UIScrollView *)scrollView{
    if(fequalzero(scrollView.contentOffset.y + scrollView.pullToRefreshView.originalTopInset)) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-SVPullToRefreshViewHeight) animated:YES];
    }
}

@end