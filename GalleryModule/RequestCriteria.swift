//
//  RequestCriteria.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 26/9/23.
//

import Foundation
import Photos

class RequestCriteria {
    
    //MARK: Media Fetching options
    var fetchLimit : Int? = 0
    var includeAllBurstAssets: Bool? = false
  //  var includeAssetSourceTypes = .typeUserLibrary // default
    var includeHiddenAssets: Bool? = false
   // fetchOptions.wantsIncrementalChangeDetails = true
    var height: CGFloat? = 300
    var width: CGFloat? = 400
    var predicate = Predicate()
    var sortDescriptors : [NSSortDescriptor] = []
    var defultAlbumTitle: String? = "Recents"
 
    
    //MARK: Media Loading options
    var deliveryMode: PHImageRequestOptionsDeliveryMode? = .opportunistic
    var isSynchronous: Bool? = false
    var normalizedCropRect: CGRect? = .zero
    var isMaximumSizeImage: Bool? = false
    private var _resizeMode: PHImageRequestOptionsResizeMode = .exact
    var resizeMode: PHImageRequestOptionsResizeMode?{
        get {
            return normalizedCropRect != .zero ? .exact : PHImageRequestOptionsResizeMode.exact
                
        }
        set(newValue) {
            _resizeMode = normalizedCropRect != .zero ? .exact:  newValue!
        }
    }
    var version: PHImageRequestOptionsVersion? = .current
    var contentMode: PHImageContentMode? = .aspectFit
    // iCloud
    var isNetworkAccessAllowed: Bool? = false
    // if isNetworkAccessAllowed is true, this handler will give, progress(0.0 to 1.0 floating point number), error(NSError), stop (bool), info
    var progressHandler: PHAssetImageProgressHandler?
}



