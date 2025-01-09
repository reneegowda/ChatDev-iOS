//
//  Post.swift

import Foundation

struct Post: Decodable {
        let id: String
        var likes: [String]
        let message: String
        let time: Date
}

