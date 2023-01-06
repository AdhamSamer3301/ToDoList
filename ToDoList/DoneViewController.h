//
//  DoneViewController.h
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol>

@property NSMutableArray *tasksD;
@property int lowCtr;
@property int medCtr;
@property int highCtr;
-(void)getCounters;
- (void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray;
- (NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString *)keyName;
- (void)reload;

@end

NS_ASSUME_NONNULL_END
