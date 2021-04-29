//
//  ErrorAlert.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/29.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class ErrorAlert {
    
    private static func errorAlert(title: String, message: String = "") -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: title, message : message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
            })
        alert.addAction(defaultAction)
        return alert
    }
    
    static func wrongWordError() -> UIAlertController {
        return errorAlert(title: "不正なワードが入力されました", message: "検索ワードを確認してください")
    }
    
    static func networkError() -> UIAlertController {
        return errorAlert(title: "インターネットに接続されていません", message: "接続状況を確認してください")
    }
    
    static func parseError() -> UIAlertController {
        return errorAlert(title: "データの表示に失敗しました")
    }
}
