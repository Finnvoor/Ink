//
//  FormattedTextView.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI


struct FormattedTextView: View {
    var text: NSAttributedString
    
    var body: some View {
        MultilineTextField(text: text).padding(.horizontal)
//        AttributedTextView(text).padding(.horizontal)
    }
}

struct AttributedTextView: UIViewRepresentable {
    var attributedText: NSAttributedString

    init(_ attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = false
        return view
    }

    func updateUIView(_ label: UITextView, context: Context) {
        label.attributedText = attributedText
    }
}

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    let text: NSAttributedString
    @Binding var calculatedHeight: CGFloat

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
//        textField.delegate = context.coordinator

        textField.isEditable = false
//        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = false
        textField.isUserInteractionEnabled = false
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        uiView.attributedText = self.text
//        if uiView.window != nil, !uiView.isFirstResponder {
//            uiView.becomeFirstResponder()
//        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }

//    func makeCoordinator() -> Coordinator {
//        return Coordinator(text: text, height: $calculatedHeight, onDone: onDone)
//    }
//
//    final class Coordinator: NSObject, UITextViewDelegate {
//        var text: String
//        var calculatedHeight: Binding<CGFloat>
//        var onDone: (() -> Void)?
//
//        init(text: String, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
//            self.text = text
//            self.calculatedHeight = height
//            self.onDone = onDone
//        }
//
//        func textViewDidChange(_ uiView: UITextView) {
//            text.wrappedValue = uiView.text
//            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
//        }
//
//        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//            if let onDone = self.onDone, text == "\n" {
//                textView.resignFirstResponder()
//                onDone()
//                return false
//            }
//            return true
//        }
//    }

}

struct MultilineTextField: View {

//    private var placeholder: String
//    private var onCommit: (() -> Void)?

    let text: NSAttributedString
//    private var internalText: Binding<String> {
//        Binding<String>(get: { self.text } ) {
//            self.text = $0
//            self.showingPlaceholder = $0.isEmpty
//        }
//    }

    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false

//    init (text: String) {
//        self.placeholder = placeholder
//        self.onCommit = onCommit
//        self._text = text
//        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
//    }

    var body: some View {
        UITextViewWrapper(text: self.text, calculatedHeight: $dynamicHeight)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
//            .background(placeholderView, alignment: .topLeading)
    }

//    var placeholderView: some View {
//        Group {
//            if showingPlaceholder {
//                Text(placeholder).foregroundColor(.gray)
//                    .padding(.leading, 4)
//                    .padding(.top, 8)
//            }
//        }
//    }
}
