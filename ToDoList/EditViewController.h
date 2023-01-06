//
//  EditViewController.h
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController

@property Task *tk;
@property id<MyProtocol> pE;
@property id<MyProtocol> pG;
@property id<MyProtocol> pD;
@end

NS_ASSUME_NONNULL_END
