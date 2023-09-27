//
//  LocalImageRequestCriteria.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 26/9/23.
//

import Foundation
import Photos

class LocalImageRequestCriteria: RequestCriteria{
 
 
  //  var contentMode
    // var imageDelivery
   
    
}

class RequestCriteriaBuilder {
    private var requestCriteria: LocalImageRequestCriteria = LocalImageRequestCriteria()
    var localImageProvider = LocalImageProvider()

    func setFetchLimit(_ fetchLimit: Int) -> Self {
        requestCriteria.fetchLimit = fetchLimit
        return self
    }

    func setIncludeAllBurstAssets(_ includeAllBurstAssets: Bool) -> Self {
        requestCriteria.includeAllBurstAssets = includeAllBurstAssets
        return self
    }

    func setIncludeHiddenAssets(_ includeHiddenAssets: Bool) -> Self {
        requestCriteria.includeHiddenAssets = includeHiddenAssets
        return self
    }

    func setHeight(_ height: CGFloat) -> Self {
        requestCriteria.height = height
        return self
    }
    

    func setWidth(_ width: CGFloat) -> Self {
        requestCriteria.width = width
        return self
    }
    func setPredicate(_ predicate: Predicate) -> Self {
        requestCriteria.predicate = predicate
        return self
    }
    func setSortDescriptors(_ sortDescriptors: Sort... ) -> Self {
        for sort in sortDescriptors {
            requestCriteria.sortDescriptors.append(sort.sortDescriptor)
        }
        return self
    }
    //func 
    func build() -> [Int: Media] {
        
        let allMedia = localImageProvider.getMediaData(fetchOptions: requestCriteria)
        return allMedia
    }
}
