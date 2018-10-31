//
//  OMPDataPickerView.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/31.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

public enum OMPDataPickerViewType {
    /// pickerView default
    case text
    /// datePicker
    case date
    /// date and time
    case dateTime
    /// time
    case time
}

public protocol OMPDataPickerViewDelegate: NSObjectProtocol {
    /// 当dataPickerView的类型是`.text`时，使用该方法
    /// - Parameters:
    ///   - pickerView: OMPDataPickerView
    ///   - titles: 选中的titles
    func dataPickerView(_ pickerView: OMPDataPickerView, didSelectTitles titles: [String])
    
    
    /// 当dataPickerView的类型不是`.text`时，使用该方法
    /// - Parameters
    ///   - pickerView: PickerView
    ///   - date: 选中的日期
    func dataPickerView(_ pickerView: OMPDataPickerView, didSelectDate date: Date)
    
    
    /// 当任意一列的一行滑动时，执行该方法
    /// - Parameters:
    ///   - pickerView: PickerView
    ///   - row: 滑动并改变的某一行
    ///   - component: 某一列
    func dataPickerView(_ pickerView: OMPDataPickerView, didChange row: Int, inComponent component: Int)
    
    /// 点击PickerView取消按钮，执行该方法
    /// - Parameters:
    ///   pickerView: PickerView
    func dataPickerViewWillCancel(_ pickerView: OMPDataPickerView)
    
    func dataPickerViewDidCancel(_ pickerView: OMPDataPickerView)
}

extension OMPDataPickerViewDelegate {
    func dataPickerView(_ pickerView: OMPDataPickerView, didSelectTitles titles: [String]) {}
    
    func dataPickerView(_ pickerView: OMPDataPickerView, didSelectDate date: Date) {}
    
    func dataPickerView(_ pickerView: OMPDataPickerView, didChange row: Int, inComponent component: Int) {}
    
    func dataPickerViewWillCancel(_ pickerView: OMPDataPickerView) {}
    
    func dataPickerViewDidCancel(_ pickerView: OMPDataPickerView) {}
}

open class OMPDataPickerView: UIView {
    public weak var delegate: OMPDataPickerViewDelegate?
    
    public var type: OMPDataPickerViewType = .text {
        didSet {
            switch type {
            case .text:
                pickerView?.isHidden = false
                datePicker?.isHidden = true
            case .date:
                pickerView?.isHidden = true
                datePicker?.datePickerMode = .date
                datePicker?.isHidden = false
            case .dateTime:
                pickerView?.isHidden = true
                datePicker?.datePickerMode = .dateAndTime
                datePicker?.isHidden = false
            case .time:
                pickerView?.isHidden = true
                datePicker?.datePickerMode = .time
                datePicker?.isHidden = false
            }
        }
    }
    
    public var textItemsForComponent: [[String]]? {
        didSet { pickerView?.reloadAllComponents() }
    }
    
    public var minimumDate: Date? {
        didSet { datePicker?.minimumDate = minimumDate }
    }
    
    public var maximumDate: Date? {
        didSet { datePicker?.maximumDate = maximumDate }
    }
    
    public var isAutoResetTextComponent: Bool = false
    
    fileprivate lazy var pickerView: UIPickerView? = {
        let toolBarFrame = self.toolBar.frame
        let rect = CGRect(x: 0, y: toolBarFrame.maxY, width: toolBarFrame.width, height: 216)
        let picker = UIPickerView(frame: rect)
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    fileprivate lazy var datePicker: UIDatePicker? = {
        let toolBarFrame = self.toolBar.frame
        let rect = CGRect(x: 0, y: toolBarFrame.maxY, width: toolBarFrame.width, height: 216)
        let picker = UIDatePicker(frame: rect)
        picker.datePickerMode = .date
        return picker
    }()
    
    fileprivate let toolBar: OMPDataPickerToolBar = {
        let bar = OMPDataPickerToolBar()
        return bar
    }()
    
    fileprivate let dataPickerController = OMPDataPickerViewController()
    
    public override init(frame: CGRect) {
        var rect = UIScreen.main.bounds
        rect.size.height = 260 // 216 + 44
        super.init(frame: rect)
        _setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        var rect = UIScreen.main.bounds
        rect.size.height = 260 // 216 + 44
        super.init(coder: aDecoder)
        _setupUI()
    }
    
    public convenience init(
        title: String?,
        type: OMPDataPickerViewType,
        delegate: OMPDataPickerViewDelegate?) {
        
        self.init(frame: .zero)
        toolBar.titleButton.title = title
        _configType(type: type)
        self.delegate = delegate
    }
    
    fileprivate func _configType(type: OMPDataPickerViewType) {
        self.type = type
    }
    
    fileprivate func _setupUI() {
        backgroundColor = UIColor.white
        toolBar.barStyle = .default
        toolBar.cancelButton.target = self
        toolBar.cancelButton.action = #selector(didClickCancelButton(button:))
        
        toolBar.confirmButton.target = self
        toolBar.confirmButton.action = #selector(didClickConfirmButton(button:))
        
        guard let picker = pickerView else { return }
        addSubview(picker)
        
        guard let dPicker = datePicker else { return }
        addSubview(dPicker)
    }
}

extension OMPDataPickerView {
    public var cancelButtonAttributes: [String: Any]? {
        return toolBar.cancelButton.titleTextAttributes(for: .normal)
    }
    
    public var confirmButtonAttributes: [String: Any]? {
        return toolBar.confirmButton.titleTextAttributes(for: .normal)
    }
    
    public var toolBarBarTinColor: UIColor? {
        return toolBar.barTintColor
    }
    
    public var toolBarTintColor: UIColor? {
        return toolBar.tintColor
    }
    
    public var titleFont: UIFont {
        return toolBar.titleButton.font!
    }
    
    public func setCancelButtonAttributes(att: [NSAttributedStringKey: Any]?) {
        toolBar.cancelButton.setTitleTextAttributes(att, for: .normal)
    }
    
    public func setConfirmButtonAttributes(att: [NSAttributedStringKey: Any]?) {
        toolBar.confirmButton.setTitleTextAttributes(att, for: .normal)
    }
    
    public func setToolBarBarTintColor(color: UIColor?) {
        toolBar.barTintColor = color
    }
    
    public func setTooBarTintColor(color: UIColor?) {
        toolBar.tintColor = color
    }
    
    public func setTitleFont(font: UIFont) {
        toolBar.titleButton.font = font
    }
    
    public func setTitleColor(color: UIColor) {
        toolBar.titleButton.titleColor = color
    }
    
    public func reloadComponent(component: Int) {
        pickerView?.reloadComponent(component)
    }
    
    public func reloadAllComponents() {
        pickerView?.reloadAllComponents()
    }
    
    public func selectedTitles(_ titles: [String]?, animated: Bool = true) {
        guard type == .text else { return }
        let totalComponent = min(titles?.count ?? 0, pickerView?.numberOfComponents ?? 0)
        for component in 0..<totalComponent {
            let items = textItemsForComponent?[component]
            guard let title = titles?[component] else { continue }
            guard let _ = items?.contains(title) else { continue }
            guard let row = items?.index(of: title) else { continue }
            pickerView?.selectRow(row, inComponent: component, animated: animated)
        }
    }
    
    public func selectedDate(_ date: Date?, animated: Bool = true) {
        guard let selectedDate = date else { return }
        datePicker?.setDate(selectedDate, animated: animated)
    }
    
    public func show(with completion: (() -> Void)? = nil) {
        
    }
    
    public func dismis(with completion: (() -> Void)? = nil) {
        
    }
}

fileprivate extension OMPDataPickerView {
    @objc func didClickCancelButton(button: UIButton) {
        dismis()
    }
    
    @objc func didClickConfirmButton(button: UIButton) {
        switch type {
        case .text:
            guard let componentCount = pickerView?.numberOfComponents else { return }
            var textItems = [String]()
            for component in 0..<componentCount {
                guard let row = pickerView?.selectedRow(inComponent: component),
                    let title = textItemsForComponent?[component][row] else {
                    continue
                }
                textItems.append(title)
                delegate?.dataPickerView(self, didSelectTitles: textItems)
            }
        case .date, .dateTime, .time:
            guard let date = datePicker?.date else { return }
            delegate?.dataPickerView(self, didSelectDate: date)
        }
        dismis()
    }
}

extension OMPDataPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return textItemsForComponent?.count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let items = textItemsForComponent?[component] else { return 0 }
        return items.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let items = textItemsForComponent?[component] else { return nil }
        return items[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let componentCount = pickerView.numberOfComponents
        for index in 0..<componentCount {
            guard index != component && index > component else {
                continue
            }
            pickerView.reloadComponent(index)
            if isAutoResetTextComponent {
                pickerView.selectRow(0, inComponent: index, animated: true)
            }
        }
        delegate?.dataPickerView(self, didChange: row, inComponent: component)
    }
}
