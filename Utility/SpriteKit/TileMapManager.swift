//
//  TileMapManager.swift
//  Utility
//
//  Created by Daniele Citi on 11/03/2019.
//  Copyright © 2019 Daniele Citi. All rights reserved.
//

import SpriteKit

func giveTileMapPhysicsBody(map: SKTileMapNode)
{
    let tileMap = map
    
    let tileSize = tileMap.tileSize
    let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
    let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
    
    for col in 0..<tileMap.numberOfColumns {
        
        for row in 0..<tileMap.numberOfRows {
            
            if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                
            {
                
                //let isEdgeTile = tileDefinition.userData?["AddBody"] as? Int  //uncomment this if needed, see article notes
                //if (isEdgeTile != 0) {
                let tileArray = tileDefinition.textures
                let tileTexture = tileArray[0]
                let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2)
                let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2)
                _ = CGRect(x: 0, y: 0, width: tileSize.width, height: tileSize.height)
                let tileNode = SKNode()
                
                tileNode.position = CGPoint(x: x, y: y)
                tileNode.physicsBody = SKPhysicsBody(texture: tileTexture, size: CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height)))
                tileNode.physicsBody?.linearDamping = 60.0
                tileNode.physicsBody?.affectedByGravity = false
                tileNode.physicsBody?.allowsRotation = false
                tileNode.physicsBody?.restitution = 0.0
                tileNode.physicsBody?.isDynamic = false
                
                
                //        tileNode.physicsBody?.categoryBitMask = CategoriaFisica.Muri
                //        tileNode.physicsBody?.contactTestBitMask = CategoriaFisica.Player
                //        tileNode.physicsBody?.collisionBitMask = CategoriaFisica.Player
                tileNode.physicsBody?.friction = 3.0
                
                tileMap.addChild(tileNode)
                //}
            }
        }
    }
}
