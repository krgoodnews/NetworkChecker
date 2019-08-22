//
//  NetworkModel.swift
//  NetworkChecker
//
//  Created by 국윤수 on 19/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Foundation
import CoreWLAN

struct NetworkModel {

  static var currentSSID: String {
    return CWWiFiClient.shared().interface(withName: nil)?.ssid() ?? "What is?"
  }

  var customName: String? // Issue #3 문자열을 replace하기 위해 필요한 문자열
}
