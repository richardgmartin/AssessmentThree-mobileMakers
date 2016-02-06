//
//  CatsViewController.m
//  Assessment3
//
//  Created by Ben Bueltmann on 1/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

#import "CatsViewController.h"
#import "AppDelegate.h"
#import "Cat.h"
#import "AddCatViewController.h"

@interface CatsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *CatsTableView;
@property NSManagedObjectContext *moc;
@property NSArray *ownerCatsArray;
@property NSString *breedPlusColor;

@end

@implementation CatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Cats";
    
//    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
//    self.moc = appDelegate.managedObjectContext;
    self.moc = self.owner.managedObjectContext;
    [self loadOwnerCats];
    
}

- (void)loadOwnerCats {
    
    self.ownerCatsArray = self.owner.cats.allObjects;
    [self.CatsTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    self.ownerCatsArray = self.owner.cats.allObjects;
    [self.CatsTableView reloadData];
    
}


#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ownerCatsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CatCell"];
    
    Cat *cat = [self.ownerCatsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cat.catname;
    self.breedPlusColor = [NSString stringWithFormat:@"%@ is a %@ %@", cat.catname, cat.color, cat.breed];
    cell.detailTextLabel.text = self.breedPlusColor;
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.owner removeCatsObject:self.ownerCatsArray[indexPath.row]];
        [self.moc deleteObject:self.ownerCatsArray[indexPath.row]];
        [self.moc save:nil];
        [self.moc refreshAllObjects];
        [self loadOwnerCats];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddCatSegue"])
    {
        AddCatViewController *dvc = segue.destinationViewController;
        dvc.owner = self.owner;
        
    }
    else
    {
        AddCatViewController *dvc = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.CatsTableView indexPathForCell:sender];
        self.cat = [self.ownerCatsArray objectAtIndex:indexPath.row];
        dvc.cat = self.cat;
        
//        UITableViewCell *cell = sender;
//        dvc.cat = [self.ownerCatsArray objectAtIndex:[self.CatsTableView indexPathForCell:cell].row];
    }
}

@end
