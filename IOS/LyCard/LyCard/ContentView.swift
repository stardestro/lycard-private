//
//  ContentView.swift
//  LyCard
//
//  Created by Hussain Alkatheri on 2/10/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct Place: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct Card: Hashable{
    let id: Int
    let color: Color
}

struct ContentView: View {
    @State public var search: String = ""
    @State public var isCamera: Bool = false
    @State public var isLocation: Bool = false
    @State private var offset = CGSize.zero
    
    @State private var selectedItem: MapFeature?
    
    var list = [
        Card(id: 0, color: .red),
        Card(id: 1, color: .blue),
        Card(id: 2, color: .pink),
        Card(id: 3, color: .green),
        Card(id: 4, color: .indigo)]
    
    @StateObject var locationDataManager = LocationDataManager()
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        VStack {
            
            if(isCamera){
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(.ultraThickMaterial)
                    .rotationEffect(.degrees(Double(offset.width / 5)))
                    .offset(x: offset.width * 1, y: 0)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                offset = gesture.translation
                            }
                            .onEnded { _ in
                                if abs(offset.width) > 100 {
                                    // remove the card
                                } else {
                                    offset = .zero
                                }
                            }
                    )
            }
            else if(isLocation){
                Spacer(minLength: 50)
                Text(selectedItem?.title ?? "select")
                Map(initialPosition: position, selection: $selectedItem){
                    UserAnnotation()
                }
                    .padding(.vertical, 30)
                    .background(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(.ultraThickMaterial)
                    )

            }
            else{
                ScrollView{
                    Spacer(minLength: 50)
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Circle()
                                .frame(height: 45)
                        })
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    ZStack{
                        ForEach(list, id: \.self) { temp in
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(temp.color)
                                .aspectRatio(1.586, contentMode: .fit) // vertical aspect = 0.631, horizontal = 1.586
                                .offset(y: CGFloat(temp.id) * 60)
                                .padding(.horizontal, 25)
                        }
                    }
                    .frame(height: 90*CGFloat(list.count), alignment: .top)
                    
//                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
//                        .aspectRatio(0.631, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .padding()
                    })
                }
                
            }
            HStack{
                Spacer()
                
                Button {
                    isLocation = !isLocation
                    isCamera = false
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }

                TextField(
                    "Search",
                    text: $search
                ).frame(width: 250)
                Button {
                    isCamera = !isCamera
                    isLocation = false
                } label: {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(.secondary)
                    .padding(.horizontal, 15)
                    
            )
        }
        .padding(.bottom, 35.0)
        .ignoresSafeArea(edges: .vertical)
    }
}

#Preview {
    ContentView()
}
