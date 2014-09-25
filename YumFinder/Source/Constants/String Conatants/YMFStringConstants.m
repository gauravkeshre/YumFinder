//
//  YMFStringConstants.m
//  Yumfinder
//
//  Created by Summer Green on 2/27/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFStringConstants.h"

NSString *const kUsername = @"username";
NSString *const kPassword = @"password";

#pragma mark - Messages Methods
NSString *const msgConfirmLogout    = @"Are you sure you want to logout?";


//Validatinon
NSString *const msgInvalidFilePath         = @"Not a valid file path.";
NSString *const msgErrorInvalidPath        = @"Invalid File Path.";

NSString *const msgErrTests                 = @"Test Data Not Found.";
NSString *const msgNoTestsAvailable         = @"No tests found.";

NSString *const msgLoginErrorTitle              = @"Login";
NSString *const msgForgotPasswordErrorTitle     = @"Forgot Password";
NSString *const msgUpdateErrorTitle             = @"Update Profile";

NSString *const msgInvalidUsername      = @"Invalid username.";
NSString *const msgInvalidEmail         = @"Invalid Email.";
NSString *const msgInvalidPassword      = @"Invalid Email/Password.";


NSString *const msgValidateEmail     = @"Please enter a valid email address.";
NSString *const msgEmptyEmail        = @"Email address cannot be empty.";
NSString *const msgValidateUsername  = @"Please enter a valid username.";
NSString *const msgValidatePassword  = @"Please enter a valid password.";
NSString *const msgEmptyPassword     = @"Password cannot be empty.";
NSString *const msgShortPassword     = @"Password should be of minimum 6 characters.";
NSString *const msgLongPassword      = @"Password should be of maximum 20 characters.";

NSString *const msgConnectionError =@"Connection Error";
NSString *const msgSubmitAgain=@"Please check you internet connection and then submit again";
NSString *const msgNoInternetConnection =@"Cannot Load. Please check your internet connection.";
NSString *const msgRequiredFieldMissingError = @"Please fill in all the required fields and try again";

NSString *const msgPleaseWait                  = @"Please wait...";


#pragma mark -  Methods
NSString *const msgErrorNoDataAvailable = @"No Data available. \nTry again later.";

NSString *const msgSomeErrorOccuurred = @"Some Error Occurred!";

/*
 *  Search
 */
#pragma mark - Search Methods

NSString *const msgInvalidSearchHashtag = @"Please enter a valid input!!!";
NSString *const msgInvalidSearchKeyword = @"Please enter atleast 2 characters to search!!!";

#pragma mark - Account Methods

#pragma mark - Notifications
NSString *const msgNoNotificationAvailable = @"No notifications found";


#pragma mark - latest Activity
NSString *const msgNoLatestActivityAvailable = @"No recent activity found";

#pragma mark - category listing
NSString *const msgNoCategoriesAvailable =@"No categories available";
NSString *const msgNetworkError=@"Network error!";
NSString *const msgFailedToRetrieveData =@"Failed to retrieve data";
NSString *const msgTestNotFound =@"Test Not Found";

#pragma mark - Cancel Test
NSString *const msgCancelWarning= @"Are you sure to cancel the test?";
NSString *const msgCancelTest=@"If you cancel the test it will taken as attempt";

#pragma mark - test Submission
NSString *const msgTimeUP=@"Time Up";
NSString *const msgArrOFAnsweredQuestion= @"mArrOFAnsweredQuestion";
NSString *const msgCorrectAnsweredCount= @"correctAnsweredCount";
NSString *const msgQuestionCount= @"questionCount";
NSString *const msgSubmittingTest=@"Submitting Your Test";
NSString *const msgSuccessSubmissionTest=@"Congratulations! You have successfully completed the test.";
NSString *const msgMissingData= @"Data Missing.....";
NSString *const msgMissingTestData= @"Your test data is missing";
NSString *const msgOfflineSubmissionStatus= @"Please Note : Your score has been recorded in the app, but couldn't be submitted to the server as there is no internet connectivity. You need to submit your score manually when you are connected.";
NSString *const msgOfflineTestStartStatus= @"Couldn't prepare the test , please insure that you are connected to the internet before starting the test.";
NSString *const msgOfflineResubmissionStatus= @"Couldn't submit your test , you have to connect to the internet before submitting the test.";

#pragma mark - ebooks listing
NSString *const msgNoEbooksAvailable  =@"No activity available on E-Books";
NSString *const msgNoEbooskInCategory =@"No eBooks available under this category";

#pragma mark - myHistory -tests
NSString *const msgNoTestHistoryAvailable = @"No activity available on tests";

#pragma mark - myHistory - Ebooks
NSString *const msgNoEbooksHistoryAvailable = @"No ebook activity available";

#pragma mark - myProfile
NSString *const msgSuccesSubmissionOfProfile        = @"Your profile was updated successfully.";
NSString *const msgValidateConfirmEmail             = @"Email's are not matching. Please check it and try again.";
NSString *const msgValidateConfirmPassword          = @"Passwords are not matching. Please check it and try again.";
NSString *const msgValidateFirstName                = @"First Name not valid please check it.";
NSString *const msgValidateLastName                 = @"Last Name not valid please check it.";
NSString *const msgValidateConfirmEmailId           = @"Confirm Email ID not valid please check it.";
NSString *const msgValidateEmployeeId               = @"Email ID not valid please check it";
NSString *const msgValidatePhoneNumber              = @"Phone number not valid.";
NSString *const msgValidateContactPerson            = @"Contact Person name is invalid.";
NSString *const msgValidateContactPersonPhoneNo     = @"Contact Person Phone number is invalid.";

NSString *const msgEmptyConfirmPassword  = @"Confirm Password cannot be empty.";
NSString *const msgEmptyFirstName        = @"First Name cannot be empty.";
NSString *const msgEmptyLastName         = @"Last Name cannot be empty.";
NSString *const msgEmptyConfirmEmail     = @"Confirm Email ID cannot be empty.";
NSString *const msgEmptyEmployeeId       = @"Employee ID cannot be empty.";
NSString *const msgEmptyPhoneNumber      = @"Phone number cannot be empty.";


#pragma mark - Feedback
NSString *const msgFeedbackEmail     = @"admin@dmos.com";
NSString *const msgFeedbackSubject   = @"Comments/Feedback";
NSString *const msgFeedbackBody      = @"If you have any concerns or feedback while using this application, please feel free to send us an email about the matter here.";

#pragma mark - uiimage picker
NSString *const msgNoImageSourceAvailable      = @"No Source for photo available";
NSString *const msgNoImageSourceAvailableError = @"It seems the device do not have the Photogallery configured.";


#pragma mark - Forgot password
NSString *const msgSuccessForgotPassword        = @"if you didn't receive an email from us, please try again after 15 minutes.";
NSString *const msgSuccessForgotPasswordHeader  = @"OK. We've sent you new password.";

#pragma mark - Test Status

NSString *const msgPassed   =@"Passed";
NSString *const msgFailed   =@"Failed";
NSString *const msgBlocked  =@"Blocked";
NSString *const msgRetake   =@"Retake";
NSString *const msgTake     =@"Take";

#pragma mark - Core Data

NSString *const msgCoreDataSavingError  =@"Whoops, couldn't save: %@";

#pragma mark - Test disclaimer
NSString *const msgStartingTest             = @"Starting your Test";
NSString *const msgDownloadingTest          = @"Downloading for your test...";
NSString *const msgPreparingTest            = @"Your test is being prepared. Please wait...";
NSString *const msgDownloadTestCompleted    = @"Your test downloading completed. Please tap on start to take the test.";
NSString *const msgTestPrepared             = @"Test is ready. Tap on start to proceed.";

#pragma mark - download Status
NSString *const msgDownloadCompleted            =@"Download completed, Start reading presentation";
NSString *const msgDownloadPending              =@"Download e-book";
NSString *const msgDownloadUpdatesAvailable     =@"Update Available. Please redownload the Ebook";

#pragma mark - Location Manager
NSString *const msgLocationManagerServiceDisabled = @"Location Services are currently disabled. Your location is unable to be identified.";

NSString * const msgLocationServivceDisabledWithSettingMessage =@"Location Service is Disabled. To re-enable, please go to Settings and turn on Location Service for this app.";
NSString * const msgUnableToFindLocation    =@"Unable To Get Current Location.";
NSString * const msgErrorNetwork            =@"Please check your network connection or that you are not in airplane mode.";
NSString * const msgErrorDenied             =@"User has denied to use current Location.";
NSString * const msgErrorHeadingFailure     =@"The heading could not be determined.";

