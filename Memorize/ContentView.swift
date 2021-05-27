//
//  ContentView.swift
//  Memorize
//
//  Created by sana on 2021/05/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            
            Text("Hello world!")
                .padding()
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
