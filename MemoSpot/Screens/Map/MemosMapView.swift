//
//  MemosMapView.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 28.07.2024.
//

import SwiftUI
import MapKit

struct MemosMapView: View {
    var memos: [Memo]
    
    
    
    var body: some View {
        VStack{
            NavigationView {
                Map(){
                    ForEach(memos) { memo in
                        Annotation(memo.title, coordinate: memo.location) {
                            NavigationLink(destination: MemoDetailsView(memo: memo)) {
                                if let image = memo.image{
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "mappin.and.ellipse")
                                }
                            }
                        }
                    }
                }
            }
        }
//        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Gradient(colors: [Color.cyan, Color.wooden]))
    }
}

#Preview {
    MemosMapView(memos: MockData.sampleMemos)
}
