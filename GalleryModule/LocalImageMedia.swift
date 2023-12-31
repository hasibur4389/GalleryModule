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
     
      //  self.id = LocalImageMedia.idCounter
       // super(self.asset)
    }
    
    func loadImageData<T>(_ loadOptions: T, completion: @escaping (UIImage?) -> Void) where T : RequestCriteria {
        let options = PHImageRequestOptions()
        
        // for image delivery mode can be set to all the three but if i am loading video it can only be opportunistic otherwise nil
        options.deliveryMode =  loadOptions.deliveryMode!
        options.isNetworkAccessAllowed = loadOptions.isNetworkAccessAllowed!
        options.isSynchronous = loadOptions.isSynchronous!
//
        options.resizeMode = loadOptions.resizeMode!
        options.version = loadOptions.version!
        loadOptions.progressHandler = options.progressHandler
//
       
        
       
        
      
        PHImageManager.default().requestImage(
            for: self.asset,
            targetSize: (loadOptions.isMaximumSizeImage)! == true ? PHImageManagerMaximumSize : CGSize(width: loadOptions.width!, height: loadOptions.height!),
            contentMode: loadOptions.contentMode!,
            options: options) { (image, info) in
//                count += 1
//                print(count)
                   // print(self.asset.localIdentifier)
               completion(image)
              
               
            }
      //  count += 1
 
       // options.deliveryMode = .highQualityFormat // Request a high-quality image
        //options.resizeMode = .exact // Resize the image exactly to the target size

//        PHImageManager.default().requestImage(
//            for: self.asset,
//            targetSize: PHImageManagerMaximumSize,
//            contentMode: .aspectFit,
//            options: options) { (image, info) in
//                uiImage = image
//        }
       
    }
    
    
    

    
    
    func loadVideoData() -> AVAsset? {
        return AVAsset()
    }
    
    
}
