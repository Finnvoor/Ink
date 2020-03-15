# InkView
This is a fork of [John Sundell's](https://twitter.com/johnsundell) Markdown parser [Ink](https://github.com/JohnSundell/Ink).  Ink was designed to render Markdown to HTML, whereas this project aims to render Markdown as a SwiftUI view.  Ink parses markdown into fragments which are then converted to HTML.  This fork assigns each of these fragments a View representation.

## Usage
```swift
import SwiftUI
import Ink

struct ExampleView: View {
    let parser = MarkdownParser()
    let markdown =
    """
    # Hello
    ---
    This is a **markdown** document.
    > Pretty cool
    """
    
    var body: some View {
        parser.view(from: self.markdown)
    }
}
}
```

## Supported syntax
InkView currently supports the following Markdown features:

- Headings (H1 - H6), using leading pound signs, for example `## H2`.
- Blockquotes can be created by placing a greater-than arrow at the start of a line, like this: `> This is a blockquote`.
- Horizontal lines can be placed using either three asterisks (`***`) or three dashes (`---`) on a new line.
