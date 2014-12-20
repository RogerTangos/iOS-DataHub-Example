//
//  MinuteTVC.m
//  GetFit
//
//  Created by Albert Carter on 12/18/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "MinuteTVC.h"

@interface MinuteTVC () {
    NSInteger numberOfEntries;
    NSString *pickerRevealed;
    NSInteger sectionPicked;
    
    UIPickerView * activityPicker;
    UIPickerView * intensityPicker;
    UIPickerView * durationPicker;
    UIDatePicker * endTimePicker;
}
@end

@implementation MinuteTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create save and cancel buttons
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                   style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftButton;
    
    // by default, none of the pickers are revealed
    pickerRevealed = @"";
    
    // create the pickers
    // activityPicker
    activityPicker = [[UIPickerView alloc] init];
    intensityPicker = [[UIPickerView alloc] init];
    durationPicker = [[UIPickerView alloc] init];
    
//    endTimePicker = [[UIDatePicker alloc] init];
//    endTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
//    endTimePicker.maximumDate= [NSDate date];
//    [endTimePicker addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
//    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    // default to just one entry, whenever the view appears/reappears.
    numberOfEntries = 1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // create a section for each entry
    return numberOfEntries;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    // activity, intensity, duration, end time
    return 8;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    sectionPicked = indexPath.section;
    
    if (indexPath.row %2 == 0) {
        [self togglePicker:indexPath];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // pickers are hidden/shown in setCellVisibilityAtIndexPath and heightForRowAtIndexPath
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Activity";
            cell.detailTextLabel.text = @"select an activity";
            break;
        case 1:
//            cell.accessoryView = activityPicker;
            cell.textLabel.text = @"activity placeholder";
            break;
        case 2:
            cell.textLabel.text = @"Intensity";
            cell.detailTextLabel.text = @"medium";
            break;
        case 3:
            cell.accessoryView = intensityPicker;
            break;
        case 4:
            cell.textLabel.text = @"Duration";
            cell.detailTextLabel.text = @"15 min";
            break;
        case 5:
            cell.accessoryView = durationPicker;
            break;
        case 6:
            cell.textLabel.text = @"End Time";
            cell.detailTextLabel.text = @"Dec 18, 2014\t8:00PM";
            break;
        case 7:
            endTimePicker = [[UIDatePicker alloc] init];
            endTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
            endTimePicker.maximumDate= [NSDate date];
            [endTimePicker addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
            
            cell.accessoryView = endTimePicker;
            break;
        default:
            break;
    }
    // hide the picker cells if necessary, and return
    [self setCellVisibilityAtIndexPath:cell withIndexPath:indexPath];
    return cell;
}

- (UITableViewCell *) setCellVisibilityAtIndexPath:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    // mimics heightForRowAtIndexPath.
    
    if (indexPath.row % 2 == 1){
        if (indexPath.section == sectionPicked) {
            // the section must match
            // odd numbered cells are hidden by default
            cell.hidden = YES;
            
            if (indexPath.row == 1 && [pickerRevealed isEqualToString:@"activity"]) {
                cell.hidden = NO;
            } else if (indexPath.row == 3 && [pickerRevealed isEqualToString:@"intensity"]){
                cell.hidden = NO;
            } else if (indexPath.row == 5 && [pickerRevealed isEqualToString:@"duration"]){
                cell.hidden = NO;
            } else if (indexPath.row == 7 && [pickerRevealed isEqualToString:@"end time"]) {
                cell.hidden = NO;
            } else {
                cell.hidden = YES;
            }
        }
    }

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // odd numbered cells are placeholders for pickers. Pickers are revealed if pickerRevealed has their string
    if (indexPath.row % 2 == 1) {
        if (indexPath.row == 1 && [pickerRevealed isEqualToString:@"activity"]) {
            return 100;
        } else if (indexPath.row == 3 && [pickerRevealed isEqualToString:@"intensity"]) {
            return 100;
        } else if (indexPath.row == 5 && [pickerRevealed isEqualToString:@"duration"]) {
            return 100;
        } else if (indexPath.row == 7 && [pickerRevealed isEqualToString:@"end time"]) {
            return 200;
        } else {
            return 0;
        }
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
    

- (void) togglePicker:(NSIndexPath *)indexPath {
    
    // get the picker's path
    NSIndexPath *pickerPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    
    // If there is no pickerRevealed, set one. If there already is, close it.
    if ([pickerRevealed length] == 0) {
        [self setPickerRevealed:pickerPath];
    } else { // clear the picker revealed, and hide all
        pickerRevealed = @"";
        activityPicker.hidden = YES;
        intensityPicker.hidden = YES;
        durationPicker.hidden = YES;
        endTimePicker.hidden = YES;
        
    }
    
    // recompute the cell height
    [self.tableView reloadRowsAtIndexPaths:@[pickerPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void) setPickerRevealed:(NSIndexPath *)indexPath {
    // helper method to determine which picker should be revealed after a click
    
    switch (indexPath.row) {
        case 1:
            pickerRevealed = @"activity";
            break;
        case 3:
            pickerRevealed = @"intensity";
            break;
        case 5:
            pickerRevealed = @"duration";
            break;
        case 7:
            pickerRevealed = @"end time";
            endTimePicker.hidden = NO;
            break;
        default:
            break;
    }
}


- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
