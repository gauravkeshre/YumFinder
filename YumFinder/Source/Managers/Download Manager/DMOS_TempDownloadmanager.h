//
//  DMOS_TempDownloadmanager.h
//  DiamondOffshore
//
//  Created by Hemanth on 9/5/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SWDownloadProgressBlock)(float progressValue,NSInteger percentage);
typedef void (^SWDowloadFinished)(NSData* fileData,NSString* fileName);
typedef void (^SWDownloadFailBlock)(NSError*error);


#define kDownloadStatus @"Download_Status"
#define kDownloadProgress @"Download_Progress"
#define kDownloadUrl @"Download_Url"
#define kDownloadLocalPath @"Download_LocalPath"
#define kDownloads @"DiamondOffshore_downloads"
#define kDownloadType @"Download_Type"
#define kDownloadTypeImage @"Image"
#define kDownloadTypeFile @"File"
#define kDownloadFileID @"DownloadFileID"

typedef NS_ENUM(NSUInteger, DMOSDownloadStatus) {
    DMOSDownloadStatusUnknown,
    DMOSDownloadStatusStarting,
    DMOSDownloadStatusStarted,
    DMOSDownloadStatusComplete,
    DMOSDownloadStatusFailed
};

@protocol SWdownloaderDelegate <NSObject>
@required
-(void)SWDownloadProgress:(float)progress Percentage:(NSInteger)percentage;
-(void)SWDownloadFinished:(NSData*)fileData;
-(void)SWDownloadFail:(NSError*)error;
@end

@interface DMOS_TempDownloadmanager : NSObject<NSURLConnectionDataDelegate>

/**
 Get Receive NSData.
 */
@property (nonatomic,readonly) NSMutableData* receiveData;

/**
 Current Download Percentage
 */
@property (nonatomic,readonly) NSInteger downloadedPercentage;

/**
 `float` value for progress bar
 */
@property (nonatomic,readonly) float progress;

/**
 Server is allow resume or not
 */
@property (nonatomic,readonly) BOOL allowResume;

/**
 Suggest Download File Name
 */
@property (nonatomic,readonly) NSString* fileName;

/**
 Delegate Method
 */
@property (nonatomic,strong) id<SWdownloaderDelegate>delegate;


@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskID;


//initwith file URL and timeout
-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout;

-(void)startWithDownloading:(SWDownloadProgressBlock)progressBlock onFinished:(SWDowloadFinished)finishedBlock onFail:(SWDownloadFailBlock)failBlock;

-(void)startWithDelegate:(id<SWdownloaderDelegate>)delegate;
-(void)cancel;
-(void)pause;
-(void)resume;
@end
