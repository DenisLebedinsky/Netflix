//
//  YoutubeSearchResponse.swift
//  Netflix
//
//  Created by Denis Lebedinsky on 12.04.2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
    let kind: String
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
