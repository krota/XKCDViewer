//
//  xkcdComicListViewController.m
//  XKCDViewer
//
//  Created by Kyle Rota on 10/3/13.
//  Copyright (c) 2013 Kyle Rota. All rights reserved.
//


#import "xkcdComicListViewController.h"

@interface xkcdComicListViewController ()

@end

@implementation xkcdComicListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
         //Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getPreviousComics:20];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
     //Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     //Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     //Return the number of rows in the section.
    comicCollection *comics = [comicCollection sharedComicList];
    
    return comics.comicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ComicItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    comicCollection *comics = [comicCollection sharedComicList];
    xkcd_comic *comic = comics.comicList[indexPath.row];
    
    cell.textLabel.text = comic.title;
    cell.textLabel.center = cell.center;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    comicCollection *comics = [comicCollection sharedComicList];
    
    if ([[segue identifier] isEqualToString:@"showComic"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        xkcd_comic *comic = [comics.comicList objectAtIndex:indexPath.row];
        [[segue destinationViewController] setCurrentComic:(NSString*)comic];
        //I have no idea why this has to be casted as a string.
    }
}

-(void) getPreviousComics:(int)numComics
{

    comicCollection *comics = [comicCollection sharedComicList];
    
    //configure the spinner
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];

    //go to a background thread so we don't block
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        NSData *data = [NSData dataWithContentsOfURL:CURRENT_COMIC_URL];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

        int currentComicNum = [[json objectForKey:@"num"] intValue];
        int currentComicCount = comics.comicList.count;

        for(int i = currentComicNum - currentComicCount; i > currentComicNum - currentComicCount - numComics; i-- )
        {
            if (currentComicNum > 0)
            {
                NSMutableString *previousComicURL = [[NSMutableString alloc]initWithString:[COMIC_URL absoluteString]];
                NSURL *URL = [[NSURL alloc]initWithString:[previousComicURL stringByReplacingOccurrencesOfString:@"*" withString:[NSString stringWithFormat:@"%d",i]]];

                //perform the request and collect the response
                NSData *data = [NSData dataWithContentsOfURL:URL];
                //parse and process the server reply
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

                xkcd_comic *newComic = [[xkcd_comic alloc] init];

                newComic.title = json[@"safe_title"];
                newComic.num = [[json objectForKey:@"num"] intValue];
                newComic.alt = json[@"alt"];
                newComic.img = json[@"img"];
                
                if(![comics.comicList containsObject:newComic])
                {
                    [comics.comicList addObject:newComic];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [self.tableView reloadData];
        });
    });
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
        [self getPreviousComics:20];
}

@end
