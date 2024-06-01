//
//  SelectListView.swift
//  ReminderSwiftUI
//
//  Created by HardiB.Salih on 6/1/24.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchResult: FetchedResults<MyList>
    
    @Binding var selectedList: MyList?
    var body: some View {
        List (myListsFetchResult) { myList in
            HStack{
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundStyle(Color(uiColor: myList.color))
                    .font(.headline)
                Text(myList.name)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if selectedList == myList {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.headline)
                }
                
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedList = myList
            }
        }
    }
}

#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
