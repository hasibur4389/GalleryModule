//
//  CustomVGrid.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 4/10/23.
//

import Foundation
import SwiftUI

struct CustomVGrid<Content: View> : View {
    @State private var scrollOffset: CGFloat = 0
    @State private var previousScrollOffset: CGFloat = 0
    
    private let numberOfItems: Int
    private let itemHeight: CGFloat
    private let cellBuilder: (Int) -> Content
    private let columns: Int

    init(numberOfItems: Int, itemHeight: CGFloat, columns: Int, viewForCell cellBuilder: @escaping (Int) -> Content) {
        self.numberOfItems = numberOfItems
        self.itemHeight = itemHeight
        self.cellBuilder = cellBuilder
        self.columns = columns
    }

    
    var body: some View {
        GeometryReader { geometry in
            self.listView(geometry)
        }
    }
    
    private func listView(_ geometry: GeometryProxy) -> some View {
        let screenHeight: CGFloat = geometry.size.height
        let canvasHeight: CGFloat = itemHeight * CGFloat((numberOfItems + columns - 1) / columns)
        let itemsPerWindow: CGFloat = min(screenHeight / itemHeight, CGFloat(numberOfItems))
        let initialWindowOffset: CGFloat = (canvasHeight / 2) - ((itemsPerWindow / 2) * itemHeight)
        
        let startIndex = Int(floor(abs(scrollOffset) / itemHeight))
        let endIndex = min(startIndex + Int(ceil(itemsPerWindow)) + 1, (numberOfItems + columns - 1) / columns)
        let visibleRange = startIndex ..< endIndex
        
        let leadingPadding: CGFloat = CGFloat(startIndex) * itemHeight
        let trailingPadding: CGFloat = canvasHeight - (CGFloat(endIndex) * itemHeight)
        
        return VStack(spacing: 0) {
            Spacer().frame(height: leadingPadding)
            ForEach(visibleRange, id: \.hashValue) { rowIndex in
                HStack(spacing: 0) {
                    ForEach(0..<columns, id: \.self) { columnIndex in
                        let index = rowIndex * columns + columnIndex
                        if index < numberOfItems {
                            self.cellBuilder(index).frame(height: self.itemHeight).border(Color.red, width: 1)
                        } else {
                            Spacer()
                        }
                    }
                }
            }
            Spacer().frame(height: max(-initialWindowOffset, trailingPadding))
        }
        .offset(y: initialWindowOffset)
        .offset(y: scrollOffset)
        .gesture(DragGesture().onChanged({ value in
            self.scrollOffset = max((-2 * initialWindowOffset), min(0, self.previousScrollOffset + value.translation.height))
        }).onEnded({ value in
            withAnimation() {
                self.scrollOffset = max((-2 * initialWindowOffset), min(0, self.previousScrollOffset + value.predictedEndTranslation.height))
                self.previousScrollOffset = self.scrollOffset
            }
        }))
    }
}

//struct ContentView: View {
//
//    var body: some View {
//        CustomVGrid(numberOfItems: 10000, itemHeight: 80, columns: 3) { index in
//            Text("\(index)")
//        }
//        .frame(width: 240, height: 200)
//        .border(Color.black, width: 2)
//        .clipped()
//    }
//}
//
//PlaygroundPage.current.setLiveView(ContentView())
//

//: A UIKit based Playground for presenting user interface
  
//
//
struct HList<Content: View>: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var previousScrollOffset: CGFloat = 0
    
    private let numberOfItems: Int
    private let itemWidth: CGFloat
    private let cellBuilder: (Int) -> Content

    init(numberOfItems: Int, itemWidth: CGFloat, viewForCell cellBuilder: @escaping (Int) -> Content) {
        self.numberOfItems = numberOfItems
        self.itemWidth = itemWidth
        self.cellBuilder = cellBuilder
        print("number of items \(numberOfItems), item width \(itemWidth)")
    }

    
    var body: some View {
        GeometryReader { geometry in
            self.listView(geometry)
        }
    }
    
    private func listView(_ geometry: GeometryProxy) -> some View {
        let screenWidth: CGFloat = geometry.size.width
        let canvasWidth: CGFloat = itemWidth * CGFloat(numberOfItems)
        let itemsPerWindow: CGFloat = min(screenWidth / itemWidth, CGFloat(numberOfItems))
        let initialWindowOffset: CGFloat = (canvasWidth / 2) - ((itemsPerWindow / 2) * itemWidth)
        
        let startIndex = Int(floor(abs(scrollOffset) / itemWidth))
        let endIndex = min(startIndex + Int(ceil(itemsPerWindow)) + 1, numberOfItems)
        let visibleRange = startIndex ..< endIndex
        
        let leadingPadding: CGFloat = CGFloat(startIndex) * itemWidth
        let trailingPadding: CGFloat = canvasWidth - (CGFloat(endIndex) * itemWidth)
        
        
        
        print(canvasWidth, itemsPerWindow, initialWindowOffset, scrollOffset)
        
        return HStack(spacing: 0) {
            Spacer().frame(width: leadingPadding)
            ForEach(visibleRange, id: \.hashValue) { index in
                self.cellBuilder(index).frame(width: self.itemWidth).border(Color.red, width: 1)
            }
            Spacer().frame(width: max(-initialWindowOffset, trailingPadding))
        }
//        .offset(x: initialWindowOffset)
        .offset(x: scrollOffset)
        .gesture(DragGesture().onChanged({ value in
            self.scrollOffset = max((-2 * initialWindowOffset), min(0, self.previousScrollOffset + value.translation.width))
        }).onEnded({ value in
            withAnimation() {
                self.scrollOffset = max((-2 * initialWindowOffset), min(0, self.previousScrollOffset + value.predictedEndTranslation.width))
                self.previousScrollOffset = self.scrollOffset
            }
        }))
    }
}

//struct HList<Content: View>: View {
//    @State private var scrollOffset: CGFloat = 0
//    @State private var previousScrollOffset: CGFloat = 0
//
//    private let numberOfItems: Int
//    private let itemWidth: CGFloat
//    private let cellBuilder: (Int) -> Content
//
//    init(numberOfItems: Int, itemWidth: CGFloat, viewForCell cellBuilder: @escaping (Int) -> Content) {
//        self.numberOfItems = numberOfItems
//        self.itemWidth = itemWidth
//        self.cellBuilder = cellBuilder
//    }
//
//
//    var body: some View {
//        GeometryReader { geometry in
//            self.listView(geometry)
//        }
//    }
//
//    private func listView(_ geometry: GeometryProxy) -> some View {
//        let screenWidth: CGFloat = geometry.size.width
//        let canvasWidth: CGFloat = itemWidth * CGFloat(numberOfItems)
//        let itemsPerWindow: CGFloat = min(screenWidth / itemWidth, CGFloat(numberOfItems))
//        let initialWindowOffset: CGFloat = (canvasWidth / 2) - ((itemsPerWindow / 2) * itemWidth)
//
//        let startIndex = Int(floor(abs(scrollOffset) / itemWidth))
//        let endIndex = min(startIndex + Int(ceil(itemsPerWindow)) + 1, numberOfItems)
//        let visibleRange = startIndex ..< endIndex
//
//        let leadingPadding: CGFloat = CGFloat(startIndex) * itemWidth
//        let trailingPadding: CGFloat = canvasWidth - (CGFloat(endIndex) * itemWidth)
//
//        return HStack(spacing: 0) {
//            Spacer().frame(width: leadingPadding)
//            ForEach(visibleRange, id: \.hashValue) { index in
//                self.cellBuilder(index).frame(width: self.itemWidth).border(Color.red, width: 1)
//            }
//            Spacer().frame(width: max(-initialWindowOffset, trailingPadding))
//        }
//        .offset(x: initialWindowOffset)
//        .offset(x: scrollOffset)
//        .gesture(DragGesture().onChanged({ value in
//            self.scrollOffset = max((-2 * initialWindowOffset), min(0, self.previousScrollOffset + value.translation.width))
//        }).onEnded({ value in
//            withAnimation() {
//                self.scrollOffset = max((-2 * initialWindowOffset), min(0, self.previousScrollOffset + value.predictedEndTranslation.width))
//                self.previousScrollOffset = self.scrollOffset
//            }
//        }))
//    }
//}
//
////struct ContentView: View {
////
////    var body: some View {
////        HList(numberOfItems: 10000, itemWidth: 80) { index in
////            Text("\(index)")
////        }
////        .frame(width: 200, height: 60)
////        .border(Color.black, width: 2)
////        .clipped()
////    }
////}
////
//// PlaygroundPage.current.setLiveView(ContentView())
