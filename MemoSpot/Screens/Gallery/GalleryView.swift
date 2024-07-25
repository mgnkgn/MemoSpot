//
//  GalleryView.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 28.07.2024.
//

import SwiftUI
import SwiftData

struct GalleryView: View {
    
    @Query(sort: \Memo.timestamp) var memos: [Memo]
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        
        NavigationView {
            VStack{
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(memos, id: \.id) { memo in
                            if let image = memo.image {
                                NavigationLink(destination: MemoDetailsView(memo: memo)) {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Gradient(colors: [Color.cyan, Color.wooden]))
            }
            .ignoresSafeArea(edges: .bottom)
        }

        
    }
}

#Preview {
    GalleryView()
}
