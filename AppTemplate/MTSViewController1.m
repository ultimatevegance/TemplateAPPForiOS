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
@interface MTSViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation MTSViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    self.tableView.dataSource  = self;
    self.tableView.delegate = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [self requestData];
    }];
    [self requestData];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)requestData {
    NSDictionary *params = @{
                             @"sort"  : @"recent"
                             };
    
    [[MTSAPIClient sharedClient] loadShotsWithParams:params responseHandler:^(DRApiResponse *response) {
        self.dataSource = [NSMutableArray array];
        for (DRShot *shotData in response.object) {
            [_dataSource addObject:shotData];
            [self.tableView reloadData];
        }
    }];
    [self.tableView.mj_header endRefreshing];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell  = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.shotData = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DRShot *shotData = self.dataSource[indexPath.row];
    return [shotData.height floatValue];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tabBarController.tabBar setHidden:YES];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.tabBarController.tabBar setHidden:NO];
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
