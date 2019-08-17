//
//  AppDelegate.swift
//  NetworkChecker
//
//  Created by 국윤수 on 18/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Cocoa
import CoreWLAN

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var ssid: String {
    return CWWiFiClient.shared().interface(withName: nil)?.ssid() ?? ""
  }

  let popover = NSPopover()

  var eventMonitor: EventMonitor?

  let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    if let button = statusItem.button {
      button.title = ssid
      button.action = #selector(togglePopover(_:))
    }

    constructMenu()

    eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
      if let strongSelf = self,
        strongSelf.popover.isShown {
        strongSelf.closePopover(sender: event)
      }
    }
  }

  @objc
  private func togglePopover(_ sender: Any?) {
    if popover.isShown {
      closePopover(sender: sender)
    } else {
      showPopover(sender: sender)
    }
  }

  private func showPopover(sender: Any?) {
    if let button = statusItem.button {
      popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
    }

    eventMonitor?.start()
  }

  private func closePopover(sender: Any?) {
    popover.performClose(sender)
    eventMonitor?.stop()
  }

  @objc
  private func printQuote(_ sender: Any?) {
    print("popover")
    popover.contentViewController = QuotesViewController.freshController()
    showPopover(sender: sender)
  }

  private func constructMenu() {
    let menu = NSMenu()

    menu.addItem(NSMenuItem(title: "SSID: \(ssid)", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "P"))
    menu.addItem(NSMenuItem.separator())
    menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

    statusItem.menu = menu
  }

}
