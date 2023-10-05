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
    @State var allMedia: [Int: Media] = [:]
    @State var count = 0
    @State var scrollToIndex: Int = 0
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  
    @State var localImageRequestCriteriaBuilder = RequestCriteriaBuilder()
    
    var body: some View {
        VStack {
           // Text(scrollToIndex == 0 ? "At the top" : (scrollToIndex == allMedia.keys.count - 1 ? "At the end" : ""))
            
            ScrollView(.vertical, showsIndicators: true){
                ScrollViewReader { proxy in
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(Array(allMedia.keys), id: \.self) { index in
                            ImageView(allMedia: $allMedia, localImageRequestCriteriaBuilder: localImageRequestCriteriaBuilder, index: index, count: $count)
                                .id(index)
                                .onAppear{
                                //    count = index
                                 //   print("Called")
                                }
                        }
                    }.onReceive(timer) { _ in
                        if scrollToIndex < allMedia.keys.count - 1 {
                            scrollToIndex += 40
                        } else {
                           // count = 0
                            scrollToIndex = 0
                            
                        }
                        //withAnimation {
                           // proxy.scrollTo(scrollToIndex, anchor: .center)
                       // }
                    }
                }
            }
          
        }.onAppear{
            scrollToIndex = allMedia.keys.count - 1
            // Critera selection
                  
                 //      req.fetchLimit = 200
                 //      req.includeHiddenAssets = false
                 //      req.includeAllBurstAssets = false
                  
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
               // predicate.filterByCreationDate(for: currentTime, condition: .lessThan)
               //        predicate.filterByMediaSubtype(for: .photoScreenshot, condition: .equal)
               //        predicate.filterByisFavorite()
               //
               //        fetchOptions.predicate = NSPredicate(format: "duration >= %d AND duration <= %d", argumentArray: [7, 15])
               //        fetchOptions.predicate = NSPredicate(format: "localIdentifier CONTAINS %@", "B35B71C5-A68E-4D9C-92F7-A8D9B2823E28/L0/001")
                
           //    predicate.makePredicateLogic(key: .duration, comparator: .lessThan, specifier: .intSpecifier)
           //    predicate.addArgument(7.0)
           //    predicate.andConjunct()
               predicate.makePredicateLogic(key: .mediaType, comparator: .equal , specifier: .objectSpecifier)
               predicate.addArgument(PHAssetMediaType.image.rawValue)
           //    predicate.andConjunct()
           //    predicate.makePredicateLogic(key: .mediaType, comparator: .equal, specifier: .objectSpecifier)
           //    predicate.addArgument(PHAssetMediaType.video.rawValue)
                
               print(predicate.getPredicateString())
                
               let startpoint = DispatchTime.now()
               print("Fetching started ")
               allMedia = localImageRequestCriteriaBuilder
                 .setFetchLimit(0)
                 .setPredicate(predicate)
                 .setSortDescriptors(.byCreationDateAscending)
                 .build()
               let duration = (DispatchTime.now().uptimeNanoseconds - startpoint.uptimeNanoseconds) / 1_000_000_000
               print("Fetching done in \(duration)")
           //        let allMedia = localImageProvider.getMediaData(fetchOptions: localImageRequestCriteria)
           //
               // here we will push in PHImageRequestOptions
               
                
           //    for (idx, media) in allMedia.enumerated(){
           //
           //     // dispatchGroup.enter()
           //      localImageRequestCriteriaBuilder
           //        .setContentMode(.default)
           //        .setDeliveryMode(.opportunistic)
           //        .setIsMaximumSizeImage(false)
           //        .setIsSynchronous(false)
           //        .setIsNetworkAccessAllowed(true)
           //        .build(media.value) { image in
           //
           //          DispatchQueue.main.async{
           //            allPhotos[idx] = image
           //            print(idx, allPhotos[idx], image)
           //          }
           //
           //
           //        }
           //
           //      count += 1
           //
           //      // to get not thumb but highquality images you have setIsSynchronous to true
           //
           //
           //    }
           //    dispatchGroup.notify(queue: .main){
           //      print(allPhotos.count)
           //    }
                
               }
        }



//struct ImageView: View {
//   
//    @Binding var allMedia: [Int: Media]
//    var localImageRequestCriteriaBuilder: RequestCriteriaBuilder
//    var index: Int
//    @State var uiImage: UIImage? = nil
//    
//    var body: some View{
//        
//        if let uiImage = uiImage {
//            Image(uiImage: uiImage)
//                .resizable()
//                .frame(width: 100, height: 60)
//                .scaledToFit()
//                .onDisappear{
//                   // DispatchQueue.main.async {
//                        self.uiImage = nil
//                 //   self.localImageRequestCriteriaBuilder = nil
//                    
//                    print("\(index) disappeared")
//                    //}
//               
//                }
//        }
//        else{
//            Image(uiImage: UIImage(color: .blue)!)
//                .resizable()
//                .frame(width: 100, height: 60)
//                .scaledToFit()
//                .onAppear{
//                 //   DispatchQueue.global().async{
//                        localImageRequestCriteriaBuilder
//                            .setContentMode(.aspectFit)
//                            .setDeliveryMode(.opportunistic)
//                            .setIsMaximumSizeImage(false)
//                            .setIsSynchronous(false)
//                            .setIsNetworkAccessAllowed(true)
//                            .build(allMedia[index]!) { image in
//                                DispatchQueue.main.async {
//                                    self.uiImage = image!
//                                    
//                                }
//                                
//                            }
//                  //  }
//                }.onDisappear{
//                  
//                }
//        }
//            
//    }
//}

struct ImageView: View {
   
    @Binding var allMedia: [Int: Media]
    var localImageRequestCriteriaBuilder: RequestCriteriaBuilder
    var index: Int
    @Binding var count: Int
    @State var uiImage: UIImage? = nil
    @State var isAppeared: Bool = false


    var body: some View {
        VStack{
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .onAppear{
                        count += 1
                    }
            } else {
                Color.blue // Set a default color when uiImage is nil
            }
        }
        .onAppear{
            isAppeared = true
            if uiImage == nil {
                localImageRequestCriteriaBuilder
                    .setContentMode(.default)
                    .setDeliveryMode(.opportunistic)
                    .setIsMaximumSizeImage(true)
                    .setIsSynchronous(false)
                    .setIsNetworkAccessAllowed(true)
                    .build(allMedia[index]!) { image in
                      
                        DispatchQueue.main.async{
                            if isAppeared {
                                uiImage = image!
                                print("done loading")
                            }
                        }


                    }
            }
        }
        .onDisappear(perform: {
            isAppeared = false
            self.uiImage = nil
        })

    }
}

//struct ImageView: View {
//    @Binding var allMedia: [Int: Media]
//    var localImageRequestCriteriaBuilder: RequestCriteriaBuilder
//    var index: Int
//    @State var image: Image? // Use Image? instead of UIImage?
//    @State var isAppeared: Bool = false
//
//    var body: some View {
//        VStack {
//            if let image = image {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else {
//                Color.blue // Set a default color or placeholder when image is nil
//            }
//        }
//        .onAppear {
//            isAppeared = true
//            if image == nil {
//                Task {
//                    localImageRequestCriteriaBuilder
//                        .setContentMode(.default)
//                        .setDeliveryMode(.opportunistic)
//                        .setIsMaximumSizeImage(false)
//                        .setIsSynchronous(false)
//                        .setIsNetworkAccessAllowed(true)
//                        .build(allMedia[index]!) { uiImage in
//                            if let uiImage = uiImage {
//                                DispatchQueue.main.async {
//                                    if isAppeared {
//                                        image = Image(uiImage: uiImage)
//                                    }
//
//                                   // self.image = convertedImage
//                                    print("done loading")
//                                }
//
//                            }
//                        }
//                }
//            }
//        }
//        .onDisappear {
//            isAppeared = false
//            image = nil
//            print("image is being nil")
//        }
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
