//
//  ContentView.swift
//  LyCard
//
//  Created by Hussain Alkatheri on 2/10/24.
//  https://www.reddit.com/r/swift/comments/iylnbl/perform_mklocalsearch_in_swiftui/


import SwiftUI
import MapKit
import CoreLocation
import PhotosUI

struct Place: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct response: Codable {
    let name: String
    let percent: Double
}

struct Card: Codable, Identifiable {
    let id: String
    let name: String
    let image: String
    let gas: Double
    let shopping: Double
    let restaurant: Double
    let travel: Double
}

struct ContentView: View {
    @State public var search: String = ""
    @State public var savedsearch: String = ""
    @State public var isCamera: Bool = false
    @State public var isLocation: Bool = false
    @State private var offset = CGSize.zero
    
    @State private var selectedItem: MapFeature?
    
    @State private var cards = [Card]()
    
    func loadData() async {

        guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
        else {
            print("json file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        cards = try! JSONDecoder().decode([Card].self, from: data!)
        
    }
    
    
    
    @StateObject var locationDataManager = LocationDataManager()
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.1987162, longitude: -97.4474712), latitudinalMeters: 50, longitudinalMeters: 50)))
    
//    @State private var currentSpan: MKCoordinateSpan
    
    @State private var apiResult: String = ""

    @FocusState private var searchFocused: Bool
    
    @State private var countOfChange: Int = 0
    
    @State var results:[MKMapItem] = []
    
//    @State private var hoverEffect: Int = (searchFocused ?? 0 ? 0: 100) ?? 0
    
    @State private var hoverEffect: CGFloat = 0.0
    
    @State var lastTime: DispatchTime = DispatchTime.now()
    
    @State var actualResponse: response = response(name: "", percent: 0)
    
    let timer = Timer.publish(every: 1.3, on: .main, in: .common).autoconnect()
    
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    
    @State var cardToPresent: String = ""
    
    private func fetchData() {
        print("fetching Data")
        //Parse URL
        let value = String("https://lycard-production.up.railway.app/bestcard?category=")
        print(value)
        let valueFinal = selectedItem?.pointOfInterestCategory?.rawValue.lowercased()
        print(valueFinal)
        if(valueFinal == nil || valueFinal == "null"){
            return
        }
        let combined = value + valueFinal!
        print(combined)
        guard let url = URL(string: combined) else { return }
        
        URLSession.shared.dataTask(with: url) { data, wowresponse, error in
            if let data = data {
                print(wowresponse)
                print(data)
//                cardToPresent = String(data: data, encoding: .utf8)!
//                JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//                print(cardToPresent)
//                if(cardToPresent != nil){
                    actualResponse = try! JSONDecoder().decode(response.self, from: data)
    //                actualResponse = try! JSONDecoder().decode([response.self, from: data)
                    print(actualResponse)
//                }
                
            } else if let error = error {
                //Print API call error
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
    var body: some View {
            ZStack {
                VStack{
                    if(isCamera){
                        if let selectedImage{
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                        }
                        Button("Open camera") {
                            self.showCamera.toggle()
                        }
                        .fullScreenCover(isPresented: self.$showCamera) {
                            accessCameraView(selectedImage: self.$selectedImage)
                        }
//                        DocumentScannerView()
//                            .padding(.bottom, 80)
                    }
                    else if(isLocation){
                        ZStack(alignment: .top) {
                            Map(position: $position, selection: $selectedItem){
                                UserAnnotation()
                            }
                            .ignoresSafeArea()
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(.ultraThinMaterial)
                                    .frame(height: 125)
                                    .padding()
                                
                                HStack {
                                    selectedItem?.image
                                        .background(
                                            RoundedRectangle(cornerRadius: 25.0)
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
                                                
//                                                Text(cards[cards.firstIndex( where: { Card in
//                                                    return Card.id == "citi-double-cash-card"
//                                                })!].name)
                                                Text(actualResponse.name)
                                                    .font(.system(size: 15))
                                                    .frame(width: 150, height: 20, alignment: .leading)
                                                Text( String(actualResponse.percent) + "%" )
                                                    .font(.system(size: 15))
                                                    .frame(width: 50, height: 20)
                                            
                                            }
                                                .onChange(of: selectedItem, initial: true) { oldValue, newValue in
                                                
                                                Task{
                                                    fetchData()
                                                }
                                                
//                                                Task {
//                                                    let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random" + String(selectedItem?.kind))!)
//                                                    let decodedResponse = try? JSONDecoder().decode(apiResult.self, from: data)
//                                                    apiResult = decodedResponse?.value ?? ""
//                                                }
                                                
                                            }
//                                                Text("Chase saphhire")
//                                                    .font(.system(size: 15))
//                                                    .frame(width: 150, height: 20, alignment: .leading)
//                                                Text("2-5%")
//                                                    .font(.system(size: 15))
//                                                    .frame(width: 50, height: 20)
                                                
                                            
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
//                            .padding(.vertical, 15)
                            ZStack{
                                ForEach(0..<cards.count, id: \.self) { index in
//                                ForEach(cards) { temp in
//                                    Text(temp.name)
//                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
//                                        .fill(AsyncImage(url: URL(string: temp.image))
                                    AsyncImage(url: URL(string: cards[index].image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } placeholder: {
                                        ProgressView()
                                    }.padding(25)
//                                        .aspectRatio(1.586, contentMode: .fit) // vertical aspect = 0.631, horizontal = 1.586
                                        .offset(y: CGFloat(index * 60))
                                }
                            }
                            .onAppear(){
                                Task {
                                    await loadData()
                                }
                            }
                            .frame(height: 70*CGFloat(cards.count), alignment: .top)
                            
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
                    VStack{
                        ForEach(self.results, id: \.self) { item in
                            Text("\(item.name ?? "Test")").foregroundColor(.black)
                        }
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
                            .autocorrectionDisabled()      
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
                            .fill(.ultraThickMaterial)
                            .frame(height: 60)
                        //                    .padding()
                    )
                    //            .offset(x: 0.0, y: hoverEffect)
                    .padding()
                }
                
            }
            .onReceive(timer, perform: { _ in
                if(savedsearch != search){
                    performSearch(search)
                    savedsearch = search
                }
            })
//            .onChange(of: search) { oldValue, newValue in
//                countOfChange = countOfChange + 1
//                let currenTime = DispatchTime.now()
//                let difference = currenTime.uptimeNanoseconds - lastTime.uptimeNanoseconds
//                lastTime = currenTime
//                let elapsedTimeInMilliSeconds = Double(difference) / 1_000_000.0
//                if(elapsedTimeInMilliSeconds > 1300 || countOfChange > 1){
//                    performSearch(newValue)
//                    countOfChange = 0
//                }
//            }
        }
    func performSearch(_ terms: String) {
            print("Search \(terms)")
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = terms
            request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: locationDataManager.currentLocation ?? CLLocationCoordinate2D(latitude: 35.1987162, longitude: -97.4474712), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                guard let response = response else {
                    print("There was an error searching for: \(String(describing: request.naturalLanguageQuery)) error: \(String(describing: error))")
                    return
                }
                self.results = response.mapItems
            }
        }
}

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

#Preview {
    ContentView()
}
