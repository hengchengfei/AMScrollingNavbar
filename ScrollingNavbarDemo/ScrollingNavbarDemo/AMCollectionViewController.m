//
//  AMCollectionViewController.m
//  ScrollingNavbarDemo
//
//  Created by David on 28/12/2013.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "AMCollectionViewController.h"
#import "UIViewController+ScrollingNavbar.h"
#import "PPiFlatSegmentedControl.h"
#import "UIViewAdditions.h"


@interface AMCollectionViewController ()

@end

@implementation AMCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self setTitle:@"Table View"];
    CGRect  bounds = [[UIScreen mainScreen]bounds];
    UIImage *whatImage =[UIImage imageNamed:@"top.png"];
    UIImageView *whatImageView=[[UIImageView alloc]initWithImage:whatImage];
    [whatImageView sizeToFit];
    self.navigationItem.titleView = whatImageView;
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self.collectionView setTop:44];
    [self.collectionView setHeight:504];
    
    // Just call this line to enable the scrolling navbar
    [self followScrollView:self.collectionView];
    
    //添加tab按钮
    PPiFlatSegmentItem *item1=[[PPiFlatSegmentItem alloc]initWithTitle:NSLocalizedString(@"精选",nil) andIcon:nil];
    PPiFlatSegmentItem *item2 = [[PPiFlatSegmentItem alloc]initWithTitle:NSLocalizedString(@"最新",nil) andIcon:nil];
    PPiFlatSegmentItem *item3 = [[PPiFlatSegmentItem alloc]initWithTitle:NSLocalizedString(@"关注",nil) andIcon:nil];
    NSArray *items = @[item1,item2,item3];
    
    
    PPiFlatSegmentedControl *segment = [[PPiFlatSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)
                                                                               items:items
                                                                        iconPosition:nil
                                                                   andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                       
                                                                   }
                                                                      iconSeparation:5];
    
    segment.color=UIColorFromRGB(0xF8F8F8);
    segment.selectedColor=UIColorFromRGB(0xF8F8F8);//选中时覆盖的颜色,一定要设置,否则默认为parent view的背景色
    
    segment.textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:UIColorFromRGB(0xC9C5C5)};
    segment.selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                       NSForegroundColorAttributeName:UIColorFromRGB(0x666666)};
    [segment.layer setMasksToBounds:YES];
    [segment.layer setCornerRadius:0.0];//设置control四个角度的度数,0为直角.
    segment.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:segment];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	// This enables the user to scroll down the navbar by tapping the status bar.
	[self showNavbar];
	
	return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat side = [UIScreen mainScreen].bounds.size.width / 2 - 8;
    return (CGSize){ side, side };
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"exampleCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *s =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *cc =  [s instantiateViewControllerWithIdentifier:@"NextViewController"];
    [self.navigationController pushViewController:cc animated:YES];
}

@end
