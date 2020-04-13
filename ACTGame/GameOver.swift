//
//  GameOver.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/03/20.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    var background: SKSpriteNode = {
           var sprite = SKSpriteNode(imageNamed: "background")
           if DeviceType.isiPad || DeviceType.isiPadPro {
               sprite.scaleTo(screenWidthPercentage: 1.0)
           } else {
               sprite.scaleTo(screenHeightPercentage: 1.0)
           }
           sprite.zPosition = 0
           return sprite
           }()
    
    var title:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "BubbleGum")
        label.fontSize = CGFloat.universalFont(size: 42)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Game Over"
        return label
    }()
    
    var score:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "BubbleGum")
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "score: \(ACTPlayerStats.shared.getScore())"
        return label
    }()
    
    var bestScore:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "BubbleGum")
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "BestScore: \(ACTPlayerStats.shared.getBestScore())"
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
    
    lazy var replayButton: BDButton = {
        var button = BDButton(imageNamed: "buttonreplay", buttonAction:{
            ACTManager.shared.transition(self, toScene: .Gameplay, transition: SKTransition.moveIn(with: .left, duration: 0.5))

            
        })
        
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 1
        return button
    }()
    
    override func didMove(to view: SKView) {
        print("moved to mainmenu")
        anchorPoint = CGPoint(x: 0.5, y:0.5)
        setupNodes()
        addNodes()
    }
    
    func setupNodes() {
        background.position = CGPoint.zero
        title.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
        score.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.height * 0.12)
        bestScore.position = CGPoint(x: ScreenSize.width * 0.0, y:ScreenSize.height * 0.08)
        backButton.position = CGPoint(x: ScreenSize.width * -0.35, y :ScreenSize.height * 0.40)
        replayButton.position = CGPoint(x: ScreenSize.width * 0.0, y:ScreenSize.height * -0.10)
    }
    
    func addNodes() {
        addChild(background)
        addChild(title)
        addChild(score)
        addChild(bestScore)
        addChild(backButton)
        addChild(replayButton)
    }
}
