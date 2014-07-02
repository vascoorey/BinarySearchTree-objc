//
//  BinarySearchTree.h
//  BinarySearchTree
//
//  Created by Vasco d'Orey on 02/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comparable.h"

@interface BinarySearchTree : NSObject

@property (nonatomic, readonly) int size;
/*!
 @abstract Of \c id<Comparable>
 */
@property (nonatomic, readonly) NSArray *keys;

- (id)objectForKey:(id <Comparable>)key;
- (void)setObject:(id)object forKey:(id <Comparable>)key;

- (id <Comparable>)min;
- (id <Comparable>)max;

- (id <Comparable>)floorForKey:(id <Comparable>)key;
- (id <Comparable>)ceilingForKey:(id <Comparable>)key;

- (id <Comparable>)select:(int)k;
- (int)rankForKey:(id <Comparable>)key;

- (void)removeMin;
- (void)removeObjectForKey:(id <Comparable>)key;

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id <Comparable> key, id object, BOOL *stop))block;

@end
