//
//  Comparable.h
//  BinarySearchTree
//
//  Created by Vasco d'Orey on 02/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, ComparisonResult) {
  /*!
   @abstract This result represents the case where both objects are equal
   */
  ComparisonResultEqual,
  /*!
   @abstract This result represents the case where the called object is greater than the object it was compared to
   */
  ComparisonResultGreaterThan,
  /*!
   @abstract This result represents the case where the called object is smaller than the object it was compared to
   */
  ComparisonResultLessThan
};

@protocol Comparable <NSObject, NSCopying>

- (ComparisonResult)compare:(id <Comparable>)other;

@end
