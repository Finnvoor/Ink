//
//  File.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI

internal struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

internal extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

internal extension NSAttributedString {
    func body() -> NSAttributedString {
        var attributes = self.attributes(at: 0, effectiveRange: nil)
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17.0)
        return NSAttributedString(string: self.string, attributes: attributes)
    }
    
    func bold() -> NSAttributedString {
        var attributes = self.attributes(at: 0, effectiveRange: nil)
        guard let font = attributes[NSAttributedString.Key.font] as? UIFont,
            let newDescriptor = font.fontDescriptor.withSymbolicTraits(
                font.fontDescriptor.symbolicTraits.union(.traitBold)
        ) else {
            return self
        }
        attributes[NSAttributedString.Key.font] = UIFont(descriptor: newDescriptor, size: font.pointSize)
        return NSAttributedString(string: self.string, attributes: attributes)
    }
    
    func italic() -> NSAttributedString {
        var attributes = self.attributes(at: 0, effectiveRange: nil)
        guard let font = attributes[NSAttributedString.Key.font] as? UIFont,
            let newDescriptor = font.fontDescriptor.withSymbolicTraits(
                font.fontDescriptor.symbolicTraits.union(.traitItalic)
        ) else {
            return self
        }
        attributes[NSAttributedString.Key.font] = UIFont(descriptor: newDescriptor, size: font.pointSize)
        return NSAttributedString(string: self.string, attributes: attributes)
    }
    
    func strikethrough() -> NSAttributedString {
        var attributes = self.attributes(at: 0, effectiveRange: nil)
        attributes.updateValue(NSUnderlineStyle.single, forKey: .strikethroughStyle)
        return NSAttributedString(string: self.string, attributes: attributes)
    }
}
