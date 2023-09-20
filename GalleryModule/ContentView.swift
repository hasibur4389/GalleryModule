//
//  ContentView.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 20/9/23.
//

import SwiftUI
import Photos

// fetch criter -> sorting, predicate, media Type, mediaSubType
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
    
    @State var allPhotos: [UIImage] = []
    @State var count = 0
    var req = RequestCriteria()
    
    var body: some View {
        VStack {
            Text("Total Photos \(allPhotos.count)")
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 100))]) {
                                ForEach(allPhotos.indices, id: \.self) { index in
                                    VStack {
                                        Image(uiImage: allPhotos[index])
                                            .resizable()
                                            .scaledToFit()
                                        Text("\(index + 1)")
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
        
    
                
                let fetchOptions = PHFetchOptions()
                
        fetchOptions.fetchLimit = req.fetchLimit!
        fetchOptions.includeAllBurstAssets = req.includeAllBurstAssets!
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary // default
        fetchOptions.includeHiddenAssets = req.includeHiddenAssets!
               // fetchOptions.wantsIncrementalChangeDetails = true
                
//                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchOptions.sortDescriptors = [Sort.byCreationDateAscending.sortDescriptor, Sort.byIsFavoriteAscending.sortDescriptor]
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
                
                albums.enumerateObjects { album, index, stop in
                    print(album.description)
                    
                    let results = PHAsset.fetchAssets(in: album, options: fetchOptions)
                    
                    results.enumerateObjects { asset, index, stop in
                        if asset.mediaType == .image{
                            let options = PHImageRequestOptions()
                            options.isSynchronous = true
                            
                            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: req.width!, height: req.height!), contentMode: .aspectFit, options: options) { image, _ in
                                allPhotos.append(image!)
                                
                            }
                        }
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
