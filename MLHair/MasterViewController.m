//
//  MasterViewController.m
//  HelloMyRSSReader
//
//  Created by sammi on 2017/6/19.
//  Copyright © 2017年 sammi. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Reachability.h"
#import "RSSParserDelegate.h"

@interface MasterViewController ()
{
    Reachability *serverReach;
}

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton; */
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    //Prepare serverReach
    serverReach = [Reachability reachabilityWithHostName:@"style.udn.com"];
    //serverReach = [Reachability reachabilityForInternetConnection];//檢查有沒有網路不針對哪個主機
    
    //下面是網路連線自動獲得通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged) name:kReachabilityChangedNotification object:nil];
    [serverReach startNotifier];
    
    
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


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NewsItem *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (IBAction)refreshTriggered:(id)sender {
    [self downloadNewsList];
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



@end
