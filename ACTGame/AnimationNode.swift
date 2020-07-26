//
//  AnimationNode.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/17.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

enum AtlasName : String{
    case sheepMan = "sheepman"
    case sheepGirl = "sheepgirl"
    case drSheep = "drsheep"
    case dog = "dog"
}

func animationNode(atlasName: AtlasName) -> SKSpriteNode{
    
    var spriteFrames: [SKTexture] = []
    var sprite = SKSpriteNode()
    var mirrorsprite = SKSpriteNode()
    let spriteAnimatedAtlas = SKTextureAtlas(named: atlasName.rawValue)

    let numImages = spriteAnimatedAtlas.textureNames.count
    for i in 1...numImages {
        let sheepTextureName = "\(atlasName.rawValue)\(i)"
        spriteFrames.append(spriteAnimatedAtlas.textureNamed(sheepTextureName))
    }

    let firstFrameTexture = spriteFrames[0]
    sprite = SKSpriteNode(texture: firstFrameTexture)
    mirrorsprite = SKSpriteNode(texture: firstFrameTexture)
    sprite.position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -0.15)
    mirrorsprite.position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -0.45)
    sprite.scaleTo(screenWidthPercentage: 1.2)
    mirrorsprite.scaleTo(screenWidthPercentage: 1.2)
    mirrorsprite.zRotation = CGFloat(Double.pi)
    mirrorsprite.alpha = 0.5
    sprite.run(SKAction.repeatForever(
    SKAction.animate(with: spriteFrames, timePerFrame: 0.3, resize: false, restore: true)))
    sprite.addChild(mirrorsprite)
    return sprite
}
