//
//  CustomPredicateQuery.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 24/9/23.
//

import Foundation
import Photos



class Predicate {
    var predicateString: String? = ""
    var arguments: [Any] = []
    
    init(_ predicateString: String, _ arguments: [Any]) {
        self.predicateString = predicateString
        self.arguments = arguments
    }
    
    init() {}
    
    //MARK: Some Default filtering options
    func filterByCreationDate(for date: Date, condition queryComparator: QueryComparator) {
        self.predicateString = ""
        self.predicateString = AssetKeys.creationDate.rawValue + queryComparator.rawValue + QuerySpecifier.intSpecifier.rawValue
        arguments.removeAll()
        self.arguments.append(date)
    }
    
    func filterByMediaSubtype(for subType: PHAssetMediaSubtype, condition queryComparator: QueryComparator) {
        self.predicateString = ""
        self.predicateString = AssetKeys.mediaSubType.rawValue + queryComparator.rawValue + QuerySpecifier.intSpecifier.rawValue
        arguments.removeAll()
        self.arguments.append(subType.rawValue)
        print(predicateString)
    }
    func filterByisFavorite(){
        self.predicateString = ""
        self.predicateString = AssetKeys.isFavorite.rawValue + QueryComparator.equal.rawValue + QuerySpecifier.trueSpecifier.rawValue
        arguments.removeAll()
    }
    
    func getPredicate() -> NSPredicate? {
        guard let predicateString = self.predicateString else {
            return nil
        }
        
        return NSPredicate(format: predicateString, argumentArray: arguments)
    }
    
  
    func setArguments(_ arguments: [Any]) {
        self.arguments = arguments
    }
    
    func addArgument(_ argument: Any) {
        self.arguments.append(argument)
    }
    
    func getPredicateString() -> String? {
        return self.predicateString
    }
    
    func getArguments() -> [Any] {
        return self.arguments
    }
    
    func makePredicateLogic(key: AssetKeys, comparator: QueryComparator, caseSensitive isCaseSensitive: Bool = false, specifier: QuerySpecifier) {
     
        if isCaseSensitive == true{
            self.predicateString! += key.rawValue + comparator.rawValue + QueryComparator.caseInsensitiveBeforeSpecifier.rawValue +  specifier.rawValue
        }
        else{
            self.predicateString! += key.rawValue + comparator.rawValue +  specifier.rawValue
        }
    }
    
    func andConjunct() {
        if (((self.predicateString?.isEmpty) != nil) ) {
            self.predicateString! += " AND "
        }
        else{
            print("Predicate String is Empty nothing to add AND to")
        }
    }
    
    func orConjunct() {
        if (((self.predicateString?.isEmpty) != nil) ) {
            self.predicateString! += " OR "
        }
        else{
            print("Predicate String is Empty nothing to add AND to")
        }
    }
}


enum QueryComparator: String {
    case notEqual = "!="
    case equal = "=="
    case greaterThan = ">"
    case lessThan = "<"
    case greaterThanOrEqual = ">="
    case lessThanOrEqual = "<="
    case caseInsensitiveBeforeSpecifier = "[c]"
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
    case In = "IN"
    case contains = "CONTAINS"
    case between = "BETWEEN"
    case like = "LIKE"
    case matching = "MATCHING"
}

enum QuerySpecifier: String {
    case objectSpecifier = "%@"
    case integerSpecifier = "%i"
    case fractionSpecifier = "%f"
    case keypathSpecifier = "%K"
    case intSpecifier = "%d"
    case trueSpecifier = "true"
    case falseSpecifier = "false"
}
// %K == %@
enum AssetKeys: String {
    case localIdentifier = "localIndentifier"
    case modificationDate = "modificationDate"
    case mediaType = "mediaType"
    case mediaSubType = "mediaSubtypes"
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
