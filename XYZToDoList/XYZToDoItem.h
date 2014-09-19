//
//  XYZToDoItem.h
//  XYZToDoList
//
//  Created by vectorliu on 14-9-19.
//
//

#import <Foundation/Foundation.h>

@interface XYZToDoItem : NSObject

@property NSString * itemName;
@property BOOL completed;
@property (readonly) NSDate * creationDate;

@end
