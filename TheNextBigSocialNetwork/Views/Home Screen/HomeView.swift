//
//  HomeView.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 14/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        TabView {
            PostsView()
                .tabItem {
                    TabBarItem(tabItemImage: .home)
                        .frame(width: 10, height: 10, alignment: .center)
                }
            
            Text("Shop")
                .tabItem {
                    TabBarItem(tabItemImage: .shop)
                }
            
            Text("Discount")
                .tabItem {
                    TabBarItem(tabItemImage: .discount)
                }
            
            Text("Gallery")
                .tabItem {
                    TabBarItem(tabItemImage: .gallery)
                }
            
            Text("Profile")
                .tabItem {
                    TabBarItem(tabItemImage: .profile)
                }
        }
    }
}

struct TabBarItem: View {
    var tabBarImage: TabBarImage
    
    init(tabItemImage: TabBarImage) {
        self.tabBarImage = tabItemImage
    }
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.accentColor)
                .frame(width: 12, height: 2)
            
            Image(tabBarImage.rawValue)
                .resizable()
                .renderingMode(.template)
                .frame(width: 26, height: 26)
                .scaledToFill()
        }
        .padding(.top)
    }
}

enum TabBarImage: String {
    case home = "home-icon"
    case shop = "shop-icon"
    case discount = "discount-shape-icon"
    case gallery = "gallery-icon"
    case profile = "profile-icon"
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
