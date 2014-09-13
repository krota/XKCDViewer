//
//  xkcdViewController.h
//  XKCDViewer
//
//  Created by Kyle Rota on 10/3/13.
//  Copyright (c) 2013 Kyle Rota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "xkcd_comic.h"

#define CURRENT_COMIC_URL [NSURL URLWithString: @"http://xkcd.com/info.0.json"]
#define PREVIOUS_COMIC_URL [NSURL URLWithString: @"http://xkcd.com/*/info.0.json"]
#define COMIC_TEST [NSURL URLWithString: @"http://xkcd.com/1/info.0.json"]

@interface xkcdViewController : UIViewController <UIAlertViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *comicView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UINavigationItem *navBar;
@property (nonatomic, assign) int screenWidth;
@property (nonatomic, strong) xkcd_comic *currentComic;

@end
