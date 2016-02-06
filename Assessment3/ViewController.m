//
//  ViewController.m
//  Assessment3
//
//  Created by Ben Bueltmann on 1/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Owner.h"
#import "CatsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSManagedObjectContext *moc;
@property NSArray *catOwners;
@property Owner *owner;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    self.moc = appDelegate.managedObjectContext;
    
    self.title = @"Cat Owners";
    
    [self loadOwners];
    
    if (self.catOwners.count == 0) {
        NSArray *plistArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"catowners" ofType:@"plist"]];
        for (NSDictionary *dict in plistArray) {
            self.owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self.moc];
            self.owner.ownername = [dict objectForKey:@"name"];
            [self.moc save:nil];
        }
        [self loadOwners];
    }
}

-(void)loadOwners {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
    self.catOwners = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
    
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.catOwners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CellID"];
    
    Owner *owner = [self.catOwners objectAtIndex:indexPath.row];

    cell.textLabel.text = owner.ownername;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    CatsViewController *dvc = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    self.owner = [self.catOwners objectAtIndex:indexPath.row];
    dvc.owner = self.owner;
    
}


//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose a default color!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *purple = [UIAlertAction actionWithTitle:@"Purple" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }];
    UIAlertAction *blue = [UIAlertAction actionWithTitle:@"Blue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }];
    UIAlertAction *orange = [UIAlertAction actionWithTitle:@"Orange" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }];
    UIAlertAction *green = [UIAlertAction actionWithTitle:@"Green" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:purple];
    [alertController addAction:blue];
    [alertController addAction:orange];
    [alertController addAction:green];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:true completion:^{
        
    }];
    
}

@end
