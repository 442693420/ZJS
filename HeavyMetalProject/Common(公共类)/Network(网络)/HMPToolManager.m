//
//  HMPToolManager.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/16.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPToolManager.h"

@implementation HMPToolManager
/**
 *  付款金额限制代码
 *
 *  @param textField    当前textField
 *  @param range        range
 *  @param string       string
 *  @param dotPreBits   小数点前整数位数
 *  @param dotAfterBits 小数点后位数
 *
 *  @return shouldChangeCharactersInRange 代理方法中 可以限制金额格式
 */

+ (BOOL) limitPayMoneyDot:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string dotPreBits:(int)dotPreBits dotAfterBits:(int)dotAfterBits

{
    if ([string isEqualToString:@"\n"]||[string isEqualToString:@""])
    { //按下return
        return YES;
    }
    
    NSCharacterSet *cs;
    NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
    if (NSNotFound == nDotLoc && 0 != range.location)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:string]invertedSet];
        if ([string isEqualToString:@"."])
        {
            return YES;
        }
        if (textField.text.length >= dotPreBits)
        {  //小数点前面6位
            // [textField resignFirstResponder];
            [MBManager showBriefAlert:[NSString stringWithFormat:@"只允许小数前%d位", dotPreBits]];
            return NO;
        }
    }
    else
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:string]invertedSet];
        if (textField.text.length >= dotPreBits + dotAfterBits + 1)
        {
            [textField resignFirstResponder];
            [MBManager showBriefAlert:[NSString stringWithFormat:@"只允许小数点后%d位", dotAfterBits]];
            return  NO;
        }
    }
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest)
    {
        [textField resignFirstResponder];
        [MBManager showBriefAlert:[NSString stringWithFormat:@"只允许小数点后%d位", dotAfterBits]];
        return NO;
    }
    if (NSNotFound != nDotLoc && range.location > nDotLoc +2)
    {  //小数点后面两位
        [textField resignFirstResponder];
        [MBManager showBriefAlert:[NSString stringWithFormat:@"只允许小数点后%d位", dotAfterBits]];
        return NO;
    }
    return YES;
}
@end
