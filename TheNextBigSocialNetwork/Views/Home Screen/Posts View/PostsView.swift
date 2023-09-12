//
//  PostsView.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 16/03/2023.
//

import SwiftUI

struct PostsView: View {
    @StateObject var homeVM = HomeViewModel()
    @State private var selectedImage = ""
    @State private var isShowingPreviewScreen = false
    
    
    var body: some View {
        VStack(spacing: 16) {
            if homeVM.isSearching {
                CustomSearchBar(searchText: $homeVM.searchString,
                                isSearching: $homeVM.isSearching)
            } else {
                HStack {
                    Image("LOGO")
                        .resizable()
                        .frame(width: 60 ,height: 16)
                        .scaledToFit()
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .onTapGesture {
                            withAnimation {
                                homeVM.isSearching.toggle()
                            }
                        }
                }
                .frame(height: 40)
                .padding(.horizontal, 20)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
            
            if homeVM.isLoading && homeVM.currentPage == 0 {
                Spacer()
                ProgressView()
                    .tint(Color.accentColor)
                    .frame(width: 80, height: 80)
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(homeVM.posts, id: \.identifier) { post in
                            PostCell(post: post,
                                     searchText: $homeVM.searchString,
                                     selectedImage: $selectedImage,
                                     isShowingFullScreen: $isShowingPreviewScreen)
                            Divider()
                        }
                        ProgressView()
                            .tint(Color.accentColor)
                            .onAppear() {
                                homeVM.currentPage += 1
                                DispatchQueue.main.async {
                                    if homeVM.searchString.isEmpty {
                                        homeVM.getHomePosts()
                                    } else {
                                        homeVM.getHomePostsWithSearchText()
                                    }
                                }
                            }
                    }
                }
            }
        }
        .onAppear() {
            homeVM.getHomePosts()
        }
        .onDebouncedChange(of: $homeVM.searchString, debounceFor: 1, perform: { _ in
            homeVM.currentPage = 0
            homeVM.getHomePostsWithSearchText()
        })
        .overlay {
            if isShowingPreviewScreen {
                ZStack {
                    Color.black.opacity(0.5)
                    
                    KingFisherImage(imageSize: CGSize(width: UIScreen.main.bounds.width - 16, height: UIScreen.main.bounds.width - 16), url: URL(string: selectedImage)!)
                        .onTapGesture {
                            isShowingPreviewScreen = false
                        }
                }
                .ignoresSafeArea()
                .onTapGesture {
                    isShowingPreviewScreen = false
                }
            }
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}

struct CustomSearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText)
                    .padding(.vertical, 10)
                Image(systemName: "xmark.circle")
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        withAnimation {
                            searchText = ""
                            isSearching.toggle()
                        }
                    }
            }
            .padding(.horizontal, 26)
            .frame(height: 40)
        }
        .transition(.opacity.combined(with: .move(edge: .bottom)))
        .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(borderColor, lineWidth: 1)
            .padding(.horizontal, 16))
    }
}
