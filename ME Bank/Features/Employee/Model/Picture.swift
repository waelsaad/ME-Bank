//
//  Picture.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import Foundation

struct Picture: Codable {
    let large, thumbnail: String?
}

extension Picture {
    var thumbnailUrl: URL? {
        if let urlString = thumbnail,
            let url = URL(string: urlString) {
            return url
        }
        return nil
    }

    var largeImageUrl: URL? {
        if let urlString = large,
            let url = URL(string: urlString) {
            return url
        }
        return nil
    }
}
