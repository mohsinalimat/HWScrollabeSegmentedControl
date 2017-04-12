//
//  HWScrollableSegmentedControl.m
//  Pods
//
//  Created by HOMWAY on 12/04/2017.
//
//

#import "HWScrollableSegmentedControl.h"

static NSString *HWCollectionViewCellIdentifier = @"HWCollectionViewCell";
#define DefaultFont [UIFont systemFontOfSize:14]
#define DefaultItemWidth 44.0
#define DefaultIndicatorHeight 2
#define DefaultInidcatorColor [UIColor blackColor]

@interface HWCollectionViewFlowLayout : UICollectionViewFlowLayout

@end

@implementation HWCollectionViewFlowLayout

- (instancetype)init
{
	if (self = [super init])
	{
		self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		self.minimumLineSpacing = 0;
		self.minimumInteritemSpacing = 0;
	}
	
	return self;
}

@end

@interface HWCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation HWCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
		self.textLabel.font = DefaultFont;
		self.textLabel.textAlignment = NSTextAlignmentCenter;
		
		[self.contentView addSubview:self.textLabel];
	}
	
	return self;
}

@end

@interface HWScrollableSegmentedControl () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation HWScrollableSegmentedControl

- (instancetype)initWithItems:(NSArray<NSString *> *)items
{
	if (self = [super init])
	{
		self.backgroundColor = [UIColor whiteColor];
		self.items = [items mutableCopy];
//		self.momentary = NO;
		self.itemWidth = DefaultItemWidth;
		self.apportionsSegmentWidthsByContent = NO;
		self.selectedSegmentIndex = 0;
		self.indicatorHeight = DefaultIndicatorHeight;
		self.indicatorColor = DefaultInidcatorColor;
		
		HWCollectionViewFlowLayout *flowLayout = [[HWCollectionViewFlowLayout alloc] init];
		self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
		[self _initialCollectionView];
		
		self.indicator = [UIView new];
		self.indicator.backgroundColor = DefaultInidcatorColor;
		
		[self addSubview:self.collectionView];
		[self.collectionView addSubview:self.indicator];
	}
	
	return self;
}

#pragma mark - Private
- (void)layoutSubviews
{
	[super layoutSubviews];
	
	self.collectionView.frame = self.bounds;
	[self.collectionView reloadData];
}

- (void)setItems:(NSMutableArray *)items
{
	_numberOfSegments = items.count;
}

- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex
{
	selectedSegmentIndex = MAX(0, selectedSegmentIndex);
	selectedSegmentIndex = MIN(self.numberOfSegments - 1, selectedSegmentIndex);
	
	_selectedSegmentIndex = selectedSegmentIndex;
	[self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:selectedSegmentIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)_initialCollectionView
{
	[self.collectionView registerClass:[HWCollectionViewCell class]
			forCellWithReuseIdentifier:HWCollectionViewCellIdentifier];
	self.collectionView.backgroundColor = [UIColor clearColor];
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.showsHorizontalScrollIndicator = NO;
	
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	
	[self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)_scrollIndicatorToCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	CGRect cellFrame = cell.frame;
	NSString *text = self.items[indexPath.item];
	
	CGSize textSize = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : DefaultFont} context:nil].size;
	CGFloat indicatorWidth = ceil(textSize.width);
	
	CGSize indicatorSize = CGSizeMake(indicatorWidth, self.indicatorHeight);
	CGFloat originY = CGRectGetHeight(self.collectionView.bounds) - self.indicatorHeight;
	CGFloat originX = CGRectGetMinX(cellFrame) + (CGRectGetWidth(cellFrame) - indicatorWidth ) / 2;
	CGRect newFrame = CGRectMake(originX, originY, indicatorSize.width, indicatorSize.height);
	
	
	if (CGRectEqualToRect(self.indicator.frame, CGRectZero))
	{
		self.indicator.frame = newFrame;
	}
	else if (!CGRectEqualToRect(self.indicator.frame, newFrame))
	{
		[UIView animateWithDuration:0.3 animations:^{
			CGRect indicatorFrame = CGRectZero;
			indicatorFrame.size = indicatorSize;
			
			self.indicator.frame = newFrame;
		}];
	}
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	
	[self _scrollIndicatorToCell:[collectionView cellForItemAtIndexPath:indexPath]  atIndexPath:indexPath];
	self.selectedSegmentIndex = indexPath.item;
	
	if (self.target)
	{
		[self.target performSelector:self.selector withObject:self];
	}
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *text = self.items[indexPath.item];
	CGSize textSize = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : DefaultFont} context:nil].size;
	CGFloat contentWidth = ceil(textSize.width) + 30;
	
	CGFloat width = self.apportionsSegmentWidthsByContent ? MAX(contentWidth, self.itemWidth) : self.itemWidth;
	CGFloat height = CGRectGetHeight(collectionView.bounds);
	
	
	return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
	if (cell.isSelected && CGRectEqualToRect(self.indicator.frame, CGRectZero))
	{
		[self _scrollIndicatorToCell:cell  atIndexPath:indexPath];
	}
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	HWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HWCollectionViewCellIdentifier forIndexPath:indexPath];
	cell.textLabel.text = self.items[indexPath.item];
	cell.selected = (self.selectedSegmentIndex == indexPath.item);
	
	return cell;
}

#pragma mark - Public
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
	if (controlEvents & UIControlEventValueChanged)
	{
		self.target = target;
		self.selector = action;
	}
}

- (NSString *)titleForSegmentAtIndex:(NSUInteger)index
{
	if (index >= self.items.count)
	{
		return self.items.lastObject;
	}
	else
	{
		return self.items[MAX(0, index)];
	}
}


@end
