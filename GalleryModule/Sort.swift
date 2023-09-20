//
//  Sort.swift
//  GalleryModule
//
//  Created by Hasibur Rahman on 20/9/23.
//

import Foundation


enum Sort {
    // Local identifier
    case byLocalIdentifierAscending
    case byLocalIdentifierDescending

    // Creation date
    case byCreationDateAscending
    case byCreationDateDescending

    // Modification date
    case byModificationDateAscending
    case byModificationDateDescending

    // Media type
    case byMediaTypeAscending
    case byMediaTypeDescending

    // Media subtypes
    case byMediaSubtypesAscending
    case byMediaSubtypesDescending

    // Duration
    case byDurationAscending
    case byDurationDescending

    // Pixel width
    case byPixelWidthAscending
    case byPixelWidthDescending

    // Pixel height
    case byPixelHeightAscending
    case byPixelHeightDescending

    // Is favorite
    case byIsFavoriteAscending
    case byIsFavoriteDescending

    // Is hidden
    case byIsHiddenAscending
    case byIsHiddenDescending

    // Burst identifier
    case byBurstIdentifierAscending
    case byBurstIdentifierDescending

    var sortDescriptor: NSSortDescriptor {
        switch self {
        // Local identifier
        case .byLocalIdentifierAscending:
            return NSSortDescriptor(key: "localIdentifier", ascending: true)
        case .byLocalIdentifierDescending:
            return NSSortDescriptor(key: "localIdentifier", ascending: false)

        // Creation date
        case .byCreationDateAscending:
            return NSSortDescriptor(key: "creationDate", ascending: true)
        case .byCreationDateDescending:
            return NSSortDescriptor(key: "creationDate", ascending: false)

        // Modification date
        case .byModificationDateAscending:
            return NSSortDescriptor(key: "modificationDate", ascending: true)
        case .byModificationDateDescending:
            return NSSortDescriptor(key: "modificationDate", ascending: false)

        // Media type
        case .byMediaTypeAscending:
            return NSSortDescriptor(key: "mediaType", ascending: true)
        case .byMediaTypeDescending:
            return NSSortDescriptor(key: "mediaType", ascending: false)

        // Media subtypes
        case .byMediaSubtypesAscending:
            return NSSortDescriptor(key: "mediaSubtypes", ascending: true)
        case .byMediaSubtypesDescending:
            return NSSortDescriptor(key: "mediaSubtypes", ascending: false)

        // Duration
        case .byDurationAscending:
            return NSSortDescriptor(key: "duration", ascending: true)
        case .byDurationDescending:
            return NSSortDescriptor(key: "duration", ascending: false)

        // Pixel width
        case .byPixelWidthAscending:
            return NSSortDescriptor(key: "pixelWidth", ascending: true)
        case .byPixelWidthDescending:
            return NSSortDescriptor(key: "pixelWidth", ascending: false)

        // Pixel height
        case .byPixelHeightAscending:
            return NSSortDescriptor(key: "pixelHeight", ascending: true)
        case .byPixelHeightDescending:
            return NSSortDescriptor(key: "pixelHeight", ascending: false)

        // Is favorite
        case .byIsFavoriteAscending:
            return NSSortDescriptor(key: "isFavorite", ascending: true)
        case .byIsFavoriteDescending:
            return NSSortDescriptor(key: "isFavorite", ascending: false)

        // Is hidden
        case .byIsHiddenAscending:
            return NSSortDescriptor(key: "isHidden", ascending: true)
        case .byIsHiddenDescending:
            return NSSortDescriptor(key: "isHidden", ascending: false)

        // Burst identifier
        case .byBurstIdentifierAscending:
            return NSSortDescriptor(key: "burstIdentifier", ascending: true)
        case .byBurstIdentifierDescending:
            return NSSortDescriptor(key: "burstIdentifier", ascending: false)
        }
    }
}
