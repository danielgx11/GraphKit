//
//  NSNumber+K.m
//  Sonar
//
//  Created by João Pedro Souza on 21/11/16.
//  Copyright © 2016 iOasys. All rights reserved.
//

#import "NSNumber+K.h"

@implementation NSNumber (K)

- (NSString *)abbreviateNumber {
    NSString *abbrevNum;
    float number = [self floatValue];
    
    // Prevent numbers smaller than 1000 to return NULL
    if (self.integerValue >= 1000) {
        NSArray *abbrev = @[ @"K", @"M", @"B" ];
        
        for (long i = abbrev.count - 1; i >= 0; i--) {
            // Convert array index to "1000", "1000000", etc
            int size = pow(10, (i + 1) * 3);
            
            if (size <= number) {
                // Removed the round and dec to make sure small numbers are included like: 1.1K
                // instead of 1K
                number = number / size;
                NSString *numberString = [self floatToString:number];
                
                // Add the letter for the abbreviation
                abbrevNum = [NSString stringWithFormat:@"%@%@", numberString, abbrev[i]];
            }
        }
    } else {
        // Numbers like: 999 returns 999 instead of NULL
        abbrevNum = [NSString stringWithFormat:@"%d", (int)number];
    }
    
    return abbrevNum;
}

- (NSString *)floatToString:(float)val {
    NSString *ret = [NSString stringWithFormat:@"%.2f", val];
    unichar c = [ret characterAtIndex:[ret length] - 1];
    
    while (c == 48) {  // 0
        ret = [ret substringToIndex:[ret length] - 1];
        c = [ret characterAtIndex:[ret length] - 1];
        
        // After finding the "." we know that everything left is the decimal number, so get a
        // substring excluding the "."
        if (c == 46) {  // .
            ret = [ret substringToIndex:[ret length] - 1];
        }
    }
    
    return ret;
}

- (NSString *)currencyFormatter {
    NSNumberFormatter *currencyNumberFormatter = [[NSNumberFormatter alloc] init];
    currencyNumberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    currencyNumberFormatter.currencySymbol = @"R$";
    currencyNumberFormatter.maximumFractionDigits = 2;
    currencyNumberFormatter.minimumFractionDigits = 2;
    currencyNumberFormatter.currencyGroupingSeparator = @".";
    currencyNumberFormatter.currencyDecimalSeparator = @",";

    return [currencyNumberFormatter stringFromNumber: self];
}

- (NSString *)numberFormatter {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.minimumFractionDigits = 2;
    numberFormatter.maximumFractionDigits = 2;
    numberFormatter.multiplier = @1;
    return [numberFormatter stringFromNumber: self];
}

- (NSString *)percentFormatter {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
    numberFormatter.minimumFractionDigits = 2;
    numberFormatter.maximumFractionDigits = 2;
    numberFormatter.multiplier = @1;
    return [numberFormatter stringFromNumber: self];
}

@end
