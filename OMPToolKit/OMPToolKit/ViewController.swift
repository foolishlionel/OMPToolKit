//
//  ViewController.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/29.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    @IBOutlet weak var pushViewController: UIButton!
    @IBAction func buttonClicked(_ sender: Any) {
        
        let pickerView = OMPDataPickerView(title: "TTADataPickerView", type: .text, delegate: nil)
        // configure pickerView type with this property
        pickerView.type = .text
        pickerView.setConfirmButtonAttributes(att: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        pickerView.setCancelButtonAttributes(att: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        pickerView.setToolBarTintColor(color: UIColor.lightGray)
        pickerView.setToolBarBarTintColor(color: UIColor(white: 0.9, alpha: 0.5))
        pickerView.setTitleFont(font: UIFont.systemFont(ofSize: 14))
        pickerView.setTitleColor(color: UIColor.red)
        // configure the delegate
        pickerView.delegate = self
        // when the pickerView type is .text, configure this property to tell the pickerView what you want to select
        pickerView.textItemsForComponent = [["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth"], ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth"], ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth"]]
        let titles = ["First", "Second", "Third"]
        // set the selectedTitles when the pickerView appers
        pickerView.selectedTitles(titles)
        // call show() or show(with completion: (() -> Void)? = nil) to show the pickerView from the bottom of the screen
        pickerView.show()
        
//        let apperance = OMPDataPickerView.appearance()
//        apperance.setConfirmButtonAttributes(att: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
//        apperance.setCancelButtonAttributes(att: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
//        apperance.setToolBarTintColor(color: UIColor.lightGray)
//        apperance.setToolBarBarTintColor(color: UIColor(white: 0.9, alpha: 0.5))
//        apperance.setTitleFont(font: UIFont.systemFont(ofSize: 14))
//        apperance.setTitleColor(color: UIColor.red)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: OMPDataPickerViewDelegate {
    // when the pickerView type is `.text`, you clicked the done button, you will get the titles you selected just now from the `titles` parameter
    func dataPickerView(_ pickerView: OMPDataPickerView, didSelectTitles titles: [String]) {
//        showLabel.text = titles.joined(separator: " ")
    }
    // when the pickerView type is NOT `.text`, you clicked the done button, you will get the date you selected just now from the `date` parameters
    func dataPickerView(_ pickerView: OMPDataPickerView, didSelectDate date: Date) {
        // actually you need configure the dateFormatter dateStyle and timeStyle to get the currect date from the `date` parameter
//        if pickerView.type == .date {
//            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .none
//        } else if pickerView.type == .time {
//            dateFormatter.timeStyle = .medium
//            dateFormatter.dateStyle = .none
//        } else if pickerView.type == .dateTime {
//            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .medium
//        }
//        showLabel.text = dateFormatter.string(from: date)
    }
    // when the pickerView  has been changed, this function will be called, and you will get the row and component which changed just now
    func dataPickerView(_ pickerView: OMPDataPickerView, didChange row: Int, inComponent component: Int) {
        print(#function)
    }
    // when you clicked the cancel button, this function will be called firstly
    func dataPickerViewWillCancel(_ pickerView: OMPDataPickerView) {
        print(#function)
    }
    // when you clicked the cancel button, this function will be called at the last
    func dataPickerViewDidCancel(_ pickerView: OMPDataPickerView) {
        print(#function)
    }
}


