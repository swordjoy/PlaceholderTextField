//
//  PlaceholderTextField.swift
//  TsinghoOA
//
//  Created by Liu Yang on 2018/10/16.
//  Copyright © 2018 Beijing Hehui Lifang Tech Co.,Ltd. All rights reserved.
//

import UIKit

// 自用简易带 placeholder 的 UITextField

class PlaceholderTextField: UITextField {
    private lazy var placeholderView = self.lazyPlaceholderView()

    override var text: String? {
        didSet {
            placeholderView.isHidden = text!.count > 0
        }
    }

    var placeholderText: String = "" {
        didSet {
            placeholderView.text = placeholderText
        }
    }

    var placeholderFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            placeholderView.font = placeholderFont
        }
    }

    var placeholderColor: UIColor = UIColor.clear {
        didSet {
            placeholderView.textColor = placeholderColor
        }
    }

    var textDidChangeBlock: ((UITextField) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }

    // MARK: config
    func config() {
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if borderStyle == .roundedRect {
            placeholderView.frame = CGRect(x: 7, y: 0, width: bounds.width - 7, height: bounds.height)
        } else {
            placeholderView.frame = bounds
        }
    }
}

extension PlaceholderTextField: UITextFieldDelegate {
    @objc func textDidChange() {
        placeholderView.isHidden = text!.count > 0
        textDidChangeBlock?(self)
    }
}

extension PlaceholderTextField {
    private func lazyPlaceholderView() -> UITextField {
        let tempView = UITextField()
        tempView.isUserInteractionEnabled = false
        tempView.font = UIFont.systemFont(ofSize: 14)
        tempView.textColor = UIColor.hexColor(0x999999)
        tempView.backgroundColor = UIColor.clear
        addSubview(tempView)
        return tempView
    }
}
