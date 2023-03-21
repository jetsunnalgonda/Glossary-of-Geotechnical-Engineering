//
//  HLKFirstViewController.h
//  Glossary of Geotechnical Engineering
//
//  Created by Haluk Isik on 03/05/14.
//  Copyright (c) 2014 Haluk Isik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLKFirstViewController : UIViewController
@property (nonatomic, strong) NSArray *terms;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
