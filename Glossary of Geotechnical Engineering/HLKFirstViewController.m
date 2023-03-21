//
//  HLKFirstViewController.m
//  Glossary of Geotechnical Engineering
//
//  Created by Haluk Isik on 03/05/14.
//  Copyright (c) 2014 Haluk Isik. All rights reserved.
//

#import "HLKFirstViewController.h"
#import "HLKSecondViewController.h"
#import <CoreData/CoreData.h>
#import "Term.h"

@interface HLKFirstViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIManagedDocument *document;

@end

@implementation HLKFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"Terms" ofType:@"plist"];
    //NSMutableArray* tmpArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    //self.dataList1 = tmpArray;
    
    /*
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 310.0, 44.0)];
    searchBarView.autoresizingMask = 0;
    searchBar.delegate = self;
    [searchBarView addSubview:searchBar];
    self.navigationItem.titleView = searchBarView;
    */
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory
    //                              ￼￼inDomains:NSUserDomainMask] firstObject];! NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    //label.font = [UIFont boldSystemFontOfSize: 14.0f];
    label.font = [UIFont fontWithName:@"Avenir" size:15.0f];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Glossary of\nGeotechnical Engineering";
    
    self.navigationItem.titleView = label;
    
    NSString *topicsPath = [[NSBundle mainBundle] pathForResource:@"Terms" ofType:@"plist"];

    self.document = [[UIManagedDocument alloc] initWithFileURL:[NSURL fileURLWithPath:topicsPath]];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:topicsPath];
    if (fileExists)
        [self.document openWithCompletionHandler:^(BOOL success) {
            /* block to execute when open */
            [self documentIsReady];
        }];
}

- (void)documentIsReady
{
    NSManagedObjectContext *context = self.document.managedObjectContext;
    NSError *error;
    
    NSFetchRequest *topicRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *topicEntityDescription = [NSEntityDescription entityForName:@"Term" inManagedObjectContext:context];
    [topicRequest setEntity:topicEntityDescription];
    Term *newTopic = nil;
    NSArray *topics = [context executeFetchRequest:topicRequest error:&error];
    if (error) NSLog(@"Error encountered in executing topic fetch request: %@", error);
    
    if ([topics count] == 0)  // No topics in database so we proceed to populate the database
    {
        NSString *topicsPath = [[NSBundle mainBundle] pathForResource:@"Terms" ofType:@"plist"];
        NSArray *topicsDataArray = [[NSArray alloc] initWithContentsOfFile:topicsPath];
        int numberOfTopics = (int)[topicsDataArray count];
        
        for (int i = 0; i<numberOfTopics; i++)
        {
            NSDictionary *topicDataDictionary = [topicsDataArray objectAtIndex:i];
            newTopic = [NSEntityDescription insertNewObjectForEntityForName:@"Term" inManagedObjectContext:context];
            [newTopic setValuesForKeysWithDictionary:topicDataDictionary];
            [context save:&error];
            if (error) NSLog(@"Error encountered in saving topic entity, %d, %@, Hint: check that the structure of the pList matches Core Data: %@",i, newTopic, error);
        };
    }
    self.terms = topics;
    NSLog(@"terms : %@", self.terms);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.terms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"table view cell");
    NSString *cellIdentifier = @"Glossary Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Term *term = self.terms[indexPath.row];
    cell.textLabel.text = term.name;
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail = self.splitViewController.viewControllers[1];
    if ([detail isKindOfClass:[UINavigationController class]]) {
        detail = [((UINavigationController *)detail).viewControllers firstObject];
    }
    if ([detail isKindOfClass:[HLKSecondViewController class]]) {
        //[self prepareViewController:detail toDisplayTerm:self.terms[indexPath.row]];
    }
}

#pragma mark - Navigation

- (void)prepareViewController:(HLKSecondViewController *)vc toDisplayDefinition:(NSDictionary *)photo
{
    vc.title = @"asd";
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableView class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Glossary Cell"]) {
                if ([segue.destinationViewController isKindOfClass:[HLKSecondViewController class]]) {
                    //[self prepareViewController:segue.destinationViewController toDisplayDefinition:self.photos[indexPath.row]];
                }
                
            }
        }
    }
}

#pragma mark - Memory warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
