//
//  PaletteEditor.swift
//  EmojiArt
//
//  Created by sana on 2021/07/02.
//

import SwiftUI

struct PaletteEditor: View {
    
    @Binding var palette: Palette
    
    var body: some View {
        Form {
            TextField("Name", text: $palette.name)
        }
        .frame(minWidth: 300, minHeight: 350)
    }
}


struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        Text("Fix Me!")
//        PaletteEditor()
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/))
    }
}
