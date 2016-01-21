//
//  FBLoginViewController.m
//  Test Parse
//
//  Created by Appmonkeyz on 1/19/16.
//  Copyright © 2016 Appmonkeyz. All rights reserved.
//

#import "FBLoginViewController.h"

#import <ParseFacebookUtilsV4/PFFacebookUtils.h>


@interface FBLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

@end

@implementation FBLoginViewController

- (void)viewDidLoad {
    self.title = @"Register";
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnRegister:(id)sender {
        PFUser *user = [PFUser user];
        user.username = self.txtUsername.text;
        user.password = self.txtPassword.text;
        user.email = self.txtEmail.text;
        
        // other fields can be set just like with PFObject
        user[@"phone"] = self.txtPhone.text;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"Hooray! Let them use the app now.");
            }
            else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"Error!!! %@",errorString);
            }
        }];
}


- (IBAction)btnClick:(id)sender {
    NSArray *permissions = @[];
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login. %@",error);
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
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
