//
//  Bookshare.m
//  School Pad
//
//  Created by Timothy Roe Jr. on 8/11/15.
//  Copyright (c) 2015 Timothy Roe Jr. All rights reserved.
//

#import "Bookshare.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Bookshare

/*!
 @param
 */
-(void)downloadBooks:(NSString *)passwordToConvert:(NSString *)username:(NSString *)apiKey:(NSString *)contentId {
    NSString *md5 = [self md5:passwordToConvert];
    NSString *url = [NSString stringWithFormat: @"https://api.bookshare.org/download/content/%@/version/1/for/%@?api_key%@", contentId, username, apiKey];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request addValue:md5 forHTTPHeaderField:@"X-password"];
    NSLog(@"MD5 Hash: %@", request.allHTTPHeaderFields);
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(NSString *)md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Response From Server: %@", responseText);
}

-(void)saveBookWithId:(NSString *)contentId {
    
}

@end
