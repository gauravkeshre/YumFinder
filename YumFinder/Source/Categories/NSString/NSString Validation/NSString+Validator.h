//
//  NSString+Validator.h
//  Nimar Labs
//
//  Created by Summer Green on 1/22/13.
//  Copyright (c) 2013 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString *rgxEmailID;
extern const NSString *rgxUSPhoneNumber;
extern const NSString *rgxURL;
extern const NSString *rgxBirthdateMonth;
extern const NSString *rgxUsername;
extern const NSString *rgxName;

typedef enum {
    SWValidValue = 0,
    SWInvalidValue,//1
    SWUnderflow,//2
    SWOverflow//3
}SWValidatorResponse;

@interface NSString (Validator)


+(BOOL)validateEmail:(NSString *)email_string;
-(BOOL)isValidEmailAddress;

+(BOOL)validateUSPhoneNumber:(NSString *)phone;
-(BOOL)isValidUSPhoneNumber;

+(BOOL)validateForComplexPassword:(NSString *)password;
-(BOOL)isValidComplexPassword;

+(BOOL)validateZipcode:(NSString*)zipcode;
-(BOOL)isValidZipcode;

+(BOOL)validateForNumeric;
-(BOOL)isValidNumeric;

+(BOOL)validateForURL:(NSString *)string;
- (BOOL)isValidURL;

+(BOOL)validateForBirthday:(NSString *)string;
-(BOOL)isValidBirthday;

+(BOOL)validateForMonth:(NSString *)string;
-(BOOL)isValidMonth;

+(BOOL)validateName:(NSString *)string;
-(BOOL)isValidName;

+(BOOL)validateCategoryName:(NSString *)string;
-(BOOL)isValidCategoryName;

+(BOOL)isProperString:(NSString *)string;
-(BOOL)isProperString;

+(BOOL)isProperHashTagString:(NSString *)string;
-(BOOL)isProperHashTagString;


#pragma mark - validating Emojis
+(BOOL)containEmojis:(NSString *)string;
-(BOOL)containEmojis;

#pragma mark - US Phone number Methods
+(NSString *)formateStringAsUSPhoneNumber:(NSString *)str;
-(NSString *)formateAsUSPhoneNumber;

+(NSString *)removePhoneNumberFormattingFromString:(NSString *)str;
-(NSString *)removePhoneNumberFormattingIfAny;

#pragma mark - Multivalue Methods
+(SWValidatorResponse)validatePassword:(NSString*)password;
-(SWValidatorResponse)isValidPassword;

+(SWValidatorResponse)validateForUsername:(NSString *)string;
-(SWValidatorResponse)isValidUsername;

#pragma mark - Convenient Methods
-(BOOL)hasOnlyWhiteSpaceAndNewLine;
@end
