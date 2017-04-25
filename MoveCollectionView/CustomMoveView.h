//
//  CustomMoveView.h
//  Unity-iPhone
//
//  Created by 66-admin on 2017/1/20.
//
//

#import <UIKit/UIKit.h>

@class CustomMoveView;

@protocol OrgMoveCellCollectionViewDataSource <UICollectionViewDataSource>

@required
/** 将外部数据源数组传入，以便在移动cell数据发生改变时进行修改重排 */
- (NSArray *)originalArrayDataForCollectionView:(CustomMoveView *)CollectionView;

@end

@protocol OrgMoveCellCollectionViewDelegate <UICollectionViewDelegate>

@required
/** 将修改重排后的数组传入，以便外部更新数据源 */
- (void)collectionView:(CustomMoveView *)collectionView newArrayDataForDataSource:(NSArray *)newArray;

@optional
/** 选中的cell准备好可以移动的时候 */
- (void)collectionView:(CustomMoveView *)collectionView cellReadyToMoveAtIndexPath:(NSIndexPath *)indexPath;

/** 选中的cell正在移动，变换位置，手势尚未松开 */
- (void)cellIsMovingInCollectionVieww:(CustomMoveView *)CollectionView;

/** 选中的cell完成移动，手势已松开 */
- (void)cellDidEndMovingInCollectionView:(CustomMoveView *)CollectionView;

@end

@interface CustomMoveView : UICollectionView

@property (nonatomic, weak) id<OrgMoveCellCollectionViewDataSource> orgDataSource;
@property (nonatomic, weak) id<OrgMoveCellCollectionViewDelegate>   orgDelegate;

@end
