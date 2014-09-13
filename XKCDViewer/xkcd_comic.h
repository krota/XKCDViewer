//
//  xkcd_comic.h
//  XKCDViewer
//
//  Created by Kyle Rota on 10/3/13.
//  Copyright (c) 2013 Kyle Rota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xkcd_comic : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) int num;
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSString *img;

@end
