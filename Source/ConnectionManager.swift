//
//  ConnectionManager.swift
//  MyLearningPod
//
//  Created by navanee-14204 on 01/03/23.
//

import Foundation
import Network

final public class ConnectionManager {
    public static let shared = ConnectionManager()
    private let monitor = NWPathMonitor()

    public var isNetworkAvailable = true

    public var connectionStatusUpdated: ((Bool) -> Void)?

    public func startMonitoring() {
        monitor.pathUpdateHandler = {[weak self] path in
            if path.status == .satisfied {
                self?.connectionStatusUpdated?(true)
                self?.isNetworkAvailable = true
                ConnectionManager.shared.isNetworkAvailable = true
            } else {
                self?.connectionStatusUpdated?(false)
                self?.isNetworkAvailable = false
                ConnectionManager.shared.isNetworkAvailable = false
            }
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

   public func currentNetworkInterfaceType() -> String {
        guard let networkInterface = monitor.currentPath.availableInterfaces.first else {
            return "Unknown"
        }

        switch networkInterface.type {
        case .wifi:
            return "WiFi"
        case .cellular:
            return "Cellular"
        case .loopback:
            return "Loopback"
        case .wiredEthernet:
            return "Wired Ethernet"
        default:
            return "Unknown"
        }

    }

    public func stopMonitoring() {
        monitor.cancel()
    }

    deinit {
        monitor.cancel()
    }

}

