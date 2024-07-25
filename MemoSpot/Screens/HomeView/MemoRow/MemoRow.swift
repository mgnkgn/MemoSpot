//
//  MemoRow.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 2.08.2024.
//

import SwiftUI

struct MemoRow: View {
    @State var isAnimating = false
    var memo: Memo
    private let randomGradient: LinearGradient
    private let randomDelay: Double
    
    init(memo: Memo) {
        self.memo = memo
        
        let gradients = [
            [Color.sky1, Color.sky2],
            [Color.sky2, Color.sky3],
            [Color.sky3, Color.sky4],
            [Color.sky4, Color.sky5],
            [Color.sky5, Color.sky1],
        ]
        
        let gradientIndex = abs(memo.id.hashValue) % gradients.count
        let gradientColors = gradients[gradientIndex]
        
        let endpoints = [
            [UnitPoint.topLeading, UnitPoint.bottomTrailing],
            [UnitPoint.bottomTrailing, UnitPoint.topLeading],
            [UnitPoint.leading, UnitPoint.bottomTrailing],
            [UnitPoint.leading, UnitPoint.topTrailing],
            [UnitPoint.trailing, UnitPoint.bottomLeading],
            [UnitPoint.trailing, UnitPoint.topLeading],
        ]
        let randomEndpoints = endpoints[0]
        
        self.randomGradient = LinearGradient(colors: gradientColors, startPoint: randomEndpoints[0], endPoint: randomEndpoints[1])
        self.randomDelay = Double.random(in: 0..<3)
    }
    
    var body: some View {
        HStack {
            if let image = memo.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 70, maxHeight: 100)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            } else {
                Image(systemName: "camera.metering.unknown")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 70, maxHeight: 30)
                    .foregroundStyle(.secondary)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                
            }
            
            VStack(alignment: .leading) {
                
                Text(memo.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.8)
                    .truncationMode(.tail)
                
                if let city = memo.city, city != "N/A" {
                    HStack {
                        Image(systemName: "mappin")
                            .rotationEffect(.degrees(20))
                            .foregroundStyle(.secondary)
                            .bold()
                        Text(city)
                            .foregroundStyle(.secondary)
                            .bold()
                            .lineLimit(1)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.8)
                            .truncationMode(.tail)
                    }
                }
            }
            Spacer()
            
            Text(memo.timestamp, format: .dateTime.month(.twoDigits).year(.twoDigits))
                .foregroundStyle(.secondary)
                .fontWeight(.bold)
                .font(.footnote)
                .padding(.trailing)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            randomGradient
                .hueRotation(.degrees(isAnimating ? 12 : 0))
                .opacity(isAnimating ? 0.5 : 1.0)
                .onAppear {
                    withAnimation(
                        Animation.easeInOut(duration: 3)
                            .repeatForever(autoreverses: true)
                            .delay(randomDelay)
                    ) {
                        isAnimating.toggle()
                    }
                }
        )
        .listRowBackground(randomGradient)
        .presentationCornerRadius(30)
        .foregroundStyle(Color.black)
    }
}

#Preview {
    MemoRow(memo: MockData.sampleMemo)
}
