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
#import "NSStrinAdditions.h"

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
    
    UIImage *img = [UIImage imageNamed:@"shiba-logo.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    [imgView setImage:img];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.shibaButton.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    self.shibaButton.layer.cornerRadius = 50;
    self.shibaButton.layer.borderWidth = 5;
    self.shibaButton.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:122.0/255.0 blue:63.0/255.0 alpha:1].CGColor;
    self.shibaButton.clipsToBounds = YES;
    
    UIImageView *shibaIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiba-transparent"]];
    shibaIcon.frame = CGRectMake(15, 15, 70, 70);
    shibaIcon.contentMode=UIViewContentModeScaleAspectFill;
    [self.shibaButton addSubview:shibaIcon];
     
    self.datasource = [NSMutableArray array];
    
    [self requestsShibas];
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://torrid-torch-679.firebaseio.com/ios/shibagram/shibas"];
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {

        [self.tableView reloadData];
        self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
        
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

#pragma DATA LOADING


//LOAD DATA URL
- (void)requestsShibas {
    [self.activityIndicator startAnimating];
    // Get a reference to our posts
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://torrid-torch-679.firebaseio.com/ios/shibagram/shibas"];
    // Retrieve new posts as they are added to the database
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        Shiba *shiba = [[Shiba alloc] initWithUUID:snapshot.key imgURL:snapshot.value[@"imgURL"] likes:snapshot.value[@"likes"] dislikes:snapshot.value[@"dislikes"] dateTime:snapshot.value[@"dateTime"]];
        [self.datasource insertObject:shiba atIndex:0];

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

#pragma like/dislike Actions

- (IBAction)likeAction:(UIButton *)sender {
    
    ShibaCellTableViewCell *cell = (ShibaCellTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Shiba *shiba = self.datasource[indexPath.row];
    //     Get a reference to our posts
    
    Firebase *upvotesRef = [[Firebase alloc] initWithUrl: [NSString stringWithFormat:@"https://torrid-torch-679.firebaseio.com/ios/shibagram/shibas/%@/likes",shiba.uuid]];
    NSLog(@"LIKE : %@", shiba.uuid);
    [upvotesRef runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
        
        NSNumber *value = currentData.value;
        if (currentData.value == [NSNull null]) {
            value = 0;
        }
        [currentData setValue:[NSNumber numberWithInt:(1 + [value intValue])]];
        shiba.likes = [NSNumber numberWithInt:(1 + [value intValue])];
        [self.datasource replaceObjectAtIndex:indexPath.row withObject:shiba];
        return [FTransactionResult successWithValue:currentData];
    }];
    [self.tableView reloadData];

    
}

- (IBAction)dislikeAction:(UIButton *)sender {
    ShibaCellTableViewCell *cell = (ShibaCellTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Shiba *shiba = self.datasource[indexPath.row];
    //     Get a reference to our posts
    
    Firebase *upvotesRef = [[Firebase alloc] initWithUrl: [NSString stringWithFormat:@"https://torrid-torch-679.firebaseio.com/ios/shibagram/shibas/%@/dislikes",shiba.uuid]];
     NSLog(@"DISLIKE : %@", shiba.uuid);
    [upvotesRef runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
        NSNumber *value = currentData.value;
        if (currentData.value == [NSNull null]) {
            value = 0;
        }
        [currentData setValue:[NSNumber numberWithInt:(1 + [value intValue])]];
        shiba.dislikes = [NSNumber numberWithInt:(1 + [value intValue])];
        [self.datasource replaceObjectAtIndex:indexPath.row withObject:shiba];
        return [FTransactionResult successWithValue:currentData];
    }];
    [self.tableView reloadData];
    
    
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
    cell.LikesLabel.text = [NSString stringWithFormat:@"%@", shiba.likes];
    cell.DislikesLabel.text = [NSString stringWithFormat:@"%@", shiba.dislikes];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    [dateFormatter setDateFormat:@"EEE dd/MM/YYYY, HH:mm"];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:shiba.dateTime]];
    

    NSData *dataFromBase64=[[NSData alloc]initWithBase64EncodedString:shiba.imgURL options:NSDataBase64DecodingIgnoreUnknownCharacters];

    UIImage *image=[UIImage imageWithData:dataFromBase64];
    cell.ImageView.image =image;
    cell.ImageBgView.image =image;
    
    return cell;
    
}


- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shibaDone:(UIStoryboardSegue*)segue {
    ShibaView* shibaView = (ShibaView*)segue.sourceViewController;
    [shibaView validate];
}


- (void)shibaDidEnd{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
