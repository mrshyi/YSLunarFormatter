#import "YSLunarFormatter.h"

@interface YSLunarFormatter ()

@property (strong, nonatomic) NSCalendar *chineseCalendar;
@property (strong, nonatomic) NSDateFormatter *formatter;
/** 农历日 */
@property (strong, nonatomic) NSArray<NSString *> *lunarDays;
/** 农历月 */
@property (strong, nonatomic) NSArray<NSString *> *lunarMonths;
/** 农历年 */
@property (strong, nonatomic) NSArray<NSString *> *lunarYears;

@end

@implementation YSLunarFormatter

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)lunarDayStringFromDate:(NSDate *)date
{
    NSInteger day = [self.chineseCalendar component:NSCalendarUnitDay fromDate:date];
    if (day != 1) {
        return self.lunarDays[day-2];
    }
    
    // First day of month
    NSString *monthString = [self.formatter stringFromDate:date];
    if ([self.chineseCalendar.veryShortMonthSymbols containsObject:monthString]) {
        return self.lunarMonths[monthString.integerValue - 1];
    }
    
    // Leap month
    NSInteger month = [self.chineseCalendar component:NSCalendarUnitMonth fromDate:date];
    monthString = [NSString stringWithFormat:@"闰%@", self.lunarMonths[month-1]];
    return monthString;
}

- (NSString *)lunarYearStringFromDate:(NSDate *)date {
    NSInteger year = [self.chineseCalendar component:NSCalendarUnitYear fromDate:date];
    return self.lunarYears[year - 1];
}

#pragma mark - lazy
- (NSArray<NSString *> *)lunarYears {
    if (!_lunarYears) {
        _lunarYears = @[@"甲子", @"乙丑", @"丙寅", @"丁卯", @"戊辰", @"己巳", @"庚午", @"辛未", @"壬申", @"癸酉",
                            @"甲戌", @"乙亥", @"丙子", @"丁丑", @"戊寅", @"己卯", @"庚辰", @"辛己", @"壬午", @"癸未",
                            @"甲申", @"乙酉", @"丙戌", @"丁亥", @"戊子", @"己丑", @"庚寅", @"辛卯", @"壬辰", @"癸巳",
                            @"甲午", @"乙未", @"丙申", @"丁酉", @"戊戌", @"己亥", @"庚子", @"辛丑", @"壬寅", @"癸丑",
                            @"甲辰", @"乙巳", @"丙午", @"丁未", @"戊申", @"己酉",  @"庚戌", @"辛亥", @"壬子", @"癸丑",
                            @"甲寅", @"乙卯", @"丙辰", @"丁巳", @"戊午", @"己未", @"庚申", @"辛酉",  @"壬戌", @"癸亥"];
    }
    return _lunarYears;
}

- (NSArray<NSString *> *)lunarMonths {
    if (!_lunarMonths) {
        _lunarMonths = @[@"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"冬月",@"腊月"];
    }
    return _lunarMonths;
}

- (NSArray<NSString *> *)lunarDays {
    if (!_lunarDays) {
        _lunarDays = @[@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                           @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",
                           @"廿十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",
                           @"三十"];
    }
    return _lunarDays;
}

- (NSCalendar *)chineseCalendar {
    if (!_chineseCalendar) {
        _chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    }
    return _chineseCalendar;
}

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.calendar = self.chineseCalendar;
        _formatter.dateFormat = @"M";
    }
    return _formatter;
}

@end
