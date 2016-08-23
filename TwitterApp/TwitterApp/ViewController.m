//
//  ViewController.m
//  TwitterApp
//
//  Created by sourav sarkar on 23/08/16.
//  Copyright © 2016 sourav sarkar. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

- (void) configureTweetTextView;
- (void) showAlertMessage:(NSString *) message;

@end

@implementation ViewController

- (void) showAlertMessage:(NSString *) message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Twitter App" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *goAway = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:goAway];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTweetTextView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showShareAction:(id)sender {
    if ([self.tweetTextView isFirstResponder]) {
        [self.tweetTextView resignFirstResponder];
    }
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Test Title" message:@"Tweet ur note" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
              if ([self.tweetTextView.text length] <= 140) {
                [twitterVC setInitialText:self.tweetTextView.text];
                  
              } else {
                NSString *tweet = [self.tweetTextView.text substringToIndex:140];
                [twitterVC setInitialText:tweet];
                // [self showAlertMessage:@"Please Sign In to Twitter"];
              }
            [self presentViewController:twitterVC animated:YES completion:nil];
        } else {
            [self showAlertMessage:@"Please Sign In to Twitter"];
        }
        
    }];
    
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Post to FB" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebookVC setInitialText:self.tweetTextView.text];
            [self presentViewController:facebookVC animated:YES completion:nil];
        } else {
            [self showAlertMessage:@"Please Sign In to facebook!"];
        }
    }];
        
    [actionController addAction:tweetAction];
    [actionController addAction:facebookAction];
    [actionController addAction:cancelAction];
    [self presentViewController:actionController animated:YES completion:nil];
}

- (void) configureTweetTextView {
    
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;

}

@end