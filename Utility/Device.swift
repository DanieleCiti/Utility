//
//  Device.swift
//  Utility
//
//  Created by Daniele Citi on 11/03/2019.
//  Copyright © 2019 Daniele Citi. All rights reserved.
//

import UIKit

let displaySize:CGRect = UIScreen.main.bounds
let displayWidth:CGFloat = displaySize.width

enum Device {
    case iPhoneSE
    case iPhone8
    case iPhonePlus
    case iPhoneX
    case iPhoneXR_Max
    case iPad9inch
    case iPad10inch
    case iPad11inch
    case iPad12inch
}

/// Funzione che riconosce il dispositivo usato in base alla larghezza del display
func deviceScreenRecognizer()-> Device
{
    var myDevice: Device!
    
    switch displayWidth {
    case 568.0:
        myDevice = .iPhoneSE
    case 667.0:
        myDevice = .iPhone8
    case 736.0:
        myDevice = .iPhonePlus
    case 812.0:
        myDevice = .iPhoneX
    case 896.0:
        myDevice = .iPhoneXR_Max
    case 1024.0:
        myDevice = .iPad9inch
    case 1112.0:
        myDevice = .iPad10inch
    case 1194.0:
        myDevice = .iPad11inch
    case 1366.0:
        myDevice = .iPad12inch
    default:
        break
    }
    
    return myDevice
}
