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


struct ContentView: View {
    
    @State var allPhotos: [Int : UIImage] = [:]
    @State var count = 0
    
    var localImageRequestCriteriaBuilder = RequestCriteriaBuilder()
    
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
                    print("Limited")
                    break
                @unknown default:
                    print("unknown")
                    break
                    
                }
                
            }
            
            
            
            }
        }
    
    func getAllLocalImages(){

            //MARK: only getting the albums, recents Images
//
        let predicate = Predicate()
        let currentTime = Date().addingTimeInterval( -7 * 24 * 60 * 60)
        
        //MARK: Default filter method calls
        //  predicate.filterByCreationDate(for: currentTime, condition: .lessThan)
        //                predicate.filterByMediaSubtype(for: .photoScreenshot, condition: .equal)
        //                predicate.filterByisFavorite()
        //
        //                fetchOptions.predicate = NSPredicate(format: "duration >= %d AND duration <= %d", argumentArray: [7, 15])
        //                fetchOptions.predicate = NSPredicate(format: "localIdentifier CONTAINS %@", "B35B71C5-A68E-4D9C-92F7-A8D9B2823E28/L0/001")
        
//        predicate.makePredicateLogic(key: .duration, comparator: .lessThan,  specifier: .intSpecifier)
//        predicate.addArgument(7.0)
//        predicate.andConjunct()
        predicate.makePredicateLogic(key: .mediaType, comparator: .equal , specifier: .objectSpecifier)
        predicate.addArgument(PHAssetMediaType.image.rawValue)
//        predicate.andConjunct()
//        predicate.makePredicateLogic(key: .mediaType, comparator: .equal, specifier: .objectSpecifier)
//        predicate.addArgument(PHAssetMediaType.video.rawValue)
        
        print(predicate.getPredicateString())
        
        
      
        let allMedia = localImageRequestCriteriaBuilder
            .setFetchLimit(2000)
            .setPredicate(predicate)
            .setSortDescriptors(.byCreationDateAscending)
            .build()
//                let allMedia = localImageProvider.getMediaData(fetchOptions: localImageRequestCriteria)
//
        // here we will push in PHImageRequestOptions
      
         
        for (idx, media) in allMedia.enumerated(){
            
          //  dispatchGroup.enter()
            localImageRequestCriteriaBuilder
                .setContentMode(.default)
                .setDeliveryMode(.opportunistic)
                .setIsMaximumSizeImage(false)
                .setIsSynchronous(false)
                .setIsNetworkAccessAllowed(true)
                .build(media.value) { image in
                
                    DispatchQueue.main.async{
                        allPhotos[idx] = image
                        print(idx, allPhotos[idx], image)
                    }
                    
                   
                }
        
            count += 1
            
            // to get not thumb but highquality images you have setIsSynchronous to true
        
           // print(allPhotos[idx])
            
        }
//        dispatchGroup.notify(queue: .main){
//            print(allPhotos.count)
//        }
        
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
