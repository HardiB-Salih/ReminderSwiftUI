//
//  MyListView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 5/31/24.
//

import SwiftUI

struct MyListView: View {
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No reminder Found")
            } else {
                ForEach(myLists) { list in
                    MyListCellView(myList: list)
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext,
                      CoreDataProvider.shared.persistentContainer.viewContext)
}


struct MyListCellView: View {
    let myList: MyList
    var body: some View {
        HStack(spacing: 0) {
            Text(myList.name)
                .padding(12)
                .padding(.leading, 5)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(Color(uiColor: myList.color))
                        .frame(width: 8)
                }
            
            Spacer()
        }
        .background(Color(uiColor: myList.color).opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color(.systemGray5), lineWidth: 1.0)
        }
    }
}
