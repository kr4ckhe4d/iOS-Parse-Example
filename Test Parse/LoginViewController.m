//
//  LoginViewController.m
//  Test Parse
//
//  Created by Appmonkeyz on 1/20/16.
//  Copyright © 2016 Appmonkeyz. All rights reserved.
//

#import "LoginViewController.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIView *vwReset;
@property (weak, nonatomic) IBOutlet UITextField *txtResetEmail;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Login";
    self.vwReset.hidden = YES;
    // Do any additional setup after loading the view.
}
- (IBAction)btnForgot:(id)sender {
    self.vwReset.hidden = NO;
}

- (IBAction)btnSendResetLink:(id)sender {
    [PFUser requestPasswordResetForEmailInBackground:self.txtResetEmail.text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnLogin:(id)sender {
    [PFUser logInWithUsernameInBackground:self.txtUsername.text
                                 password:self.txtPassword.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"Logged in as %@",user);
                                        } else {
                                            NSLog(@"Login failed with error %@",error);
                                        }
                                    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
