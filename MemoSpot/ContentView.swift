//
//  ContentView.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 25.07.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var memos: [Memo]

    var body: some View {
       MemosTabView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Memo.self, inMemory: true)
}
