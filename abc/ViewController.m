//
//  ViewController.m
//  abc
//
//  Created by Martin Michelini on 4/24/16.
//  Copyright © 2016 Martin Michelini. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "YTVimeoExtractor.h"

static NSString *const helpVideoURL = @"http://vimeo.com/100440444";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playVideoAction:(id)sender {
    
    [[YTVimeoExtractor sharedExtractor]fetchVideoWithVimeoURL:helpVideoURL withReferer:nil completionHandler:^(YTVimeoVideo * _Nullable video, NSError * _Nullable error) {
        
        if (video) {
            
            //Will get the lowest available quality.
            //NSURL *lowQualityURL = [video lowestQualityStreamURL];
            
            //Will get the highest available quality.
            NSURL *highQualityURL = [video highestQualityStreamURL];
            
            AVPlayer *moviePlayer = [AVPlayer playerWithURL:highQualityURL];
            AVPlayerViewController *moviePlayerViewController = [AVPlayerViewController new];
            moviePlayerViewController.player = moviePlayer;
            [self presentViewController:moviePlayerViewController animated:YES completion:nil];
            [moviePlayer play];
            
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"The Help Video is not available at this time" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                                                  }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

@end
