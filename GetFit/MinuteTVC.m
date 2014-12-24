//
//  MinuteTVC.m
//  GetFit
//
//  Created by Albert Carter on 12/18/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

// YOU'RE ADDING Activity Pickers the new rows.

#import "MinuteTVC.h"

@interface MinuteTVC () {
    NSInteger numberOfEntries;
    
    NSIndexPath *pickerPath;
    BOOL minuteSetup;
    
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
    
    // create the pickers
    // activityPicker
    activityPicker = [[UIPickerView alloc] init];
    intensityPicker = [[UIPickerView alloc] init];
    durationPicker = [[UIPickerView alloc] init];
    
//
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    // default to just one entry and to just having setup the view whenever the view appears/reappears,
    numberOfEntries = 1;
    minuteSetup = YES;
    
    endTimePicker = [[UIDatePicker alloc] init];
    endTimePicker.hidden = YES;
    endTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    endTimePicker.maximumDate= [NSDate date];
    [endTimePicker addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // create a section for each entry
    return numberOfEntries;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // activity, intensity, duration, end time
    if (minuteSetup) {
        return 4;
    } else {
        return 5;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    // create or delete the picker row.
    // if creating a row, assign the picker path
    if (minuteSetup) {
        NSLog(@"new picker simple case:\nindexPath: %d, pickerPath: %d", indexPath.row, pickerPath.row);
        minuteSetup = NO;
        pickerPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[pickerPath] withRowAnimation:UITableViewRowAnimationMiddle];
    } else if (pickerPath.section == indexPath.section && pickerPath.row -1 != indexPath.row){
        // picker is open, and user has clicked a row not related to the picker
        
        // delete the old picker
        NSLog(@"delete the old picker:\nindexPath: %d, pickerPath: %d", indexPath.row, pickerPath.row);
        minuteSetup = YES;
        NSIndexPath * tempPickerPath = [NSIndexPath indexPathForRow:pickerPath.row inSection:pickerPath.section];
        pickerPath = nil;
        [self.tableView deleteRowsAtIndexPaths:@[tempPickerPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        // dynamic setting for pickerPath, since we may just have deleted a row above or below the indexPath
        if (indexPath.row < tempPickerPath.row) {
            pickerPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        } else {
            pickerPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        }
        
        // make a new picker
        NSLog(@"make a new picker:\nindexPath: %d, pickerPath: %d", indexPath.row, pickerPath.row);
        minuteSetup = NO;
        [self.tableView insertRowsAtIndexPaths:@[pickerPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    } else {
        // simple case.
        
        
        // clear minuteSetup and pickerPath. use tempPickerPath for deleting the row
        // because when deleteRowsAtIndexPaths is called, it calls heightForRowAtIndexPath,
        // which uses pickerPath to determine cell height.
        NSLog(@"delete picker simple case:\nindexPath: %d, pickerPath: %d", indexPath.row, pickerPath.row);
        minuteSetup = YES;
        NSIndexPath * tempPickerPath = [NSIndexPath indexPathForRow:pickerPath.row inSection:pickerPath.section];
        pickerPath = nil;
        [self.tableView deleteRowsAtIndexPaths:@[tempPickerPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath called");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // pickers are hidden/shown in setCellVisibilityAtIndexPath and heightForRowAtIndexPath
    
    if (minuteSetup) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Activity";
                cell.detailTextLabel.text = @"select an activity";
                break;
            case 1:
                cell.textLabel.text = @"Intensity";
                cell.detailTextLabel.text = @"medium";
                break;
            case 2:
                cell.textLabel.text = @"Duration";
                cell.detailTextLabel.text = @"15 min";
                break;
            case 3:
                cell.textLabel.text = @"End Time";
                cell.detailTextLabel.text = @"Dec 18, 2014\t8:00PM";
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 1:
                NSLog(@"activityPicker");
                break;
            case 2:
                NSLog(@"intensityPicker");
                break;
            case 3:
                NSLog(@"durationPicker");
                break;
            case 4:
                NSLog(@"endTimePicker");
                endTimePicker.hidden = NO;
                cell.accessoryView = endTimePicker;
                break;
            default:
                break;
        }
    }

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"heightForRowAtIndexPath called");
//    NSLog(@"indexPath.row: %d, pickerPath.row: %d", indexPath.row, pickerPath.row);
    if ([indexPath isEqual:pickerPath]) {
        return 150;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
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
