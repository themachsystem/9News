//
//  UITestingConfig.swift
//  News
//
//  Created by Alvis Mach on 13/3/21.
//

import Foundation

struct UITestingConfig {
    /**
     * Returns true if UI Tests are being executed.
     */
    static var isTesting: Bool {
        return processInfo.arguments.contains(kShouldMockNetworkCall)
    }
    
    static var networkCallShouldFail: Bool {
        return processInfo.environment[kNetworkCallShouldFail] == "true"
    }
    
    private static let processInfo = ProcessInfo.processInfo
}

// MARK: - Constants
extension UITestingConfig {
    static let kShouldMockNetworkCall = "shouldMockNetworkCall"
    static let kNetworkCallShouldFail = "networkCallShouldFail"
    
    struct AccessibilityIdentifier {
        static let webViewNavigationTitle = "webViewNavigationTitle"
    }
}



