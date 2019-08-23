//
//  ReplaceViewModel.swift
//  NetworkChecker
//
//  Created by 국윤수 on 23/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Cocoa

final class ReplaceNameViewModel {

  var bindableNames = Bindable<[ReplaceName]>()

  func didClickAdd() {
    let currentSSID = Network.currentSSID

    // 중복된 이름으로 저장된 객체가 없으면 현재 와이파이 정보를 추가한다.
    let isAlreadyContain = bindableNames.value?.map { $0.originalName }.contains(currentSSID)
    if isAlreadyContain?.not() == true {
      bindableNames.value?.append(ReplaceName(originalName: Network.currentSSID, visibleName: nil))
    }
  }

  init() {
    bindableNames.value = []
  }
}
