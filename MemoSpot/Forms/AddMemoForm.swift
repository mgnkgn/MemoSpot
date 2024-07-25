//
//  AddMemoForm.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 28.07.2024.
//

import SwiftUI
import MapKit
import LocationPicker
import PhotosUI
import SwiftData
import CoreLocation

struct AddMemoForm: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State var memoTitle: String = ""
    @State var memoSummary: String = ""
    @State var memoDate: Date = .now
    @State var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)
    @State var showLocationSheet = false
    
    
    @State var photosPickerItem: PhotosPickerItem?
    @State var memoImageData: Data?
    @State var memoImage: UIImage?
    
    @State var titleError: String = ""
    
    @Binding var addFormShown: Bool
    
    @State var memoCity: String = ""
    @State var memoCountry: String = ""
    
    let titleLimit = 20
    
    
    var body: some View {
        
        
        VStack {
            HStack {
                Button(action: {
                    addFormShown = false
                }, label: {
                    Text("Cancel")
                })
                Spacer()
            }
            .padding()
            Form {
                Section(content: {
                    TextField("Memo Title", text: $memoTitle)
                        .onChange(of: memoTitle) { oldValue, newValue in
                            
                            if(newValue.count > titleLimit){
                                memoTitle = oldValue
                                titleError = "Max limit reached for title"
                            } else {
                                titleError = ""
                            }
                          
                        }
                    TextEditor(text: $memoSummary)
                        .redacted(reason: .placeholder)
                        .onChange(of: memoSummary) { _, _ in
                            titleError = ""
                        }
                    if !titleError.isEmpty {
                        Text(titleError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                }, header: {
                    Text("Title & Summary")
                })
                
                
                
                Section(content:  {
                    DatePicker("Memo Date", selection: $memoDate, displayedComponents: .date)
                }, header: {
                    Text("Date")
                })
                
                Section {
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                        Text("\(coordinates.latitude), \(coordinates.longitude)")
                    }
                    
                    Button("Select location") {
                        self.showLocationSheet.toggle()
                    }
                } header: {
                    Text("Location")
                }
                
                Section {
                    PhotosPicker(selection: $photosPickerItem, matching: .images){
                        ZStack {
                            if (memoImage != nil) {
                                Image(uiImage: memoImage!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 300)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                                    .padding()
                            } else {
                                Image(systemName: "photo.badge.plus.fill")
                                    .scaleEffect(2)
                            }
                        }
                        .presentationCornerRadius(50)
                        .frame(maxWidth: .infinity, minHeight: 120)
                        
                    }
                } header: {
                    Text("Memo Picture")
                }
                
                Button(action: {
                    print(["Title": memoTitle, "Summary": memoSummary])
                    addMemo()
                    
                }, label: {
                    Text("Save Memo")
                })
                
            }
            
        }
        
        .tint(.cyan)
        .onChange(of: photosPickerItem, { _, _ in
            Task {
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        memoImageData = data
                        memoImage = image
                    }
                }
            }
        })
        .sheet(isPresented: $showLocationSheet) {
            LocationPicker(instructions: "Tap to select coordinates", coordinates: $coordinates, dismissOnSelection: true)
        }
    }
    
    func addMemo(){
        if memoTitle.isEmpty || memoSummary.isEmpty {
            titleError = "Title and summary is required."
        } else {
            let geoCoder = CLGeocoder()
            let sourceLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            geoCoder.reverseGeocodeLocation(sourceLocation) { placemarks, error in
                if let error = error {
                    print("Geocoding error: \(error)")
                    memoCity = "N/A"
                    memoCountry = "N/A"
                } else {
                    guard let placemark = placemarks?.first else {
                        memoCity = "N/A"
                        memoCountry = "N/A"
                        self.createAndSaveMemo()
                        return
                    }
                    
                    memoCity = placemark.locality ?? "N/A"
                    memoCountry = placemark.isoCountryCode ?? "N/A"
                }
                print("Add: ", ["city": memoCity, "country": memoCountry])
                self.createAndSaveMemo()
                
            }
            
            
            
            
        }
    }
    
    func resetStates(){
        memoTitle = ""
        memoSummary = ""
        memoDate = .now
        memoImageData = nil
        memoImage = nil
        photosPickerItem = nil
        
        titleError = ""
    }
    
    func createAndSaveMemo() {
        let newMemo = Memo(id: UUID(), timestamp: memoDate, title: memoTitle, summary: memoSummary, imageData: memoImageData, latitude: coordinates.latitude, longitude: coordinates.longitude, city: memoCity, country: memoCountry)
        
        modelContext.insert(newMemo)
        try? modelContext.save()
        addFormShown = false
        resetStates()
    }
}

#Preview {
    AddMemoForm(addFormShown: .constant(false))
}






