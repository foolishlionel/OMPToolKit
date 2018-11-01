//
//  OMPDataPickerViewController.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/31.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class OMPDataPickerViewController: UIViewController {
    
    weak var pickerView: OMPDataPickerView? = nil
    
    deinit {
        #if DEBUG
        ompLog("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension OMPDataPickerViewController {
    public func showPickerView(pickerView: OMPDataPickerView,
                               completion: (() -> Void)? = nil) {
        
        
        self.pickerView = pickerView
        
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while (topController?.presentedViewController != nil) {
            topController = topController?.presentedViewController
        }
        topController?.resignFirstResponder()
        
        pickerView.frame.origin.y = view.bounds.size.height
        view.addSubview(pickerView)
        
        view.frame = CGRect(
            x: 0,
            y: 0,
            width: topController?.view.bounds.size.width ?? 0,
            height: topController?.view.bounds.size.height ?? 0
        )
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topController?.addChildViewController(self)
        topController?.view.addSubview(view)
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: UIViewAnimationOptions.beginFromCurrentState,
            animations: {
                self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
                pickerView.frame.origin.y = self.view.bounds.size.height - pickerView.frame.size.height;
        }) { _ in
            guard let handle = completion else { return }
            handle()
        }
    }
    
    public func dismissWithCompletion(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
            self.view.backgroundColor = UIColor.clear
            self.pickerView?.frame.origin.y = self.view.bounds.size.height
        }) { _ in
            self.pickerView?.removeFromSuperview()
            self.willMove(toParentViewController: nil)
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
            
            guard let handle = completion else { return }
            handle()
        }
    }
}


extension OMPDataPickerViewController {
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tap:)))
        view.addGestureRecognizer(tap)
        tap.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension OMPDataPickerViewController {
    @objc func viewTapped(tap: UITapGestureRecognizer) {
        if tap.state == UIGestureRecognizerState.ended {
            dismissWithCompletion()
        }
    }
}

extension OMPDataPickerViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let isContains = pickerView?.bounds.contains(touch.location(in: pickerView)), isContains == true else {
            return true
        }
        return false
    }
}
