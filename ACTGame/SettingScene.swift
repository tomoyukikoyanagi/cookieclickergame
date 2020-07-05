//
//  DiaryScene.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/10.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class SettingsScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        setupNodes()
        addNodes()
        }
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(color: .brown, size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        sprite.zPosition = settingSceneLayer.background
        return sprite
        }()
    
    var titlelogo: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: gameSceneManager.ImageName.diarytitlenode.rawValue)
    sprite.zPosition = settingSceneLayer.titlelogo
    return sprite
    }()
    
    var titleLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = settingSceneLayer.title
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "設定"
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    lazy var backButton: BDButton = {
        var button = BDButton(imageNamed: gameSceneManager.ImageName.backbutton.rawValue, buttonAction: {
            gameSceneManager.shared.transition(self, toScene: .TopMenu, transition: SKTransition.reveal(with: .down, duration: 0.3))
        })
        button.scaleTo(screenWithPercentage: 0.2)
        button.zPosition = settingSceneLayer.button
        return button
    }()
    
    func setupNodes() {
        background.position = CGPoint(x:ScreenSize.width * 0.5,y: ScreenSize.height * 0.5)
        backButton.position = CGPoint(x:ScreenSize.width * 0.15,y: ScreenSize.height * 0.9)
        titleLabel.position = CGPoint(x:ScreenSize.width * 0.5, y: ScreenSize.height * 0.8)
        titlelogo.position = CGPoint(x:ScreenSize.width * 0.5, y: ScreenSize.height * 0.8)
    }
    
    func addNodes() {
        addChild(background)
        addChild(backButton)
        addChild(titleLabel)
        addChild(titlelogo)
    }
}

struct settingSceneLayer {
    static let background : CGFloat = 0
    static let titlelogo : CGFloat = 1
    static let title : CGFloat = 2
    
    static let button : CGFloat = 5
}
