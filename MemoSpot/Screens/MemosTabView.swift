//
//  MemosTabView.swift
//  MemoSpotter
//
//  Created by Mehmet Güneş Akgün on 28.07.2024.
//

import SwiftUI
import SwiftData

struct MemosTabView: View {
    
    @Query(sort: \Memo.timestamp) var memos: [Memo]
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
                
            
            ChartView()
                .tabItem {
                    Image(systemName: "chart.dots.scatter")
                    Text("Graph")
                }
                .toolbarBackground(.hidden, for: .tabBar)
                


            
            GalleryView()
                .tabItem {
                    Image(systemName: "photo.circle.fill")
                    Text("Gallery")
                }
            
            MemosMapView(memos: memos)
                .tabItem {
                    Image(systemName: "map.circle.fill")
                    Text("Map")
                }
                .toolbarBackground(.hidden, for: .tabBar)
                
        }
        .accentColor(.black)
        
       
    }
}

#Preview {
    MemosTabView()
}
