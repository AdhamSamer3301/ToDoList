//
//  TableViewCell.h
//  ToDoList
//
//  Created by Adham Samer on 04/01/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabelTxt;
@property (weak, nonatomic) IBOutlet UILabel *cellDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;


@end

NS_ASSUME_NONNULL_END
