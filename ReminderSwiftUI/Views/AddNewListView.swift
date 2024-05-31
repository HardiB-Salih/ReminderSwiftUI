//
//  AddNewListView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import SwiftUI

struct AddNewListView: View {
    @State private var name = ""
    @State private var selectedColor = Color(.systemRed)
    @Environment(\.dismiss) private var dismiss
    let onSave: (String, UIColor) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .font(.system(size: 100))
                        .foregroundStyle(selectedColor)
                        
                    TextField("List Name", text: $name)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        }
                    
                    ColorPickerView(selectedColor: $selectedColor)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("New List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        onSave(name, UIColor(selectedColor))
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
        }
        }
    }
}

#Preview {
    NavigationStack {
        AddNewListView(onSave: {( _ , _ ) in} )
    }
}
