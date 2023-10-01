//
//  LocalImageRequestCriteria.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 26/9/23.
//

import Foundation
import Photos
import UIKit

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
    
    func setDefultAlbumTitle(_ title: String) -> Self {
        requestCriteria.defultAlbumTitle = title
        return self
    }
    
    
    // ImageLoading Options
    func setDeliveryMode(_ deliveryMode: PHImageRequestOptionsDeliveryMode) -> Self {
        requestCriteria.deliveryMode = deliveryMode
        return self
    }
    
    func setIsSynchronous(_ isSynchronous: Bool) -> Self {
        requestCriteria.isSynchronous = isSynchronous
        return self
    }
    func setContentMode(_ contentMode: PHImageContentMode) -> Self {
        requestCriteria.contentMode = contentMode
        return self
    }
    func setNormalizedCropRect(_ normalizedRect: CGRect) -> Self {
        requestCriteria.normalizedCropRect = normalizedRect
        return self
    }
    func setIsMaximumSizeImage(_ isMaximumSizeImage: Bool) -> Self {
        requestCriteria.isMaximumSizeImage = isMaximumSizeImage
        return self
    }
    func setResizeMode(_ resizeMode: PHImageRequestOptionsResizeMode) -> Self {
        requestCriteria.resizeMode = resizeMode
        return self
    }
    
    func setVersion(_ version: PHImageRequestOptionsVersion)-> Self {
        requestCriteria.version = version
        return self
    }
    
    func setIsNetworkAccessAllowed(_ isNetworkAccessAllowed: Bool) -> Self {
        requestCriteria.isNetworkAccessAllowed =
        isNetworkAccessAllowed
        return self
    }
    
    
//    func getProgressHandler()-> PHAssetImageProgressHandler{
//        return requestCriteria.progressHandler!
//    }
    
    //func 
    func build() -> [Int: Media] {
        
        let allMedia = localImageProvider.getMediaData(fetchOptions: requestCriteria)
        return allMedia
    }
    
    func build(_ media: Media)-> UIImage {
        return media.loadImageData(requestCriteria)!
        
    }
}
