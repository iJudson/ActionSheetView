//
//  ViewController.swift
//  ActionSheetView
//
//  Created by 陈恩湖 on 2017/4/14.
//  Copyright © 2017年 Judson. All rights reserved.
//

private extension Selector {
static let clickProfileCenterActionSheetItem = #selector(ActionSheetViewController.clickActionSheetItem(_:))

}


import UIKit

class ActionSheetViewController: UIViewController {
    
    @IBOutlet weak var bottomSheetButton1: UIButton!
    @IBOutlet weak var bottomSheetButton2: UIButton!
    @IBOutlet weak var bottomSheetButton3: UIButton!
    @IBOutlet weak var bottomSheetButton4: UIButton!
    @IBOutlet weak var bottomSheetButton5: UIButton!
    @IBOutlet weak var bottomSheetButton6: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubViews()
    }
    
    fileprivate func initializeSubViews() {
        // 初始化显示控件
        let buttons: [UIButton] = [bottomSheetButton1, bottomSheetButton2, bottomSheetButton3, bottomSheetButton4, bottomSheetButton5, bottomSheetButton6]
        initializeButtons(buttons: buttons)
        
    }
    
    fileprivate func initializeButtons(buttons: [UIButton]) {
        for (index, object) in buttons.enumerated() {
            object.layer.borderWidth = 1
            object.layer.borderColor = UIColor.gray.cgColor
            object.layer.cornerRadius = 2
            object.clipsToBounds = true
            object.tag = index // 为 button 指定一个 tag （from 0 to 5）
        }
    }
    

    @IBAction func showHintViewAction(_ sender: UIButton) {
        
        switch sender.tag {
            case 0:
                showEditMenuActionSheet(actionType: .editProfileCenter)
                
            case 1:
                showEditMenuActionSheet(actionType: .handledImageRecognizer)

            case 2:
                showEditMenuActionSheet(actionType: .sharedOtherRecommendComment)
                
            case 3:
                showEditMenuActionSheet(actionType: .handledComment)

            case 4:
                showEditMenuActionSheet(actionType: .profileEditPhotoToken)

            case 5:
                showEditMenuActionSheet(actionType: .setting)
            
            default:
                break
        }
    }
    
    fileprivate func showEditMenuActionSheet(actionType: SourceControlType) {
        NotificationCenter.default.addObserver(self, selector: .clickProfileCenterActionSheetItem, name: NSNotification.Name(rawValue: "ActionSheetClickedNotification"), object: nil)
        
        let actionSheetView = BottomActionSheetView()
        actionSheetView.initialSheetViewItems(actionType)
        actionSheetView.show()
        actionSheetView.clickBackgroundGrayViewAction = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            NotificationCenter.default.removeObserver(strongSelf, name: NSNotification.Name(rawValue: "ActionSheetClickedNotification"), object: nil)
        }
    }
    
    @objc fileprivate func clickActionSheetItem(_ notification: NSNotification) {
        guard let notificationObject = notification.object as? ActionSheetItemType else {
            return
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ActionSheetClickedNotification"), object: nil)
        switch notificationObject {
        case .edit:
            print("Edit Action")
            
        case .delete:
            print("Delete Action")
        case .recognizedPhoto:
            print("recognizedPhoto Action")

        case .exitLogin:
            print("exitLogin Action")

        case .tokenPhotos:
            print("exitLogin Action")

        case .chosenFromAlbum:
            print("chosenFromAlbum Action")

        case .reply:
            print("reply Action")

        case .report:
            print("report Action")

        case .share:
            print("share Action")

        case .savedPhotos:
            print("savedPhotos Action")

        case .copy:
            print("copy Action")

        case .cancel:
            print("cancel Action")
            
        }
    }

}

