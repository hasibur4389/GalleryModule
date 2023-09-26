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
    var localImageProvider = LocalImageProvider()
    
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
            
            
            func getAllLocalImages(){
                let allMedia = localImageProvider.getMediaData()
              
                for media in allMedia{
                    allPhotos[count] =  media.loadImageData()
                    count += 1
                    
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
