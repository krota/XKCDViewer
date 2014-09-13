//
//  comicCollection.h
//  XKCDViewer
//
//  Created by Kyle Rota on 10/15/13.
//  Copyright (c) 2013 Kyle Rota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface comicCollection : NSObject

@property(nonatomic,strong) NSMutableArray *comicList;

@property(nonatomic,strong) NSString *currentComic;

+(comicCollection*)sharedComicList;

@end
