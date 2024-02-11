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
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)

    
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            
            if(isCamera){
                DocumentScannerView()
            }
            else if(isLocation){
                ZStack(alignment: .top) {
                    Map(initialPosition: position, selection: $selectedItem){
                        UserAnnotation()
                    }
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
                                )
//                                .padding(.trailing, 50)
                            Text(selectedItem?.title ?? "Select a Buisness")
                        }
                        
                        
                            
                    }
                    .padding(.top, 50)
//                    Text(selectedItem?.title ?? "select")
//                        .background(
//                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
//                                .fill(.pink)
//                                .frame(height: 100)
//                        )
                        
//                        Spacer()
//                        Spacer()
//                    }
                }
                
//                    .background(
//                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
//                            .fill(.ultraThickMaterial)
//                    )

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
            // HoverBar
            HStack{
                Spacer(minLength: 10)
                Button {
                    isLocation = !isLocation
                    isCamera = false
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
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
                    .frame(width: 200)
                    .font(.system(size: 30))
                }
                
                Button {
                    isCamera = !isCamera
                    isLocation = false
                } label: {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 20)
                        .foregroundStyle(.pink, .black)
                }
                Spacer(minLength: 15)
            }
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                
//                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .fill(.secondary)
                    .frame(height: 60)
//                    .padding()
            )
            .padding()
        }
        .padding(.bottom, 35.0)
        .ignoresSafeArea(edges: .vertical)
    }
}


//    struct accessCameraView: UIViewControllerRepresentable {
//        
//        @Binding var selectedImage: UIImage?
//        @Environment(\.presentationMode) var isPresented
//        
//        func makeUIViewController(context: Context) -> UIImagePickerController {
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .camera
//            imagePicker.allowsEditing = false
//            imagePicker.delegate = context.coordinator
//            return imagePicker
//        }
//        
//        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//            
//        }
//
//        func makeCoordinator() -> Coordinator {
//            return Coordinator(picker: self)
//        }
//    }
//
//    // Coordinator will help to preview the selected image in the View.
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var picker: accessCameraView
//        
//        init(picker: accessCameraView) {
//            self.picker = picker
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            guard let selectedImage = info[.originalImage] as? UIImage else { return }
//            self.picker.selectedImage = selectedImage
//            self.picker.isPresented.wrappedValue.dismiss()
//        }
//    }

#Preview {
    ContentView()
}
