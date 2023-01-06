//
//  MyProtocol.h
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MyProtocol <NSObject>

-(void) addTask:(Task*) tk;
-(void) editTask:(Task*) tkE;

@end

NS_ASSUME_NONNULL_END
