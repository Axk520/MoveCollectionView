//
//  ViewController.m
//  MoveCollectionView
//
//  Created by 66-admin on 2017/3/17.
//  Copyright © 2017年 66rpg. All rights reserved.
//

#import "ViewController.h"
#import "CustomTopCell.h"
#import "UIView+Extension.h"
#import "CustomMoveView.h"
#import "CGControl.h"
#import "UIColor+Extensions.h"

#define ViewToXWidth    6.f
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, OrgMoveCellCollectionViewDataSource,OrgMoveCellCollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    CGFloat     sureBtnHeight;
    CGFloat     itemCellHeight;
}
@property (nonatomic, strong) NSMutableArray    *   topDataArray;
@property (nonatomic, strong) NSMutableArray    *   bottomDataArray;
@property (nonatomic, strong) CustomMoveView    *   collectionView;

@property (nonatomic, strong) UILabel           *   topTitleLabel;
@property (nonatomic, strong) UILabel           *   topdetailLabel;
@property (nonatomic, strong) UILabel           *   bottomTitleLabel;
@property (nonatomic, strong) NSDictionary      *   customDataDict;
@property (nonatomic, strong) UIButton          *   exitButton;

@end

static NSString * const TopCellId       = @"TopCellId";
static NSString * const BottomCellId    = @"BottomCellId";
static NSString * const TopHeaderId     = @"TopHeaderId";
static NSString * const BottomHeaderId  = @"BottomHeaderId";

@implementation ViewController

- (UIButton *)exitButton {
    
    if (_exitButton == nil) {
        _exitButton = [CGControl createButtonWithFrame:CGRectZero title:nil imageName:@"close_write.png" bgImageName:nil target:self method:@selector(exitButton:)];
        _exitButton.backgroundColor = [UIColor clearColor];
        _exitButton.layer.masksToBounds = YES;
    }
    return _exitButton;
}

- (UILabel *)topTitleLabel {
    
    if (_topTitleLabel == nil) {
        _topTitleLabel = [CGControl createLabelWithFrame:CGRectZero font:15.0 text:@"已定制"];
        _topTitleLabel.textColor = [UIColor colorWithHexString:@"#2e2f31"];
        _topTitleLabel.backgroundColor = [UIColor clearColor];
    }
    return _topTitleLabel;
}

- (UILabel *)topdetailLabel {
    
    if (_topdetailLabel == nil) {
        _topdetailLabel = [CGControl createLabelWithFrame:CGRectZero font:12.0 text:@"长按拖拽可编辑标签顺序"];
        _topdetailLabel.textColor = [UIColor colorWithHexString:@"#9fa1a5"];
        _topdetailLabel.backgroundColor = [UIColor clearColor];
    }
    return _topdetailLabel;
}

- (UILabel *)bottomTitleLabel {
    
    if (_bottomTitleLabel == nil) {
        _bottomTitleLabel = [CGControl createLabelWithFrame:CGRectZero font:15.0 text:@"未定制"];
        _bottomTitleLabel.textColor = [UIColor colorWithHexString:@"#2e2f31"];
        _bottomTitleLabel.backgroundColor = [UIColor clearColor];
    }
    return _bottomTitleLabel;
}

- (NSDictionary *)customDataDict {

    if (_customDataDict == nil) {
        NSString * customPath = [[NSBundle mainBundle] pathForResource:@"custom" ofType:@"plist"];
        _customDataDict = [NSDictionary dictionaryWithContentsOfFile:customPath];
    }
    return _customDataDict;
}

- (NSMutableArray *)topDataArray {
    
    if (_topDataArray == nil) {
        NSArray * not_customArr = [self.customDataDict objectForKey:@"user_custom"];
        _topDataArray = [NSMutableArray arrayWithArray:not_customArr];
    }
    return _topDataArray;
}

- (NSMutableArray *)bottomDataArray {
    
    if (_bottomDataArray == nil) {
        NSArray * user_customArr = [self.customDataDict objectForKey:@"not_custom"];
        _bottomDataArray = [NSMutableArray arrayWithArray:user_customArr];
    }
    return _bottomDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f6f8"];
    
    sureBtnHeight  = 48.f;
    itemCellHeight = 50.f;
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize                 = CGSizeMake((ScreenWidth - ViewToXWidth * 2) / 3.0, itemCellHeight);
    flowLayout.sectionInset             = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    flowLayout.minimumLineSpacing       = 0.f;
    flowLayout.minimumInteritemSpacing  = 0.f;
    
    self.collectionView = [[CustomMoveView alloc]initWithFrame:CGRectMake(ViewToXWidth, 20.f, ScreenWidth - ViewToXWidth * 2.0, ScreenHeight - sureBtnHeight - 20.f) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f5f6f8"];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.orgDelegate     = self;
    self.collectionView.orgDataSource   = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CustomTopCell    class] forCellWithReuseIdentifier:TopCellId];
    [self.collectionView registerClass:[CustomBottomCell class] forCellWithReuseIdentifier:BottomCellId];
    
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:TopHeaderId];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:BottomHeaderId];
    
    CGFloat btnFontSize = 15.f;
    UIButton * sureBtn  = [CGControl createButtonWithFrame:CGRectMake(0, ScreenHeight - sureBtnHeight, ScreenWidth, sureBtnHeight) title:@"完 成" imageName:nil bgImageName:nil target:self method:@selector(sureButton:)];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#ffac28" alpha:1.0];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
}

- (void)sureButton:(UIButton *)button {
    
    NSLog(@"---*** 确定以后的操作 ***---");
}

- (void)exitButton:(UIButton *)button  {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return  self.topDataArray.count;
    }else {
        return self.bottomDataArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        CustomTopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TopCellId forIndexPath:indexPath];
        [cell refreshCustomTopCellWithData:[self.topDataArray objectAtIndex:indexPath.row]];
        return cell;
    }else {
        CustomBottomCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:BottomCellId forIndexPath:indexPath];
        [cell refreshCustomBottomCellWithData:[self.bottomDataArray objectAtIndex:indexPath.row]];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(ScreenWidth, 45.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(ScreenWidth, 0.f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (self.topDataArray.count > 1) {
            NSDictionary * dict = [self.topDataArray objectAtIndex:indexPath.row];
            NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:1];
            [self.topDataArray    removeObjectAtIndex:indexPath.row];
            [self.bottomDataArray insertObject:dict atIndex:0];
            [UIView animateWithDuration:0.3 animations:^{
                [collectionView moveItemAtIndexPath:indexPath toIndexPath:index];
                [self.collectionView reloadItemsAtIndexPaths:@[index]];
            }];
        }else {
            UIAlertView * pView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定制化标签要留一个哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [pView show];
        }
    }else {
        
        if (self.topDataArray.count < 9) {
            NSDictionary * dict = [self.bottomDataArray objectAtIndex:indexPath.row];
            NSIndexPath * index = [NSIndexPath indexPathForRow:self.topDataArray.count inSection:0];
            [self.bottomDataArray removeObjectAtIndex:indexPath.row];
            [self.topDataArray    addObject:dict];
            [UIView animateWithDuration:0.3 animations:^{
                [collectionView moveItemAtIndexPath:indexPath toIndexPath:index];
                [self.collectionView reloadItemsAtIndexPaths:@[index]];
            }];
        }else {
            UIAlertView * pView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"自定义定制化标签的上限是9个哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [pView show];
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView * reusableView = nil;
    if([kind isEqual:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            
            UICollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:TopHeaderId forIndexPath:indexPath];
            [headView addSubview:self.topTitleLabel];
            [headView addSubview:self.topdetailLabel];
            [headView addSubview:self.exitButton];
            self.topTitleLabel.frame  = CGRectMake(ViewToXWidth, 20.f, 60.f, headView.org_h - 30.f);
            self.topdetailLabel.frame = CGRectMake(_topTitleLabel.org_x + _topTitleLabel.org_w, _topTitleLabel.org_y + 2.f, 150.f, self.topTitleLabel.org_h);
            self.exitButton.frame     = CGRectMake(ScreenWidth - 44.f, 18.f, 14.f, 14.f);
            reusableView = headView;
        }else {
            
            UICollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:BottomHeaderId forIndexPath:indexPath];
            [headView addSubview:self.bottomTitleLabel];
            self.bottomTitleLabel.frame = CGRectMake(ViewToXWidth, 0.f, 60.f, headView.org_h);
            reusableView = headView;
        }
    }
    return reusableView;
}

- (void)collectionView:(CustomMoveView *)collectionView newArrayDataForDataSource:(NSArray *)newArray {
    
    self.topDataArray = [NSMutableArray arrayWithArray:newArray];
}

- (NSArray *)originalArrayDataForCollectionView:(CustomMoveView *)CollectionView {
    
    return self.topDataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
