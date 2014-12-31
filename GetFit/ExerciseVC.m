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

@property BOOL exercising;
@property UILabel *stopwatch;
@property NSTimeInterval startTime;


@property UIButton *intensityButton;
@property UIButton *activityButton;
@property UIButton *startButton;

@property UIPickerView *activityPicker;
@property UIPickerView *intensityPicker;

@end

@implementation ExerciseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // some useful varibales
    CGRect windowFrame = self.view.frame;
    CGFloat buttonWidth = 125;
    UIColor *systemBlue = [UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0];
    
    // make pickers
    _activityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-250, self.view.bounds.size.width, 216)];
    _activityPicker.dataSource = self;
    _activityPicker.delegate = self;
    [_activityPicker setBackgroundColor:[UIColor whiteColor]];
    
    _intensityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-250, self.view.bounds.size.width, 216)];
    _intensityPicker.dataSource = self;
    _intensityPicker.delegate = self;
    [_intensityPicker setBackgroundColor:[UIColor whiteColor]];
    [_intensityPicker reloadAllComponents];

    // tap the background to remove pickers
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickers)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    
    // make buttons
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
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.frame = CGRectMake(windowFrame.size.width/2-buttonWidth/2, 375, buttonWidth, buttonWidth);
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _startButton.layer.borderWidth = 1.0;
    _startButton.layer.cornerRadius = _startButton.bounds.size.width/2;
    [_startButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [_startButton addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
    
    // make stopwatch
    _stopwatch = [[UILabel alloc] initWithFrame:CGRectMake(0, 238,  windowFrame.size.width, 125)];
    [_stopwatch setText:@"0:00.0"];
    _stopwatch.textAlignment = NSTextAlignmentCenter;
    _stopwatch.font = [UIFont fontWithName:@"Helvetica Light" size:90];
//    [_stopwatch setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_stopwatch];
    
    
    
}


- (void) dismissPickers {
    [UIView beginAnimations:@"MoveOut" context:nil];
    [_activityPicker removeFromSuperview];
    [_intensityPicker removeFromSuperview];
    [UIView commitAnimations];
    
}

#pragma mark - buttons

- (void) startRecording {
    [self dismissPickers];
    _exercising = !_exercising;
    
    if (_exercising) {
        [_startButton setTitle:@"Stop" forState:UIControlStateNormal];
         _startTime = [NSDate timeIntervalSinceReferenceDate];
        [self updateStopwatch];
    } else {
        [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
}

- (void) editAction {
    [UIView beginAnimations:@"MoveOut" context:nil];
    [_intensityPicker removeFromSuperview];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    [self.view insertSubview:_activityPicker aboveSubview:self.view];
    [UIView commitAnimations];
    
}

- (void) editIntensity {
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

# pragma mark - stopwatch
- (void) updateStopwatch {
    if (!_exercising) {
        _stopwatch.text = @"0:00.0";
        return;
    };
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - _startTime;
    
    int min = (int) (elapsed / 60.0);
    elapsed -= min * 60;
    int sec = (int) (elapsed);
    elapsed -= sec;
    int fraction = elapsed * 10;
    
    _stopwatch.text = [NSString stringWithFormat:@"%u:%02u.%u", min, sec, fraction];
    
    [self performSelector:@selector(updateStopwatch) withObject:self afterDelay:0.1];
}

# pragma mark - picker

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    Resources *resources = [Resources sharedResources];
    
    if (pickerView == _activityPicker) {
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
