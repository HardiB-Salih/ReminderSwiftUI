//
//  ColorPickerView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: Color
    
    let colors: [Color] = [
        Color(.systemRed),
        Color(.systemGreen),
        Color(.systemBlue),
        Color(.systemYellow),
        Color(.systemOrange),
        Color(.systemPurple),
    ]
    
    var body: some View {
        
        HStack {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    Circle().fill()
                        .foregroundStyle(color)
                        .padding(1)
                    
                    Circle()
                        .stroke(selectedColor == color ? Color(.darkGray) : .clear, lineWidth: 4)
                        .scaleEffect(CGSize(width: 1.1, height: 1.1))
                }.onTapGesture {
                    selectedColor = color
                }
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
//        .background(.thinMaterial)
//        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        
        
        
        
        
        
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(Color(.systemGreen)))
}
