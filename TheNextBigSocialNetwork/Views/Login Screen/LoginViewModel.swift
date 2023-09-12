//
//  LoginViewModel.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 16/03/2023.
//

import Foundation
class LoginViewModel: ObservableObject {
    let networkLayer = NetworkLayer.shared
    let userDefaults = UserDefaults.standard
    
    @Published var username = ""
    @Published var password = ""
    
    @Published var loginResponse: LoginResponse?
    @Published var errorMessage: String?
    
    @Published var displayHomeView = false
    @Published var displayErrorMessage = false
    @Published var disableLoginBtn = false
    
    func login() {
        self.disableLoginBtn = true
        let parameters: [String: Any] = [
            "username" : username ,
            "password" : password
        ]
        networkLayer.login(endpoint: .auth, className: LoginResponse.self, params: parameters) { response in
            self.disableLoginBtn = false
            switch response {
            case .success(let data):
                self.loginResponse = data
                if let token = data.token {
                    self.userDefaults.set(token, forKey: UserToken)
                }
                self.displayHomeView = true
                
            case .failure:
                self.errorMessage = "Wrong username or password"
                self.displayErrorMessage = true
            }
        }
    }
}
