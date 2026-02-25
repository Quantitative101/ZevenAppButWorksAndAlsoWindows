//
//  JSONUtility.m
//  WhatsApp
//

#import "JSONUtility.h"

@implementation JSONUtility

+ (NSDictionary *)JSONParse:(NSString *)data {
    if (!data) {
        NSLog(@"Input string is nil");
        return nil;
    }

    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) {
        NSLog(@"Failed to convert string to NSData.");
        return nil;
    }

    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:0
                                                      error:&error];

    if (error || ![jsonObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Error parsing JSON: %@", error);
        return nil;
    }

    return jsonObject;
}

+ (NSString *)JSONStringify:(NSDictionary *)dictionary {
    if (!dictionary) {
        NSLog(@"Input dictionary is nil");
        return nil;
    }

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0
                                                         error:&error];

    if (!jsonData || error) {
        NSLog(@"Error serializing JSON: %@", error);
        return nil;
    }

    NSString *jsonString =
        [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];

    return jsonString;
}

@end
