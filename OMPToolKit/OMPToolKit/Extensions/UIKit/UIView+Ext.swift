//
//  UIView+Ext.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/29.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

extension UIView {
    public var top: CGFloat {
        get { return frame.top }
        set(value) {
            var frame = self.frame
            frame.top = value
            self.frame = frame
        }
    }
    
    public var left: CGFloat {
        get { return frame.left }
        set(value) {
            var frame = self.frame
            frame.left = value
            self.frame = frame
        }
    }
    
    public var bottom: CGFloat {
        get { return frame.bottom }
        set(value) {
            var frame = self.frame
            frame.bottom = value
            self.frame = frame
        }
    }
    
    public var right: CGFloat {
        get { return frame.right }
        set(value) {
            var frame = self.frame
            frame.right = value
            self.frame = frame
        }
    }
    
    public var width: CGFloat {
        get { return frame.width }
        set(value) {
            var frame = self.frame
            frame.width = value
            self.frame = frame
        }
    }
    
    public var height: CGFloat {
        get { return frame.height }
        set(value) {
            var frame = self.frame
            frame.height = value
            self.frame = frame
        }
    }
    
    public var centerX: CGFloat {
        get { return frame.centerX }
        set(value) {
            var frame = self.frame
            frame.centerX = value
            self.frame = frame
        }
    }
    
    public var centerY: CGFloat {
        get { return frame.centerY }
        set(value) {
            var frame = self.frame
            frame.centerY = value
            self.frame = frame
        }
    }
}
