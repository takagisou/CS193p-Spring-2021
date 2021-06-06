//
//  ContentView.swift
//  Set
//
//  Created by sana on 2021/06/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("text")
    }
}


struct CardView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: Const.cornerRadius)
            
        }
    }
    
    private enum Const {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
