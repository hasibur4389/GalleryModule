//
//  LocalImageMedia.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 26/9/23.
//

import UIKit
import Photos



class LocalImageMedia: Media{
 
    let asset: PHAsset
    
    init(asset: PHAsset) {
        self.asset = asset
        
       // super(self.asset)
    }
    
   
    
    func loadImageData() -> UIImage? {
        let options = PHImageRequestOptions()
            options.isNetworkAccessAllowed = true
            options.deliveryMode = .highQualityFormat
        
        var uiImage = UIImage()
            PHImageManager.default().requestImage(
                for: self.asset,
              targetSize: PHImageManagerMaximumSize,
              contentMode: .default,
              options: options) { (image, _) in
                  uiImage = image!
            }
        return uiImage
    }
    func loadVideoData() -> AVAsset? {
        return AVAsset()
    }
    
    
}
