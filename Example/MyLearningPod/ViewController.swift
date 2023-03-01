//
//  ViewController.swift
//  MyLearningPod
//
//  Created by NavaneethanG12 on 03/01/2023.
//  Copyright (c) 2023 NavaneethanG12. All rights reserved.
//

import UIKit
import MyLearningPod

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let networkMonitor = ConnectionManager.shared
        networkMonitor.startMonitoring()

        networkMonitor.connectionStatusUpdated = { isActive in
            DispatchQueue.main.async {
                self.view.backgroundColor = isActive ? .green : .red
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

