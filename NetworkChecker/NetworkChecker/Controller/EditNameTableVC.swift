//
//  EditNameTableVC.swift
//  NetworkChecker
//
//  Created by 국윤수 on 19/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Cocoa

class EditNameTableVC: NSViewController {

  var networks: [NetworkModel] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  @IBOutlet weak var tableView: NSTableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
  }

  @IBAction func didClickAdd(_ sender: NSButton) {
    let network = NetworkModel(ssid: "WIFI NAME", customName: "CUSTOM")
    networks.append(network)
  }
}

extension EditNameTableVC: NSTableViewDelegate, NSTableViewDataSource {

  func numberOfRows(in tableView: NSTableView) -> Int {
    return networks.count
  }

}

extension EditNameTableVC {
  /// Storyboard instantiation
  static func freshController() -> EditNameTableVC {
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)

    let identifier = NSStoryboard.SceneIdentifier("EditNameTableVC")
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? EditNameTableVC else {
      fatalError("Why cant i find EditNameTableVC? - Check Main.storyboard")
    }
    return viewcontroller
  }
}

