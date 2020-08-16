//
//  LoginData.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 16/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import Foundation

struct User :Decodable {
    
        let id: Int?
        let first_name: String?
        let last_name: String?
        let phone: String?
        let email: String?
}

struct userModel :Decodable {

        let success: Bool
        let data: [User]
    
    init( success: Bool?,
          data: [User] = [])
     {
        self.success = success ?? false
        self.data = data
     }

}
