//
//  Owner+CoreDataProperties.h
//  Assessment3
//
//  Created by Richard Martin on 2016-01-29.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Owner.h"

NS_ASSUME_NONNULL_BEGIN
@class Cat;

@interface Owner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *ownername;
@property (nullable, nonatomic, retain) NSSet<Cat *> *cats;

@end

@interface Owner (CoreDataGeneratedAccessors)

- (void)addCatsObject:(Cat *)value;
- (void)removeCatsObject:(Cat *)value;
- (void)addCats:(NSSet<Cat *> *)values;
- (void)removeCats:(NSSet<Cat *> *)values;

@end

NS_ASSUME_NONNULL_END
