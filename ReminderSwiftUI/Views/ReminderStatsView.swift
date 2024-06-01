//
//  ReminderStatsView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import SwiftUI

struct ReminderStatsView: View {
    let icon: String
    let title: String
    let count: Int?
    let iconColor: Color
    
    var body: some View {
            HStack {
                VStack (alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .font(.title)
                    
                    Text(title)
                        .opacity(0.8)
                }
                
                Spacer()
                
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                        .bold()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color(.systemGray5), lineWidth: 1.0)
            }
        }
    
}

#Preview {
    ReminderStatsView(icon: "calendar", title: "Today", count: 100, iconColor: .red)
}
