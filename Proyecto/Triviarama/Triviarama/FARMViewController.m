//
//  FARMViewController.m
//  Triviarama
//
//  Created by Rob on 22/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "FARMViewController.h"

@interface FARMViewController ()

@end

@implementation FARMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackgroundPantallaInicio.jpg"]];
    self.FarmWebVIew.delegate = self;
    [self loadSite];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) loadSite{
    NSString *aux = @"https://sites.google.com/site/farmcreditos/";
    NSURL *url = [NSURL URLWithString:aux];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.FarmWebVIew loadRequest:requestObj];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGSize contentSize = self.FarmWebVIew.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    self.FarmWebVIew.scrollView.minimumZoomScale = rw;
    self.FarmWebVIew.scrollView.maximumZoomScale = rw;
    self.FarmWebVIew.scrollView.zoomScale = rw;
    
    
}
@end
