//
//  MTSViewController2.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSViewController2.h"
#import "Common.h"
#import "CollectionViewCell.h"
#import "YYWebImage.h"
static  NSString *cellId = @"CollectionViewCell";
static  NSString *bannerCellId = @"HeaderBannerCell";
static  NSInteger cellMargin = 10;

@interface MTSViewController2 ()       
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) iCarousel *_carouselView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MTSViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"LAB";
    //UICollectionView
    self.collectionView.dataSource =  self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:bannerCellId];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
    
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
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UICollectionViewCell *bannerCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:bannerCellId forIndexPath:indexPath];
        if (! __carouselView.superview) {
            [bannerCell addSubview:__carouselView];
        }
        return bannerCell;
        } else {
        CollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        return cell;
 
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 12;
    }
}
#pragma mark - UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return __carouselView.frame.size;
    } else {
        NSInteger cellWidth = (kScreenWidth - cellMargin * 3) / 2;
        NSInteger cellHeight = cellWidth;
        return CGSizeMake(cellWidth, cellHeight);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
            return CGSizeZero;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }
    return UIEdgeInsetsMake(0, cellMargin, 0, cellMargin);
}

#pragma mark - Carousel

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (view == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 50)];
        label.numberOfLines = 2;
        [label setFont:[UIFont systemFontOfSize:20 weight:20]];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"What If They Failed Your Expectations?";
        view = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, carousel.frame.size.height)];
        label.center = view.center;
        [view addSubview:label];
//        ((UIImageView *)view).image = [UIImage imageNamed:_items[index]];
        [((YYAnimatedImageView *)view) yy_setImageWithURL:[NSURL URLWithString:@"https://media.giphy.com/media/l0Iy5QIKUH5pN4rJu/giphy.gif"] options:YYWebImageOptionProgressive]; ;
        view.contentMode = UIViewContentModeScaleAspectFill;
        
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
