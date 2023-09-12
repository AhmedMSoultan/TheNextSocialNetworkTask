//
//  PostCell.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 16/03/2023.
//

import SwiftUI

struct PostCell: View {
    var post: Post
    @Binding var searchText: String
    @Binding var selectedImage: String
    @Binding var isShowingFullScreen: Bool
    
    let numberOfPhotos = Int(arc4random_uniform(4))
    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            //MARK: Header View
            HStack(spacing: 4) {
                KingFisherImage(imageSize: CGSize(width: 40, height: 40),
                                url: URL(string: "https://picsum.photos/170/17\(post.id ?? 0)")!,
                                hasCornerRadius: true)
                .cornerRadius(20)
                .onTapGesture {
                    withAnimation {
                        selectedImage = "https://picsum.photos/170/17\(post.id ?? 0)"
                        isShowingFullScreen = true
                    }
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text((post.userId ?? 0).description)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(textColor)
                        Spacer()
                        
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 16, height: 4)
                            .foregroundColor(dotsColor)
                    }
                    
                    Text("2 days ago")
                        .font(.system(size: 13))
                        .foregroundColor(dateColor)
                }
                Spacer()
            }
            
            //MARK: Post Text View
            TextWithHighlightedSearchText(text: post.body ?? "", searchText: searchText)
                .font(.system(size: 17, weight: .regular))
            
            //MARK: Post Image View
            ImageGalleryView(selectedImage: $selectedImage,
                             isShowingFullScreen: $isShowingFullScreen,
                             imageCount: post.id ?? 0)
        }
        .padding(.horizontal, 16)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PostCell(post: Post(id: 1,
                                title: "This is important to remember.",
                                body: "This is important to remember. Love isn't like pie. You don't need to divide it among all your friends and loved ones. No matter how much love you give, you can always give more. It doesn't run out, so don't try to hold back giving it as if it may one day run out. Give it freely and as much as you want.",
                                userId: 12,
                                tags: ["magical","crime"],
                                reactions: 2),
                     searchText: .constant("important"),
                     selectedImage: .constant(""),
                     isShowingFullScreen: .constant(false))
        }
    }
}
