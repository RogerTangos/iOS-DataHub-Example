//
//  ExerciseVC.m
//  GetFit
//
//  Created by Albert Carter on 12/31/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "ExerciseVC.h"
#import "Resources.h"

@interface ExerciseVC ()

@property NSString *currentlyEditing;
@property UITextField *activityField;
@property UITextField *intensityField;

@end

@implementation ExerciseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentlyEditing = @"";
    
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickers)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    
    UIPickerView *activityPicker = [[UIPickerView alloc] init];
    activityPicker.dataSource = self;
    activityPicker.delegate = self;
    activityPicker.tag = 0;
    [activityPicker setBackgroundColor:[UIColor whiteColor]];
    
    UIPickerView *intensityPicker = [[UIPickerView alloc] init];
    intensityPicker.dataSource = self;
    intensityPicker.delegate = self;
    intensityPicker.tag = 1;
    [intensityPicker setBackgroundColor:[UIColor whiteColor]];
    
    // some useful varibales
    CGRect windowFrame = self.view.frame;
    CGFloat buttonWidth = 125;
    UIColor *systemBlue = [UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0];
   
    // make textFields for pickers
    _activityField = [[UITextField alloc] initWithFrame:CGRectMake(25, 100, buttonWidth, buttonWidth)];
    [_activityField setText:@"-select activity-"];
    [_activityField setTextColor:systemBlue];
    _activityField.layer.cornerRadius = _activityField.bounds.size.width/2;
    _activityField.inputView = activityPicker;
    _activityField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _activityField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [_activityField setBackgroundColor:[UIColor grayColor]];
    _activityField.layer.borderWidth = 1.0;
    [_activityField.layer setBorderColor:[systemBlue CGColor]];
    [_activityField addTarget:self action:@selector(editAction) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:_activityField];
    
    _intensityField = [[UITextField alloc] initWithFrame:CGRectMake(windowFrame.size.width-25-buttonWidth, 100, buttonWidth, buttonWidth)];
    [ _intensityField setText:@"-select intensity-"];
    [ _intensityField setTextColor:systemBlue];
    _intensityField.layer.cornerRadius =  _intensityField.bounds.size.width/2;
    _intensityField.inputView = intensityPicker;
    _intensityField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _intensityField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [ _intensityField setBackgroundColor:[UIColor grayColor]];
    _intensityField.layer.borderWidth = 1.0;
    [_intensityField addTarget:self action:@selector(editIntensity) forControlEvents:UIControlEventEditingDidBegin];
    [ _intensityField.layer setBorderColor:[systemBlue CGColor]];
    [self.view addSubview: _intensityField];
    
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(windowFrame.size.width/2-buttonWidth/2, 250, buttonWidth, buttonWidth);
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    startButton.layer.borderWidth = 1.0;
    startButton.layer.cornerRadius = startButton.bounds.size.width/2;
    [startButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [startButton addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
}

- (void) startRecording {
    NSLog(@"start button pressed");
    [self dismissPickers];
}

- (void) editAction {
    _currentlyEditing = @"action";
}

- (void) editIntensity {
    _currentlyEditing = @"intensity";
}

- (void) dismissPickers {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - picker

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    Resources *resources = [Resources sharedResources];
    
    if ([_currentlyEditing isEqualToString:@"action"]) {
        return [resources.activities count];
    }
    
    return [resources.intensities count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Resources *resources = [Resources sharedResources];
    if ([_currentlyEditing isEqualToString:@"action"]) {
        return [resources.activities objectAtIndex:row];
    }
    
    return [resources.intensities objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Resources *resources = [Resources sharedResources];
    
    if ([_currentlyEditing isEqualToString:@"action"]) {
        [_activityField setText:[resources.activities objectAtIndex:row]];
        [_activityField setTextAlignment:NSTextAlignmentCenter];
    } else {
        [_intensityField setText:[resources.intensities objectAtIndex:row]];
        [_intensityField setTextAlignment:NSTextAlignmentCenter];
    }
    
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
