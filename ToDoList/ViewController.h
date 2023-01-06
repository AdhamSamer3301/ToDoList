//
//  ViewController.h
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import <UIKit/UIKit.h>

#import "MyProtocol.h"
@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol,UISearchBarDelegate>

@property NSMutableArray *tasks;
@property NSArray *tasksTodo;
@property NSUserDefaults *userDef;
@property NSMutableArray *filteredTasks;
@property BOOL isFiltered;
-(void)reload;

-(void)writeArrayWithCustomObjToUserDefaults:(NSString*)keyName withArray:(NSMutableArray*)myArray;
-(NSArray*)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName;

@end

