//
//  LoginResponse.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 15/03/2023.
//

import Foundation

struct LoginResponse : Codable {
    let id : Int?
    let username : String?
    let email : String?
    let firstName : String?
    let lastName : String?
    let gender : String?
    let image : String?
    let token : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case gender = "gender"
        case image = "image"
        case token = "token"
    }
}
