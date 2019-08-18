//
//  NSColor+.swift
//  NetworkChecker
//
//  Created by 국윤수 on 18/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Cocoa

extension NSColor {
  static var danger: NSColor {
    return NSColor(rgbHex: 0xff6666)
  }

  convenience init(rgbHex: UInt) {
    self.init(red: CGFloat((rgbHex & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbHex & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbHex & 0x0000FF) / 255.0,
              alpha: 1.0)
  }

}
