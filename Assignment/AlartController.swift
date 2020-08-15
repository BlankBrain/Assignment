//
//  AlartController.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 14/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import Foundation
import UIKit

class AlartController {
    static func showAlart(_ inViewController: UIViewController, title: String , message: String)
    {
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                             inViewController.present(alert, animated: true)
    }
}
