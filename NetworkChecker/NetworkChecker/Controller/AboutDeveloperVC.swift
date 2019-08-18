//
//  AboutDeveloperVC.swift
//  NetworkChecker
//
//  Created by 국윤수 on 18/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Cocoa

class AboutDeveloperVC: NSViewController {

  @IBOutlet weak var appVersionLabel: NSTextField!
  @IBOutlet weak var developerInfoLabel: NSTextField!

  override func viewDidLoad() {
    super.viewDidLoad()

    setVersionLabel()
    
  }

  private func setVersionLabel() {
    if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
      appVersionLabel.stringValue = "ver \(version)"
    }
  }

  @IBAction func didTapWebSite(_ sender: NSButton) {
    guard let url = URL(string: "https://yunsu.dev/") else {
      return
    }

    NSWorkspace.shared.open(url)
  }
}

extension AboutDeveloperVC {
  /// Storyboard instantiation
  static func freshController() -> AboutDeveloperVC {
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)

    let identifier = NSStoryboard.SceneIdentifier("AboutDeveloperVC")
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? AboutDeveloperVC else {
      fatalError("Why cant i find AboutDeveloperVC? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
