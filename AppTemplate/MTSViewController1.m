//
//  MTSViewController1.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSViewController1.h"
#import "Common.h"
#import "TableViewCell.h"
#import "MTSDRShot.h"
#import "MSRereshGifHeader.h"
#import "HMSegmentedControl.h"

@interface MTSViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *columns;

@end

@implementation MTSViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.title = @"Home";
    self.tableView.dataSource  = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 461.5;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];
    MSRereshGifHeader *header = [MSRereshGifHeader headerWithRefreshingBlock:^{
        [self requestDataBySelectedIndex:self.segmentControl.selectedSegmentIndex];

            }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self requestDataBySelectedIndex:self.segmentControl.selectedSegmentIndex];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
 }

-  (void)setupUI {
    self.columns = [NSMutableArray arrayWithObjects:@"Trending",@"Popular",@"Gifs", nil];
    _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.columns];
    _segmentControl.backgroundColor = [UIColor clearColor];
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.frame = CGRectMake(0, 24, kScreenWidth, 40);
    _segmentControl.selectionIndicatorColor = [UIColor flatWhiteColor];
    _segmentControl.selectionIndicatorHeight = 2.0f;
    _segmentControl.selectedSegmentIndex = 0;
    [_segmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    _segmentControl.titleTextAttributes = @{
                                            NSForegroundColorAttributeName : [UIColor flatWhiteColorDark],
                                            NSFontAttributeName : [UIFont fontWithName:@"Advent Pro" size:18.5f]
                                            };
    _segmentControl.selectedTitleTextAttributes = @{
                                                    NSForegroundColorAttributeName : [UIColor flatWhiteColor],
                                                    NSFontAttributeName : [UIFont fontWithName:@"Advent Pro" size:20.0f]
                                                    };
    self.navigationItem.titleView = _segmentControl;
}

- (void)requestDataBySelectedIndex:(NSUInteger)selectedIndex {
    
    if (_segmentControl.selectedSegmentIndex == 0) {
        NSDictionary *params = @{
                                 @"sort"  : @"recent"
                                 };
        
        [self requestDataWithParam:params];
    } else if (_segmentControl.selectedSegmentIndex == 1) {
        NSDictionary *params = @{
                                 @"sort"  : @""
                                 };
        
        [self requestDataWithParam:params];
        
    } else if (_segmentControl.selectedSegmentIndex == 2) {
        NSDictionary *params = @{
                                 @"list"  : @"animated"
                                 };
        
        [self requestDataWithParam:params];
        
    }

}

- (void)requestDataWithParam:(NSDictionary  *)params   {
    [self.dataSource removeAllObjects];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [[MTSAPIClient sharedClient] loadShotsWithParams:params responseHandler:^(DRApiResponse *response) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView.mj_header endRefreshing];
            self.dataSource = [NSMutableArray array];
            for (DRShot *shotData in response.object) {
                [_dataSource addObject:shotData];
                [self.tableView reloadData];
            }
        }];
        
    });
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);

    [self requestDataBySelectedIndex:segmentedControl.selectedSegmentIndex];
}

#pragma mark -UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell  = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shotData = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

#pragma mark -ScrollView

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
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

@end
