//
//  ShopMasterApp.swift
//  ShopMaster
//
//  Created by Sales, Wyllian Fonseca on 11/05/26.
//

import SwiftUI

@main
struct ShopMasterApp: App {
    @StateObject var viewModel = LojaViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
