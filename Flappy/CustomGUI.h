//
//  CustomGUI.h
//  Flappy
//
//  Created by Travis Delly on 9/20/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomGUI : NSObject

-(UIButton*)standardButton:(NSString*)text;
-(UITextView*)defaultTextView;
-(UITextField*)defaultTextField:(NSString*)placeHolder;
-(UIButton*)defaultButton:(NSString*)text;
-(UILabel*)defaultLabel:(NSString*)text;
-(UIView*)defaultView;
-(UIView*)backgroundView;
-(UIButton*)defaultMenuButton:(NSString*)title;
-(UITextField*)defaultTextFieldWithText:(NSString*)text;
@property UITapGestureRecognizer *doubletap;


@end

