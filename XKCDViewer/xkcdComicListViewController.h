//
//  xkcdComicListViewController.h
//  XKCDViewer
//
//  Created by Kyle Rota on 10/15/13.
//  Copyright (c) 2013 Kyle Rota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "xkcd_comic.h"
#import "comicCollection.h"

#define CURRENT_COMIC_URL [NSURL URLWithString: @"http://xkcd.com/info.0.json"]
#define COMIC_URL [NSURL URLWithString: @"http://xkcd.com/*/info.0.json"]

@interface xkcdComicListViewController : UITableViewController

@end
