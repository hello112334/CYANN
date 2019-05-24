//
//  FuncClass.swift
//  CHANN
//
//  Created by 陳豐文 on 2019/05/19.
//  Copyright © 2019 BooLuON. All rights reserved.
//

import Foundation
import UIKit

// Creating a Key of book
func gernerateKey() {
    
    let now = Date()
    let deFormatter = DateFormatter()
    //    deFormatter.dateFormat = "yyyy-MM-dd'0'HH:mm:ssZ"
    deFormatter.dateFormat = "yyyyMMdd'0'HHmmss"
    let key = deFormatter.string(from: now)
    itemKey = key
}
