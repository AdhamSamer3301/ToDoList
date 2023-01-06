//
//  ProgressViewController.m
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import "EditViewController.h"
#import "ProgressViewController.h"
#import "DoneViewController.h"
#import "TableViewCell.h"
#import "ViewController.h"
#import "Task.h"
@interface ProgressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabelViewP;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabelViewP.delegate = self;
    _tabelViewP.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    _tasksP = [[self readArrayWithCustomObjFromUserDefaults:@"progressTasks"] mutableCopy];
    [_tabelViewP reloadData];
}
-(void) reload{
    [_tabelViewP reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditViewController *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"edit"];
    evc.pG = self;
    evc.tk = [_tasksP objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:evc animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"progCell" forIndexPath:indexPath];
    Task *tmp = [[self readArrayWithCustomObjFromUserDefaults:@"progressTasks"] objectAtIndex:indexPath.row];

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
    return [_tasksP count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete task!" message:@"Are u sure u want to DELETE this task?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete !"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *_Nonnull action) {
        [self->_tasksP removeObjectAtIndex:indexPath.row];
        [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:self->_tasksP];
        [self->_tabelViewP reloadData];
    }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:delete];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:Nil];
    }
}

- (void)addTask:(Task *)tk {
    if(_tasksP == nil){
        _tasksP = [NSMutableArray new];
    }
    _tasksP = [[self readArrayWithCustomObjFromUserDefaults:@"progressTasks"] mutableCopy];
    [_tasksP addObject:tk];
    [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:_tasksP];
    [_tabelViewP reloadData];
    printf("Added");
}
- (void)editTask:(Task *)tkE{
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"toDo"];
    DoneViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"done"];
    switch (tkE.status) {
        case 0:
            vc.tasks = [[self readArrayWithCustomObjFromUserDefaults:@"todoTasks"] mutableCopy];
            if([vc.tasks count]==0||vc.tasks == nil){
                vc.tasks = [NSMutableArray new];
                [vc.tasks addObject:tkE];
                [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:vc.tasks];
                [vc.self reload];
                [_tasksP removeObject:tkE];
                [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:_tasksP];
                
            }else{
                for (int i =0;i<[vc.tasks count];i++) {
                    Task *task = vc.tasks[i];
                    if(task !=nil){
                        if([tkE.name isEqual:task.name] || [tkE.descrip isEqual:task.descrip]){
                            [vc.tasks removeObject:task];
                            [vc.tasks addObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:vc.tasks];
                            [vc.self reload];
                        }
                        else{
                            [vc.tasks addObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:vc.tasks];
                            [vc.self reload];
                            [_tasksP removeObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:_tasksP];
                        }
                    }
                }
            }
            
            break;
        case 1:
            if(_tasksP==nil){
                _tasksP = [NSMutableArray new];
            }
            _tasksP = [[self readArrayWithCustomObjFromUserDefaults:@"progressTasks"] mutableCopy];
                for (int i =0;i<[_tasksP count];i++) {
                    Task *task = _tasksP[i];
                    if(task !=nil){
                        if([tkE.name isEqual:task.name] || [tkE.descrip isEqual:task.descrip]){
                            [_tasksP removeObject:task];
                            [_tasksP addObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:_tasksP];
                            [_tabelViewP reloadData];
                        }
                        else{
                            [_tasksP addObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:_tasksP];
                            [_tabelViewP reloadData];
                        }
                    }
                }
            break;
        case 2:
            dvc.tasksD = [[self readArrayWithCustomObjFromUserDefaults:@"doneTasks"] mutableCopy];
            if([dvc.tasksD count]==0||dvc.tasksD == nil){
                dvc.tasksD = [NSMutableArray new];
                [dvc.tasksD addObject:tkE];
                [self writeArrayWithCustomObjToUserDefaults:@"doneTasks" withArray:dvc.tasksD];
                [dvc.self reload];
                [_tasksP removeObject:tkE];
                [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:_tasksP];
                
            }else{
                for (int i =0;i<[dvc.tasksD count];i++) {
                    Task *task = dvc.tasksD[i];
                    if(task !=nil){
                        if([tkE.name isEqual:task.name] || [tkE.descrip isEqual:task.descrip]){
                            [dvc.tasksD removeObject:task];
                            [dvc.tasksD addObject:tkE];
                            
                            [self writeArrayWithCustomObjToUserDefaults:@"doneTasks" withArray:dvc.tasksD];
                            [dvc.self reload];
                        }
                        else{
                            [dvc.tasksD addObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"doneTasks" withArray:dvc.tasksD];
                            [dvc.self reload];
                            [_tasksP removeObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:_tasksP];
                        }
                    }
                }
            }
            break;
        default:
            break;
    }
    
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
