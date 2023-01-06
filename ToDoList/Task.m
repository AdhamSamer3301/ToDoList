//
//  Task.m
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import "Task.h"

@implementation Task

- (void)setName:(NSString *)name withDescription:(NSString *)description andDate:(NSDate *)date andPriority:(NSInteger)priority {
    [self setName:name];
    [self setDescrip:description];
    [self setDate:date];
    [self setPriority:priority];
    [self setStatus:0];
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_descrip forKey:@"description"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeInteger:_priority forKey:@"priority"];
    [coder encodeInteger:_status forKey:@"status"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];

    if (self != nil) {
        _name = [coder decodeObjectForKey:@"name"];
        _descrip = [coder decodeObjectForKey:@"description"];
        _date = [coder decodeObjectForKey:@"date"];
        _priority = [coder decodeIntegerForKey:@"priority"];
        _status = [coder decodeIntegerForKey:@"status"];
    }

    return self;
}

@end
