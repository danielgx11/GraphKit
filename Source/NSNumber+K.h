//
//  NSNumber+K.h
//  Sonar
//
//  Created by João Pedro Souza on 21/11/16.
//  Copyright © 2016 iOasys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (K)

- (NSString *)abbreviateNumber;

- (NSString *)currencyFormatter;
- (NSString *)numberFormatter;
- (NSString *)percentFormatter;

@end
