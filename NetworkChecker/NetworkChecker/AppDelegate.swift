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
    return CWWiFiClient.shared().interface(withName: nil)?.ssid() ?? "What is?"
  }

  let popover = NSPopover()

  var eventMonitor: EventMonitor?

  let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    setWifiStatus()

    constructMenu()

    eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
      if let strongSelf = self,
        strongSelf.popover.isShown {
        strongSelf.closePopover(sender: event)
      }
    }

    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setWifiStatus), userInfo: nil, repeats: true)
  }

  /// Wifi 정보를 StatusItem에 보여준다
  @objc private func setWifiStatus() {
    guard let button = statusItem.button else {
      return
    }

    button.title = ssid
    button.contentTintColor = ssid == "wadiz guest free" ? .danger : nil
    button.action = #selector(togglePopover(_:))

    print(ssid)
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
  private func didTapAboutDeveloper(_ sender: Any?) {
    popover.contentViewController = AboutDeveloperVC.freshController()
    showPopover(sender: sender)
  }

  private func constructMenu() {
    let menu = NSMenu()

    menu.addItem(NSMenuItem(title: "개발자 정보", action: #selector(AppDelegate.didTapAboutDeveloper(_:)), keyEquivalent: ""))
    menu.addItem(NSMenuItem.separator())
    menu.addItem(NSMenuItem(title: "종료", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))

    statusItem.menu = menu
  }

}
