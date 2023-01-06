//
//  ViewController.m
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import "AddViewController.h"
#import "DoneViewController.h"
#import "ProgressViewController.h"
#import "EditViewController.h"
#import "TableViewCell.h"
#import "ViewController.h"
#import "tasks.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *toDoTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarField;


@end

@implementation ViewController

- (IBAction)addBtn:(id)sender {
    AddViewController *avc = [self.storyboard instantiateViewControllerWithIdentifier:@"add"];

    avc.p = self;
    [self.navigationController pushViewController:avc animated:YES];
//    [self presentViewController:avc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFiltered = false;
    self.searchBarField.delegate = self;
    _toDoTable.delegate = self;
    _toDoTable.dataSource = self;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        _isFiltered = false;
    }else{
        _isFiltered = true;
        _filteredTasks=[NSMutableArray new];
        for (int i = 0; i< [_tasks count]; i++) {
            Task *tmp = _tasks[i];
            if([ searchText isEqualToString:tmp.name] || [tmp.name containsString:searchText]){
                _isFiltered = true;
                [_filteredTasks addObject:tmp];
            }
//            NSRange *nameRange = [tmp.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    _tasks = [[self readArrayWithCustomObjFromUserDefaults:@"todoTasks"]mutableCopy];
    [_toDoTable reloadData];
}
- (void)reload{
    [_toDoTable reloadData];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"toDoCell" forIndexPath:indexPath];
    
    

    Task *tmp = [[self readArrayWithCustomObjFromUserDefaults:@"todoTasks"] objectAtIndex:indexPath.row];
    cell.cellLabelTxt.text = tmp.name;
    cell.cellDescriptionLabel.text = tmp.descrip;
//        cell.textLabel.text = tmp.name;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 110;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_isFiltered){
        return [_filteredTasks count];
    }else
    {
        return [_tasks count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditViewController *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"edit"];

    evc.pE = self;
    evc.tk = [_tasks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:evc animated:YES];
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
        [self->_tasks removeObjectAtIndex:indexPath.row];
        [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:self->_tasks];
        [self->_toDoTable reloadData];
    }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:delete];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:Nil];
    }
}

- (void)addTask:(Task *)tk {
    if(_tasks == nil){
        _tasks=[NSMutableArray new];
    }
    [_tasks addObject:tk];
    [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:_tasks];
    [_toDoTable reloadData];
    printf("Added! ");
}

-(void) editTask:(Task *)tkE{
    ProgressViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"progress"];
    DoneViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"done"];
    switch (tkE.status) {
        case 0:
            for (int i =0;i<[_tasks count];i++) {
                Task *task = _tasks[i];
                if(task !=nil){
                    if([tkE.name isEqual:task.name] || [tkE.descrip isEqual:task.descrip]){
                        [_tasks removeObject:task];
                        [_tasks addObject:tkE];
                        [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:_tasks];
                    }
                    else{
                        [_tasks addObject:tkE];
                        [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:_tasks];
                    }
                }
            }
            [_toDoTable reloadData];
            break;
        case 1:
            pvc.tasksP = [[self readArrayWithCustomObjFromUserDefaults:@"progressTasks"] mutableCopy];
            if([pvc.tasksP count]==0||pvc.tasksP == nil){
                pvc.tasksP = [NSMutableArray new];
                [pvc.tasksP addObject:tkE];
                [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:pvc.tasksP];
                [pvc.self reload];
                [_tasks removeObject:tkE];
                [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:_tasks];
                
            }else{
                for (int i =0;i<[pvc.tasksP count];i++) {
                    Task *task = pvc.tasksP[i];
                    if(task !=nil){
                        if([tkE.name isEqual:task.name] || [tkE.descrip isEqual:task.descrip]){
                            [pvc.tasksP removeObject:task];
                            [pvc.tasksP addObject:tkE];
                            
                            [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:pvc.tasksP];
                            [pvc.self reload];
                        }
                        else{
                            [pvc.tasksP addObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"progressTasks" withArray:pvc.tasksP];
                            [pvc.self reload];
                            [_tasks removeObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:_tasks];
                        }
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
                [_tasks removeObject:tkE];
                [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:_tasks];
                
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
                            [_tasks removeObject:tkE];
                            [self writeArrayWithCustomObjToUserDefaults:@"todoTasks" withArray:_tasks];
                        }
                    }
                }
            }
            break;
        default:
            break;
    }
    
    
    printf("Edited or Added if not exist! ");
}

-(void)writeArrayWithCustomObjToUserDefaults:(NSString*)keyName withArray:(NSMutableArray*)myArray
{
    NSData *data =[NSKeyedArchiver archivedDataWithRootObject:myArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:keyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSArray*)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return myArray;
}
@end
