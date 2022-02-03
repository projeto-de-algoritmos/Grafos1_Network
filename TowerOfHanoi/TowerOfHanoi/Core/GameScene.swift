//
//  GameScene.swift
//  TowerOfHanoi
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 02/11/19.
//  Copyright © 2019 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

protocol GameStateDelegate: AnyObject {
    func becameSolvable()
    func becameUnsolvable()
}

class GameScene: SKScene {
    weak var gameStateDelegate: GameStateDelegate?
    
    private var baseNode: BaseNode!

    private var leftTower: TowerNode!
    private var middleTower: TowerNode!
    private var rightTower: TowerNode!
    
    private func nextSolvableTowers() -> (source: TowerNode, destination: TowerNode, auxiliary: TowerNode)? {
        let solvedTower: TowerNode
        let nextTower: TowerNode
        let auxiliaryTower: TowerNode
        
        if leftTower.disks.count == disks.count {
            solvedTower = leftTower
            nextTower = middleTower
            auxiliaryTower = rightTower
        } else if middleTower.disks.count == disks.count {
            solvedTower = middleTower
            nextTower = rightTower
            auxiliaryTower = leftTower
        } else if rightTower.disks.count == disks.count {
            solvedTower = rightTower
            nextTower = leftTower
            auxiliaryTower = middleTower
        } else {
            return nil
        }
        
        return (source: solvedTower, destination: nextTower, auxiliary: auxiliaryTower)
    }
    
    private var disks: [DiskNode] = {
        var disksArray: [DiskNode] = []
        for i in 0..<5 {
            disksArray.append(DiskNode(type: i))
        }
        return disksArray
    }()
    
    private func popDisk(from tower: TowerNode) {
        movedDiskOriginalTower = tower
        diskBeingMoved = tower.disks.pop()
    }
    
    private var diskBeingMoved: DiskNode?
    private var movedDiskOriginalTower: TowerNode?
    
    private var isSolving: Bool = false

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupNodes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if isSolving {
            return
        }
        
        if let touch = touches.first?.location(in: self) {
            if leftTower.contains(touch) {
                popDisk(from: leftTower)
            } else if middleTower.contains(touch) {
                popDisk(from: middleTower)
            } else if rightTower.contains(touch) {
                popDisk(from: rightTower)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let touch = touches.first?.location(in: self) {
            diskBeingMoved?.position = touch
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let touch = touches.first?.location(in: self), let diskBeingMoved = diskBeingMoved {
            func updateMovedDiskTower(to tower: TowerNode) {
                if diskBeingMoved.type < (tower.disks.peek()?.type ?? Int.max) {
                    diskBeingMoved.moveInstantaneously(to: tower)
                    tower.disks.push(diskBeingMoved)
                    self.movedDiskOriginalTower = nil
                    self.diskBeingMoved = nil
                } else {
                    updateMovedDiskTower(to: self.movedDiskOriginalTower!)
                }
            }
            if leftTower.contains(touch) {
                updateMovedDiskTower(to: leftTower)
            } else if middleTower.contains(touch) {
                updateMovedDiskTower(to: middleTower)
            } else if rightTower.contains(touch) {
                updateMovedDiskTower(to: rightTower)
            } else {
                updateMovedDiskTower(to: self.movedDiskOriginalTower!)
            }
            
            if nextSolvableTowers() == nil {
                gameStateDelegate?.becameUnsolvable()
            } else {
                gameStateDelegate?.becameSolvable()
            }
        }
    }
    
    func solveNext() {
        var moves: [(disk: DiskNode, from: TowerNode, to: TowerNode)] = []
        
        func solve(numberOfDisks: Int, from source: TowerNode, to destination: TowerNode, auxiliary tower: TowerNode) {
            guard numberOfDisks != 0 else { return }

            solve(numberOfDisks: numberOfDisks - 1, from: source, to: tower, auxiliary: destination)
            moves.append((disk: disks[numberOfDisks - 1], from: source, to: destination))
            print("Move disk \(numberOfDisks) from \(source.type) to \(destination.type)")
            solve(numberOfDisks: numberOfDisks - 1, from: tower, to: destination, auxiliary: source)
        }
        
        if let nextSolvableSet = nextSolvableTowers() {
            solve(numberOfDisks: disks.count, from: nextSolvableSet.source, to: nextSolvableSet.destination, auxiliary: nextSolvableSet.auxiliary)

            var moveActions: [SKAction] = []
            gameStateDelegate?.becameUnsolvable()
            isSolving = true

            for move in moves {
                moveActions.append(move.disk.moveTo(tower: move.to))
                moveActions.append(SKAction.run {
                    let _ = move.from.disks.pop()
                    move.to.disks.push(move.disk)
                })
                moveActions.append(SKAction.wait(forDuration: 0.4))
            }
            
            moveActions.append(SKAction.run {[weak self] in
                self?.gameStateDelegate?.becameSolvable()
                self?.isSolving = false
            })
            
            self.run(SKAction.sequence(moveActions))
        }
    }
    
    private func setupNodes() {
        setupBaseNode()
        setupTowers()
    }

    private func setupTowers() {
        leftTower = TowerNode(type: .left)
        leftTower.anchorPoint = CGPoint(x: 0.5, y: 0)
        leftTower.position = CGPoint(x: size.width * 0.25, y: baseNode.frame.maxY)
        addChild(leftTower)
        for disk in disks.reversed() {
            disk.moveInstantaneously(to: leftTower)
            leftTower.disks.push(disk)
            addChild(disk)
        }

        middleTower = TowerNode(type: .middle)
        middleTower.anchorPoint = CGPoint(x: 0.5, y: 0)
        middleTower.position = CGPoint(x: size.width * 0.5, y: baseNode.frame.maxY)
        addChild(middleTower)

        rightTower = TowerNode(type: .right)
        rightTower.anchorPoint = CGPoint(x: 0.5, y: 0)
        rightTower.position = CGPoint(x: size.width * 0.75, y: baseNode.frame.maxY)
        addChild(rightTower)
    }

    private func setupBaseNode() {
        baseNode = BaseNode()
        baseNode.size.width = size.width
        baseNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        baseNode.position = CGPoint(x: size.width/2, y: 0)
        addChild(baseNode)
    }
}
