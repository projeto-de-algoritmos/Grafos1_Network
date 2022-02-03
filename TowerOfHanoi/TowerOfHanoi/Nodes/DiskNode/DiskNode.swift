//
//  Disk.swift
//  TowerOfHanoi
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 02/11/19.
//  Copyright © 2019 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

class DiskNode: SKSpriteNode {
    let type: Int

    init(type: Int) {
        self.type = type
        let texture = SKTexture(imageNamed: "disk")

        super.init(texture: texture, color: .clear, size: .zero)
        color = UIColor.random
        size = size(for: type)
        colorBlendFactor = 0.5
        zPosition = 1
        
        name = "Disk \(type)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveInstantaneously(to tower: TowerNode) {
        if let topDiskPosition = tower.disks.peek()?.position {
            self.position = CGPoint(x: topDiskPosition.x,
                                    y: topDiskPosition.y + self.size.height)
        } else {
            self.position = CGPoint(x: tower.position.x,
                                    y: tower.frame.minY + self.size.height)
        }
    }
    
    func moveTo(tower: TowerNode) -> SKAction {
        return SKAction.run {
            var positionToMoveTo: CGPoint
            if let topDiskPosition = tower.disks.peek()?.position {
                positionToMoveTo = CGPoint(x: topDiskPosition.x,
                                        y: topDiskPosition.y + self.size.height)
            } else {
                positionToMoveTo = CGPoint(x: tower.position.x,
                                        y: tower.frame.minY + self.size.height)
            }
            
            self.run(SKAction.move(to: positionToMoveTo, duration: 0.3))
        }
    }

    func size(for type: Int) -> CGSize {
        return CGSize(width: 50 + 10*type, height: 15)
    }

}
