//
//  TapkuTestViewController.h
//  TapkuTest
//
//  Created by Mori Hidetoshi on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>

@interface TapkuTestViewController : TKCalendarMonthTableViewController {
    NSMutableArray *dataArray; 
	NSMutableDictionary *dataDictionary;
}
@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;

- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;


@end
