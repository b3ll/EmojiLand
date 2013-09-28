//
//  🐑.m
//  emojiland
//
//  Created by Adam Bell on 9/28/2013.
//  Copyright (c) 2013 Adam Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>
#import <objc/objc-class.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

static NSString* description(id self, SEL _cmd) {
    return [NSString stringWithFormat:@"I am a %@ with a pointer: %p", NSStringFromClass([self class]), self];
}

static void startTheParty(id self, SEL _cmd) {
    NSLog(@"🎉🎈🎊🎂🎁");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Class sheepClass = objc_allocateClassPair([NSObject class], [@"🐑" UTF8String], 0);
        
        Method descriptionMethod = class_getInstanceMethod([NSObject class], @selector(description));
        
        const char *types = method_getTypeEncoding(descriptionMethod);
        
        class_addMethod(sheepClass, @selector(description), (IMP)description, types);
        
        class_addMethod(sheepClass, NSSelectorFromString(@"🎉"), (IMP)startTheParty, "v@:");
        
        objc_registerClassPair(sheepClass);
        
        // Create a Sheep
        id sheep = [[NSClassFromString(@"🐑") alloc] init];
        
        // Print out the Sheep
        NSLog(@"%@", sheep);
        
        // Start the Party
        [sheep performSelector:NSSelectorFromString(@"🎉")];
    }
    return 0;
}

#pragma clang diagnostic pop
