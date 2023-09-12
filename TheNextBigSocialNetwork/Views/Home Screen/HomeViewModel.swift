//
//  HomeViewModel.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 16/03/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    let networkLayer = NetworkLayer.shared
    let userDefaults = UserDefaults.standard
    
    @Published var homePostsResponse: HomePostsResponse?
    @Published var errorMessage: String?
    @Published var searchString: String = ""
    @Published var isSearching = false
    @Published var posts = [Post]()
    @Published var isLoading = false
    @Published var displayErrorMessage = false
    
    var currentPage = 0
    
    func getHomePosts() {
        isLoading = true
        networkLayer.get(endPoint: .getAllPosts, className: HomePostsResponse.self) { response in
            self.isLoading = false
            switch response {
            case .success(let data):
                self.homePostsResponse = data
                if let posts = data.posts {
                    if self.currentPage == 0 {
                        self.posts = posts
                    } else {
                        self.posts.append(contentsOf: posts)
                    }
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.displayErrorMessage = true
            }
        }
    }
    
    func getHomePostsWithSearchText() {
        isLoading = true
        networkLayer.get(endPoint: .searchPosts(searchString), className: HomePostsResponse.self) { response in
            self.isLoading = false
            switch response {
            case .success(let data):
                self.homePostsResponse = data
                if let posts = data.posts {
                    if self.currentPage == 0 {
                        self.posts = posts
                    } else {
                        self.posts.append(contentsOf: posts)
                    }
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.displayErrorMessage = true
            }
        }
    }
}
