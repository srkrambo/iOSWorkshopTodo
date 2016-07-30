//
//  Entity+CoreDataProperties.h
//  iOSWorkshopTodo
//
//  Created by Rajkumar S on 7/30/16.
//  Copyright © 2016 Eezy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *desc;

@end

NS_ASSUME_NONNULL_END
