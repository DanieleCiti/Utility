//
//  Motion.swift
//  Utility
//
//  Created by Daniele Citi on 11/03/2019.
//  Copyright © 2019 Daniele Citi. All rights reserved.
//

import CoreMotion
import SceneKit

/// Funzione che converte angoli da radianti in gradi
func degrees(radians:Double) -> Double {
    return 180 / .pi * radians
}

func handleDeviceMotionUpdate(deviceMotion:CMDeviceMotion, node: SCNNode) {
    let attitude = deviceMotion.attitude
    let roll = degrees(radians: attitude.roll)
    let pitch = degrees(radians: attitude.pitch)
    //  let yaw = degrees(radians: attitude.yaw)
    
    // print("Roll: \(roll)")
    // print("Pitch: \(pitch)")
    // print("Yaw: \(yaw)")
    //roll: avanti/indietro. Pitch: destra/sinistra. Yaw: Laterale
    
    if roll >= -30 // avanti
    {
        node.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: -1.5), asImpulse: false)
        node.physicsBody?.angularVelocity = SCNVector4(x: -1, y: 0, z: 0, w: 3.0)
    }
    if roll <= -47 // indietro
    {
        node.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: 1.5), asImpulse: false)
        node.physicsBody?.angularVelocity = SCNVector4(x: 1, y: 0, z: 0, w: 3.0)
    }
    if pitch >= 9 // destra
    {
        node.physicsBody?.applyForce(SCNVector3(x: 1.5, y: 0, z: 0.0), asImpulse: false)
        node.physicsBody?.angularVelocity = SCNVector4(x: 0, y: 0, z: -1, w: 3.0)
    }
    if pitch <= -8 // sinistra
    {
        node.physicsBody?.applyForce(SCNVector3(x: -0.5, y: 0, z: 0.0), asImpulse: false)
        node.physicsBody?.angularVelocity = SCNVector4(x: 0, y: 0, z: 1, w: 3.0)
    }
}

/// Funzione da chiamare nel ViewDidAppear che fa muovere un nodo sferico con corpo fisico in base all'inclinazione del device
func motionLogic(nodeToMove: SCNNode, motionManager: CMMotionManager)
{
    if motionManager.isDeviceMotionAvailable {
        
        motionManager.deviceMotionUpdateInterval = 0.1
        
        motionManager.startDeviceMotionUpdates(
            to: OperationQueue.current!, withHandler: {
                (deviceMotion, error) -> Void in
                
                if(error == nil) {
                    handleDeviceMotionUpdate(deviceMotion: deviceMotion!, node: nodeToMove)
                } else {
                    //handle the error
                    print("ERRORE")
                }
        })
    }
}
