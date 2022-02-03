//
//  TowerNode.swift
//  TowerOfHanoi
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 02/11/19.
//  Copyright © 2019 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

class TowerNode: SKSpriteNode {

    let type: Tower
    let disks = Stack<DiskNode>()

    init(type: Tower) {
        self.type = type

        let texture = SKTexture(imageNamed: "tower")
        super.init(texture: texture, color: .clear, size: texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
