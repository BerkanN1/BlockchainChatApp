//
//  AlertManager.swift
//  Blockchain_ChatApp
//
//  Created by BERKAN NALBANT on 16.01.2024.
//

import SwiftUI

class AlertManager: ObservableObject {
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var primaryButtonTitle = ""
    

    func showAlert(title: String, message: String, primaryButtonTitle: String = "OK") {
        self.alertTitle = title
        self.alertMessage = message
        self.primaryButtonTitle = primaryButtonTitle
        self.showAlert = true
    }

    func hideAlert() {
        self.showAlert = false
    }
}

