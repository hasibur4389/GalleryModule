//
//  CollectionView.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 5/10/23.
//

import SwiftUI

struct CollectionView: UIViewRepresentable {
   // var myTexts: [String]
    @ObservedObject var dataModel: DataModel
    
 
//    init(allMedia: [Int : Media], localRequestCriteriaBuilder: RequestCriteriaBuilder) {
//        self.allMedia = allMedia
//        self.localRequestCriteriaBuilder = localRequestCriteriaBuilder
//    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    func updateUIView(_ uiView: UICollectionView, context: UIViewRepresentableContext<CollectionView>) {
        uiView.reloadData()
    }
    
    func makeUIView(context: UIViewRepresentableContext<CollectionView>) -> UICollectionView {
        
          let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
            let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         //   collectioView.backgroundColor = UIColor.clear
        collectioView.dataSource = context.coordinator
        collectioView.delegate = context.coordinator
        collectioView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.identifier)
            return collectioView
        
    }
}

//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionView()
//    }
//}


class Coordinator: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
     var myCollectionView: CollectionView
    
    init(_ myCollectionView: CollectionView) {
        self.myCollectionView = myCollectionView
        super.init()
    }
    
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("I am here")
        return myCollectionView.dataModel.allMedia.count
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.identifier, for: indexPath) as! MyCell
      
        
        
                // Configure your cell here (e.g., set background color, labels, etc.)
      //  cell.text = myCollectionView.myTexts[indexPath]
       // cell.setupText(text: myCollectionView.myTexts[indexPath.row])
        cell.setupImage(localRequestCriteria: myCollectionView.dataModel.localImageRequestCriteriaBuilder, media: myCollectionView.dataModel.allMedia[indexPath.row]!)
        
                return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: 100, height: 100)
            }
    
    
    
}
