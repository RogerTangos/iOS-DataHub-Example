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

;
@property UIButton *intensityButton;
@property UIButton *activityButton;

@property UIPickerView *activityPicker;
@property UIPickerView *intensityPicker;

@end

@implementation ExerciseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentlyEditing = @"";
    
    _activityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-250, self.view.bounds.size.width, 216)];
    _activityPicker.dataSource = self;
    _activityPicker.delegate = self;
    [_activityPicker setBackgroundColor:[UIColor whiteColor]];

    
    _intensityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-250, self.view.bounds.size.width, 216)];
    _intensityPicker.dataSource = self;
    _intensityPicker.delegate = self;
    [_intensityPicker setBackgroundColor:[UIColor whiteColor]];
    [_intensityPicker reloadAllComponents];

    
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickers)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    
    // some useful varibales
    CGRect windowFrame = self.view.frame;
    CGFloat buttonWidth = 125;
    UIColor *systemBlue = [UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0];
    
    _activityButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 100, buttonWidth, buttonWidth)];
    [_activityButton setTitle:@"-select action" forState:UIControlStateNormal];
    [_activityButton setTitleColor:systemBlue forState:UIControlStateNormal];
    _activityButton.layer.cornerRadius = _activityButton.bounds.size.width/2;
    _activityButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _activityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _activityButton.layer.borderWidth = 1.0;
    [_activityButton.layer setBorderColor:[systemBlue CGColor]];
    [_activityButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_activityButton];
    
    
    _intensityButton = [[UIButton alloc] initWithFrame:CGRectMake(windowFrame.size.width-25-buttonWidth, 100, buttonWidth, buttonWidth)];
    [ _intensityButton setTitle:@"-select intensity-" forState:UIControlStateNormal];
    [ _intensityButton setTitleColor:systemBlue forState:UIControlStateNormal];
    _intensityButton.layer.cornerRadius =  _intensityButton.bounds.size.width/2;
    _intensityButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _intensityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _intensityButton.layer.borderWidth = 1.0;
    [_intensityButton addTarget:self action:@selector(editIntensity) forControlEvents:UIControlEventTouchUpInside];
    [ _intensityButton.layer setBorderColor:[systemBlue CGColor]];
    [self.view addSubview: _intensityButton];
    
    
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


- (void) dismissPickers {
    [UIView beginAnimations:@"MoveOut" context:nil];
    [_activityPicker removeFromSuperview];
    [_intensityPicker removeFromSuperview];
    [UIView commitAnimations];
    
}

#pragma mark - buttons

- (void) startRecording {
    NSLog(@"start button pressed");
    [self dismissPickers];
}

- (void) editAction {
    NSLog(@"editAction reached");
    _currentlyEditing = @"action";
    
    
    [UIView beginAnimations:@"MoveOut" context:nil];
    [_intensityPicker removeFromSuperview];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [self.view insertSubview:_activityPicker aboveSubview:self.view];
    [UIView commitAnimations];
    
}

- (void) editIntensity {
    NSLog(@"editIntensity reached");
    _currentlyEditing = @"intensity";
    

    [_activityPicker removeFromSuperview];
    [UIView commitAnimations];

    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [self.view insertSubview:_intensityPicker aboveSubview:self.view];
    [UIView commitAnimations];
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
    if (pickerView == _activityPicker) {
        return [resources.activities objectAtIndex:row];
    }
    
    return [resources.intensities objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Resources *resources = [Resources sharedResources];
    
    if (pickerView == _activityPicker) {
        [_activityButton setTitle:[resources.activities objectAtIndex:row ] forState:UIControlStateNormal];
//        [_activityButton setTextAlignment:NSTextAlignmentCenter];
    } else {
        [_intensityButton setTitle:[resources.intensities objectAtIndex:row] forState:UIControlStateNormal];
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
