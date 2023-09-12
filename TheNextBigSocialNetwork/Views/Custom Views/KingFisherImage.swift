//
//  KingFisherImage.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 14/03/2023.
//

import SwiftUI
import Kingfisher

struct KingFisherImage: View {
    var imageSize: CGSize
    var url: URL
    var hasCornerRadius = true
    var cornerRadiusValue = 8.0
    
    @State private var showActivity = true
    @State private var imageError = false
    
    var body: some View {
        
        if !imageError {
            KFImage.url(url)
                .placeholder({
                    Color.black
                })
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onSuccess { result in
                    showActivity = false
                }
                .onFailure { error in
                    showActivity = false
                    imageError = true
                }
                .resizable()
                .scaledToFill()
                .frame(width: imageSize.width, height: imageSize.height)
                .cornerRadius(hasCornerRadius ? cornerRadiusValue : 0)
                .overlay(Group {
                    if showActivity {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    }
                })
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(hasCornerRadius ? cornerRadiusValue : 0)
                .frame(width: imageSize.width, height: imageSize.height)
        }
    }
}

struct KingFisherImage_Previews: PreviewProvider {
    static var previews: some View {
        KingFisherImage(imageSize: CGSize(width: 500, height: 500),
                        url: URL(string: "https://picsum.photos/170/170")!,
                        hasCornerRadius: true)
    }
}
