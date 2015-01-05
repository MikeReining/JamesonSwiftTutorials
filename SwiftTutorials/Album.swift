//
//  Album.swift
//  SwiftTutorials
//
//  Created by Michael Reining on 1/4/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation

class Album {
    var title: String
    var price: String
    var thumbnailImageURL: String
    var largeImageURL: String
    var itemURL: String
    var artistURL: String
    
    init(title: String, price: String, thumbnailImageURL: String, largeImageURL: String, itemURL: String, artistURL: String) {
        self.title = title
        self.price = price
        self.thumbnailImageURL = thumbnailImageURL
        self.largeImageURL = largeImageURL
        self.itemURL = itemURL
        self.artistURL = artistURL
    }
    
    class func albumsWithJSON(allResults: NSArray) -> [Album] {
        var albums = [Album]()
        if allResults.count > 0 {
            for result in allResults {
                var title = result["trackName"] as? String
                if title == nil {
                    title = result["collectionName"] as? String
                }
                var price = result["formattedPrice"] as? String
                if price == nil {
                    price = result["collectionPrice"] as? String
                    if price == nil {
                        var priceFloat: Float? = result["collectionPrice"] as? Float
                        var nf: NSNumberFormatter = NSNumberFormatter()
                        nf.maximumFractionDigits = 2
                        if priceFloat != nil {
                            price = "$"+nf.stringFromNumber(priceFloat!)!
                        }
                    }
                }
                let thumbnailURL = result["artworkUrl60"] as? String ?? ""
                let imageURL = result["artworkUrl100"] as? String ?? ""
                let artistURL = result["artistViewUrl"] as? String ?? ""
                var itemURL = result["collectionViewUrl"] as? String
                if itemURL == nil {
                    itemURL = result["trackViewUrl"] as? String
                }
                var newAlbum = Album(title: title!, price: price!, thumbnailImageURL: thumbnailURL, largeImageURL: imageURL, itemURL: itemURL!, artistURL: artistURL)
                albums.append(newAlbum)
            }
        }
        return albums
    }
}
