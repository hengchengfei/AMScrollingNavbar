//
//  NextViewController.m
//  ScrollingNavbarDemo
//
//  Created by hengchengfei on 14/12/22.
//  Copyright (c) 2014年 Andrea Mazzini. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController()

@end

@implementation NextViewController

-(IBAction)back:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}

@end