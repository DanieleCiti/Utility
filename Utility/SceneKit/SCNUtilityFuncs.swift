//
//  SCNUtilityFuncs.swift
//  Utility
//
//  Created by Daniele Citi on 11/03/2019.
//  Copyright © 2019 Daniele Citi. All rights reserved.
//

import SceneKit
import UIKit

func pointFollowsPlayer(followerPoint: SCNNode, nodeToFollow: SCNNode, zOffSet:Float, iPhoneZOffSet:Float, yOffSet:Float)
{
    let nodeToFollowPos = nodeToFollow.presentation.position
    
    let position = SCNVector3(nodeToFollowPos.x, nodeToFollowPos.y+yOffSet, nodeToFollowPos.z+zOffSet)
    let iPhonePosition = SCNVector3(nodeToFollowPos.x, nodeToFollowPos.y+yOffSet, nodeToFollowPos.z+iPhoneZOffSet)
    
    switch deviceScreenRecognizer() {
    case .iPhoneSE:
        followerPoint.position = iPhonePosition
    case .iPhone8:
        followerPoint.position = iPhonePosition
    case .iPhonePlus:
        followerPoint.position = iPhonePosition
    case .iPhoneX:
        followerPoint.position = iPhonePosition
    case .iPhoneXR_Max:
        followerPoint.position = iPhonePosition
    default:
        followerPoint.position = position
    }
}


enum CategoriaFisica:Int {
    case player = 1, floor, enemy, rightPoint, leftPoint, ball, goalLine, porta, deadLine
}

enum TypeOfPhysicsBody {
    case dynamic
    case kinematic
    case statico
}
/**
 Funzione che assegna un corpo fisico ad un nodo e ne inizializza le varie proprietà.
 
 */
func setupPhysicsBody(node: SCNNode,type:TypeOfPhysicsBody,affectedByGravity: Bool,mass: CGFloat, friction:CGFloat, rollingFriction: CGFloat,restitution: CGFloat, categoryBitMask:Int,contactTestBitMask:Int,collisionBitMask:Int)
{
    switch type {
    case .dynamic:
        node.physicsBody = SCNPhysicsBody.dynamic()
    case .kinematic:
        node.physicsBody = SCNPhysicsBody.kinematic()
    case .statico:
        node.physicsBody = SCNPhysicsBody.static()
    }
    
    node.physicsBody?.isAffectedByGravity = affectedByGravity
    node.physicsBody?.mass = mass
    node.physicsBody?.friction = friction
    node.physicsBody?.rollingFriction = rollingFriction
    node.physicsBody?.restitution = restitution
    node.physicsBody?.categoryBitMask = categoryBitMask
    node.physicsBody?.contactTestBitMask = contactTestBitMask
    node.physicsBody?.collisionBitMask = collisionBitMask
}

func randomMoveAction(myNode: SCNNode, myPoint1: SCNNode)
{
    let action1 = SCNAction.move(to: myPoint1.position, duration: randomTimeInterval())
    
    myNode.runAction(action1, forKey: "action")
    
}

func generateRandomNumber(_ from:Int, _ to:Int, _ quantità:Int?)-> [Int]
{
    var myRandomNumbers = [Int]() // tutti i numeri generati
    var numberOfNumbers = quantità // quanti numeri generare
    
    let lower = UInt32(from) // genera da questo numero...
    let higher = UInt32(to+1) // a questo numero.
    
    if numberOfNumbers == nil || numberOfNumbers! > (to-from) + 1
    {
        numberOfNumbers = (to-from) + 1
    }
    
    while myRandomNumbers.count != numberOfNumbers
    {
        let myNumber = arc4random_uniform(higher-lower + lower)
        
        if !myRandomNumbers.contains(Int(myNumber)) // Se l'array NON contiene myNumber
        {
            myRandomNumbers.append(Int(myNumber))
        }
    }
    
    return myRandomNumbers
}

func randomTimeInterval()-> TimeInterval
{
    var myTime = TimeInterval()
    
    let randomNumber = generateRandomNumber(1, 3, 1)
    
    switch randomNumber {
    case [1]:
        myTime = 1.2
    case [2]:
        myTime = 1.3
    case [3]:
        myTime = 0.8
    default:
        myTime = 1.7
    }
    return myTime
}
