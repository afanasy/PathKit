//
// PathKit
// Copyright(c) 2011 Afanasy Kurakin <afanasy@gmail.com>
// BSD Licensed
//

#import "PathKit.h"

@implementation NSArray (PathKit)

- (id)get:(NSString*)path
{
    if(!path)
        return nil;
	if(![path length])
		return self;    
	if([path hasSuffix:@"/"])
		return [self get:[path substringToIndex:([path length] - 1)]];
	
	id p = [[path componentsSeparatedByString:@"/"] mutableCopy];
    
    int i = [[p objectAtIndex:0] intValue];
	
	if((i >= [self count]) || (i < 0))
		return nil;
    
	id subject = [self objectAtIndex:i];
    
	if([p count] == 1)
		return subject;
    
	if([subject respondsToSelector:@selector(get:)]) {
		[p removeObjectAtIndex:0];
		return [subject get:[p componentsJoinedByString:@"/"]];
	}
    
	return nil;
}

@end

@implementation NSMutableArray (PathKit)

- (void)post:(NSString*)path this:(id)value {
    
	if(!path)
		path = [NSString stringWithFormat:@"%d", [self count]];
    
	id p = [path componentsSeparatedByString:@"/"];
	
	id object = self;
	int i = 1;
	for(NSString* key in p) {
		id subject = nil;
		if([object respondsToSelector:@selector(get:)])
			subject = [object get:key];
		if(!subject) {
			if(i < [p count])
				subject = [[NSMutableDictionary dictionary] retain];
			else
				subject = value;
			
			if([object respondsToSelector:@selector(setObject:forKey:)] && (subject != nil)) {
				[object setObject:subject forKey:key];
			}
			else
				break;
		}
		object = subject;
		i ++;
	}
}

- (void)delete:(id)path
{
    if(!path)
        return;
    
    id p = [[path componentsSeparatedByString:@"/"] mutableCopy];
    id key = [p lastObject];
    [p removeLastObject];
    
    if(![p count]) {
        int i = [key intValue];
        
        if((i >= [self count]) || (i < 0))
            return;
        
        [self removeObjectAtIndex:i];        
    }
    else {
        id container = [self get:[p componentsJoinedByString:@"/"]];
        [container delete:key];
    }
}

- (void)merge:(id)value
{
	if([value isKindOfClass:[NSArray class]]) {

		for(int i = 0; i < [value count]; i++) {
			id v = [value objectAtIndex:i];
			if([self objectAtIndex:i]) {
				if([[self objectAtIndex:i] respondsToSelector:@selector(merge:)] && ([[self objectAtIndex:i] class] == [v class]))
					[[self objectAtIndex:i] merge:v];
				else 
					[self replaceObjectAtIndex:i withObject:[v deepMutableCopy]];
			}
			else
				[self addObject:[v deepMutableCopy]];
		}
	}
}

@end

@implementation NSDictionary (PathKit)

- (id)get:(NSString*)path
{
    if(!path)
        return nil;
	if(![path length])
		return self;
	if([path hasSuffix:@"/"])
		return [self get:[path substringToIndex:([path length] - 1)]];
    
	id p = [[path componentsSeparatedByString:@"/"] mutableCopy];
	
	id subject = [self objectForKey:[p objectAtIndex:0]];
    
	if([p count] == 1)
		return subject;
    
	if([subject respondsToSelector:@selector(get:)]) {
		[p removeObjectAtIndex:0];
		return [subject get:[p componentsJoinedByString:@"/"]];
	}
    
	return nil;
}

@end

@implementation NSMutableDictionary (PathKit)

- (void)post:(NSString*)path this:(id)value
{	
	id p = [path componentsSeparatedByString:@"/"];
	    
    id object = self;
    int i = 1;
    for(NSString* key in p) {
        id subject = nil;
        if([object respondsToSelector:@selector(objectForKey:)])
            subject = [object objectForKey:key];
        if(!subject) {
            if(i < [p count])
                subject = [[NSMutableDictionary dictionary] retain];
            else
                subject = value;
            if(subject != nil)
                [object setObject:subject forKey:key];
        }
        if((i == [p count]) && (subject != nil))
            [object setObject:value forKey:key];
        object = subject;
        i ++;
    }
}

- (void)delete:(id)path
{
    if(!path)
        return;
    
    id p = [[path componentsSeparatedByString:@"/"] mutableCopy];
    id key = [p lastObject];
    [p removeLastObject];
    
    if(![p count]) {
        [self removeObjectForKey:key];
    }
    else {
        id container = [self get:[p componentsJoinedByString:@"/"]];
        [container delete:key];
    }
}

- (void)merge:(id)value
{
	if([value isKindOfClass:[NSDictionary class]]) {
		for(NSString* key in value) {
			id v = [value objectForKey:key];
			if([self objectForKey:key] && [[self objectForKey:key] respondsToSelector:@selector(merge:)] && ([[self objectForKey:key] class] == [v class]))
                [[self objectForKey:key] merge:v];
			else
                [self setObject:[v deepMutableCopy] forKey:key];
		}
	}
}

@end

@implementation NSNull (deepMutableCopy)
- (id)deepMutableCopy {
    return [self copy];
}
@end

@implementation NSNumber (deepMutableCopy)
- (id)deepMutableCopy {
    return [self copy];
}
@end

@implementation NSString (deepMutableCopy)
- (id)deepMutableCopy {
    return [self mutableCopy];
}
@end

@implementation NSArray (deepMutableCopy)
- (id)deepMutableCopy {
	id r = [[NSMutableArray array] retain];
	for(id item in self)
		[r addObject:[item deepMutableCopy]];
	return r;
}
@end

@implementation NSDictionary (deepMutableCopy)
- (id)deepMutableCopy {
	id r = [[NSMutableDictionary dictionary] retain];
	for(NSString* key in self)
		[r setObject:[[self objectForKey:key] deepMutableCopy] forKey:key];
	return r;
}
@end
