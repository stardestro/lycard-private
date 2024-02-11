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
    @State public var isLocation: Bool = true
    @State private var offset = CGSize.zero
    
    @State private var selectedItem: MapFeature?
    
    var list = [
        Card(id: 0, color: .red),
        Card(id: 1, color: .blue),
        Card(id: 2, color: .pink),
        Card(id: 3, color: .green),
        Card(id: 4, color: .indigo)]
    
    @StateObject var locationDataManager = LocationDataManager()
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.1987162, longitude: -97.4474712), latitudinalMeters: 50, longitudinalMeters: 50)))

    @FocusState private var searchFocused: Bool
    
    @State var results:[MKMapItem] = []
    
//    @State private var hoverEffect: Int = (searchFocused ?? 0 ? 0: 100) ?? 0
    
    @State private var hoverEffect: CGFloat = 0.0
    
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    
    var body: some View {
            ZStack {
                VStack{
                    if(isCamera){
                        DocumentScannerView()
                            .padding(.bottom, 80)
                    }
                    else if(isLocation){
                        ZStack(alignment: .top) {
                            Map(initialPosition: position, selection: $selectedItem){
                                UserAnnotation()
                            }
                            .ignoresSafeArea()
                            //                        .padding(.vertical, 10)
                            //                    VStack(alignment: .leading) {
                            //                        Spacer(minLength: 1)
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(.ultraThinMaterial)
                                    .frame(height: 125)
                                    .padding()
                                
                                HStack {
                                    selectedItem?.image
                                        .background(
                                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                                .fill(selectedItem?.backgroundColor ?? .clear)
                                                .frame(alignment: .trailing)
                                        )
                                        .padding(.horizontal, 6)
                                    VStack{
                                        Text(selectedItem?.title ?? "Select a Business")
                                            .frame(width: 210, height: 75, alignment: .leading)
                                            .font(.system(size: 25))
                                            .fixedSize(horizontal: true, vertical: false)
                                        if(selectedItem != nil){
                                            HStack{
                                                Text("Chase saphhire")
                                                    .font(.system(size: 15))
                                                    .frame(width: 150, height: 20, alignment: .leading)
                                                Text("2-5%")
                                                    .font(.system(size: 15))
                                                    .frame(width: 50, height: 20)
                                                
                                            }
                                        }
                                    }
                                    .frame(width: 230, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                    
                                }
                                
                                
                                
                            }
                            
                        }
                        
                    }
                    else{
                        ScrollView{
                            Spacer(minLength: 50)
                            HStack{
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    //                            Circle()
                                    Image("imageicon")
                                        .resizable()
                                        .scaledToFit()
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
                }
                if(searchFocused){
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            searchFocused = false
                        }
                }
//                .onTapGesture {
//                    if(searchFocused){
//                        searchFocused = false
//                    }
//                }
                // HoverBar
                VStack{
                    Spacer()
                    HStack{
                        Spacer(minLength: 10)
                        Button {
                            isLocation = !isLocation
                            isCamera = false
                        } label: {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 35)
                                .foregroundStyle(.pink, .black)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 24, style: .circular)
                                .fill(Color(uiColor: .systemGray4))
                                .frame(height: 55)
                            TextField(
                                "Search",
                                text: $search
                            )
                            .focused($searchFocused)
                            .frame(width: 200)
                            .font(.system(size: 30))
                            
                            //                    .onChange(of: searchFocused) { oldValue, newValue in
                            //                        if(searchFocused){
                            //                            withAnimation(.easeIn(duration: 0.05)) { hoverEffect = -265.0 }
                            //                        }
                            //                        else{
                            //                            withAnimation(.spring(duration: 1)) { hoverEffect = 0.0 }
                            //                        }
                            //                    }
                        }
                        
                        Button {
                            isCamera = !isCamera
                            isLocation = false
                        } label: {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 25)
                                .foregroundStyle(.pink, .black)
                        }
                        Spacer(minLength: 15)
                    }
                    .frame(alignment: .bottom)
                    .ignoresSafeArea(.all)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                        
                        //                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .fill(.secondary)
                            .frame(height: 60)
                        //                    .padding()
                    )
                    //            .offset(x: 0.0, y: hoverEffect)
                    .padding()
                }
                
            }
        }
    }


#Preview {
    ContentView()
}
