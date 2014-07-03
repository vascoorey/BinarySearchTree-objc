//
//  BinarySearchTree.m
//  BinarySearchTree
//
//  Created by Vasco d'Orey on 02/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "BinarySearchTree.h"

@interface Node : NSObject

@property (nonatomic, copy) id key;
@property (nonatomic, strong) id object;

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;

@property (nonatomic) int nodesInSubtree;

+ (instancetype)nodeWithKey:(id)key object:(id)object nodesInSubtree:(int)nodesInSubtree;

@end

@implementation Node

+ (instancetype)nodeWithKey:(id)key object:(id)object nodesInSubtree:(int)nodesInSubtree {
  NSParameterAssert(key);
  NSParameterAssert(object);
  
  Node *n = [[self alloc] init];
  n.key = key;
  n.object = object;
  n.nodesInSubtree = nodesInSubtree;
  
  return n;
}

- (id)copy {
  Node *copied = [[self class] nodeWithKey:self.key object:self.object nodesInSubtree:self.nodesInSubtree];
  copied.left = self.left;
  copied.right = self.right;
  return copied;
}

@end

@interface BinarySearchTree()

@property (nonatomic, strong) Node *root;

- (int)sizeForNode:(Node *)node;

- (id)objectForKey:(id)key node:(Node *)node;
- (Node *)setObject:(id)object forKey:(id)key node:(Node *)node;

- (Node *)minForNode:(Node *)node;
- (Node *)maxForNode:(Node *)node;
- (Node *)floorForNode:(Node *)node key:(id)key;
- (Node *)ceilingForNode:(Node *)node key:(id)key;

- (Node *)select:(Node *)node k:(int)k;
- (int)rankForNode:(Node *)node key:(id)key;

- (Node *)removeMinForNode:(Node *)node;
- (Node *)removeObjectForNode:(Node *)node key:(id)key;

- (NSString *)logNode:(Node *)node;

- (NSArray *)keysForMin:(id)min max:(id)max;
- (void)keysForNode:(Node *)node array:(NSMutableArray *)keys min:(id)min max:(id)max;

@end

@implementation BinarySearchTree

#pragma mark - Size

- (int)size {
  return [self sizeForNode:self.root];
}

- (int)sizeForNode:(Node *)node {
  if(!node) return 0;
  
  return node.nodesInSubtree;
}

#pragma mark - Get/Put

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
  return [self objectForKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)key {
  [self setObject:object forKey:key];
}

- (id)objectForKey:(id)key {
  return [self objectForKey:key node:self.root];
}

- (id)objectForKey:(id)key node:(Node *)node {
  if(!node) return nil;
  
  NSComparisonResult result = [key compare:node.key];
  if(result == NSOrderedAscending) {
    return [self objectForKey:key node:node.left];
  } else if(result == NSOrderedDescending) {
    return [self objectForKey:key node:node.right];
  } else {
    return node.object;
  }
}

- (void)setObject:(id)object forKey:(id)key {
  self.root = [self setObject:object forKey:key node:self.root];
}

- (Node *)setObject:(id)object forKey:(id)key node:(Node *)node {
  if(!node) {
    return [Node nodeWithKey:key object:object nodesInSubtree:1];
  }
  
  NSComparisonResult result = [key compare:node.key];
  if(result == NSOrderedAscending) {
    node.left = [self setObject:object forKey:key node:node.left];
  } else if(result == NSOrderedDescending) {
    node.right = [self setObject:object forKey:key node:node.right];
  } else {
    node.object = object;
  }
  node.nodesInSubtree = [self sizeForNode:node.left] + [self sizeForNode:node.right] + 1;
  
  return node;
}

#pragma mark - Operators

- (id)min {
  return [self minForNode:self.root].key;
}

- (Node *)minForNode:(Node *)node {
  if(!node.left) return node;
  return [self minForNode:node.left];
}

- (id)max {
  return [self maxForNode:self.root].key;
}

- (Node *)maxForNode:(Node *)node {
  if(!node.right) return node;
  return [self maxForNode:node.right];
}

- (id)floorForKey:(id)key {
  return [self floorForNode:self.root key:key].key;
}

- (Node *)floorForNode:(Node *)node key:(id)key {
  if(!node) return nil;
  
  NSComparisonResult result = [key compare:node.key];
  if(result == NSOrderedSame) {
    return node;
  } else if(result == NSOrderedAscending) {
    return [self floorForNode:node.left key:key];
  }
  
  Node *t = [self floorForNode:node.right key:key];
  if(t) return t;
  
  return node;
}

- (id)ceilingForKey:(id)key {
  return [self ceilingForNode:self.root key:key].key;
}

- (Node *)ceilingForNode:(Node *)node key:(id)key {
  if(!node) return nil;
  
  NSComparisonResult result = [key compare:node.key];
  if(result == NSOrderedSame) {
    return node;
  } else if(result == NSOrderedDescending) {
    return [self floorForNode:node.left key:key];
  }
  
  Node *t = [self floorForNode:node.right key:key];
  if(t) return t;
  
  return node;
}

- (id)select:(int)k {
  return [self select:self.root k:k].key;
}

- (Node *)select:(Node *)node k:(int)k {
  if(!node) return nil;
  
  int size = [self sizeForNode:node.left];
  if(size > k) {
    return [self select:node.left k:k];
  } else if(size < k) {
    return [self select:node.right k:(k - size - 1)];
  }
  
  return node;
}

- (int)rankForKey:(id)key {
  return [self rankForNode:self.root key:key];
}

- (int)rankForNode:(Node *)node key:(id)key {
  if(!node) return 0;
  
  NSComparisonResult result = [key compare:node.key];
  if(result == NSOrderedAscending) {
    return [self rankForNode:node.left key:key];
  } else if(result == NSOrderedDescending) {
    return 1 + [self sizeForNode:node.left] + [self rankForNode:node.right key:key];
  }
  
  return [self sizeForNode:node.left];
}

#pragma mark - Deletes

- (void)removeMin {
  self.root = [self removeMinForNode:self.root];
}

- (Node *)removeMinForNode:(Node *)node {
  if(!node.left) {
    return node.right;
  }
  node.left = [self removeMinForNode:node.left];
  node.nodesInSubtree = [self sizeForNode:node.left] + [self sizeForNode:node.right] + 1;
  
  return node;
}

- (void)removeObjectForKey:(id)key {
  self.root = [self removeObjectForNode:self.root key:key];
}

- (Node *)removeObjectForNode:(Node *)node key:(id)key {
  if(!node) return nil;
  
  NSComparisonResult result = [key compare:node.key];
  if(result == NSOrderedAscending) {
    node.left = [self removeObjectForNode:node.left key:key];
  } else if(result == NSOrderedDescending) {
    node.right = [self removeObjectForNode:node.right key:key];
  } else {
    if(!node.right) {
      return node.left;
    } else if(!node.left) {
      return node.right;
    }
    
    Node *newNode = [node copy];
    node = [self minForNode:newNode.right];
    node.right = [self removeMinForNode:newNode.right];
    node.left = newNode.left;
  }
  node.nodesInSubtree = [self sizeForNode:node.left] + [self sizeForNode:node.right] + 1;
  
  return node;
}

#pragma mark - Logging

- (NSString *)logNode:(Node *)node {
  if(!node) return @"";
  
  NSString *log = @"";
  log = [log stringByAppendingString:[self logNode:node.left]];
  log = [log stringByAppendingFormat:@"%@", node.object];
  log = [log stringByAppendingString:[self logNode:node.right]];
  
  return log;
}

- (NSString *)description {
  return [self logNode:self.root];
}

#pragma mark - Enumeration

- (NSArray *)keys {
  return [self keysForMin:[self min] max:[self max]];
}

- (NSArray *)keysForMin:(id)min max:(id)max {
  NSMutableArray *a = [NSMutableArray array];
  [self keysForNode:self.root array:a min:min max:max];
  return a;
}

- (void)keysForNode:(Node *)node array:(NSMutableArray *)keys min:(id)min max:(id)max {
  if(!node) return;
  
  NSComparisonResult low = [min compare:node.key];
  NSComparisonResult high = [max compare:node.key];
  
  if(low == NSOrderedAscending) {
    [self keysForNode:node.left array:keys min:min max:max];
  }
  if((low == NSOrderedSame || low == NSOrderedAscending) && (high == NSOrderedDescending || high == NSOrderedSame)) {
    [keys addObject:node.key];
  }
  if(high == NSOrderedDescending) {
    [self keysForNode:node.right array:keys min:min max:max];
  }
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id, id, BOOL *))block {
  BOOL *stop = NO;
  for(id key in self.keys) {
    block(key, [self objectForKey:key], stop);
    if(stop) {
      return;
    }
  }
}

@end
