//
//  RGLoginValidator.swift
//  65apps-4
//
//  Created by Garafutdinov Ravil on 18/01/2018.
//  Copyright © 2018 RG. All rights reserved.
//

import UIKit

class RGLoginValidator: NSObject {
    func isValidLogin(_ login: String) -> Bool {
        return (login.range(of: "^[a-zA-Z][a-zA-Z0-9.-]{2,31}$", options: .regularExpression, range: nil, locale: nil) != nil)
    }
}
