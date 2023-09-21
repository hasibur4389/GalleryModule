//
//  LocalImageProvider.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 20/9/23.
//

import Foundation


class Predicate{
    var predicateString: String?
    var arguments: [Any] = []
   
  
    enum AssetKeys: String {
        case localIdentifier = "localIndentifier"
        case modificationDate = "modificationDate"
        case mediaType = "mediaType"
        case mediaSubType = "mediaSubType"
        case creationDate = "creationDate"
        case duration = "duration"
        case pixelWidth = "pixelWidth"
        case pixelHeight = "pixelHeight"
        case isHidden = "isHidded"
        case isFavorite = "isFavorite"
        case burstIdentifier = "burstIdentifier"
     
    }


    enum AssetCollectionKeys: String {
        case localIdentifier = "localIndentifier"
        case title = "title"
        case startDate = "startDate"
        case endDate = "endDate"
        case estimatedAssetCount = "estimatedAssetCount"
        
    }

    enum AssetCollectionListKeys: String {
        case localIdentifier = "localIndentifier"
        case title = "title"
        case startDate = "startDate"
        case endDate = "endDate"
        
    }

   
    init(_ predicateString: String, _ arguments: [Any]){
        self.predicateString = predicateString
        self.arguments = arguments
//        self.assetkeysEnum = .localIdentifier
//        self.assetCollectionKeysEnum = .title
//        self.assetCollectionListKeysEnum = .localIdentifier
    }
    init(){
        
    }
   
    func setPredicateString(_ predicateString: String){
        self.predicateString = predicateString
    }
    
    func setArguments(_ arguments: [Any]){
        self.arguments = arguments
    }
    
    func getPredicateString() -> String? {
        return self.predicateString
    }
    
    func getArguments() -> [Any]{
        return self.arguments
    }
    
}




