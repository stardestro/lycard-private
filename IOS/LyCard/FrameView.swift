//
//  FrameView.swift
//  LyCard
//
//  Created by Hussain Alkatheri on 2/10/24.
//  //  From https://www.kodeco.com/26244793-building-a-camera-app-with-swiftui-and-combine

import SwiftUI

struct FrameView: View {
    var image: CGImage?
    private let label = Text("Camera frame")
    var body: some View {
        if let image = image {
          // 2
          GeometryReader { geometry in
            // 3
            Image(image, scale: 1.0, orientation: .upMirrored, label: label)
              .resizable()
              .scaledToFill()
              .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .center)
              .clipped()
          }
        } else {
          // 4
          Color.black
        }
    }
}

#Preview {
    FrameView()
}
