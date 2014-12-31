//
//  ExerciseVC.m
//  GetFit
//
//  Created by Albert Carter on 12/31/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "ExerciseVC.h"

@interface ExerciseVC ()
@property UITextField *activityField;
@property UITextField *intensityField;

@end

@implementation ExerciseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPickerView *activityPicker = [[UIPickerView alloc] init];
    activityPicker.dataSource = self;
    activityPicker.delegate = self;
    
    UIPickerView *intensityPicker = [[UIPickerView alloc] init];
    intensityPicker.dataSource = self;
    intensityPicker.delegate = self;
    
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
    [ _intensityField.layer setBorderColor:[systemBlue CGColor]];
    [self.view addSubview: _intensityField];
    
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(windowFrame.size.width/2-buttonWidth/2, 250, buttonWidth, buttonWidth);
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    startButton.layer.borderWidth = 1.0;
    startButton.layer.cornerRadius = startButton.bounds.size.width/2;
    [startButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [self.view addSubview:startButton];
}

- (void) showActivityPicker {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma marks - picker

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"foo";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSString *text = self.theData[row];
    [_activityField setText:@"Foo"];
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
