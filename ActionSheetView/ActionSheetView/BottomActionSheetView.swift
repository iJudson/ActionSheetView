//
//  BottomActionSheetView.swift
//  ActionSheetView
//
//  Created by 陈恩湖 on 2017/4/15.
//  Copyright © 2017年 Judson. All rights reserved.
//

import UIKit

private extension Selector {
    static let clickBackgroundGrayView = #selector(BottomActionSheetView.clickBackgroundGrayView)
    static let clickActionSheetItem = #selector(BottomActionSheetView.clickActionSheetItem(_:))
    
}

enum SourceControlType {
    case setting
    case profileEditPhotoToken
    case deletedComment
    case handledComment
    case handledProfileRecommendComment
    case sharedOtherRecommendComment
    case handledArticlePhotos
    case handledImageRecognizer
    case editProfileCenter
}

enum ActionSheetItemType: String {
    case recognizedPhoto = "识别二维码或链接"
    case exitLogin = "退出登录"
    case tokenPhotos = "拍照"
    case chosenFromAlbum = "从手机相册选取"
    case delete = "删除"
    case reply = "回复"
    case report = "举报"
    case share = "分享"
    case edit = "编辑"
    case savedPhotos = "存储图片"
    case copy = "拷贝"
    case cancel = "取消"
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class BottomActionSheetView: UIView {
    
    fileprivate var contentViewHeight: CGFloat = 0
    fileprivate var backgroundGrayView: UIView!
    fileprivate var contentView: UIView!
    fileprivate var cancelButton: UIButton!
    fileprivate var blackTextColor: UIColor = UIColor.black
    fileprivate var redTextColor: UIColor = UIColor.red
    fileprivate var grayTextColor: UIColor = UIColor.gray
    fileprivate var actionItemType: ActionSheetItemType = .cancel
    
    var itemHeight: CGFloat = 60
    
    var clickBackgroundGrayViewAction: (() -> Void)?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.alpha = 1.0
        
        backgroundGrayView = UIView()
        backgroundGrayView.frame = self.bounds
        backgroundGrayView.backgroundColor = UIColor.black
        backgroundGrayView.alpha = 0.4
        backgroundGrayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: .clickBackgroundGrayView))
        addSubview(backgroundGrayView)
        
        // 除了取消按钮之外的 内容视图
        contentView = UIView()
        contentView.frame = CGRect(x: 0, y: screenHeight, width: frame.size.width, height: itemHeight)
        contentView.backgroundColor = UIColor.white
        insertSubview(contentView, aboveSubview: backgroundGrayView)
        
        // 取消按钮
        let cancelText = NSLocalizedString("ActionSheet_Cancel", comment: "底部弹框取消按钮文本")
        cancelButton = UIButton(type: .custom)
        cancelButton.frame = CGRect(x: 0, y: contentView.bounds.size.height - itemHeight, width: contentView.bounds.size.width, height: itemHeight)
        cancelButton.setTitle(cancelText, for: .normal)
        cancelButton.addTarget(self, action: .clickActionSheetItem, for: .touchUpInside)
        cancelButton.setTitleColor(grayTextColor, for: .normal)
        cancelButton.alpha = 0.8
    }
    
    func initialSheetViewItems(_ sourceControlType: SourceControlType, compeltionHandler: ((Bool) -> Void)? = nil) {
        
        switch sourceControlType {
        case .setting:
            let exitLoginText: String = NSLocalizedString("ActionSheet_ExitLogin", comment: "退出登录文本")
            addActionSheetItems([exitLoginText], textColor: redTextColor)
            
        case .profileEditPhotoToken:
            let tokenPhotoText: String = NSLocalizedString("ActionSheet_TokenPhoto", comment: "拍照文本")
            let fetchPhotosFromAlbumText: String = NSLocalizedString("ActionSheet_FetchPhotosFromAlbum", comment: "从手机相册选取文本")
            addActionSheetItems([tokenPhotoText, fetchPhotosFromAlbumText], textColor: blackTextColor)
            
        case .deletedComment:
            let deleteText: String = NSLocalizedString("ActionSheet_Delete", comment: "删除文本")
            addActionSheetItems([deleteText], textColor: redTextColor)
            
        case .handledComment:
            let replyText: String = NSLocalizedString("ActionSheet_Reply", comment: "回复文本")
            let reportText: String = NSLocalizedString("ActionSheet_Report", comment: "举报文本")
            addActionSheetItems([replyText, reportText], textColor: blackTextColor)
            
        case .sharedOtherRecommendComment:
            let shareText: String = NSLocalizedString("ActionSheet_Share", comment: "分享文本")
            addActionSheetItems([shareText], textColor: blackTextColor)
            
        case .handledProfileRecommendComment:
            let editText: String = NSLocalizedString("ActionSheet_Edit", comment: "编辑文本")
            let shareText: String = NSLocalizedString("ActionSheet_Share", comment: "分享文本")
            let deleteText: String = NSLocalizedString("ActionSheet_Delete", comment: "删除文本")
            addActionSheetItems([editText, shareText, deleteText], textColor: blackTextColor)
            
        case .handledArticlePhotos:
            let savePhotoText: String = NSLocalizedString("ActionSheet_Image_Save", comment: "存储图片文本")
            let pasteText: String = NSLocalizedString("ActionSheet_ImageURL_Paste", comment: "拷贝文本")
            addActionSheetItems([savePhotoText, pasteText], textColor: blackTextColor)
            
        case .handledImageRecognizer:
            let imageRecognizedText: String = NSLocalizedString("ActionSheet_Image_Recognize", comment: "识别二维码或链接")
            let savePhotoText: String = NSLocalizedString("ActionSheet_Image_Save", comment: "存储图片文本")
            let pasteText: String = NSLocalizedString("ActionSheet_ImageURL_Paste", comment: "拷贝文本")
            addActionSheetItems([imageRecognizedText, savePhotoText, pasteText], textColor: blackTextColor)
            
        case .editProfileCenter:
            let editText: String = NSLocalizedString("ActionSheet_Edit", comment: "编辑文本")
            let deleteText: String = NSLocalizedString("ActionSheet_Delete", comment: "删除文本")
            addActionSheetItems([editText, deleteText], textColor: blackTextColor)
            
        }
        
        // add cancel button
        cancelButton.frame = CGRect(x: 0, y: contentView.bounds.size.height - itemHeight, width: contentView.bounds.size.width, height: itemHeight)
        contentView.addSubview(cancelButton)
        // 判断是否初始化成功
        compeltionHandler?(contentViewHeight != 0)
    }
    
    fileprivate func addActionSheetItems(_ itemsTitle: [String], textColor: UIColor) {
        let itemCount = itemsTitle.count + 1
        contentViewHeight = CGFloat(itemCount) * itemHeight
        contentView.frame = CGRect(x: 0, y: screenHeight, width: frame.size.width, height: contentViewHeight)
        for (index, title) in itemsTitle.enumerated() {
            initialItemButton(index: index, text: title, titleColor: textColor)
        }
    }
    
    fileprivate func initialItemButton(index: Int, text: String, titleColor: UIColor) {
        let button = UIButton(type: .custom)
        button.setTitle(text, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.frame = CGRect(x: 0, y: itemHeight * CGFloat(index), width: contentView.bounds.size.width, height: itemHeight)
        button.addTarget(self, action: .clickActionSheetItem, for: .touchUpInside)
        button.setTitleColor(titleColor, for: .normal)
        contentView.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        guard contentViewHeight != 0 else {
            print("error: 必须先初始化 contentView,再调用显示方法")
            return
        }
        UIApplication.shared.keyWindow?.addSubview(self)
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
        self.backgroundGrayView.alpha = 0.0
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundGrayView.alpha = 0.4
            self.contentView.frame.origin.y -= self.contentViewHeight
        })
    }
    
}

// MARK: 点击方法
extension BottomActionSheetView {
    
    @objc fileprivate func clickActionSheetItem(_ button: UIButton) {
        guard let titleLabel = button.titleLabel, let titleText = titleLabel.text else {
            return
        }
        hideSheetView()
        switch titleText {
        case "识别二维码或链接":
            actionItemType = .recognizedPhoto
            
        case "退出登录":
            actionItemType = .exitLogin
            
        case "拍照":
            actionItemType = .tokenPhotos
            
        case "从手机相册选取":
            actionItemType = .chosenFromAlbum
            
        case "删除":
            actionItemType = .delete
            
        case "回复":
            actionItemType = .reply
            
        case "举报":
            actionItemType = .report
            
        case "分享":
            actionItemType = .share
            
        case "编辑":
            actionItemType = .edit
            
        case "存储图片":
            actionItemType = .savedPhotos
            
        case "拷贝":
            actionItemType = .copy
            
        case "取消":
            actionItemType = .cancel
            
        default:
            break
        }
        // 添加通知 监听点击事件
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ActionSheetClickedNotification"), object: actionItemType)
    }
    
    fileprivate func hideSheetView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundGrayView.alpha = 0.0
            self.contentView.frame.origin.y = self.frame.size.height
        }, completion: { result in
            self.removeFromSuperview()
        })
    }
    
    @objc fileprivate func clickBackgroundGrayView() {
        clickBackgroundGrayViewAction?()
        hideSheetView()
    }
}
