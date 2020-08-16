//
//  CountryCode.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 17/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import Foundation
struct Code :Decodable {
    
        let id: Int?
        let country_name: String?
        let code: String?
        let created_at: String?
        let updated_at: String?
}

struct codeModel :Decodable {

        let success: Bool
        let data: [Code]
    
    init( success: Bool?,
          data: [Code] = [])
     {
        self.success = success ?? false
        self.data = data
     }

}
