//
//  String+Extension.swift
//  Eratosthenes
//
//  Created by doug harper on 9/23/17.
//  Copyright © 2017 Doug Harper. All rights reserved.
//

import Foundation

public extension String {
  public func deletingCharacters(in characters: CharacterSet) -> String {
    return self.components(separatedBy: characters).filter { !$0.isEmpty }.joined(separator: " ")
    }
  
  public mutating func deleteMillisecondsIfPresent() {
    if count == 24 {
      let range = index(endIndex, offsetBy: -5)..<index(endIndex, offsetBy: -1)
      removeSubrange(range)
    }
  
  }
}
