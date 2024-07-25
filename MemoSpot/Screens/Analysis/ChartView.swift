//
//  MemosListView.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 28.07.2024.
//

import SwiftUI
import SwiftData

struct ChartView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Memo.timestamp) var memos: [Memo]
    
    var body: some View {
        
        VStack{
            CalendarChart()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Gradient(colors: [Color.cyan, Color.wooden]))
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    
}

#Preview {
    ChartView()
}
