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
        AttributedTextView(text: text).padding(.horizontal)
    }
}

struct AttributedTextView: View {
    let text: NSAttributedString
    @State private var dynamicHeight: CGFloat = 100

    var body: some View {
        UITextViewWrapper(text: self.text, calculatedHeight: $dynamicHeight)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
    }
}

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    let text: NSAttributedString
    @Binding var calculatedHeight: CGFloat

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()

        textField.isEditable = false
        textField.isSelectable = false
        textField.isUserInteractionEnabled = false
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
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
