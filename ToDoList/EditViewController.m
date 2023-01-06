//
//  EditViewController.m
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import "DoneViewController.h"
#import "EditViewController.h"
#import "ProgressViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *descripeTxtField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegment;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePick;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameTxtField.text = _tk.name;
    _descripeTxtField.text = _tk.descrip;
    _prioritySegment.selectedSegmentIndex = _tk.priority;
    _datePick.date = _tk.date;
    _statusSegment.selectedSegmentIndex = _tk.status;
}

- (IBAction)editBtn:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Edit task!" message:@"Are u sure u want to edit this task?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Edit !"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *_Nonnull action) {
        Task *editTask = self->_tk;
        [editTask setName:self->_nameTxtField.text];
        [editTask setDescrip:self->_descripeTxtField.text];
        [editTask setDate:self->_datePick.date];
        [editTask setPriority:self->_prioritySegment.selectedSegmentIndex];
        [editTask setStatus:self->_statusSegment.selectedSegmentIndex];

        [self->_pE editTask:editTask];
        [self->_pG editTask:editTask];

        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];

    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:Nil];
}

/*
 #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end
