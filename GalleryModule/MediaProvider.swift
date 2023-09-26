//
//  MediaProvider.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 26/9/23.
//

import Foundation


protocol MediaProvider{
    
    func getMediaData() ->[Media]
    func getCategoryData()
    func getPaginatedMediaData() 
    func getPaginatedCategoryData()
}
