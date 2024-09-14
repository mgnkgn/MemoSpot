//
//  Item.swift
//  MemoSpotter
//
//  Created by Mehmet Güneş Akgün on 25.07.2024.
//

import Foundation
import SwiftData
import SwiftUI
import CoreLocation

@Model
final class Memo {
    var id: UUID
    var timestamp: Date
    var title: String
    var summary: String
    var imageData: Data?
    var latitude: Double
    var longitude: Double
    var city: String?
    var country: String?
    
    
    
    init(id: UUID, timestamp: Date, title: String, summary: String, imageData: Data? = nil, latitude: Double, longitude: Double, city: String?, country: String?) {
        self.id = id
        self.timestamp = timestamp
        self.title = title
        self.summary = summary
        self.imageData = imageData
        self.latitude = latitude
        self.longitude = longitude
        self.city = city
        self.country = country
    }
    
    var image: Image? {
        guard let imageData = imageData else { return nil }
        guard let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }
    //    var image: Image? {
    //        if title != "Paris Title" {
    //            return Image("cat-image")
    //        }
    //
    //        return nil
    //    }
    
    var location: CLLocationCoordinate2D {
        get {
            let latitude = latitude
            let longitude = longitude
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    
    func fetchCityName(completion: @escaping (String?) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(nil)
                return
            }
            let city = placemarks?.first?.locality
            completion(city ?? "N/A")
        }
    }
    
}

let calendar = Calendar.current
let now = Date()

struct MockData {
    
    static let sampleMemo = Memo(id: UUID(), timestamp: .now, title: "Madrid Title", summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",  latitude: 40.41, longitude: 3.71, city: "Madrid", country: "Spain")
    
    static let sampleMemos: [Memo] = [
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -9, to: now)!,
            title: "Madrid Title",
            summary: """
                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                """,
            latitude: 40.41,
            longitude: -3.71,
            city: "Madrid",
            country: "Spain"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -20, to: now)!,
            title: "Barcelona Title",
            summary: """
                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                """,
            latitude: 40.41,
            longitude: -3.71,
            city: "Barcelona",
            country: "Spain"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -390, to: now)!,
            title: "New York Title",
            summary: """
                New York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainmentNew York is a bustling metropolis known for its iconic landmarks, such as the Statue of Liberty and Times Square. It's a hub of culture, finance, and entertainment.
                """,
            latitude: 40.7128,
            longitude: -74.0060,
            city: "New York",
            country: "USA"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -10, to: now)!,
            title: "Paris Title",
            summary: """
                Paris, the capital of France, is known for its art, fashion, and culture. The Eiffel Tower, Notre-Dame Cathedral, and the Louvre Museum are just a few of its many attractions.
                """,
            latitude: 48.8566,
            longitude: 2.3522,
            city: "Paris",
            country: "France"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -20, to: now)!,
            title: "Tokyo Title",
            summary: """
                Tokyo, the capital of Japan, is a city that combines the ultramodern and the traditional, from neon-lit skyscrapers to historic temples. It’s famous for its bustling streets, shopping, and dining.
                """,
            latitude: 35.6895,
            longitude: 139.6917,
            city: "Tokyo",
            country: "Japan"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -1, to: now)!,
            title: "Sydney Title",
            summary: """
                Sydney is known for its Sydney Opera House, with a distinctive sail-like design, and its stunning harbor. It's a major city in Australia with vibrant arts and culture scenes.
                """,
            latitude: -33.8688,
            longitude: 151.2093,
            city: "Sydney",
            country: "Australia"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -70, to: now)!,
            title: "Cairo Title",
            summary: """
                Cairo, the capital of Egypt, is famous for its rich history and proximity to the Pyramids of Giza. The city is a blend of ancient monuments and modern city life.
                """,
            latitude: 30.0444,
            longitude: 31.2357,
            city: "Cairo",
            country: "Egpyt"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -100, to: now)!,
            title: "Rio de Janeiro Title",
            summary: """
                Rio de Janeiro is known for its Copacabana and Ipanema beaches, the Christ the Redeemer statue, and its vibrant Carnival festival. It’s a major city in Brazil.
                """,
            latitude: -22.9068,
            longitude: -43.1729,
            city: "Rio de Janeiro",
            country: "Brazil"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -120, to: now)!,
            title: "Moscow Title",
            summary: """
                Moscow, the capital of Russia, is known for its historical and architectural landmarks, such as the Kremlin, Red Square, and Saint Basil's Cathedral.
                """,
            latitude: 55.7558,
            longitude: 37.6173,
            city: "Moscow",
            country: "Russia"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -140, to: now)!,
            title: "Cape Town Title",
            summary: """
                Cape Town is known for its stunning landscapes, including Table Mountain and beautiful beaches. It's a vibrant city in South Africa with a rich history.
                """,
            latitude: -33.9249,
            longitude: 18.4241,
            city: "Cape Town",
            country: "South Africa"
        ),
        Memo(
            id: UUID(),
            timestamp: calendar.date(byAdding: .day, value: -21, to: now)!,
            title: "Bangkok Title",
            summary: """
                Bangkok, the capital of Thailand, is known for its ornate shrines and vibrant street life. The Grand Palace and Wat Arun are among its many cultural landmarks.
                """,
            latitude: 13.7563,
            longitude: 100.5018,
            city: "Bangkok",
            country: "Thailand"
        )
    ]
}
