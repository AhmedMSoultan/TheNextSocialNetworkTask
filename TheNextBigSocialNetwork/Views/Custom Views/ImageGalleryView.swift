//
//  ImageGalleryView.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 11/09/2023.
//

import SwiftUI

struct ImageGalleryView: View {
    @Binding var selectedImage: String
    @Binding var isShowingFullScreen: Bool
    let imageCount: Int
    let columns = [
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center)
    ]
    
    var body: some View {
        VStack {
            
            //MARK: Post Image View
            switch imageCount {
            case 1:
                KingFisherImage(imageSize: CGSize(width: UIScreen.main.bounds.width - 16, height: 178),
                                url: URL(string: "https://picsum.photos/170/17\(0)")!,
                                hasCornerRadius: true)
                .onTapGesture {
                    selectedImage = "https://picsum.photos/170/17\(0)"
                    isShowingFullScreen = true
                }
            case 2:
                LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                    // MARK: Lists from Universal Search
                    
                    ForEach((0...1), id: \.self) { number in
                        KingFisherImage(imageSize: CGSize(width: UIScreen.main.bounds.width/2 - 24, height: 178),
                                        url: URL(string: "https://picsum.photos/170/17\(number)")!,
                                        hasCornerRadius: true)
                        .onTapGesture {
                            selectedImage = "https://picsum.photos/170/17\(number)"
                            isShowingFullScreen = true
                        }
                    }
                }
            case 3:
                HStack {
                    KingFisherImage(imageSize: CGSize(width: UIScreen.main.bounds.width/2 - 24, height: 178 * 2 + 8), url: URL(string: "https://picsum.photos/170/17\(0)")!,
                                    hasCornerRadius: true)
                    .onTapGesture {
                        selectedImage = "https://picsum.photos/170/17\(0)"
                        isShowingFullScreen = true
                    }
                    
                    VStack {
                        ForEach((1...2), id: \.self) { number in
                            KingFisherImage(imageSize: CGSize(width: UIScreen.main.bounds.width/2 - 24, height: 178), url: URL(string: "https://picsum.photos/170/17\(number)")!,
                                            hasCornerRadius: true)
                            .onTapGesture {
                                selectedImage = "https://picsum.photos/170/17\(number)"
                                isShowingFullScreen = true
                            }
                        }
                    }
                }
                
            case 4:
                LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                    // MARK: Lists from Universal Search
                    
                    ForEach((0...3), id: \.self) { number in
                        KingFisherImage(imageSize: CGSize(width: UIScreen.main.bounds.width/2 - 24, height: 178),
                                        url: URL(string: "https://picsum.photos/170/17\("https://picsum.photos/170/17\(number)")")!,
                                        hasCornerRadius: true)
                        .onTapGesture {
                            selectedImage = "https://picsum.photos/170/17\("https://picsum.photos/170/17\(number)")"
                            isShowingFullScreen = true
                        }
                    }
                }
                
            default:
                LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                    // MARK: Lists from Universal Search
                    
                    ForEach((0...3), id: \.self) { number in
                        if number == 3 {
                            ZStack {
                                KingFisherImage(imageSize: CGSize(width: UIScreen.main.bounds.width/2 - 24, height: 178), url: URL(string: "https://picsum.photos/170/17\(number)")!,
                                                hasCornerRadius: true)
                                .onTapGesture {
                                    selectedImage = "https://picsum.photos/170/17\(number)"
                                    isShowingFullScreen = true
                                }
                                
                                // Thin Material with Image
                                Rectangle()
                                    .foregroundColor(.black)
                                    .opacity(0.5)
                                    .frame(width: UIScreen.main.bounds.width/2 - 24, height: 178)
                                
                                if imageCount > 4 {
                                    Text("+\(imageCount - 4)")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(10)
                                }
                            }
                            .cornerRadius(8)
                            .padding(4)
                        } else {
                            KingFisherImage(imageSize: CGSize(width: UIScreen.main.bounds.width/2 - 24, height: 178),
                                            url: URL(string: "https://picsum.photos/170/17\(number)")!,
                                            hasCornerRadius: true)
                            .onTapGesture {
                                selectedImage = "https://picsum.photos/170/17\(number)"
                                isShowingFullScreen = true
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ImageGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryView(selectedImage: .constant(""), isShowingFullScreen: .constant(false),imageCount: 6)
    }
}
