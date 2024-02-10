//
//  ContentView.swift
//  LyCard
//
//  Created by Hussain Alkatheri on 2/10/24.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @State public var search: String = ""
    @State public var isCamera: Bool = false
    @State public var isLocation: Bool = false
    @State private var offset = CGSize.zero
    
    @State private var selectedItem: MapFeature?

    var body: some View {
        VStack {
            Spacer()
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
                Text(selectedItem?.title ?? "select")
                Map(selection: $selectedItem){
                    UserAnnotation()
                }
                    .padding(.vertical, 30)
                    .background(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(.ultraThickMaterial)
                    )
                
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
                    
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
