//
//  TextWithHighlightedSearchText.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 11/09/2023.
//

import SwiftUI

struct TextWithHighlightedSearchText: View {
    let text: String
    let searchText: String
    
    var body: some View {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: searchText, options: .caseInsensitive)
        
//        attributedString.addAttribute(.foregroundColor, value: UIColor.yellow, range: range)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: range)
        
        return Text("\(attributedString)")
    }
}

struct TextWithHighlightedSearchText_Previews: PreviewProvider {
    static var previews: some View {
        TextWithHighlightedSearchText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                      searchText: "sit")
    }
}
