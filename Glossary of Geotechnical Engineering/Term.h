//
//  Term.h
//  Glossary of Geotechnical Engineering
//
//  Created by Haluk Isik on 03/05/14.
//  Copyright (c) 2014 Haluk Isik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Term : NSManagedObject

@property (nonatomic, retain) NSString * definition;
@property (nonatomic, retain) NSString * name;

@end
