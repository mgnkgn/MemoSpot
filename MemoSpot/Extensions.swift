//
//  Extensions.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 26.07.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let wooden = Color("wood")
    static let darkwooden = Color("darkwood")
    static let sky1 = Color("skyColor1")
    static let sky2 = Color("skyColor2")
    static let sky3 = Color("skyColor3")
    static let sky4 = Color("skyColor4")
    static let sky5 = Color("skyColor5")
    
}

extension Date {
    func year(using calendar: Calendar = .current) -> Int {
        calendar.component(.year, from: self)
    }
    
    func firstDayOfYear(using calendar: Calendar = .current) -> Date? {
        DateComponents(calendar: calendar, year: year(using: calendar)).date
    }
}
