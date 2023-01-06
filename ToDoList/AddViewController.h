//
//  AddViewController.h
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController

//@property Task *tk;
@property id<MyProtocol> p;
@end

NS_ASSUME_NONNULL_END
