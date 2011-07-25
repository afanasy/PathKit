//
// PathKit
// Copyright(c) 2011 Afanasy Kurakin <afanasy@gmail.com>
// BSD Licensed
//

#import <Foundation/Foundation.h>

@interface NSArray (PathKit)
- (id)get:(id)path;
@end

@interface NSMutableArray (PathKit)
- (void)post:path this:(id)value;
- (void)delete:(id)path;
- (void)merge:(id)value;
@end

@interface NSDictionary (PathKit)
- (id)get:(id)path;
@end

@interface NSMutableDictionary (PathKit)
- (void)post:(NSString*)pathString this:(id)value;
- (void)delete:(id)pathString;
- (void)merge:(id)value;
@end

@interface NSNull (deepMutableCopy)
- (id)deepMutableCopy;
@end

@interface NSNumber (deepMutableCopy)
- (id)deepMutableCopy;
@end

@interface NSString (deepMutableCopy)
- (id)deepMutableCopy;
@end

@interface NSArray (deepMutableCopy)
- (id)deepMutableCopy;
@end

@interface NSDictionary (deepMutableCopy)
- (id)deepMutableCopy;
@end