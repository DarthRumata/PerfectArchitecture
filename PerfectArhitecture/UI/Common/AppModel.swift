//
//  AppModel.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 28.12.2021.
//

import SwiftyBeaver

class AppModel {
    func configure() {
        SwiftyBeaver.addDestination(ConsoleDestination())
        if var logURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            logURL.appendPathComponent("swiftybeaver.log")
            SwiftyBeaver.addDestination(FileDestination(logFileURL: logURL))
        }
        
    }
}
