//
//  AddCatViewController.m
//  Assessment3
//
//  Created by Ben Bueltmann on 1/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

#import "AddCatViewController.h"
#import "AppDelegate.h"
#import "Owner.h"
#import "Cat.h"

@interface AddCatViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property NSManagedObjectContext *moc;

@end

@implementation AddCatViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Add Cat";
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    self.moc = appDelegate.managedObjectContext;
    
    if (self.cat) {
        self.nameTextField.text = self.cat.catname;
        self.breedTextField.text = self.cat.breed;
        self.colorTextField.text = self.cat.color;
    }
}


- (IBAction)onPressedUpdateCat:(UIButton *)sender {
    
    if (self.cat)
    {
        self.cat.catname = self.nameTextField.text;
        self.cat.breed = self.breedTextField.text;
        self.cat.color = self.colorTextField.text;
        [self.cat.managedObjectContext save:nil];
        
    } else
    {
        
        Cat *cat = [NSEntityDescription insertNewObjectForEntityForName:@"Cat" inManagedObjectContext:self.moc];
        cat.catname = self.nameTextField.text;
        cat.breed = self.breedTextField.text;
        cat.color = self.colorTextField.text;
        cat.owner = self.owner;
        [self.owner addCatsObject:cat];
        [self.owner.managedObjectContext save:nil];
        //        Cat *cat = [NSEntityDescription insertNewObjectForEntityForName:@"Cat" inManagedObjectContext:self.owner.managedObjectContext];
        //        [self.moc save:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
