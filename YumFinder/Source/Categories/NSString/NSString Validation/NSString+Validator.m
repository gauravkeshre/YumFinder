//
//  NSString+Validator.m
//  Nimar Labs
//
//  Created by Summer Green on 1/22/13.
//  Copyright (c) 2013 Nimar Labs. All rights reserved.
//

#import "NSString+Validator.h"
const NSString *rgxName = @"\\w.*"; //@"[A-Za-z]+[0-9A-Za-z]*";//

const NSString *rgxUsername =  @"[a-zA-Z]+[0-9a-zA-Z]*[_ .]{0,1}[0-9a-zA-Z]+"
;
const NSString *rgxUsername_2 = @"[A-Za-z]{1,}[A-Za-z_.0-9]*[A-Za-z0-9]{1,}";
//[A-Za-z]+[A-Za-z_.0-9]*[A-Za-z0-9]+ -> equivalent to above one

const NSString *rgxEmailID = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

const NSString *rgxUSPhoneNumber =@"[(][0-9]{3}[)] [0-9]{3}[-][0-9]{4}"; //gk

const NSString *regexURL = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";

const NSString *rgxURL   = @"((http|https)://)*((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";

const NSString *rgxBirthdateMonth = @"^(0?[1-9]|[12]\\d|3[01]) \\b(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May?|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sept(?:ember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)$";

const NSString *rgxMonth= @"(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May?|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sept(?:ember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)$";

const NSString *rgxHashTag = @"#\\w+";


//@"[235689][0-9]{6}([0-9]{3})?" ;
//@"^(\+\d)*\s*(\(\d{3}\)\s*)*\d{3}(-{0,1}|\s{0,1})\d{2}(-{0,1}|\s{0,1})\d{2}$";


@implementation NSString (Validator)

-(BOOL)isValidEmailAddress{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rgxEmailID];
    return [emailTest evaluateWithObject:self];
}


+(BOOL)validateEmail:(NSString *)email{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rgxEmailID];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - Phone Number Methods
-(BOOL)isValidUSPhoneNumber{
    return [NSString validateUSPhoneNumber:self];

}

+(BOOL)validateUSPhoneNumber:(NSString *)phone{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rgxUSPhoneNumber];
    return [emailTest evaluateWithObject:phone];

}

#pragma mark - Password Methods
+(SWValidatorResponse)validatePassword:(NSString*)password{
    
    NSInteger len = [password length];
    if ([password hasOnlyWhiteSpaceAndNewLine]) {
        return SWInvalidValue;
    }
    if (len<6) {
        return SWUnderflow;
    }
    if (len>20) {
        return SWOverflow;
    }
    return SWValidValue;
}

-(SWValidatorResponse)isValidPassword{
    return [NSString validatePassword:self];
}



#pragma mark - Complex Password Methods
+(BOOL)validateForComplexPassword:(NSString *)password{
    if ([password length] < 6 ) {
        return NO;
    }
    // Check for character types
    BOOL isUppercase=NO;
    BOOL isLowercase=NO;
    BOOL isNumber=NO;
    for (unsigned int i = 0; i<[password length]; i++) {
        unichar c = [password characterAtIndex:i];
        if([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c]) {
            isUppercase = YES;
        }
        if([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c]) {
            isLowercase = YES;
        }
        if( c>='0' && c<='9') {
            isNumber = YES;
        }
    }
    if (!isUppercase || !isLowercase || !isNumber) {
        return NO;
    }
    return YES;
}
-(BOOL)isValidComplexPassword{
    return [NSString validateForComplexPassword:self];
}


#pragma mark - ZIP Code Methods

// Works for 5 digit zipcodes
+(BOOL)validateZipcode:(NSString*)zipcode {
    
    NSNumber *nmf = [[NSNumberFormatter alloc] numberFromString:zipcode];
    if([nmf isEqual:[NSNull null]] && [zipcode length] != 5 ) {
        
        nmf =nil;
        return NO;
    }
    
    nmf =nil;
    return YES;
}
-(BOOL)isValidZipcode{
    return [NSString validateZipcode:self];
}

#pragma mark - Numeric.. Methods
+(BOOL)validateForNumeric{
    return YES;
}

-(BOOL)isValidNumeric{
    return YES;
}

#pragma mark - URL Methods

+(BOOL)validateForURL:(NSString *)string{
    
    NSURL *url = [NSURL URLWithString:string];
    return (url && url.scheme && url.host);
}

+(BOOL)validateForMonth:(NSString *)string{
    NSPredicate *monthTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rgxMonth];
    return [monthTest evaluateWithObject:string];
}

- (BOOL)isValidURL
{
    return [NSString validateForURL:self];
}

#pragma mark - Birthday Methods 
// Format: 11 March

+(BOOL)validateForBirthday:(NSString *)string{
    NSPredicate *dobtest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rgxBirthdateMonth];
    return [dobtest evaluateWithObject:string];
    
}
-(BOOL)isValidBirthday{
    return [NSString validateForBirthday:self];
}

-(BOOL)isValidMonth{
    return [NSString validateForMonth:self];
}
#pragma mark - Username Methods

/*
 * begin with alpha
 * end with alpha
 * minummum 1 charachters
 * max length 20 Char
 * can have only _ and . 
 */
+(SWValidatorResponse)validateForUsername:(NSString *)string{
    
    NSInteger len = [string length];
    if (len < 1 || [string hasOnlyWhiteSpaceAndNewLine]) {
        return SWUnderflow;
    }
    
    if (len>20) {
        return SWOverflow;
    }
    
    NSPredicate *untest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rgxUsername];
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789_"] invertedSet];
    BOOL hasEmoji = ([string rangeOfCharacterFromSet:set].location!=NSNotFound);

    if ([untest evaluateWithObject:string] && !hasEmoji) {
        return SWValidValue;
    }
        return SWInvalidValue;
}
-(SWValidatorResponse)isValidUsername{
    return [NSString validateForUsername:self];
}

#pragma mark - HasEmojis
+(BOOL)containEmojis:(NSString *)string{
    
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}
-(BOOL)containEmojis{
     return [NSString containEmojis:self];
}


#pragma mark - Username Methods

/*
 * begin with alpha
 * connot contain special charachters
 */
+(BOOL)validateName:(NSString *)string{
    
//    NSPredicate *untest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rgxName];
    if ([string hasOnlyWhiteSpaceAndNewLine]) {
        return NO;
    }
    return YES;//[untest evaluateWithObject:string];

}
-(BOOL)isValidName{
    return [NSString validateName:self];
}
#pragma mark - Category name Methods
+(BOOL)validateCategoryName:(NSString *)string{
    return YES;
}
-(BOOL)isValidCategoryName{
    return [NSString validateCategoryName:self];
}

#pragma mark - General Srting Methods
+(BOOL)isProperString:(NSString *)string{
    return [string isProperString];
}
-(BOOL)isProperString{
    return (self!=nil && [self isValidURL] && [self length]>0 && ![self isEqualToString:@""] && ![self isEqual:[NSNull null]]);
}
#pragma mark - HashTag
+(BOOL)isProperHashTagString:(NSString *)string{
    return [string isProperHashTagString];
}

-(BOOL)isProperHashTagString{
    NSPredicate *hashTagtest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rgxHashTag];
    return [hashTagtest evaluateWithObject:self];
}


#pragma mark - Private Methods
-(BOOL)hasOnlyWhiteSpaceAndNewLine{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return ([[self stringByTrimmingCharactersInSet:set] length]<1);
}
#pragma mark - Convenience Methods
+(NSString *)formateStringAsUSPhoneNumber:(NSString *)str{
    str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    if([[str stringByTrimmingCharactersInSet:set] length]>0  || [str length]<10)return nil; //check if that
    
    NSArray *arr = @[[str substringWithRange:NSRangeFromString(@"{0,3}")], [str substringWithRange:NSRangeFromString(@"{3,3}")],[str substringWithRange:NSRangeFromString(@"{6,4}")]];
    return [NSString stringWithFormat:@"(%@) %@-%@",arr[0], arr[1], arr[2]];
}
-(NSString *)formateAsUSPhoneNumber{
    return [[self class]formateStringAsUSPhoneNumber:self];
}

#pragma mark - Convenience Methods
+(NSString *)removePhoneNumberFormattingFromString:(NSString *)str{
    str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return str;
}
-(NSString *)removePhoneNumberFormattingIfAny{
    return [[self class]removePhoneNumberFormattingFromString:self];
}
@end
