//
//  ReplaceNameTableVC
//  NetworkChecker
//
//  Created by 국윤수 on 19/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Cocoa

final class ReplaceNameTableVC: NSViewController {

  // MARK: - View Model
  let viewModel = ReplaceNameViewModel()

  // MARK: - View
  @IBOutlet weak var tableView: NSTableView!

  // MARK: - Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupTableView()
    setupViewModelObserver()
  }

  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupViewModelObserver() {
    viewModel.bindableNames.bind { [unowned self] names in
      self.tableView.reloadData()
    }
  }

  @IBAction func didClickAdd(_ sender: NSButton) {
    viewModel.didClickAdd()
  }
}

extension ReplaceNameTableVC: NSTableViewDelegate, NSTableViewDataSource {

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
    return viewModel.bindableNames.value?.count ?? 0
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

    guard let replaceName = viewModel.bindableNames.value?[row] else { return nil }

    switch cellType {
    case .ssid:
      cell.textField?.stringValue = replaceName.originalName
    case .name:
      cell.textField?.isEditable = true
      cell.textField?.placeholderString = replaceName.originalName
      cell.textField?.stringValue = replaceName.visibleName ?? ""
    }

    return cell
  }

}

extension ReplaceNameTableVC {
  /// Storyboard instantiation
  static func freshController() -> ReplaceNameTableVC {
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)

    let identifier = NSStoryboard.SceneIdentifier("ReplaceNameTableVC")
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ReplaceNameTableVC else {
      fatalError("Why cant i find EditNameTableVC? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
