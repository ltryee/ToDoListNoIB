//
//  XYZAddToDoItemViewController.m
//  XYZToDoList
//
//  Created by vectorliu on 14-9-16.
//
//

#import "XYZAddToDoItemViewController.h"
#import "XYZToDoItem.h"
#import "XYZToDoItemTableViewController.h"

@interface XYZAddToDoItemViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation XYZAddToDoItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(20,
                                                                            100,
                                                                            CGRectGetWidth(self.view.bounds) - 2 * 20,
                                                                            30)];
    textField.placeholder = @"New to-do item";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:textField];
    self.textField = textField;
    
    self.navigationItem.title = @"Add To-Do Item";
    self.navigationItem.leftItemsSupplementBackButton = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(unWindtoList:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(unWindtoList:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)unWindtoList:(id)sender {
    if (sender == self.navigationItem.rightBarButtonItem && self.textField.text.length > 0) {
        XYZToDoItem *todoItem = [[XYZToDoItem alloc] init];
        todoItem.itemName = self.textField.text;
        todoItem.completed = NO;
        
        XYZToDoItemTableViewController * vc = self.navigationController.viewControllers[0];
        [vc addToDoItem:todoItem];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
