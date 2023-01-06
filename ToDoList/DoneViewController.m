//
//  DoneViewController.m
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import "DoneViewController.h"
#import "TableViewCell.h"

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *doneTableView;

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _doneTableView.delegate = self;
    _doneTableView.dataSource = self;
}
- (void)viewWillAppear:(BOOL)animated{
    _tasksD = [[self readArrayWithCustomObjFromUserDefaults:@"doneTasks"] mutableCopy];
    [_doneTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell =(TableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
    Task *tmp = [[self readArrayWithCustomObjFromUserDefaults:@"doneTasks"] objectAtIndex:indexPath.row];

    cell.cellLabelTxt.text = tmp.name;
    cell.cellDescriptionLabel.text = tmp.descrip;
    switch (tmp.priority) {
        case 0:
            [cell.cellImage setImage:[UIImage imageNamed:@"Low"]];
            break;

        case 1:
            [cell.cellImage setImage:[UIImage imageNamed:@"Medium"]];
            break;

        case 2:
            [cell.cellImage setImage:[UIImage imageNamed:@"High"]];
            break;

        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tasksD count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    switch (section) {
//        case 0:
//            return @"Low";
//            break;
//        case 1:
//            return @"Medium";
//            break;
//        case 2:
//            return @"High";
//            break;
//        default:
//            return @"";
//            break;
//    }
//
//}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return false;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)addTask:(nonnull Task *)tk {
    if(_tasksD == nil){
        _tasksD = [NSMutableArray new];
    }
    _tasksD = [[self readArrayWithCustomObjFromUserDefaults:@"doneTasks"] mutableCopy];
    [_tasksD addObject:tk];
    [self writeArrayWithCustomObjToUserDefaults:@"doneTasks" withArray:_tasksD];
    [_doneTableView reloadData];
    printf("Added");
}

- (void)reload{
    [_doneTableView reloadData];
}
- (void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:keyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString *)keyName {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    return myArray;
}
@end
