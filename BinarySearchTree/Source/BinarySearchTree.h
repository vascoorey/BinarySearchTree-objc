//
//  BinarySearchTree.h
//  BinarySearchTree
//
//  Created by Vasco d'Orey on 02/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinarySearchTree : NSObject

@property (nonatomic, readonly) int size;
@property (nonatomic, readonly) NSArray *keys;

- (id)objectForKey:(id)key;
- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)object forKey:(id)key;
- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)key;

- (id)min;
- (id)max;

- (id)floorForKey:(id)key;
- (id)ceilingForKey:(id)key;

- (id)select:(int)k;
- (int)rankForKey:(id)key;

- (void)removeMin;
- (void)removeObjectForKey:(id)key;

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id object, BOOL *stop))block;

@end
