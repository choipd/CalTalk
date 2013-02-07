//
//  CSMainTabBarController.m
//  CalTalk
//
//  Created by Choi Myungjin on 2/7/13.
//  Copyright (c) 2013 Choipd Studios. All rights reserved.
//

#import "CSMainTabBarController.h"
#import <baas.io/Baas.h>

@interface CSMainTabBarController ()

@end

@implementation CSMainTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([BaasioUser currentUser] == nil) {
        [self performSegueWithIdentifier:@"display_signup" sender:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
