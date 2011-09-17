//
//  TapkuTestViewController.m
//  TapkuTest
//
//  Created by Mori Hidetoshi on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TapkuTestViewController.h"

#import <EventKit/EventKit.h>

@implementation TapkuTestViewController

@synthesize dataArray, dataDictionary;




- (void) viewDidLoad{
	[super viewDidLoad];
//	[self.monthView selectDate:[NSDate month]];
    
}

- (void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
//    [dateFormatter setDateFormat:@"dd.MM.yy"]; 
//    NSDate *d = [dateFormatter dateFromString:@"02.05.11"]; 
//    [dateFormatter release];
//    
//    [self.monthView selectDate:d];
	
	/*
     TKDateInformation info = [[NSDate date] dateInformation];
     //info.year += 1;
     info.month = 3;
     info.day = 25;
     NSDate *d = [NSDate dateFromDateInformation:info];
     [self.monthView selectDate:d];
     */
	
}

- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{

    LOG_CURRENT_METHOD;
    
	[self generateRandomDataForStartDate:startDate endDate:lastDate];
	return dataArray;
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	
    LOG_CURRENT_METHOD;

	// CHANGE THE DATE TO YOUR TIMEZONE
	TKDateInformation info = [date dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *myTimeZoneDay = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone systemTimeZone]];
	
	NSLog(@"Date Selected: %@",myTimeZoneDay);
	
	[self.tableView reloadData];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
    
    LOG_CURRENT_METHOD;

	[super calendarMonthView:mv monthDidChange:d animated:animated];
	[self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    LOG_CURRENT_METHOD;

	return 1;
	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
    
    LOG_CURRENT_METHOD;

	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LOG_CURRENT_METHOD;

    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    
	
    
	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
	cell.textLabel.text = [ar objectAtIndex:indexPath.row];
	
    return cell;
	
}


- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
    LOG_CURRENT_METHOD;
    
    EKEventStore *eventStore = [[[EKEventStore alloc] init] autorelease];
    EKCalendar *cal = [eventStore defaultCalendarForNewEvents];

    NSPredicate *p = [eventStore predicateForEventsWithStartDate:start endDate:end calendars:[NSArray arrayWithObject:cal]];
    NSArray *events = [eventStore eventsMatchingPredicate:p];
	
	NSLog(@"Delegate Range: %@ %@ %d",start,end,[start daysBetweenDate:end]);
	
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
	
	NSDate *d = start;
	while(YES){
		
        BOOL exist = NO;
        for (EKEvent *e in events) {
            if ([d isSameDay:e.startDate]) {
                
                NSMutableArray *array = [self.dataDictionary objectForKey:d];
                if (!array) {
                    array = [NSMutableArray array];
                }
                [self.dataDictionary setObject:array forKey:d];
                [array addObject:e.title];
                exist = YES;
            }
        }
        [self.dataArray addObject:[NSNumber numberWithBool:exist]];
        
//		int r = arc4random();
//		if(r % 3==1){
//			[self.dataDictionary setObject:[NSArray arrayWithObjects:@"Item one",@"Item two",nil] forKey:d];
//			[self.dataArray addObject:[NSNumber numberWithBool:YES]];
//			
//		}else if(r%4==1){
//			[self.dataDictionary setObject:[NSArray arrayWithObjects:@"Item one",nil] forKey:d];
//			[self.dataArray addObject:[NSNumber numberWithBool:YES]];
//			
//		}else
//			[self.dataArray addObject:[NSNumber numberWithBool:NO]];
		
		
		TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		info.day++;
		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		if([d compare:end]==NSOrderedDescending) break;
	}
	
}


@end
