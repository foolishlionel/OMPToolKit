//
//  OMPDataPickerTitleBarButtonItem.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/31.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class OMPDataPickerTitleBarButtonItem: UIBarButtonItem {

    public var font: UIFont? = UIFont.systemFont(ofSize: 14) {
        didSet {
            guard let titleFont = font else { return }
            titleButton.titleLabel?.font = titleFont
        }
    }
    
    public var titleColor: UIColor? = UIColor.lightGray {
        didSet {
            guard let color = titleColor else {
                titleButton.setTitleColor(UIColor.lightGray, for: .disabled)
                return
            }
            titleButton.setTitleColor(color, for: .disabled)
        }
    }
    
    fileprivate let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    fileprivate let titleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isEnabled = false
        button.titleLabel?.numberOfLines = 3
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.setTitleColor(UIColor(red: 0, green: 0.5, blue: 1, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        button.backgroundColor = .clear
        return button
    }()
    
    override var title: String? {
        didSet { titleButton.setTitle(title, for: .normal) }
    }
    
    override init() {
        super.init()
        _setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupUI()
    }
    
    convenience init(title: String?) {
        self.init()
        self.title = title
    }

}

fileprivate extension OMPDataPickerTitleBarButtonItem {
    func _setupUI() {
        titleView.addSubview(titleButton)
        _layoutViews()
        customView = titleView
    }
    
    func _layoutViews() {
        if #available(iOS 11.0, *) {
            titleView.translatesAutoresizingMaskIntoConstraints = false
            titleView.setContentHuggingPriority(UILayoutPriority.defaultLow - 1, for: .vertical)
            titleView.setContentHuggingPriority(UILayoutPriority.defaultLow - 1, for: .horizontal)
            titleView.setContentHuggingPriority(UILayoutPriority.defaultHigh - 1, for: .vertical)
            titleView.setContentHuggingPriority(UILayoutPriority.defaultHigh - 1, for: .horizontal)
            
            titleButton.translatesAutoresizingMaskIntoConstraints = false
            titleButton.setContentHuggingPriority(UILayoutPriority.defaultLow - 1, for: .vertical)
            titleButton.setContentHuggingPriority(UILayoutPriority.defaultLow - 1, for: .horizontal)
            titleButton.setContentHuggingPriority(UILayoutPriority.defaultHigh - 1, for: .vertical)
            titleButton.setContentHuggingPriority(UILayoutPriority.defaultHigh - 1, for: .horizontal)
            
            let top = NSLayoutConstraint(item: titleButton, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .top, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint(item: titleButton, attribute: .bottom, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1, constant: 0)
            let leading = NSLayoutConstraint(item: titleButton, attribute: .leading, relatedBy: .equal, toItem: titleView, attribute: .leading, multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint(item: titleButton, attribute: .trailing, relatedBy: .equal, toItem: titleView, attribute: .trailing, multiplier: 1, constant: 0)
            titleView.addConstraints([top, bottom, leading, trailing])
        } else {
            titleButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            titleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
