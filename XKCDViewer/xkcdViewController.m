//
//  xkcdViewController.m
//  XKCDViewer
//
//  Created by Kyle Rota on 10/3/13.
//  Copyright (c) 2013 Kyle Rota. All rights reserved.
//

#import "xkcdViewController.h"

@interface xkcdViewController ()
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@implementation xkcdViewController

- (void)setCurrentComic:(xkcd_comic*)comic
{
    if (_currentComic != comic)
    {
        _currentComic = comic;
        
        // Update the view.
        [self displayComic];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.scrollView.minimumZoomScale = 0.43;
    self.scrollView.maximumZoomScale = 6.0;
    self.scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayComic
{
    //configure the spinner
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_currentComic.img]]];
        if ( image == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            _navBar.title = _currentComic.title;
            _comicView.image = image;
            _comicView.contentMode = UIViewContentModeCenter;
            [_comicView sizeToFit];
            
            _scrollView.contentSize = _comicView.image.size;
            
            if(image.size.width < _screenWidth)
            {
                int horizontalOffset = (_screenWidth - image.size.width)/2;
                _comicView.frame = CGRectMake(horizontalOffset,0,image.size.width,image.size.height);
                _scrollView.zoomScale = 1;
            }
            else if(_screenWidth/image.size.width >= _scrollView.minimumZoomScale)
            {
                _scrollView.zoomScale = _screenWidth/image.size.width;
            }
            else
            {
                _scrollView.zoomScale = _scrollView.minimumZoomScale;
            }
        });
    dispatch_async(dispatch_get_main_queue(), ^{
        [spinner stopAnimating];
    });

    _comicView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAltText:)];
    [_comicView addGestureRecognizer:tapRecognizer];
}

-(void)showAltText:(id)sender
{
    UIAlertView *altText = [[UIAlertView alloc] initWithTitle:@"" message:_currentComic.alt delegate:self cancelButtonTitle:@"Return" otherButtonTitles: nil];
    [altText show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [alertView cancelButtonIndex])
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.comicView;
}

@end
