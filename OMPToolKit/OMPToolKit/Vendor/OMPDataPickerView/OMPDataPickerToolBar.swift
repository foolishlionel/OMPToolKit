//
//  OMPDataPickerToolBar.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/31.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class OMPDataPickerToolBar: UIToolbar {
    let cancelButton = UIBarButtonItem(
        barButtonSystemItem: .cancel,
        target: nil,
        action: nil
    )
    
    let confirmButton = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: nil,
        action: nil
    )
    
    let flexibleSpace = UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil
    )
    
    let titleButton = OMPDataPickerTitleBarButtonItem(title: nil)

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11.0, *) { return }
        
        var leftRect: CGRect = .zero
        var rightRect: CGRect = .zero
        var isTitleBarButtonFound = false
        
        let sortedSubviews = subviews.sorted { (v1, v2) -> Bool in
            let x1 = v1.frame.minX
            let x2 = v2.frame.minX
            
            if x1 != x2 {
                return x1 < x2
            } else {
                let y1 = v1.frame.minY
                let y2 = v2.frame.minY
                return y1 < y2
            }
        }
        
        for barButtonItemView in sortedSubviews {
            if isTitleBarButtonFound {
                rightRect = barButtonItemView.frame
                break
            } else if barButtonItemView.isMember(of: UIView.self) {
                isTitleBarButtonFound = true
            } else if barButtonItemView.isKind(of: UIControl.self) {
                leftRect = barButtonItemView.frame
            }
        }
        
        var x: CGFloat = 8
        if leftRect != .zero {
            x = leftRect.maxX + 8
        }
        
        let width: CGFloat = rightRect.minX - leftRect.maxX - 16
        titleButton.customView?.frame = CGRect(x: x, y: 0, width: width, height: frame.size.height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 44
        return size
    }
}

fileprivate extension OMPDataPickerToolBar {
    func _setupUI() {
        sizeToFit()
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        isTranslucent = true
        tintColor = UIColor.black // default tint color is black
        items = [cancelButton,
                 flexibleSpace,
                 titleButton,
                 flexibleSpace,
                 confirmButton]
    }
}
