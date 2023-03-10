//
//  Task.h
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject

@property NSString *name;
@property NSString *descrip;
@property NSDate *date;
@property NSInteger priority;
@property NSInteger status;

@end

NS_ASSUME_NONNULL_END
