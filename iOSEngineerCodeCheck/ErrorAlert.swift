//
//  ErrorAlert.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/29.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class ErrorAlert {
    static func wrongWordError() -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: "不正なワードが入力されました", message: "検索ワードを確認してください", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
            })
        alert.addAction(defaultAction)
        return alert
    }
    
    static func networkError() -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: "インターネットに接続されていません", message: "接続状況を確認してください", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
            })
        alert.addAction(defaultAction)
        return alert
    }
    
    static func parseError() -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: "データの表示に失敗しました", message: "", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
            })
        alert.addAction(defaultAction)
        return alert
    }
}
