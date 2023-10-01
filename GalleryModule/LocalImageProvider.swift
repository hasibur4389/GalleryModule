import Foundation
import Photos



class LocalImageProvider: MediaProvider{
    

    // query like sort, predicate, loading options
    
    
    // let requestCritera: LocalImageRequestCriteria
    var allMedia : [Int: Media] = [:]
    
    //    init() {
    ////        self.predicate = Predicate()
    //        //  self.localImageMedia = LocalImageMedia(asset: predicate)
    //      //  self.requestCritera = LocalImageRequestCriteria()
    //    }
    
    func getMediaData<T>(fetchOptions: T) -> [Int: Media] where T : RequestCriteria {
        
        // different fetching options
        let fetchAssetOptions = PHFetchOptions()
        let fetchAssetCollectionOptions = PHFetchOptions()
        
//        fetchAssetOptions.sortDescriptors = fetchOptions.sortDescriptors
        //fetchAssetOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchAssetOptions.fetchLimit = fetchOptions.fetchLimit!
        fetchAssetOptions.includeAllBurstAssets = fetchOptions.includeAllBurstAssets!
        fetchAssetOptions.includeHiddenAssets = fetchOptions.includeHiddenAssets!
        // fetchOptions.wantsIncrementalChangeDetails = true
        // fetchOptions.includeAssetSourceTypes
        
        fetchAssetOptions.predicate = fetchOptions.predicate.getPredicate()
       // fetchAssetOptions.predicate = NSPredicate(format: "duration >= %d", argumentArray: [3])
       
        let albums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: fetchAssetCollectionOptions)
        //
        print(albums.count)
        // here we will push in PHFetchOption for asset and for PHFecthOption for assetCollection
    
        

        albums.enumerateObjects { album, albumIndex, stop in
            // print(albumIndex)
           
            let results = PHAsset.fetchAssets(in: album, options: fetchAssetOptions)
            print("\(album.localizedTitle) has \(results.count) assets")
            
            if album.localizedTitle == fetchOptions.defultAlbumTitle! {
                print("yess")
            }
            // var idx = 0
            results.enumerateObjects { [self] asset, assetIndex, stop in
                //  print("asset is\(asset.mediaType.rawValue)")
                
                // if asset.mediaType == .image{
                
                //MARK: Gif identifying
                let assetResource = PHAssetResource.assetResources(for: asset)
                //
                let assetUTI = assetResource.first?.originalFilename.lowercased()
                
                allMedia[assetIndex] = LocalImageMedia(asset: asset)
                
                //                        let isGif = assetUTI?.hasSuffix(".gif")
                //                        // different loading options
                //  print("assetUTI \(assetResource.first?.assetLocalIdentifier)")
                
                //                    let options = PHImageRequestOptions()
                //                    //                            options.isSynchronous = true
                //
                //
                //                    // if isGif == true {
                //                    PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: requestCritera.width!, height: requestCritera.height!), contentMode: .aspectFit, options: nil) { image, info in
                //                        //
                //                        //
                //                        //
                //                        //                                }
                //                        //                                if let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool {
                //                        //                                        print("is thumb: \(isDegraded)")
                //                        //                                    }
                //                        // allPhotos.append(image!)
                //
                //                       // allPhotos[assetIndex] = image
                //
                //                    }
                // }
                // }
            }
        }
        return allMedia
        
    }
    
    func getCategoryData() {
        
    }
    
    func getPaginatedMediaData() {
        
    }
    
    func getPaginatedCategoryData() {
        
    }
    
    
}

//struct Re{
//   
//    var fetchLimit : Int? = 0
//    var includeAllBurstAssets: Bool? = false
//  //  var includeAssetSourceTypes = .typeUserLibrary // default
//    var includeHiddenAssets: Bool? = false
//   // fetchOptions.wantsIncrementalChangeDetails = true
//    var height: CGFloat? = 300
//    var width: CGFloat? = 400
//  //  var contentMode
//    // var imageDelivery
//    
//}

