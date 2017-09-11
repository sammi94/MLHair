//
//  NewsTVC.m
//  MLHair
//
//  Created by Ｍasqurin on 2017/9/11.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "NewsTVC.h"
#import "Reachability.h"
#import "RSSParserDelegate.h"
#import "DetailViewController.h"

@interface NewsTVC ()
{
    Reachability *serverReach;
}
@property NSMutableArray *objects;

@end

@implementation NewsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    serverReach = [Reachability reachabilityWithHostName:@"style.udn.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged) name:kReachabilityChangedNotification object:nil];
    [serverReach startNotifier];
    
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *dVC = [self.storyboard instantiateViewControllerWithIdentifier:@"dVC"];
    dVC.detailItem = _objects[indexPath.row];
    [self.navigationController pushViewController:dVC animated:true];
    
}

-(void) networkStatusChanged{
    
    NetworkStatus status = [serverReach currentReachabilityStatus];
    
    if(status == NotReachable){
        NSLog(@"Network is not reachable.");
    }else{
        NSLog(@"Network is reachable with: %ld",status);
        [self downloadNewsList];//切換到有網路就刷新
    }
    
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NewsItem *item = self.objects[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.pubDate;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void) downloadNewsList{
    
    //Check network status
    if([serverReach currentReachabilityStatus] == NotReachable){
        //Maybe show some hint to user...
        [self.tableView.refreshControl endRefreshing];//沒網路一拉收起來
        return;
    }
    
    //Download RSS Feed.
    NSString *urlString = @"https://style.udn.com/rss/news/2002/8054/8403?ch=style";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //End the refreshing.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.refreshControl endRefreshing];
        });
        
        if (error) {
            NSLog(@"Download Fail: %@",error.description);
            return ;
        }
        //下面兩行除錯用
        NSString *xmlContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"XML Content: %@",xmlContent);
        
        //Parse XML Content.
        NSXMLParser * parser = [[NSXMLParser alloc] initWithData:data];
        RSSParserDelegate *parserDelegate = [RSSParserDelegate new];
        parser.delegate = parserDelegate;
        
        if ([parser parse]) {
            NSLog(@"parse OK.");
            
            _objects =[NSMutableArray arrayWithArray:[parserDelegate getResults]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            NSLog(@"Parse Fail.");
        }
        
    }];
    [task resume];
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
