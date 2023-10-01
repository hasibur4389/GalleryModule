//
//  Media.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 26/9/23.
//

import Foundation
import UIKit
import AVFoundation
import Photos


protocol Media {
    var asset: PHAsset { get }
    
   
    func loadImageData<T: RequestCriteria>(_ loadOptions: T) -> UIImage?
    
    func loadVideoData() -> AVAsset?
}

