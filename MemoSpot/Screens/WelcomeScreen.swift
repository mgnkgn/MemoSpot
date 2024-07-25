//
//  WelcomeScreen.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 26.07.2024.
//

import SwiftUI




struct WelcomeScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Stick()
                    .fill(.darkwood.gradient)
                    .padding(10)
                    .shadow(radius: 3)
                
                
                VStack {
                    NavigationLink(destination: HomeViewTest()){
                        ZStack {
                            Arrow()
                                .fill(.wood.gradient)
                                .frame(width: 350, height: 120)
                                .shadow(radius: 7)
                            
                            Text("HOME")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                        }
                        .rotationEffect(.degrees(1))
                        .padding([.bottom], 50)
                    }
                    
                    NavigationLink(destination: ListViewTest()){
                        ZStack{
                            Arrow()
                                .fill(.wood.gradient)
                                .frame(width: 290, height: 120)
                                .shadow(radius: 7)
                            
                            Text("LIST")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                        }
                        .rotationEffect(.degrees(-10))
                        .padding([.bottom], 70)
                    }
                    
                    NavigationLink(destination: GalleryViewTest()){
                        ZStack {
                            Arrow()
                                .fill(.wood.gradient)
                                .frame(height: 120)
                                .shadow(radius: 7)
                                .rotationEffect(.degrees(190))
                            
                            Text("GALLERY")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                                .rotationEffect(.degrees(10))
                        }
                    }
                    
                    
                    
                }
                
                
            }
            .background(Gradient(colors: [Color.cyan, Color.blue]))
            .ignoresSafeArea()
        }
    }
}

struct HomeViewTest: View {
    var body: some View {
        Text("Home Screen")
    }
}

struct ListViewTest: View {
    var body: some View {
        Text("List Screen")
    }
}

struct GalleryViewTest: View {
    var body: some View {
        Text("Gallery Screen")
    }
}



#Preview {
    WelcomeScreen()
}
