# ActionSheetView

## 功能简介
这是项目中很常见的底部提示栏, 主要是用于点击每一个栏目的 item 响应相应的事件, 一般会在项目中全局使用

## 开发环境
*XCode8.1* + *swift3.0*, 如果下载项目后, 编译失败, 请检查 `XCode` 版本是否满足.

## 类的参数详细介绍
***ActionSheetView***
+ init() 初始化基础控件：蒙板、内容视图、取消按钮
+ initialSheetViewItems() 进一步完整地绘制内容视图，让内容视图按需显示 items（可以按照自己需求添加 items 到枚举值中 - ActionSheetItemType）
- recognizedPhoto 识别二维码或链接
- exitLogin 退出登录
- tokenPhotos 拍照
- chosenFromAlbum 从手机相册选取
- delete 删除
- reply 回复
- report 举报
- share 分享
- edit 编辑
- savedPhotos 存储图片
- copy 拷贝
- cancel 取消
+ show() 显示方法
+ ActionSheetClickedNotification 通知名称，在用户点击 SheetViewItems 的时候 Post 一次，相对于 block 或者 代理，这里我们使用通知方法，会更加面向对象、封装性更高

## 功能具体实现
+ [如何更好的封装全局提示栏](http://www.jianshu.com/p/584c2952e80a)

## 效果
+ [主界面]（http://upload-images.jianshu.io/upload_images/2691764-3032960865dd27d0.png）
+ [动态显示提示栏]（http://upload-images.jianshu.io/upload_images/2691764-608932b52dd6c258.gif）
