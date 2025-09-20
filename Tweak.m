#import <Foundation/Foundation.h>
#import <objc/runtime.h> 

@class UIScreen;

static BOOL new_isCaptured(UIScreen * self, SEL _cmd) {
    return NO;
}

static void (*orig__setCaptured)(UIScreen *, SEL, BOOL) = NULL;
static void new__setCaptured(UIScreen * self, SEL _cmd, BOOL captured) {
    return orig__setCaptured(self, _cmd, NO);
}

static UIScreen* new_mirroredScreen(UIScreen * self, SEL _cmd) {
    return nil;
}

__attribute__((constructor)) static void initialize(void) {
	const Class className = objc_getClass("UIScreen");
	{
		const Method method = class_getInstanceMethod(className, sel_registerName("isCaptured")); 
		method_setImplementation(method, (IMP)new_isCaptured);
	}
    const Method method = class_getInstanceMethod(className, sel_registerName("_setCaptured:")); 
    orig__setCaptured = (void (*)(UIScreen *, SEL, BOOL))method_getImplementation(method);
    method_setImplementation(method, (IMP)new__setCaptured);
	{
		const Method method = class_getInstanceMethod(className, sel_registerName("mirroredScreen")); 
		method_setImplementation(method, (IMP)new_mirroredScreen);
	}
}
