//
//  Animation.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

func drinkModeAnimationNode() -> SKNode{
    let animationNode  = SKNode()
    var rainbowNode = SKSpriteNode(imageNamed: "rainbow.png")
    rainbowNode.zPosition = topmenuLayer.background
    rainbowNode.blendMode = .screen
    animationNode.addChild(rainbowNode)
    rainbowNode.position = CGPoint(x:  ScreenSize.width * 3.0 , y:0)
    rainbowNode.nodes(at:CGPoint(x:0 , y:0))
//    rainbowNode.isUserInteractionEnabled = true
    let actionMove = SKAction.move(to: CGPoint(x:ScreenSize.width * -2.5, y: 0), duration: TimeInterval(drinkModeTime))
    rainbowNode.run(actionMove)
    animationNode.isUserInteractionEnabled = false
    return animationNode
}

//MARK: 夢シーン用画面遷移アニメ

func fadeAnimationNode() -> SKNode{
    let animationNode  = SKNode()
    
    var squarecount: CGFloat = 0.0
    let delayTime: CGFloat = 0.1
    var x: CGFloat = 0
    var y: CGFloat = 0
    for j in 0...4 {
        for i in 0...3 {
            let width = ScreenSize.width / 4
            let height = ScreenSize.height / 4
            var square1 = SKSpriteNode(color: .black, size: CGSize(width: width, height: width))
            var square2 = SKSpriteNode(color: .black, size: CGSize(width: width, height: width))
                
            square1.position = CGPoint(x: -1.5 * width + width * x, y: -2 * height + width * y)
            square2.position = CGPoint(x: width * 1.5 - width * x, y: 2 * height - width * y)
            
            square1.alpha = 0.0
            square2.alpha = 0.0
            square1.zPosition = topmenuLayer.animation
            square2.zPosition = topmenuLayer.animation
            animationNode.addChild(square1)
            animationNode.addChild(square2)
            let delay = SKAction.wait(forDuration: TimeInterval(delayTime * squarecount))
            let fadein = SKAction.fadeAlpha(by: 1.0, duration: 1)
            let seq = SKAction.sequence([delay, fadein])
            x += 1.0
            square1.run(seq)
            square2.run(seq)// 実行
            squarecount += 1.0
        }
        x = 0.0
        y += 1.0
        
    }
    var title = SKSpriteNode(imageNamed: "title.png")
    title.zPosition = 20
    title.alpha = 0.0
    animationNode.addChild(title)
    let delay = SKAction.wait(forDuration: TimeInterval(3.0))
    let fadein = SKAction.fadeAlpha(by: 1.0, duration: 3.0)
    let seq = SKAction.sequence([delay, fadein])
    title.run(seq)
    return animationNode
}
