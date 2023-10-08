//
//  DataClass.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 5/10/23.
//

import Foundation

class DataModel: ObservableObject{
    @Published var allMedia: [Int: Media] = [:]
    @Published var count = 0
//    @State var scrollToIndex: Int = 0
   @Published var localImageRequestCriteriaBuilder = RequestCriteriaBuilder()

}
