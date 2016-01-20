//
//  ViewController.m
//  Test Parse
//
//  Created by Appmonkeyz on 1/18/16.
//  Copyright © 2016 Appmonkeyz. All rights reserved.
//
#import <Parse/Parse.h>

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtSchool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnSaveStudent:(id)sender {
    PFObject *testObject = [PFObject objectWithClassName:@"Student"];
    testObject[@"Name"] = [self.txtName text];
    testObject[@"School"] = [self.txtSchool text];
    [testObject saveInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnStore:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Student"];
    // Pin PFQuery results
    NSArray *objects = [query findObjects]; // Online PFQuery results
    [PFObject pinAllInBackground:objects block:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Done");
    }];
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"Lecturer"];
    // Pin PFQuery results
    NSArray *objects1 = [query1 findObjects]; // Online PFQuery results
    [PFObject pinAllInBackground:objects1 block:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Done");
    }];
    
    
}
- (IBAction)btnQueryLocalStore:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Student"];
    NSLog(@"%@",query);
    // Query the Local Datastore
    [query fromLocalDatastore];
    //[query whereKey:@"Name" equalTo:@"Nipuna"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu records.",(unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (IBAction)retrieveUser:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Lecturer"];
    NSLog(@"%@",query);
    // Query the Local Datastore
    [query fromLocalDatastore];
    //[query whereKey:@"Name" equalTo:@"Nipuna"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu records.",(unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (IBAction)btnCurrentUser:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"The current user is %@",currentUser);
    } else {
        NSLog(@"No logged in user found");
    }
}
- (IBAction)btnLogout:(id)sender {
    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
    if(currentUser){
        [PFUser logOut];
        NSLog(@"Logged out %@ successfully",currentUser.username);
    }
    else{
        NSLog(@"No Logged in users");
    }
    
    

}

- (IBAction)btnLogin:(id)sender {
    [self performSegueWithIdentifier:@"LOGIN_VIEW" sender:self];
}

- (IBAction)btnRetrieve:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Student"];
    //[query whereKey:@"Name" equalTo:@"Nipuna"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu records.",(unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", [object objectForKey:@"Name"]);
                NSLog(@"%@", [object objectForKey:@"School"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}
- (IBAction)btnFacebook:(id)sender {
    [self performSegueWithIdentifier:@"FB_LOGIN" sender:self];
}


@end
