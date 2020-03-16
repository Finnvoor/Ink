//
//  FormattedTextView.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI


struct FormattedTextView: View {
    let text: NSAttributedString
    let urlAction: (Foundation.URL) -> Void
    
    var body: some View {
        AttributedTextView(text: text, urlAction: urlAction).padding(.horizontal)
    }
}

struct AttributedTextView: View {
    let text: NSAttributedString
    let urlAction: (Foundation.URL) -> Void
    @State private var dynamicHeight: CGFloat = 100

    var body: some View {
        UITextViewWrapper(text: self.text, urlAction: self.urlAction, calculatedHeight: $dynamicHeight)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
    }
}

struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    let text: NSAttributedString
    let urlAction: (Foundation.URL) -> Void
    @Binding var calculatedHeight: CGFloat
    private var delegate: UITextViewWrapperDelegate = UITextViewWrapperDelegate()
    
    public init(text: NSAttributedString, urlAction: @escaping (Foundation.URL) -> Void, calculatedHeight: Binding<CGFloat>) {
        self.text = text
        self.urlAction = urlAction
        self._calculatedHeight = calculatedHeight
    }

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textView = UITextView()
        self.delegate.urlAction = self.urlAction
        textView.delegate = self.delegate
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.clear

        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        uiView.attributedText = self.text
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height
            }
        }
    }
}

internal class UITextViewWrapperDelegate: NSObject, UITextViewDelegate {
    var urlAction: (Foundation.URL) -> Void
    
    override init() {
        self.urlAction = { _ in }
        super.init()
    }
    
    internal func textView(_ textView: UITextView, shouldInteractWith URL: Foundation.URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.urlAction(URL)
        return false
    }
}
