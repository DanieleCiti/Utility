//
//  JoystickUtilities.swift
//  Utility
//
//  Created by Daniele Citi on 11/03/2019.
//  Copyright © 2019 Daniele Citi. All rights reserved.
//

import Foundation

/* func joystickLogic(joy: CDJoystick, nodeToMove: SCNNode)
{
    let top = CGPoint(x: 0.0, y: -1.0)
    let down = CGPoint(x: 0.0, y: 1.0)
    let right = CGPoint(x: 1.0, y: 0.0)
    let left = CGPoint(x: -1.0, y: 0.0)
    
    joy.trackingHandler = { joystickData in
        
        // print("Velocity:", joystickData.velocity)
        // print("Angle:", joystickData.angle)
        
        if gameOver == false
        {
            if joystickData.velocity.y == top.y
            {
                nodeToMove.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: -0.5), asImpulse: false)
                nodeToMove.physicsBody?.angularVelocity = SCNVector4(x: -1, y: 0, z: 0, w: 3.0)
            }
            if joystickData.velocity.y == down.y
            {
                nodeToMove.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: 0.5), asImpulse: false)
                nodeToMove.physicsBody?.angularVelocity = SCNVector4(x: 1, y: 0, z: 0, w: 3.0)
            }
            if joystickData.velocity.x == right.x
            {
                nodeToMove.physicsBody?.applyForce(SCNVector3(x: 0.5, y: 0, z: 0.0), asImpulse: false)
                nodeToMove.physicsBody?.angularVelocity = SCNVector4(x: 0, y: 0, z: -1, w: 3.0)
            }
            if joystickData.velocity.x == left.x
            {
                nodeToMove.physicsBody?.applyForce(SCNVector3(x: -0.5, y: 0, z: 0.0), asImpulse: false)
                nodeToMove.physicsBody?.angularVelocity = SCNVector4(x: 0, y: 0, z: 1, w: 3.0)
            }
        }
    }
    
} // fine func */
