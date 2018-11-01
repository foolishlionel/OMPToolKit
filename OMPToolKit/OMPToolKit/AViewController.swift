//
//  AViewController.swift
//  OMPToolKit
//
//  Created by flion on 2018/11/1.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while (topController?.presentedViewController != nil) {
            topController = topController?.presentedViewController
        }
        ompLog(topController!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
