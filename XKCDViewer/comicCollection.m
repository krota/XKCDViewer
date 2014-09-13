//
//  comicCollection.m
//  XKCDViewer
//
//  Created by Kyle Rota on 10/15/13.
//  Copyright (c) 2013 Kyle Rota. All rights reserved.
//

#import "comicCollection.h"
#import "xkcd_comic.h"

@implementation comicCollection

static comicCollection *theComicCollection = nil;

-(id)init
{
    self = [super init];
    
    if(self)
    {
        
        self.comicList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+(comicCollection*)sharedComicList
{
    if(theComicCollection == nil)
    {
        theComicCollection = [[comicCollection alloc] init];
    }
    
    return theComicCollection;
}


@end
