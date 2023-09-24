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
    
    func filterByCreationDate(for date: Date, condition queryComparator: QueryComparator) {
        self.predicateString = AssetKeys.creationDate.rawValue + queryComparator.rawValue + QuerySpecifier.intSpecifier.rawValue
        arguments.removeAll()
        self.arguments.append(date)
    }
    
    func filterByMediaSubtype(for subType: PHAssetMediaSubtype, condition queryComparator: QueryComparator) {
        self.predicateString = AssetKeys.mediaSubType.rawValue + queryComparator.rawValue + QuerySpecifier.intSpecifier.rawValue
        arguments.removeAll()
        self.arguments.append(subType.rawValue)
        print(predicateString)
    }
    
    func getPredicate() -> NSPredicate? {
        guard let predicateString = self.predicateString else {
            return nil
        }
        
        return NSPredicate(format: predicateString, argumentArray: arguments)
    }
    
    func setPredicateString(_ predicateString: String) {
        self.predicateString = predicateString
    }
    
    func setArguments(_ arguments: [Any]) {
        self.arguments = arguments
    }
    
    func addArguments(_ argument: Any) {
        self.arguments.append(argument)
    }
    
    func getPredicateString() -> String? {
        return self.predicateString
    }
    
    func getArguments() -> [Any] {
        return self.arguments
    }
    
    func makePredicateLogic(key: String, comparator: String, specifier: String) {
        self.predicateString = ""
        self.predicateString! += key + comparator + specifier
    }
    
    func andConjunct(firstString str1: String, secondString str2: String) -> String {
        return str1 + " AND " + str2
    }
    
    func orConjunct(firstString str1: String, secondString str2: String) -> String {
        return str1 + " OR " + str2
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
