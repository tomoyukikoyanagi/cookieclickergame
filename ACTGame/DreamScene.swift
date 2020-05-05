//
//  DreamScene.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit
import UIKit

class DreamScene: SKScene {
    
    var character : String
    var talkSet : [String]
    
    override init(size: CGSize) {
        //        ここはセリフ管理クラスで作成
        character = ""
        talkSet = ["これはテストです","これはあくまでテストです"]
        super.init(size: size)

        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    var background: SKSpriteNode = {
           var sprite = SKSpriteNode(imageNamed: "***")
           if DeviceType.isiPad || DeviceType.isiPadPro {
               sprite.scaleTo(screenWidthPercentage: 1.0)
           } else {
               sprite.scaleTo(screenHeightPercentage: 1.0)
           }
           sprite.zPosition = 0
           return sprite
           }()
    
    var title:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "GenEi LateMin V2")
        label.fontSize = CGFloat.universalFont(size: 42)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Game Over"
        return label
    }()
    
    lazy var backButton: BDButton = {
            var button = BDButton(imageNamed: "buttonback", title: "Back", buttonAction: {
               ACTManager.shared.transition(self, toScene:.MainMenu, transition: SKTransition.moveIn(with: .right, duration: 0.5))

            })
            button.zPosition = 1
            button.scaleTo(screenWithPercentage: 0.25)
            return button
        }()
    
    var characterNode: SKSpriteNode = {
        var character = SKSpriteNode(imageNamed: "character")
        return character
    }()
   
    lazy var fukidashi: BDButton = {
        var button = BDButton(imageNamed: "buttonback", title: "", buttonAction: {
            var labelText = self.talkSet[1]
            NotificationCenter.default.post(name: .notifyFukidashi, object: nil, userInfo: ["label": labelText])
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.25)
        return button
    }()
    
    var sheepLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "羊が0000匹"
        return label
    }()
    
    override func didMove(to view: SKView) {
        print("moved to mainmenu")
        anchorPoint = CGPoint(x: 0.5, y:0.5)
        setupNodes()
        addNodes()
    }
    
    func setupNodes() {
        background.position = CGPoint.zero
        title.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.4)
        fukidashi.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
        backButton.position = CGPoint(x: ScreenSize.width * -0.35, y :ScreenSize.height * 0.40)
    }
    
    func addNodes() {
        addChild(background)
        addChild(title)
        addChild(backButton)
        addChild(fukidashi)
    }
}

