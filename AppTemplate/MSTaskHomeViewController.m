//
//  MSTaskHomeViewController.m
//  AppTemplate
//
//  Created by Monster on 08/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSTaskHomeViewController.h"
#import "MSCalendarViewController.h"
#import "MSArchivedTasksViewController.h"
#import "TableViewCell.h"

@interface MSTaskHomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *mTaskCellID = @"TableViewCell";

@implementation MSTaskHomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"home_s"]];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        //navigation items configuration
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(calendar:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"safebox"] style:UIBarButtonItemStylePlain target:self action:@selector(safebox:)];
    }
    
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"TASKS";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:mTaskCellID bundle:nil] forCellReuseIdentifier:mTaskCellID];
    _tableView.estimatedRowHeight = 150;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
}

- (void)calendar:(UIBarButtonItem *)sender {
    MSCalendarViewController *calendarVC = [[MSCalendarViewController alloc] init];
    [self.navigationController pushViewController:calendarVC animated:YES];
}

- (void)safebox:(UIBarButtonItem *)sender {
    MSArchivedTasksViewController *archivedTaskVC = [[MSArchivedTasksViewController alloc] init];
    [self.navigationController pushViewController:archivedTaskVC animated:YES];
}

#pragma mark UITableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *taskCell = [_tableView dequeueReusableCellWithIdentifier:mTaskCellID forIndexPath:indexPath];
    taskCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return taskCell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"TODAY";
    }
    if (section == 1) {
        return @"MONDAY";
    }

    if (section == 2) {
        return @"TUESDAY";
    }
    else {
        return @"";
    }
    
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
