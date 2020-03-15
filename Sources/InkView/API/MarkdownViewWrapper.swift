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
        case .text(let text):
            return text.eraseToAnyView()
        case .heading(let heading):
            return heading.eraseToAnyView()
        case .horizontalLine:
            return HorizontalLineView().eraseToAnyView()
        case .codeBlock(let codeBlock):
            return codeBlock.eraseToAnyView()
        case .blockquote(let blockquote):
            return blockquote.eraseToAnyView()
        case .none:
            return EmptyView().eraseToAnyView()
        }
    }
}

@available(iOS 13.0, *)
internal enum MarkdownViewType {
    case text(Text)
    case heading(HeadingView)
    case horizontalLine
    case codeBlock(CodeBlockView)
    case blockquote(BlockquoteView)
    case none
}
