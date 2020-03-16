//
//  MarkdownViewWrapper.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct MarkdownViewWrapper: Identifiable {
    public let id = UUID()
    var type: MarkdownViewType
    var view: some View {
        switch type {
        case .heading(let heading, let level):
            return HeadingView(text: heading, level: level).eraseToAnyView()
        case .horizontalLine:
            return HorizontalLineView().eraseToAnyView()
        case .codeBlock(let code, let options):
            return CodeBlockView(text: code, options: options).eraseToAnyView()
        case .blockquote(let quote):
            return BlockquoteView(text: quote).eraseToAnyView()
        case .formattedText(let text):
            return FormattedTextView(text: text, urlAction: { url in UIApplication.shared.open(Foundation.URL(string: String(url))!) }).eraseToAnyView()
        case .link(let text, let url):
            return LinkText(text: text, url: url).eraseToAnyView()
        case .none:
            return EmptyView().eraseToAnyView()
        }
    }
}

@available(iOS 13.0, *)
internal enum MarkdownViewType {
    case heading(heading: String, level: Int)
    case horizontalLine
    case codeBlock(code: String, options: MarkdownParser.ViewOptions)
    case blockquote(quote: String)
    case formattedText(text: NSAttributedString)
    case link(text: String, url: String)
    case none
}
