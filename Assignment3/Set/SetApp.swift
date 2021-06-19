//
//  SetApp.swift
//  Set
//
//  Created by sana on 2021/06/04.
//

import SwiftUI

@main
struct SetApp: App {
    
    private let viewModel = SetViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
