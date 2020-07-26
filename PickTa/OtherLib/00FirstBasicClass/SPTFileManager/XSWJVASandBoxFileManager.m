//
//  XSWJVASandBoxFileManager.m
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

#import "XSWJVASandBoxFileManager.h"

@implementation XSWJVASandBoxFileManager

// 获得家目录
+ (NSString *)getHomeDirectory {
    return NSHomeDirectory();
}

// 获取Caches目录路径的方法：
+ (NSString *)getCachesDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    
    return cachesPath;
}

// 获取tmp目录路径的方法：
+ (NSString *)getTemporaryDirectory {
    return NSTemporaryDirectory();
}

// 获取应用程序程序包中资源文件路径的方法1
+ (NSString *)getMainBundleSoucePathOfName:(NSString *)fileName ofType:(NSString *)fileType {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    
    return filePath;
}

// 获取应用程序程序包中资源文件路径的方法2
+ (NSString *)getMainBundleSoucePathOfName:(NSString *)fileName {
    NSString *paths = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [paths stringByAppendingPathComponent:fileName];
    
    return filePath;
}

#pragma mark - DocumentDirectory操作

// 获取Documents目录路径的方法
+ (NSString *)getDocumentsDirectory {
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        NSLog(@"Documents目录不存在");
    }
    return documentsDirectory;
    
#else
    NSString *homePath = [[NSBundle mainBundle] resourcePath];
    return homePath;
#endif
}

+ (NSString *)getDirectoryForDocuments:(NSString *)dir {
    NSString *dirPath = [[self getDocumentsDirectory] stringByAppendingPathComponent:dir];
    BOOL isDir = NO;
    BOOL isCreated = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir];
    
    if ( isCreated == NO || isDir == NO ) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (success == NO) {
            NSLog(@"create dir error: %@", error.debugDescription);
        }
    }
    
    [self addSkipBackupAttributeToItemAtURL:dirPath];
    
    return dirPath;
}

+ (NSString *)getDirectoryOfDocumentFileWithName:(NSString *)fileName {
    if ([fileName isEqualToString:@""]) {
        return nil;
    }
    
    NSString *documentsPath = [self getDocumentsDirectory];
    
    if (documentsPath) {
        return [documentsPath stringByAppendingPathComponent:fileName]; // 获取用于存取的目标文件的完整路径
    }
    
    return nil;
}

// 判断某文件在path下面是否存在
+ (BOOL)isFileExitsAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath isDirectory:NULL]) {
        return YES;
    }
    
    return NO;
}

// 判断某文件在DocumentsPath下面是否存在
+ (BOOL)isFileExitsAtDocumentsPathWithName:(NSString *)fileName {
    if ([fileName isEqualToString:@""]) {
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [self getDirectoryOfDocumentFileWithName:fileName];
    
    if ([fileManager fileExistsAtPath:filePath isDirectory:NULL]) {
        return YES;
    }
    
    return NO;
}

// 移除DocumentsPath已存在的某个文件
+ (void)removeFileAtDocumentsPathWithName:(NSString *)fileName {
    if ([fileName isEqualToString:@""]) {
        return;
    }
    
    NSError *error = nil;
    
    if ([self isFileExitsAtDocumentsPathWithName:fileName]) {
        [[NSFileManager defaultManager] removeItemAtPath:[self getDirectoryOfDocumentFileWithName:fileName] error:&error];
        
        if (error) {
            NSLog(@"移除文件失败，错误信息：%@", error);
        } else {
            NSLog(@"成功移除文件");
        }
    } else {
        NSLog(@"文件不存在");
    }
}


// copy bundle项目文件到Documents目录下
+ (void)coptItemFormMainBundleToDocumentsWithFile:(NSString *)fileName {
    if ([fileName isEqualToString:@""]) {
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *filePath = [self getDirectoryOfDocumentFileWithName:fileName];
    
    if ([fileManager fileExistsAtPath:filePath] == NO) {
        NSString *resourcePath = [self getMainBundleSoucePathOfName:fileName];
        [fileManager copyItemAtPath:resourcePath toPath:filePath error:&error];
    }
}


+ (void)coptItemFormMainBundleToDocumentsWithFile:(NSString *)fileName ofType:(NSString *)fileType {
    if ([fileName isEqualToString:@""]) {
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *documentsDirectory = [self getDocumentsDirectory];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, fileType]];
    
    if ([fileManager fileExistsAtPath:filePath] == NO) {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
        [fileManager copyItemAtPath:resourcePath toPath:filePath error:&error];
    }
}





#pragma mark - OTherHelps
// UIImage *image = ImageNamed(@"backBtn");
// NSData *imgData = nil;
// if (UIImagePNGRepresentation(image) == nil) {
//    imgData = UIImageJPEGRepresentation(image, 1);
// } else {
//    imgData = UIImagePNGRepresentation(image);
// }
// [SandBoxFileManage saveImageFromName:@"backBtn" data:imgData];


+ (NSString *)pathOnDiskForName:(NSString *)fileName dirPath:(NSString *)dirPath {
    return [NSString stringWithFormat:@"%@/%@", dirPath, fileName];
}

+ (BOOL)loadFromCacheIfPresent:(NSString *)fileName dirPath:(NSString *)dirPath {
    return [[NSFileManager defaultManager]
            fileExistsAtPath:[self pathOnDiskForName:fileName dirPath:dirPath]];
}

#pragma mark - NSData的存放路径

+ (void)addSkipBackupAttributeToItemAtURL:(NSString *)path {
    NSError *error = nil;
    NSURL *url = [NSURL fileURLWithPath:path];
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    //        BOOL success = [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    //        return success;
}

+ (NSString *)getDBNSDataDirectoryForName:(NSString *)dataName dir:(NSString *)dir { // AUDIO_DOC_NAME
    NSString *path = [NSString stringWithFormat:@"%@/%@", [XSWJVASandBoxFileManager getDocumentsDirectory], dir];
    
    if ([self isFileExitsAtPath:path] == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [self addSkipBackupAttributeToItemAtURL:path];
    return [NSString stringWithFormat:@"%@/%@/%@", [XSWJVASandBoxFileManager getDocumentsDirectory], dir, dataName];
}

+ (BOOL)saveData:(NSData *)fileData dir:(NSString *)dir name:(NSString *)fileName {
    NSString *path = [self getDBNSDataDirectoryForName:fileName dir:dir];
    
    if ([fileData writeToFile:path atomically:NO] == NO) {
        NSLog(@"save image failure");
        return NO;
    }
    return YES;
}

+ (BOOL)deleteDataFromDir:(NSString *)dir name:(NSString *)fileName {
    NSString *path = [self getDBNSDataDirectoryForName:fileName dir:dir];
    
    BOOL isDir = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    bool isDeleted = false;
    
    if (isDir == NO && existed == YES) {
        isDeleted = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    NSLog(@"删除%@成功与否：%d", fileName, isDeleted);
    return isDeleted;
}

#pragma mark - 图片

+ (NSString *)getDocumentsImageDirectoryForClass {
    NSString *imageDir = [[XSWJVASandBoxFileManager getDocumentsDirectory] stringByAppendingPathComponent:kImageDoc];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    //    [self addSkipBackupAttributeToItemAtURL:imageDir];
    
    return imageDir;
}


+ (BOOL)saveImageFromName:(NSString *)imageName data:(NSData *)imageData {
    NSString *path = [self pathOnDiskForName:imageName dirPath:self.getDocumentsImageDirectoryForClass];
    
    return [imageData writeToFile:path atomically:YES];
}

+ (BOOL)deleteImageFromName:(NSString *)imageName {
    NSString *path = [self pathOnDiskForName:imageName dirPath:self.getDocumentsImageDirectoryForClass];
    
    BOOL isDir = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    bool isDeleted = false;
    
    if (isDir == NO && existed == YES) {
        isDeleted = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    return isDeleted;
}

+ (UIImage *)getImageFromName:(NSString *)imageName {
    NSString *path = [self pathOnDiskForName:imageName dirPath:self.getDocumentsImageDirectoryForClass];
    
    return [UIImage imageWithContentsOfFile:path];
}

#pragma mark - 声音

+ (NSString *)getDocumentsAudioDirectoryForClass {
    NSString *audioDir = [[XSWJVASandBoxFileManager getDocumentsDirectory] stringByAppendingPathComponent:kAudioDoc];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:audioDir withIntermediateDirectories:YES attributes:nil error:nil];
    //    [self addSkipBackupAttributeToItemAtURL:audioDir];
    
    return audioDir;
}

+ (NSString *)getAudioPathFromName:(NSString *)audioName {
    NSString *path = [self pathOnDiskForName:audioName dirPath:self.getDocumentsAudioDirectoryForClass];
    
    return path;
}

+ (BOOL)deleteAudioFromName:(NSString *)audioName {
    NSString *path = [self pathOnDiskForName:audioName dirPath:self.getDocumentsAudioDirectoryForClass];
    
    BOOL isDir = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    bool isDeleted = false;
    
    if (isDir == NO && existed == YES) {
        isDeleted = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    return isDeleted;
}

+ (NSString *)getDocumentsDataDirectoryForClass {
    NSString *audioDir = [[XSWJVASandBoxFileManager getDocumentsDirectory] stringByAppendingPathComponent:@"DataDoc"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:audioDir withIntermediateDirectories:YES attributes:nil error:nil];
    //    [self addSkipBackupAttributeToItemAtURL:audioDir];
    
    return audioDir;
}


@end
