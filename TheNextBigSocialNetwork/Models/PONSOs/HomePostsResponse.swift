//
//  HomePostsResponse.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 15/03/2023.
//

import Foundation

struct HomePostsResponse : Codable {
    let posts : [Post]?
    let total : Int?
    let skip : Int?
    let limit : Int?

    enum CodingKeys: String, CodingKey {
        case posts = "posts"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }
}

struct Post : Codable, Identifiable {
    var identifier = UUID()
    let id : Int?
    let title : String?
    let body : String?
    let userId : Int?
    let tags : [String]?
    let reactions : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case body = "body"
        case userId = "userId"
        case tags = "tags"
        case reactions = "reactions"
    }
}
