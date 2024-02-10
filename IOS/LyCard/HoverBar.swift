////
////  HoverBar.swift
////  LyCard
////
////  Created by Hussain Alkatheri on 2/10/24.
////
//
//import SwiftUI
//
//struct HoverBar: View {
//    @Binding public var search: String
//    @Binding public var isCamera: Bool
//    @Binding public var isLocation: Bool
//    var body: some View {
//        HStack{
//            Spacer()
//            Button {
//                isLocation = !isLocation
//            } label: {
//                Image(systemName: "mappin.and.ellipse")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 30)
//            }
//
//            TextField(
//                "Search",
//                text: $search
//            ).frame(width: 250)
//            Button {
//                isCamera = !isCamera
//            } label: {
//                Image(systemName: "camera")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 30)
//            }
//            Spacer()
//        }
//        .background(
//            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
//                .fill(.secondary)
//                
//        )
//    }
//}
//
//#Preview {
//    @State var testing0: String = ""
//    @State var testing1: Bool = false
//    @State var testing2: Bool = false
//    HoverBar(search: $testing0, isCamera: $testing1, isLocation: $testing2)
//}
