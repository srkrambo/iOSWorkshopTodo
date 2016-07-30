//
//  ViewController.m
//  iOSWorkshopTodo
//
//  Created by Rajkumar S on 7/30/16.
//  Copyright © 2016 Eezy. All rights reserved.
//

#import "ViewController.h"
#import "Entity.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self setupData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData {
    // Fetch from coredata and reloadTable
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
    self.dataArray = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Entity *entity = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = entity.title;
    cell.detailTextLabel.text = entity.desc;
    return cell;
}

- (IBAction)addData:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Todo" message:@"Enter your todo details" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
         textField.placeholder = NSLocalizedString(@"Title", @"Title");
     }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
         textField.placeholder = NSLocalizedString(@"Desc", @"Desc");
     }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *titleTextField = alertController.textFields.firstObject;
        UITextField *descTextField = alertController.textFields.lastObject;
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:appDelegate.managedObjectContext];
        Entity *toDo = (Entity *)[[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:appDelegate.managedObjectContext];
        toDo.title = titleTextField.text;
        toDo.desc = descTextField.text;
        [appDelegate saveContext];
        [self setupData];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}


@end
