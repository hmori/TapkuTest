//
//  TapkuTestAppDelegate.h
//  TapkuTest
//
//  Created by Mori Hidetoshi on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TapkuTestViewController;

@interface TapkuTestAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TapkuTestViewController *viewController;

@end
