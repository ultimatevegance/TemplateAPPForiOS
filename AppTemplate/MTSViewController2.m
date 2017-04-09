//
//  MTSViewController2.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSViewController2.h"
#import "Common.h"
#import "YYWebImage.h"
#import "MTSDesingerCollectionViewCell.h"
#import "MTSProjectTableViewCell.h"
#import "MTSBannerView.h"
static  NSString *cellId = @"MTSProjectTableViewCell";
static  NSString *bannerCellId = @"HeaderBannerCell";
static  NSString *designerCellId = @"DesignerCell";
static  NSString *designersCollectionViewId = @"Designers";

@interface MTSViewController2 ()       
@property (weak, nonatomic) IBOutlet UITableView *wrapperTableView;
@property (strong, nonatomic)  UICollectionView *designersCollectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) iCarousel *_carouselView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MTSViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"LAB";
    [self setupUI];
    //UITableView
    self.wrapperTableView.dataSource =  self;
    self.wrapperTableView.delegate = self;
    [self.wrapperTableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    [self.wrapperTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:bannerCellId];
    [self.wrapperTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:designersCollectionViewId];
//    self.wrapperTableView.estimatedRowHeight = 461.5;
    self.wrapperTableView.rowHeight = UITableViewAutomaticDimension;
    [self.wrapperTableView setNeedsLayout];
    [self.wrapperTableView layoutIfNeeded];

    
}

- (void)setupUI{
    //Carousel
    _items = [NSMutableArray arrayWithObjects:@"giphy.gif",@"giphy-2.gif",@"source.gif",@"giphy-4.gif",@"testImage5", nil];
    __carouselView = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.35)];
    __carouselView.delegate = self;
    __carouselView.dataSource = self;
    __carouselView.type = iCarouselTypeRotary;
    __carouselView.pagingEnabled = YES;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    _pageControl.center = CGPointMake(kScreenWidth / 2, CGRectGetHeight(__carouselView.frame) - 20);
    _pageControl.numberOfPages = __carouselView.numberOfItems;
    [__carouselView addSubview:_pageControl];
    //designers Collection View
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.designersCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake (0, 0, kScreenWidth, kScreenHeight * 0.27)collectionViewLayout:layout2];
    self.designersCollectionView.delegate = self;
    self.designersCollectionView.dataSource = self;
    self.designersCollectionView.pagingEnabled = YES;
    self.designersCollectionView.showsHorizontalScrollIndicator = NO;
    self.designersCollectionView.backgroundColor = [UIColor colorWithHexString:@"1A1720"];
    [self.designersCollectionView registerNib:[UINib nibWithNibName:@"MTSDesingerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:designerCellId];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       if (indexPath.section == 0) {
        UITableViewCell *bannerCell = [self.wrapperTableView dequeueReusableCellWithIdentifier:bannerCellId forIndexPath:indexPath];
        if (! __carouselView.superview) {
            [bannerCell addSubview:__carouselView];
        }
        return bannerCell;
    } else if (indexPath.section == 1) {
        UITableViewCell *designersCell = [self.wrapperTableView dequeueReusableCellWithIdentifier:designersCollectionViewId forIndexPath:indexPath];
        [designersCell addSubview:self.designersCollectionView];
        return designersCell;
    } else {
      MTSProjectTableViewCell *cell = [self.wrapperTableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        return cell;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    } else {
        return 12;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return __carouselView.frame.size.height;
    } else if (indexPath.section == 1) {
        return self.designersCollectionView.frame.size.height ;
    }
    else {
        return 446;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
        return 50;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    titleView.backgroundColor = [UIColor colorWithHexString:@"1A1720"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.frame];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Futura-Bold" size:20]];
    [titleLabel setTextColor:[UIColor whiteColor]];      
    [titleView addSubview:titleLabel];
    if (section == 1) {
        titleLabel.text = @"Popular Designers";
    } else if (section == 2) {
        titleLabel.text = @"Trending Projects";
    } else {
        titleLabel.text = @"";
    }
    return titleView;
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTSDesingerCollectionViewCell *designerCell = [self.designersCollectionView dequeueReusableCellWithReuseIdentifier:designerCellId forIndexPath:indexPath];
    return designerCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
    
}
#pragma mark - UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger cellHeight =  self.designersCollectionView.bounds.size.height ;
    NSInteger cellWidth = cellHeight * 0.78;
        return CGSizeMake(cellWidth, cellHeight);

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
            return CGSizeZero;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
       return UIEdgeInsetsZero;
}

#pragma mark - Carousel

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (view == nil) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 50)];
//        label.numberOfLines = 0;
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor whiteColor];
//        label.text = @"WHAT IF THEY FAILED YOUR EXPECTATION?";
//        view = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, carousel.frame.size.height)];
//        label.center = view.center;
//        [view addSubview:label];
////        ((UIImageView *)view).image = [UIImage imageNamed:_items[index]];
//        [((YYAnimatedImageView *)view) yy_setImageWithURL:[NSURL URLWithString:@"http://img.tuboshu.com/images/article/201409/23/1906/00/201409231906007365_600.gif"] options:YYWebImageOptionProgressive]; ;
//        view.contentMode = UIViewContentModeScaleAspectFill;
        MTSBannerView *bannerView = [[[NSBundle mainBundle] loadNibNamed:@"BannerView" owner:self options:nil] lastObject];
        view = bannerView;
        
    }
    return view;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _items.count;
}

-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    _pageControl.currentPage = __carouselView.currentItemIndex;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.3;
    }
    return value;
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
