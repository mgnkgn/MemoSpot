//
//  MemoDetailsView.swift
//  MemoSpotter
//
//  Created by Mehmet Güneş Akgün on 28.07.2024.
//

import SwiftUI

struct MemoDetailsView: View {
    var memo: Memo = MockData.sampleMemo
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            VStack{
                ZStack{
                    if let city = memo.city, city != "N/A"{
                        HStack {
                            Image(systemName: "mappin")
                                .rotationEffect(.degrees(20))
                            Text(memo.city ?? "")
                                .font(.subheadline)
                                .italic()
                                .bold()
                            Spacer()
                        }
                        .padding(.top, -57)
                        .padding(.leading, 20)
                    }
                    Arrow()
                        .fill(.wood.gradient)
                        .frame(width: 390, height: 70)
                        .shadow(radius: 10)
                    
                    VStack{
                        Text(memo.title)
                            .font(.title)
                            .bold()
                            .foregroundStyle(.darkwood)
                        
                    }
                    HStack {
                        Spacer()
                        Text(memo.timestamp, style: .date)
                            .font(.subheadline)
                            .italic()
                    }
                    .padding(.top, 100)
                    .padding(.trailing, 20)
                }
            }
            .rotationEffect(.degrees(-5))
            .padding([.bottom], 10)
            .padding([.top], 50)
            
                        Spacer()
            
            if let image = memo.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                    .padding()
            }
            
            
            
            ScrollView{
                VStack {
                    Text(memo.summary)
                        .font(.body)
                    
                }
                .padding()
                .bold()
                .italic()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Gradient(colors: [Color.cyan, Color.wooden]))
        .gesture(
            DragGesture()
                .onEnded{ value in
                    if value.translation.width > 100 {
                        dismiss()
                    }
                }
        )
    
        
        
        
        
    }
    
}

#Preview {
    MemoDetailsView()
}
