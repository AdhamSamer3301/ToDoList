//
//  ProgressViewController.h
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgressViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MyProtocol>

//@property id<MyProtocol> pG;
//@property Task *tkP;
@property NSMutableArray *tasksP;

- (void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray;
- (NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString *)keyName;
- (void)reload;

//-(void)addTaskP:(Task*) tkP;

@end

NS_ASSUME_NONNULL_END
