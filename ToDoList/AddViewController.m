//
//  AddViewController.m
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import "AddViewController.h"
#import "Task.h"
#import "ViewController.h"
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *descripTxtField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePick;


@end

@implementation AddViewController
- (IBAction)segmentChoose:(id)sender {
}

- (IBAction)addBtn:(id)sender {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add task!" message:@"Are u sure u want to add this task?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Add !"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *_Nonnull action) {
        if([self->_nameTxtField.text isEqualToString:@""]||[self->_descripTxtField.text isEqualToString:@""]){
            UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"Missing Data !" message:@"Enter Data" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok !" style:UIAlertActionStyleDefault handler:nil];
            [alert2 addAction:ok];
            [self presentViewController:alert2 animated:YES completion:Nil];
        }else{
            Task *taskObj = [Task new];
            [taskObj setName:self->_nameTxtField.text];
            [taskObj setDescrip:self->_descripTxtField.text];
            [taskObj setDate:self->_datePick.date];
            [taskObj setPriority:self->_prioritySegment.selectedSegmentIndex];
            [taskObj setStatus:0];
            [self.p addTask:taskObj];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:Nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
