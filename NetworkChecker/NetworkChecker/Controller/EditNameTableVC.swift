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
    networks.append(NetworkModel(customName: ""))
  }
}

extension EditNameTableVC: NSTableViewDelegate, NSTableViewDataSource {

  fileprivate enum CellType {
    case ssid, name

    var cellID: String {
      switch self {
      case .ssid:
        return "SSIDCellID"
      case .name:
        return "NameCellID"
      }
    }
  }
  func numberOfRows(in tableView: NSTableView) -> Int {
    return networks.count
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    var cellType: CellType

    if tableColumn == tableView.tableColumns[0] {
      cellType = .ssid
    } else {
      cellType = .name
    }

    guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellType.cellID),
                                        owner: nil) as? NSTableCellView else {
      return nil
    }

    switch cellType {
    case .ssid:
      cell.textField?.stringValue = "\(cellType) \(row)"
    case .name:
      cell.textField?.isEditable = true
      cell.textField?.placeholderString = "\(cellType) \(row)"
    }

    return cell
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

