//
//  XYZToDoItemTableViewController.m
//  XYZToDoList
//
//  Created by vectorliu on 14-9-16.
//
//

#import "XYZToDoItemTableViewController.h"
#import "XYZAddToDoItemViewController.h"
#import "XYZToDoItem.h"

@interface XYZToDoItemTableViewController ()<UINavigationControllerDelegate>
@property NSMutableArray * toDoItems;
@end

@implementation XYZToDoItemTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"My To-Do Item";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(trigerAddToDoItem:)];
    self.toDoItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ListPrototypeCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInitialData {
    NSString *path = [NSMutableString stringWithString:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    path = [path stringByAppendingPathComponent:@"data.plist"];
    NSArray *todoItems = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *item in todoItems) {
        XYZToDoItem *todoItem = [[XYZToDoItem alloc] init];
        todoItem.itemName = item[@"title"];
        todoItem.completed = ((NSNumber *)item[@"completed"]).boolValue;
        [self.toDoItems addObject:todoItem];
    }
}

- (void)trigerAddToDoItem:(id)sender {
    XYZAddToDoItemViewController * vc = [[XYZAddToDoItemViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addToDoItem:(XYZToDoItem *)todoItem {
    [self.toDoItems addObject:todoItem];
    [self.tableView reloadData];
    
    [self saveToLocal];
}

- (void)saveToLocal {
    NSMutableArray *todoItems = [NSMutableArray array];
    for (XYZToDoItem *item in self.toDoItems) {
        [todoItems addObject:@{@"title" : item.itemName,
                               @"completed" : @(item.completed),
                               }];
    }
    NSString *path = [NSMutableString stringWithString:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    path = [path stringByAppendingPathComponent:@"data.plist"];
    NSLog(@"%s:\n%@", __func__, path);
    [todoItems writeToFile:path atomically:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.toDoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    XYZToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XYZToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self saveToLocal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
