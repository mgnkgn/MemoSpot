//
//  CalendarChart.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 5.08.2024.
//

import SwiftUI
import SwiftData
import Charts

struct CalendarChart: View {
    @Query(sort: \Memo.timestamp) var memos: [Memo]
    
    @State private var yearSelected: Int = Calendar.current.component(.year, from: Date())
    var availableYears: [Int] {
        let years = memos.map { Calendar.current.component(.year, from: $0.timestamp) }
        return Array(Set(years)).sorted()
    }
    
    var memosSorted: [Memo] {
        memos
            .filter { Calendar.current.component(.year, from: $0.timestamp) == yearSelected }
            .sorted { $0.timestamp > $1.timestamp }
    }
    
    var body: some View {
        if memos.isEmpty {
            Text("You do not have any memos yet")
                .italic()

        } else {
            VStack{
                Picker("Year", selection: $yearSelected) {
                    ForEach(availableYears, id: \.self) { year in
                        Text(String(year)).tag(year)
                    }
                }
                .colorMultiply(.wooden)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 7, height: 7)))
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                Chart {
                    ForEach(memosSorted) { memo in
                        PointMark(
                            x: .value("Date", memo.timestamp, unit: .weekOfYear),
                            y: .value("Memos", memo.country ?? memo.title)
                        )
                        .annotation(){
                            Text(memo.city!)
                                .font(.footnote)
                                .foregroundStyle(Color.darkwooden)
                                .shadow(radius: 10)
                                .bold()
                                .rotationEffect(.degrees(-15))
                                .offset(x: CGFloat(-5), y: CGFloat(7))
                                .padding(.horizontal)
                        }
                        .foregroundStyle(Color.darkwooden.gradient)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) {
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(centered: true, anchor: .topLeading)
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    }
                }
                .chartScrollableAxes(.horizontal)
                .aspectRatio(1, contentMode: .fit)
                .padding()
            }
        }
    }
}

#Preview {
    CalendarChart()
}
