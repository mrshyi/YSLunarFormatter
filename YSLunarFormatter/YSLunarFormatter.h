#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSLunarFormatter : NSObject

- (NSString *)lunarDayStringFromDate:(NSDate *)date;
- (NSString *)lunarYearStringFromDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
