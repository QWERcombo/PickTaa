//
//  XSWJVASandBoxFileManager.h
//  BFZLShopMall-Dev
//
//  Created by SOPOCO_ljt on 2019/4/16.
//  Copyright © 2019 Pengyuzhifeng Technology Co., Ltd. All rights reserved.
//

/*
 iOS沙箱模型的有四个文件夹documents，tmp，app，Library
 （NSHomeDirectory()），
 手动保存的文件在documents文件里
 NSUserDefaults保存的文件在tmp文件夹里
 
 1、Documents 目录：您应该将所有的应用程序数据文件写入到这个目录下。这个目录用于存储用户数据或其它应该定期备份的信息。
 2、AppName.app 目录：这是应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，所以您在运行时不能对这个目录中的内容进行修改，否则可能会使应用程序无法启动。
 3、Library 目录：这个目录下有两个子目录：Caches 和 Preferences
 Preferences 目录：包含应用程序的偏好设置文件。您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.
 Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。此目录下文件不会在应用退出删除。
 4、tmp 目录：这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。此目录下文件可能会在应用退出后删除。
 */

#import <Foundation/Foundation.h>



@interface XSWJVASandBoxFileManager : NSObject

+ (NSString *)getHomeDirectory;
//获取Documents目录路径的方法
+ (NSString *)getDocumentsDirectory;
+ (NSString *)getDirectoryForDocuments:(NSString *)dir;
//获取Caches目录路径的方法：
+ (NSString *)getCachesDirectory;
//获取tmp目录路径的方法：
+ (NSString *)getTemporaryDirectory;
//获取应用程序程序包中资源文件路径的方法1
+ (NSString *)getMainBundleSoucePathOfName:(NSString *)fileName ofType:(NSString *)fileType;
//获取应用程序程序包中资源文件路径的方法2
+ (NSString *)getMainBundleSoucePathOfName:(NSString *)fileName;

+ (NSString *)getDirectoryOfDocumentFileWithName:(NSString *)fileName;
//判断某文件在path下面是否存在
+ (BOOL)isFileExitsAtPath:(NSString *)filePath;
//判断某文件在DocumentsPath下面是否存在
+ (BOOL)isFileExitsAtDocumentsPathWithName:(NSString *)fileName;
//移除DocumentsPath已存在的某个文件
+ (void)removeFileAtDocumentsPathWithName:(NSString *)fileName ;
+ (void)coptItemFormMainBundleToDocumentsWithFile:(NSString *)fileName;
+ (void)coptItemFormMainBundleToDocumentsWithFile:(NSString *)fileName ofType:(NSString *)fileType;

+ (NSString *)pathOnDiskForName:(NSString *)fileName dirPath:(NSString *)dirPath;
+ (BOOL)loadFromCacheIfPresent:(NSString *)fileName dirPath:(NSString *)dirPath;

#pragma mark - NSData的存放路径
+ (void)addSkipBackupAttributeToItemAtURL:(NSString *)path;
+ (NSString *)getDBNSDataDirectoryForName:(NSString *)dataName dir:(NSString *)dir;
+ (BOOL)saveData:(NSData *)fileData dir:(NSString *)dir name:(NSString *)fileName;
+ (BOOL)deleteDataFromDir:(NSString *)dir name:(NSString *)fileName;

#pragma mark - 图片相关
+ (NSString *)getDocumentsImageDirectoryForClass;
+ (BOOL)saveImageFromName:(NSString *)imageName data:(NSData *)imageData;
+ (BOOL)deleteImageFromName:(NSString *)imageName;
+ (UIImage *)getImageFromName:(NSString *)imageName;

#pragma mark - 声音相关
+ (NSString *)getDocumentsAudioDirectoryForClass;
+ (NSString *)getAudioPathFromName:(NSString *)audioName;
+ (BOOL)deleteAudioFromName:(NSString *)audioName;

+ (NSString *)getDocumentsDataDirectoryForClass;

@end


