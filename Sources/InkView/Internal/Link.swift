/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/
import UIKit

internal struct Link: Fragment, AttributedStringConvertible {
    var modifierTarget: Modifier.Target { .links }

    var target: Target
    var text: FormattedText

    static func read(using reader: inout Reader) throws -> Link {
        try reader.read("[")
        let text = FormattedText.read(using: &reader, terminator: "]")
        try reader.read("]")

        guard !reader.didReachEnd else { throw Reader.Error() }

        if reader.currentCharacter == "(" {
            reader.advanceIndex()
            let url = try reader.read(until: ")")
            return Link(target: .url(url), text: text)
        } else {
            try reader.read("[")
            let reference = try reader.read(until: "]")
            return Link(target: .reference(reference), text: text)
        }
    }

    func html(usingURLs urls: NamedURLCollection,
              modifiers: ModifierCollection) -> String {
        let url = target.url(from: urls)
        let title = text.html(usingURLs: urls, modifiers: modifiers)
        return "<a href=\"\(url)\">\(title)</a>"
    }
    
    func view(options: MarkdownParser.ViewOptions) -> MarkdownViewWrapper {
        MarkdownViewWrapper(type: .link(text: text.plainText().unescaped, url: ""))
    }
    
    func attributedString() -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: text.plainText().unescaped, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)])
        attrString.addAttribute(.link, value: "www.google.com", range: NSRange(location: 0, length: attrString.string.count))
        return attrString
    }

    func plainText() -> String {
        text.plainText()
    }
}

extension Link {
    enum Target {
        case url(URL)
        case reference(Substring)
    }
}

extension Link.Target {
    func url(from urls: NamedURLCollection) -> URL {
        switch self {
        case .url(let url):
            return url
        case .reference(let name):
            return urls.url(named: name) ?? name
        }
    }
}
