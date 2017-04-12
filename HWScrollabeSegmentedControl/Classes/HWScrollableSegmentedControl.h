//
//  HWScrollableSegmentedControl.h
//  Pods
//
//  Created by HOMWAY on 12/04/2017.
//
//


@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface HWScrollableSegmentedControl : UIView


/**
 Items are `NSString`s. Item is automatically sized to fit content

 @param items An array of NSString objects (for segment titles)
 */
- (instancetype)initWithItems:(NSArray<NSString *> *)items;


/**
 If set, then we don't keep showing selected state after tracking ends.
 Default is `NO`.
 */
//@property(nonatomic,getter=isMomentary) BOOL momentary;

@property(nonatomic) NSUInteger selectedSegmentIndex;


/**
 Returns the number of segments the receiver has.
 */
@property(nonatomic, readonly) NSUInteger numberOfSegments;

/**
 <#Description#>
 */
@property(nonatomic) CGFloat itemWidth;


/**
 The height of the indicator view, default is 2 points.
 */
@property(nonatomic) CGFloat indicatorHeight;


/**
 The color of the indicator view, default is black.
 */
@property(nonatomic, strong) UIColor *indicatorColor;

/**
 If the value of this property is YES, the control attempts to adjust segment widths based on their content widths.
 
 Default is `NO`.
 */
@property(nonatomic) BOOL apportionsSegmentWidthsByContent;


/**
 Associates a target object and action method with the control.You register the target-action methods for a scrollable segmented control using the UIControlEventValueChanged constant

 @param target The target object—that is, the object whose action method is called. If you specify nil, UIKit searches the responder chain for an object that responds to the specified action message and delivers the message to that object.
 
 @param action A selector identifying the action method to be called. You may specify a selector whose signature matches any of the signatures in UIControl. This parameter must not be nil.
 
 @param controlEvents A bitmask specifying the control-specific events for which the action method is called. Always specify at least one constant. For a list of possible constants, see UIControlEvents.
 */
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;


/**
 Returns the title of the specified segment.

 @param index An index number identifying a segment in the control. It must be a number between 0 and the number of segments (numberOfSegments) minus 1; values exceeding this upper range are pinned to it.
 @return Returns the string (title) assigned to the receiver as content.
 */
- (NSString *)titleForSegmentAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
