import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var popover = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()
        popover.contentSize = NSSize(width: 300, height: 200)
        popover.contentViewController = NSHostingController(rootView: contentView)

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "key.fill", accessibilityDescription: "Password Generator")
            button.action = #selector(togglePopover(_:))
        }

        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) {
            [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown {
                strongSelf.popover.performClose(event)
            }
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
                eventMonitor?.start()
            }
        }
    }
}
