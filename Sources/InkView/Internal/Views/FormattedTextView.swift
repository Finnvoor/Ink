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
        AttributedTextView(text).padding(.horizontal)
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
