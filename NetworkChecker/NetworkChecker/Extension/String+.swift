//
//  String+.swift
//  NetworkChecker
//
//  Created by 국윤수 on 18/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Foundation

extension String {
  func replace(target: String, withString: String) -> String {
    return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
  }
}
