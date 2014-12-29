//
//  MinuteTVC.m
//  GetFit
//
//  Created by Albert Carter on 12/18/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

// YOU'RE ADDING Activity Pickers the new rows.

#import "MinuteTVC.h"
#import "ActivityPickerView.h"

@interface MinuteTVC () {
    NSInteger numberOfEntries;
    
    NSIndexPath *pickerPath;
    BOOL minuteSetup;
    
    UIPickerView * activityPicker;
    UIPickerView * intensityPicker;
    UIPickerView * durationPicker;
    UIDatePicker * endTimePicker;
    
    NSArray * activities;
    NSArray * intensities;
    NSArray * durations;
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
    
    
    // populate the picker option arrays
    activities = [[NSArray alloc] initWithObjects:@"Aerobics", @"American football", @"Badminton", @"Ballet", @"Bandy", @"Baseball", @"Basketball", @"Beach Volleyball", @"Body Pump", @"Bowling", @"Boxing", @"Circuit Training", @"Cleaning", @"Climbing", @"Cricket", @"Cross country skiing", @"Curling", @"Cycling", @"Dancing", @"Disk Ultimate", @"Downhill skiing", @"Eliptical Training", @"Fencing", @"Floorball", @"Golfing", @"Gym Training", @"Handball", @"Hockey", @"Indoor Cycling", @"Kayaking", @"Kettlebell", @"Kite Surfing", @"Lacrosse", @"Marshall Arts", @"Paddling", @"Paintball", @"Parkour", @"Petanque", @"Pilates", @"Polo", @"Raquetball", @"Riding", @"Roller Blading", @"Roller Skiing", @"Roller Skating", @"Rowing", @"Rugby", @"Running", @"Running on Treadmill", @"Skuba Diving", @"Skateboarding", @"Snowboarding", @"Snow Shoeing", @"Soccer", @"Spinning", @"Squash", @"Stair Climbing", @"Stretching", @"Surfing", @"Swimming", @"Table Tennis", @"Tennis", @"Volleyball", @"Walking", @"Walking on Treadmill", @"Water Polo", @"Weight Training", @"Wheelchair", @"Wind Surfing", @"Wrestling", @"Yoga", @"Zumba", nil];
    
    intensities = [[NSArray alloc] initWithObjects:@"High", @"Medium", @"Low", nil];
    
    durations = [[NSArray alloc] initWithObjects:@"5 min", @"10 min", @"15 min", @"20 min", @"25 min", @"30 min", @"35 min", @"40 min", @"45 min", @"50 min", @"55 min", @"1 hr  0 min", @"1 hr  5 min", @"1 hr 10 min", @"1 hr 15 min", @"1 hr 20 min", @"1 hr 25 min", @"1 hr 30 min", @"1 hr 35 min", @"1 hr 40 min", @"1 hr 45 min", @"1 hr 50 min", @"1 hr 55 min", @"2 hr  0 min", @"2 hr 15 min", @"2 hr 30 min", @"2 hr 45 min", @"3 hr  0 min", @"3 hr 15 min", @"3 hr 30 min", @"3 hr 45 min", @"4 hr  0 min", @"4 hr 15 min", @"4 hr 30 min", @"4 hr 45 min", @"5 hr  0 min",nil];
    
    // create the pickers
    activityPicker = [[UIPickerView alloc] init];
    intensityPicker = [[UIPickerView alloc] init];
    durationPicker = [[UIPickerView alloc] init];
    
    [activityPicker setDelegate:self];
    [intensityPicker setDelegate:self];
    [durationPicker setDelegate:self];
    
    
    
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
    endTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    endTimePicker.maximumDate= [NSDate date];
    [endTimePicker addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    }

- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Picker view DataSource/Delegate Methods

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSLog(@"titleForRow is being called");
    switch (pickerPath.row) {
        case 1:
            return [activities objectAtIndex:row];
        case 2:
            return [intensities objectAtIndex:row];
        case 3:
            return [durations objectAtIndex:row];
        default:
            return nil;
    }
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // find the picker setting the thing
    // find the index of the related cell
    // find the text of the picker
    // find change the cell text
    
    // find the cell that created the picker
    NSIndexPath *cellPath = [NSIndexPath indexPathForRow:pickerPath.row-1 inSection:pickerPath.section];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:cellPath];
    
    // find what the user selected, and assign to the relevant cell
    NSString *selection = [NSString alloc];
    switch (pickerPath.row) {
        case 1:
            selection = [activities objectAtIndex:row];
            break;
        case 2:
            selection = [intensities objectAtIndex:row];
            break;
        case 3:
            selection = [durations objectAtIndex:row];
            break;
        case 4:
            NSLog(@"Time picker shouldn't be called in pickerView");
            break;
        default:
            break;
    }
    
    // assign the selection to the cell
    cell.detailTextLabel.text = selection;
    
    
    NSLog(@"%@", selection);
    
//    NSLog(@"Selected activity/thing: %@. Index of selected row: %i", [activities objectAtIndex:row], row);
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    NSLog(@"The pickerPath.row is: %d", pickerPath.row);
    switch (pickerPath.row) {
        case 1:
            return [activities count];
        case 2:
            return [intensities count];
        case 3:
            return [durations count];
        default:
            return 4;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
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
        minuteSetup = NO;
        pickerPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[pickerPath] withRowAnimation:UITableViewRowAnimationMiddle];
    } else if (pickerPath.section == indexPath.section && pickerPath.row -1 != indexPath.row){
        // picker is open, and user has clicked a row not related to the picker
        
        // delete the old picker
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
        minuteSetup = NO;
        [self.tableView insertRowsAtIndexPaths:@[pickerPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    } else {
        // simple case.
        // clear minuteSetup and pickerPath. use tempPickerPath for deleting the row
        // because when deleteRowsAtIndexPaths is called, it calls heightForRowAtIndexPath,
        // which uses pickerPath to determine cell height.
        minuteSetup = YES;
        NSIndexPath * tempPickerPath = [NSIndexPath indexPathForRow:pickerPath.row inSection:pickerPath.section];
        pickerPath = nil;
        [self.tableView deleteRowsAtIndexPaths:@[tempPickerPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
                cell.accessoryView = activityPicker;
                break;
            case 2:
                NSLog(@"intensityPicker");
                cell.accessoryView = intensityPicker;
                break;
            case 3:
                NSLog(@"durationPicker");
                cell.accessoryView = durationPicker;
                break;
            case 4:
                NSLog(@"endTimePicker");
                cell.accessoryView = endTimePicker;
                break;
            default:
                break;
        }
    }

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:pickerPath]) {
        switch (indexPath.row) {
            case 1:
                return 110;
            case 2:
                return 75;
            case 3:
                return 110;
            case 4:
                return 162;
            default:
                return 160;
        }
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
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
