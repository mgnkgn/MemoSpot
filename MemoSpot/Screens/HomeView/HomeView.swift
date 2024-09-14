//
//  HomeView.swift
//  MemoSpotter
//
//  Created by Mehmet Güneş Akgün on 28.07.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State var addFormShown: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.cyan, Color.wooden], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    // Header HStack
                    HStack {
                        Image("memo-spotter")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 5)
                        Text("MemoSpot")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .shadow(radius: 7)
                        
                        Spacer()
                        
                        Button(action: {
                            addFormShown = true
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundStyle(.wood)
                                .shadow(radius: 10)
                        })
                        .sheet(isPresented: $addFormShown, onDismiss: {
                            Interstitial.shared.showInterstitialAds()
                        }, content: {
                            AddMemoForm(addFormShown: $addFormShown)
                        })
                    }
                    .padding()
                    .background(Color.clear)
                    
                    // Search bar
                    SearchBar(text: $searchText)
                    
                    // List of memos
                    MemosListView(searchText: searchText)
                    
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    HomeView()
}

struct SearchBar: View {
    @Binding var text: String
    @State var isActive: Bool = false
    
    var body: some View {
        HStack{
            
            
            if isActive {
                TextField("Search memo", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .opacity(0.4)
                    .padding()
                    .bold()
                Button(action: {
                    withAnimation {
                        isActive = false
                    }
                }, label: {
                    Text("Cancel")
                        .padding(.trailing, 15)
                })
            } else {
                Spacer()
                Image(systemName: "magnifyingglass")
                    .padding(.trailing, 15)
                    .onTapGesture {
                        withAnimation {
                            isActive = true
                        }
                    }
            }
            
        }
        .padding(9)
        
    }
}

struct MemosListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Memo.timestamp) var memos: [Memo]
        
    var searchText: String
    
    var filteredMemos: [Memo] {
        if searchText.isEmpty {
            return memos
        } else {
            return memos.filter { $0.title.contains(searchText) }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredMemos, id: \.id) { memo in
                ZStack {
                    MemoRow(memo: memo)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true){
                            Button(role: .destructive, action: {
                                deleteItem(memo)
                            }, label: {
                                Image(systemName: "trash")
                            })
                            .clipShape(Circle())
                            
                        }
                    NavigationLink(destination: MemoDetailsView(memo: memo)) {
                        Rectangle().opacity(0.0)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowSeparator(.hidden)
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .background(Color.clear)
        .scrollContentBackground(.hidden)
        .navigationDestination(for: Memo.self) { memo in
            MemoDetailsView(memo: memo)
        }
    }
    
    private func deleteItem(_ memo: Memo) {
        withAnimation {
            if let index = memos.firstIndex(where: { $0.id == memo.id }) {
                modelContext.delete(memos[index])
            }
        }
    }
}
