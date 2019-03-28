//
//  Delay.swift
//  Utility
//
//  Created by Daniele Citi on 11/03/2019.
//  Copyright © 2019 Daniele Citi. All rights reserved.
//

import UIKit

/// A delay function
func delay(seconds: Double, completion: @escaping ()-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}
