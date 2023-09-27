//
//  RequestCriteria.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 26/9/23.
//

import Foundation

class RequestCriteria {
    
    var fetchLimit : Int? = 0
    var includeAllBurstAssets: Bool? = false
  //  var includeAssetSourceTypes = .typeUserLibrary // default
    var includeHiddenAssets: Bool? = false
   // fetchOptions.wantsIncrementalChangeDetails = true
    var height: CGFloat? = 300
    var width: CGFloat? = 400
    var predicate = Predicate()
    var sortDescriptors : [NSSortDescriptor] = []
 
  //  var contentMode
    // var imageDelivery
}


