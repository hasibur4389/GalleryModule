import Foundation
import Photos



class LocalImageProvider: MediaProvider{
    
    // query like sort, predicate, loading options
    let predicate: Predicate

    let requestCritera: LocalImageRequestCriteria
    var allMedia : [Media] = []
    
    init() {
        self.predicate = Predicate()
      //  self.localImageMedia = LocalImageMedia(asset: predicate)
        self.requestCritera = LocalImageRequestCriteria()
    }
    func getMediaData() -> [Media] {
        // different fetching options
        let fetchAssetOptions = PHFetchOptions()
        let fetchAssetCollectionOptions = PHFetchOptions()
        
        
        
        fetchAssetOptions.sortDescriptors = [Sort.byCreationDateAscending.sortDescriptor]
        fetchAssetOptions.fetchLimit = requestCritera.fetchLimit!
        fetchAssetOptions.includeAllBurstAssets = requestCritera.includeAllBurstAssets!
        //fetchOptions.includeAssetSourceTypes
        fetchAssetOptions.includeHiddenAssets = requestCritera.includeHiddenAssets!
        // fetchOptions.wantsIncrementalChangeDetails = true
        
        // different sorting options
        
        
        
        // User Access

       
        let currentTime = Date().addingTimeInterval( -7 * 24 * 60 * 60)
        
        //MARK: Default filter method calls
      //  predicate.filterByCreationDate(for: currentTime, condition: .lessThan)
//                predicate.filterByMediaSubtype(for: .photoScreenshot, condition: .equal)
//                predicate.filterByisFavorite()
//
        
        predicate.makePredicateLogic(key: .pixelWidth, comparator: .lessThan,  specifier: .integerSpecifier)
        predicate.addArgument(1800)
        predicate.andConjunct()
        predicate.makePredicateLogic(key: .mediaType, comparator: .equal , specifier: .objectSpecifier)
        predicate.addArgument(PHAssetMediaType.video.rawValue)
        print(predicate.getPredicateString())
   
        
    
        //  var newString3 = predicate.andConjucnt(firstString: newString!, secondString: newString2!)
        // final call
        //        predicate.setPredicateString(newString3)
        //  print(predicate.getPredicateString()!, predicate.getArguments())
        
        //        let oneWeek = Date().addingTimeInterval( -60)
      
        
        
 
        
        if let finalPredicate = predicate.getPredicate() {
            fetchAssetOptions.predicate = finalPredicate
        }else{
            print("predicate found nil")
            fetchAssetOptions.predicate = nil
        }
        fetchAssetOptions.predicate = nil
//                fetchOptions.predicate = NSPredicate(format: "duration >= %d AND duration <= %d", argumentArray: [7, 15])
//                fetchOptions.predicate = NSPredicate(format: "localIdentifier CONTAINS %@", "B35B71C5-A68E-4D9C-92F7-A8D9B2823E28/L0/001")
           
            //MARK: Fetches all the images along with gifs first frame, duplicates from each folder in PhotoLibraru
            //                let results = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            //
            //                results.enumerateObjects { asset, index, stop in
            //                    let options = PHImageRequestOptions()
            //                    PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 300, height: 200), contentMode: .aspectFit, options: options) { (image, _) in
            //                        allPhotos.append(image!)
            //                    }
            //                }
            
            
            //MARK: only getting the albums, recents Images
        
            let foptions = PHFetchOptions()
         let prd = NSPredicate(format: "title == %@", "My Album")
           // foptions.predicate = prd
        let albums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: foptions)
//
        print(albums.count)
            
            albums.enumerateObjects { album, albumIndex, stop in
               // print(albumIndex)
               
                let results = PHAsset.fetchAssets(in: album, options: nil)
                print("\(album.localizedTitle) has \(results.count) assets")
                // var idx = 0
                results.enumerateObjects { [self] asset, assetIndex, stop in
                  //  print("asset is\(asset.mediaType.rawValue)")
                    
                    // if asset.mediaType == .image{
                    
                    //MARK: Gif identifying
                                            let assetResource = PHAssetResource.assetResources(for: asset)
                    //
                                            let assetUTI = assetResource.first?.originalFilename.lowercased()
                    
                    allMedia.append(LocalImageMedia(asset: asset))
                  
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

