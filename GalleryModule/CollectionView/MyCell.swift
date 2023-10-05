//
//  MyCell.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 5/10/23.
//

import Foundation

import UIKit

class MyCell: UICollectionViewCell {
    static let identifier = "myCell"
   // var uiImage: UIImage?
   // var text: String = ""
    let imageView = UIImageView()
    var aLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.addSubview(aLabel)
//        aLabel.translatesAutoresizingMaskIntoConstraints = false
//        aLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//        aLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
//        aLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
//        aLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupText(uiImage: UIImage ){
//        self.imageView.image = uiImage
//    }
    
    func setupImage(localRequestCriteria: RequestCriteriaBuilder, media: Media ){
     //   self.imageView.image = uiImage
        localRequestCriteria
            .setContentMode(.default)
            .setDeliveryMode(.opportunistic)
            .setIsMaximumSizeImage(false)
            .setIsSynchronous(false)
            .setIsNetworkAccessAllowed(true)
            .build(media) { image in
              
                DispatchQueue.main.async{
//                    if isAppeared {
                    self.imageView.image = image
                        print("done loading")
//                    }
                }


            }
        
    }
    
    
    
}
