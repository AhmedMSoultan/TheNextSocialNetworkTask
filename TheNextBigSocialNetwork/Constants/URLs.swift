//
//  URLs.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 15/03/2023.
//

import Foundation

let baseURL = "https://dummyjson.com/"

enum EndPoint {
    case auth
    case getAllPosts
    case searchPosts(String)
    
    
    var url: URL {
        return URL(string: self.urlValue) ?? URL(string: "")!
    }

    var urlValue: String {
        switch self {
        case .auth:
            return baseURL + "auth/login"
        case .getAllPosts:
            return baseURL + "posts"
        case .searchPosts(let searchText):
            return baseURL + "posts/search?q=\(searchText)"
        }
    }
}
