//
//  ViewController.m
//  iosPhoto
//
//  Created by XING Lei on 02/03/2016.
//  Copyright (c) 2016 XING Lei. All rights reserved.
//

#import "ViewController.h"
#import "Shiba.h"
#import "ShibaView.h"
#import "ShibaCellTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ShibaDelegate>

@property (weak, nonatomic) IBOutlet UIButton *shibaButton;
@property(nonatomic,strong) NSMutableArray *datasource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) Firebase *ref;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *shibaButton;
    shibaButton.layer.cornerRadius = 30;
    shibaButton.layer.borderWidth = 2;
    shibaButton.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:122.0/255.0 blue:63.0/255.0 alpha:1].CGColor;
    shibaButton.clipsToBounds = YES;
    
    
    self.title = @"Shibagram";
    
    self.datasource = [NSMutableArray array];
    
    [self requestsShibas];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

//LOAD DATA URL
- (void)requestsShibas {
    [self.activityIndicator startAnimating];
    // Get a reference to our posts
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://torrid-torch-679.firebaseio.com/ios/shibagram/shibas"];
    // Retrieve new posts as they are added to the database
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        Shiba *shiba = [[Shiba alloc] initWithUUID:snapshot.key imgURL:snapshot.value[@"imgURL"] likes:snapshot.value[@"likes"] dislikes:snapshot.value[@"dislikes"] description:snapshot.value[@"description"]];
        [self.datasource addObject:shiba];
        
    }];
    
    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"reload : %lu",(unsigned long)self.datasource.count);
        [self.tableView reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.activityIndicator.hidden = YES;
            self.tableView.alpha = 1;
        }];
        
    }];
  
}

- (IBAction)likeAction:(UIButton *)sender {

    
}

- (IBAction)dislikeAction:(id)sender {
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    ShibaCellTableViewCell *cell =(ShibaCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Shiba *shiba = self.datasource[indexPath.row];
    cell.LikesLabel.text = [NSString stringWithFormat:@"%@ likes", shiba.likes];
    cell.DislikesLabel.text = [NSString stringWithFormat:@"%@ dislikes", shiba.dislikes];
    cell.CaptionLabel.text = [NSString stringWithFormat:@"%@", shiba.caption];
    
//        cell.ImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:shiba.imgURL]]];
//    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:shiba.imgURL] placeholderImage:[UIImage imageNamed:@"shiba-overlay.png"]];
    UIImage *shibaImg = [self decodeBase64ToImage:[NSString stringWithFormat:@"%@", shiba.imgURL]];
    NSLog(@"%@ shibaImg", shibaImg);
    cell.ImageView.image = [self decodeBase64ToImage:[NSString stringWithFormat:@"%@", shiba.imgURL]];
    
    return cell;
    
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSLog(@"%@ --------- Data", data);
    return [UIImage imageWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (IBAction)shibaAction:(UIStoryboardSegue*)segue {
    ShibaView* sv = [self.storyboard instantiateViewControllerWithIdentifier:@"shibaView"];
    sv.delegate = self;
    [self.navigationController presentViewController:sv animated:YES completion:nil];
}
*/
- (IBAction)shibaDone:(UIStoryboardSegue*)segue {
    ShibaView* shibaView = (ShibaView*)segue.sourceViewController;
    [shibaView validate];
}


- (void)shibaDidEnd{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
