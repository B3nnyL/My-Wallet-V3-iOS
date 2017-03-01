//
//  KIFUITestActor+Login.m
//  Blockchain
//
//  Created by Kevin Wu on 4/14/16.
//  Copyright © 2016 Qkos Services Ltd. All rights reserved.
//

#import "KIFUITestActor+Login.h"
#import "Blockchain-Prefix.pch"
#import "RootService.h"

// 5s simulator
const CGPoint alertOkButtonCenterShortText = (CGPoint){154, 340};
const CGPoint alertOkButtonCenterMediumText = (CGPoint){154, 362};
const CGPoint alertOkButtonRight = (CGPoint){175, 340};
const CGPoint pinKeyTwo = (CGPoint){154, 362};

@implementation KIFUITestActor (Login)

- (void)manualPairWithGUID:(NSString *)guid password:(NSString *)password
{
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_LOG_IN];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_LOG_IN];
    
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MANUAL_PAIR];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MANUAL_PAIR];
    
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MANUAL_PAIR_FIELD_GUID];
    [self enterText:guid intoViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MANUAL_PAIR_FIELD_GUID];
    [self enterText:password intoViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MANUAL_PAIR_FIELD_PASSWORD];
    
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MANUAL_PAIR_CONTINUE];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MANUAL_PAIR_CONTINUE];
    
    [self setupPIN];
    
    [self waitForTimeInterval:2];
    [self tapScreenAtPoint:alertOkButtonCenterShortText];
    
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SIDE_MENU];
}

- (void)setupPIN
{
    [self waitForViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_NUMPAD_VIEW];
    [self enterPIN];
    [self waitForTimeInterval:.2];
    [self enterPIN];
}

- (void)createNewWallet
{
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CREATE_NEW_WALLET];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CREATE_NEW_WALLET];
    
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CREATE_WALLET];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CREATE_WALLET];
    
    [self waitForTimeInterval:8];
    [self tapScreenAtPoint:alertOkButtonCenterMediumText];
    
    [self setupPIN];
    
    [self waitForTimeInterval:2];
    [self tapScreenAtPoint:alertOkButtonCenterShortText];
    
    [self waitForTimeInterval:.5];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CLOSE_BUTTON];

    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SIDE_MENU];
}

- (void)enterPIN
{
    [self waitForViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_NUMPAD_VIEW];
    
    [self tapScreenAtPoint:pinKeyTwo];
    [self tapScreenAtPoint:pinKeyTwo];
    [self tapScreenAtPoint:pinKeyTwo];
    [self tapScreenAtPoint:pinKeyTwo];
}

- (void)logoutAndForgetWallet
{
    [self logout];
    
    [self forgetWallet];
}

- (void)logout
{
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SIDE_MENU];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SIDE_MENU];
    
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CELL_LOGOUT];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CELL_LOGOUT];
    
    [self waitForTimeInterval:.2];
    [self tapScreenAtPoint:alertOkButtonRight];
}

- (void)forgetWallet
{
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_FORGET_WALLET];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_FORGET_WALLET];
    
    [self waitForTimeInterval:.2];
    [self tapScreenAtPoint:alertOkButtonRight];
    
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CREATE_NEW_WALLET];
}

#pragma mark - Send

- (void)send
{
    [self goToSend];
    [self typeInAddress];
    
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SEND_FIAT_FIELD];
    [self enterTextIntoCurrentFirstResponder:@"0.10"];
    [self waitForAnimationsToFinish];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CONTINUE_PAYMENT];
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CONFIRM_PAYMENT];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CONFIRM_PAYMENT];
}

- (void)goToSend
{
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SEND_TAB];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SEND_TAB];
}

- (void)typeInAddress
{
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SELECT_ADDRESS];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SELECT_ADDRESS];
    [self enterTextIntoCurrentFirstResponder:@"1MdLTHM5xTNuu7D12fyce5MqtchnRmuijq"];
}

// No decimal

- (void)confirmSendAmountNoDecimal
{
    [self confirmSendAmountWithText:@"1"];
}

- (void)confirmSendAmountArabicNumeralsNoDecimal
{
    [self confirmSendAmountWithText:@"١"];
}

// Period separator

- (void)confirmSendAmountDecimalPeriodDecimalFirst
{
    [self confirmSendAmountWithText:@".10"];
}

- (void)confirmSendAmountDecimalPeriodZeroThenDecimal
{
    [self confirmSendAmountWithText:@"0.10"];
}

- (void)confirmSendAmountDecimalPeriodNumberThenDecimal
{
    [self confirmSendAmountWithText:@"1.10"];
}

- (void)confirmSendAmountDecimalPeriodArabicTextNoDecimal
{
    [self confirmSendAmountWithText:@"١"];
}

- (void)confirmSendAmountDecimalPeriodArabicTextDecimalFirst
{
    [self confirmSendAmountWithText:@".١٠"];
}

- (void)confirmSendAmountDecimalPeriodArabicTextZeroThenDecimal
{
    [self confirmSendAmountWithText:@"٠.١٠"];
}

- (void)confirmSendAmountDecimalPeriodArabicTextNumberThenDecimal
{
    [self confirmSendAmountWithText:@"١.١٠"];
}

// Comma separator

- (void)confirmSendAmountDecimalCommaDecimalFirst
{
    [self confirmSendAmountWithText:@",10"];
}

- (void)confirmSendAmountDecimalCommaZeroThenDecimal
{
    [self confirmSendAmountWithText:@"0,10"];
}

- (void)confirmSendAmountDecimalCommaNumberThenDecimal
{
    [self confirmSendAmountWithText:@"1,10"];
}

- (void)confirmSendAmountDecimalCommaArabicTextDecimalFirst
{
    [self confirmSendAmountWithText:@",١٠"];
}

- (void)confirmSendAmountDecimalCommaArabicTextZeroThenDecimal
{
    [self confirmSendAmountWithText:@"٠,١٠"];
}

- (void)confirmSendAmountDecimalCommaArabicTextNumberThenDecimal
{
    [self confirmSendAmountWithText:@"١,١٠"];
}

// Arabic Comma separator

- (void)confirmSendAmountDecimalArabicCommaDecimalFirst
{
    [self confirmSendAmountWithText:@"٫10"];
}

- (void)confirmSendAmountDecimalArabicCommaZeroThenDecimal
{
    [self confirmSendAmountWithText:@"0٫10"];
}

- (void)confirmSendAmountDecimalArabicCommaNumberThenDecimal
{
    [self confirmSendAmountWithText:@"1٫10"];
}

- (void)confirmSendAmountDecimalArabicCommaAndTextDecimalFirst
{
    [self confirmSendAmountWithText:@"٫١٠"];
}

- (void)confirmSendAmountDecimalArabicCommaAndTextZeroThenDecimal
{
    [self confirmSendAmountWithText:@"٠٫١٠"];
}

- (void)confirmSendAmountDecimalArabicCommaAndTextNumberThenDecimal
{
    [self confirmSendAmountWithText:@"١٫١٠"];
}

- (void)confirmSendAmountWithText:(NSString *)text
{
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SEND_FIAT_FIELD];
    [self enterTextIntoCurrentFirstResponder:text];
    [self waitForAnimationsToFinish];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_CONTINUE_PAYMENT];
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MODAL_BACK_CHEVRON];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_MODAL_BACK_CHEVRON];
    [self clearTextFromViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_SEND_FIAT_FIELD];
}

#pragma mark - Receive

- (void)goToReceive
{
    [self waitForTappableViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_RECEIVE_TAB];
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_RECEIVE_TAB];
}

- (uint64_t)confirmReceiveAmount:(NSString *)randomAmount
{
    [self tapViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_RECEIVE_FIAT_FIELD];
    [self clearTextFromViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_RECEIVE_FIAT_FIELD_INPUT_ACCESSORY];
    [self enterTextIntoCurrentFirstResponder:randomAmount];
    [self waitForAnimationsToFinish];
    
    UITextField *textField = (UITextField *)[self waitForViewWithAccessibilityLabel:ACCESSIBILITY_LABEL_RECEIVE_FIAT_FIELD];
    return [app.wallet parseBitcoinValueFromTextField:textField];
}

- (uint64_t)computeBitcoinValue:(NSString *)amount
{
    return [app.wallet parseBitcoinValueFromString:amount];
}

@end