//
//  ViewController.swift
//  ActionSheetView
//
//  Created by 陈恩湖 on 2017/4/14.
//  Copyright © 2017年 Judson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bottomSheetButton: UIButton!

    @IBOutlet weak var centerHintButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubViews()
    }
    
    fileprivate func initializeSubViews() {
        // 初始化显示控件
        bottomSheetButton.layer.borderWidth = 1
        bottomSheetButton.layer.borderColor = UIColor.gray.cgColor
        bottomSheetButton.layer.cornerRadius = 2
        bottomSheetButton.clipsToBounds = true
        
        // 初始化显示控件
        centerHintButton.layer.borderWidth = 1
        centerHintButton.layer.borderColor = UIColor.gray.cgColor
        centerHintButton.layer.cornerRadius = 2
        centerHintButton.clipsToBounds = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    @IBAction func showHintViewAction(_ sender: UIButton) {
        print("显示点什么东西--\(sender)")
    }
    
    
    

}

