//
//  ContentView.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 20/9/23.
//

import SwiftUI
import Photos

// fetch critera -> sorting, predicate, media Type, mediaSubType
// loading criteria -> image quality, asynchronusly, image size(width, height), contentMode


struct RequestCriteria{
   
    var fetchLimit : Int? = 0
    var includeAllBurstAssets: Bool? = false
  //  var includeAssetSourceTypes = .typeUserLibrary // default
    var includeHiddenAssets: Bool? = false
   // fetchOptions.wantsIncrementalChangeDetails = true
    var height: CGFloat? = 300
    var width: CGFloat? = 400
  //  var contentMode
    // var imageDelivery
    
}

struct ContentView: View {
    
    @State var allPhotos: [Int : UIImage] = [:]
    @State var count = 0
    var req = RequestCriteria()
    
    var body: some View {
        VStack {
            Text("Total Photos \(allPhotos.count)")
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 100))]) {
                    ForEach(allPhotos.keys.sorted(), id: \.self) { index in
                                    VStack {
                                        Image(uiImage: allPhotos[index]!)
                                            .resizable()
                                            .scaledToFit()
                                      //  Text("\(index + 1)")
                                    }
                                }
                            }
                        }

        }.onAppear{
            // Critera selection
           
//            req.fetchLimit = 200
//            req.includeHiddenAssets = false
//            req.includeAllBurstAssets = false
            
            PHPhotoLibrary.requestAuthorization { status in
                switch status{
                case .authorized:
                    getAllLocalImages()
                    break
                case .notDetermined:
                    print("NotDetermined")
                    break
                case .restricted:
                    print("restricted")
                    break
                case .denied:
                    print("denied")
                    break
                case .limited:
                    print("Loimited")
                    break
                @unknown default:
                    print("unknown")
                    break
                    
                }
     
    }
    
    
    func getAllLocalImages(){
        
    
              // different fetching options
                let fetchOptions = PHFetchOptions()
                
        fetchOptions.fetchLimit = req.fetchLimit!
        fetchOptions.includeAllBurstAssets = req.includeAllBurstAssets!
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary // default
        fetchOptions.includeHiddenAssets = req.includeHiddenAssets!
               // fetchOptions.wantsIncrementalChangeDetails = true

        // different sorting options
        fetchOptions.sortDescriptors = [Sort.byCreationDateAscending.sortDescriptor, Sort.byIsFavoriteAscending.sortDescriptor]
        
      
        let oneWeek = Date().addingTimeInterval( -60)
        let format =  " \(Predicate.AssetKeys.mediaType.rawValue) == %d && \(Predicate.AssetKeys.creationDate.rawValue) < %@ "
        
        let arguments = [PHAssetMediaType.image.rawValue, oneWeek] as [Any]
        let predicateObject = Predicate(format, arguments)
       
     
//        fetchOptions.predicate =  NSPredicate(format: " (creationDate < %@) || (mediaType == %d)", [oneWeek as CVarArg, PHAssetMediaType.image.rawValue] as [Any])
        fetchOptions.predicate =  NSPredicate(format: " mediaType == %d || creationDate < %@",  [PHAssetMediaType.image.rawValue, oneWeek] )
        fetchOptions.predicate = NSPredicate(format: predicateObject.getPredicateString()!, argumentArray: predicateObject.getArguments())
        
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
                let albums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
                
               // print(albums.firstObject?.localizedTitle)
        
                albums.enumerateObjects { album, albumIndex, stop in
                   // print(albumIndex)
                    
                    let results = PHAsset.fetchAssets(in: album, options: fetchOptions)
                  //  print("index is \(results.count)")
                   // var idx = 0
                    results.enumerateObjects { asset, assetIndex, stop in
                        print("asset is\(asset.mediaType.rawValue)")
                       // if asset.mediaType == .image{
                            
                            // different loading options
                           // print("is thumb \(PHImageResultIsDegradedKey.)")
                            let options = PHImageRequestOptions()
//                            options.isSynchronous = true
                           
                            
                            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: req.width!, height: req.height!), contentMode: .aspectFit, options: options) { image, info in
                                
//                                if let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool {
//                                        print("is thumb: \(isDegraded)")
//                                    }
                               // allPhotos.append(image!)
                                
                                allPhotos[assetIndex] = image
                             //   idx += 1
                            }
                       // }
                    }
                }
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
