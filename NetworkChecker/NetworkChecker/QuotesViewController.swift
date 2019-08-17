//
//  QuotesViewController.swift
//  NetworkChecker
//
//  Created by 국윤수 on 18/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {

  @IBOutlet weak var textLabel: NSTextField!

  let quotes = Quote.all

  var currentQuoteIndex = 0 {
    didSet {
      updateQuote()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    currentQuoteIndex = 0
  }

  private func updateQuote() {
    textLabel.stringValue = String(describing: quotes[currentQuoteIndex])
  }

}

// MARK: Actions

extension QuotesViewController {
  @IBAction func previous(_ sender: NSButton) {
    currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
  }

  @IBAction func next(_ sender: NSButton) {
    currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
  }

  @IBAction func quit(_ sender: NSButton) {
    NSApplication.shared.terminate(sender)
  }
}

extension QuotesViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> QuotesViewController {
    //1.
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)

    //2.
    let identifier = NSStoryboard.SceneIdentifier("QuotesViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? QuotesViewController else {
      fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
