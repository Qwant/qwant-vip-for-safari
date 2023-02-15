//
//  TextArea.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 08/02/2023.
//

import SwiftUI

struct TextArea: NSViewRepresentable {
    @Binding var text: String

    func makeNSView(context: Context) -> NSScrollView {
        context.coordinator.createTextViewStack()
    }

    func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let textArea = nsView.documentView as? NSTextView, textArea.string != self.text {
            textArea.string = self.text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var text: Binding<String>

        init(text: Binding<String>) {
            self.text = text
        }

        func textView(_ textView: NSTextView, shouldChangeTextIn range: NSRange, replacementString text: String?) -> Bool {
            defer {
                self.text.wrappedValue = (textView.string as NSString).replacingCharacters(in: range, with: text!)
            }
            return true
        }

        fileprivate lazy var textStorage = NSTextStorage()
        fileprivate lazy var layoutManager = NSLayoutManager()
        fileprivate lazy var textContainer = NSTextContainer()
        fileprivate lazy var textView = NSTextView(frame: CGRect(), textContainer: textContainer)
        fileprivate lazy var scrollview = NSScrollView()

        func createTextViewStack() -> NSScrollView {
            let contentSize = scrollview.contentSize

            textContainer.containerSize = CGSize(width: contentSize.width, height: CGFloat.greatestFiniteMagnitude)
            textContainer.widthTracksTextView = true

            textView.minSize = CGSize.zero
            textView.maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            textView.isVerticallyResizable = true
            textView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
            textView.autoresizingMask = [.width]
            textView.delegate = self
            textView.font = .monospacedSystemFont(ofSize: 15, weight: .regular)

            scrollview.borderType = .noBorder
            scrollview.hasVerticalScroller = true
            scrollview.documentView = textView

            textStorage.addLayoutManager(layoutManager)
            layoutManager.addTextContainer(textContainer)

            return scrollview
        }
    }
}
