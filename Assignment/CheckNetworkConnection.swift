//
//  CheckNetworkConnection.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 16/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

