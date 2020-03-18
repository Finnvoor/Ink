/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/
import UIKit

struct InlineCode: Fragment, AttributedStringConvertible {
    var modifierTarget: Modifier.Target { .inlineCode }

    private var code: String

    static func read(using reader: inout Reader) throws -> InlineCode {
        try reader.read("`")
        var code = ""

        while !reader.didReachEnd {
            switch reader.currentCharacter {
            case \.isNewline:
                throw Reader.Error()
            case "`":
                reader.advanceIndex()
                return InlineCode(code: code)
            default:
                if let escaped = reader.currentCharacter.escaped {
                    code.append(escaped)
                } else {
                    code.append(reader.currentCharacter)
                }

                reader.advanceIndex()
            }
        }

        throw Reader.Error()
    }

    func html(usingURLs urls: NamedURLCollection,
              modifiers: ModifierCollection) -> String {
        return "<code>\(code)</code>"
    }
    
    func view(options: MarkdownParser.ViewOptions) -> MarkdownViewWrapper {
        MarkdownViewWrapper(type: .none)
    }
    
    func attributedString() -> NSAttributedString {
        return NSAttributedString(string: code.unescaped, attributes: [
            NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 17.0, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.backgroundColor: UIColor.secondarySystemBackground
        ])
    }

    func plainText() -> String {
        code
    }
}
