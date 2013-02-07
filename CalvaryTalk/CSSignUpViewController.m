//
//  CSSignUpViewController.m
//  CalTalk
//
//  Created by Choi Myungjin on 2/6/13.
//  Copyright (c) 2013 Choipd Studios. All rights reserved.
//

#import "CSSignUpViewController.h"
#import <baas.io/Baas.h>

@interface CSSignUpViewController ()

@end

@implementation CSSignUpViewController

- (IBAction)sign_up:(id)sender {
    NSString* password = self.password_field.text;
    NSString* name = self.name_field.text;
    NSString* email = self.email_field.text;
    
    [BaasioUser signUpInBackground:email
                          password:password
                              name:name
                             email:email
                      successBlock:^{
                          [BaasioUser signInBackground:email password:password successBlock:^{
                              [self dismissViewControllerAnimated:YES completion:^{
                                  NSLog(@"%@", [BaasioUser currentUser]);
                              }];
                          } failureBlock:^(NSError *error) {
                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"로그인에 실패하였습니다.\n다시 시도해주세요."
                                                                                  message:error.localizedDescription
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil];
                              [alertView show];
                          }];
        
    } failureBlock:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"회원가입에 실패하였습니다.\n다시 시도해주세요."
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
