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
        UILabelView(text: self.text)
            .padding(.horizontal)
    }
}

struct UILabelView: UIViewRepresentable {
    
    var text: NSAttributedString
    
    func makeUIView(context: UIViewRepresentableContext<UILabelView>) -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<UILabelView>) {
        uiView.attributedText = self.text
    }
}
