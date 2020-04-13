//
//  MainMenu.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/03/17.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit


class MainMenu: SKScene {
    
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
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "The Biggest Donut"
        return label
    }()
    
    
    lazy var playButton: BDButton = {
        var button = BDButton(imageNamed:"buttonplay", buttonAction: {
            
            let chance = CGFloat.random(in: 1 ... 10)
            if chance <= 5 {
//                self.showAds()
            } else {
                self.startGameplay()
            }
            
        })
        button.scaleTo(screenWithPercentage: 0.33)
        button.zPosition = 1
        return button
    } ()
    
    lazy var rateButton: BDButton = {
        var button = BDButton(imageNamed: "ratebutton", buttonAction:{})
        
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 1
        return button
    }()
    
    lazy var shareButton: BDButton = {
        var button = BDButton(imageNamed: "sharebutton", buttonAction:{})
        
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 1
        return button
    }()
    
    @objc func startGameplayNotification(_info: Notification) {
        startGameplay()
    }
    
    func startGameplay() {
        ACTManager.shared.transition(self, toScene: .Gameplay, transition: SKTransition.moveIn(with: .right, duration:0.5))
    }
    
    override func didMove(to view: SKView) {
        print("moved to mainmenu")
        anchorPoint = CGPoint(x: 0.5, y:0.5)
        setupNodes()
        addNodes()
    }
    
    func setupNodes() {
        background.position = CGPoint.zero
        playButton.position = CGPoint.zero
        title.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
        rateButton.position = CGPoint(x:ScreenSize.width * -0.20, y: ScreenSize.height * -0.15)
        shareButton.position = CGPoint(x:ScreenSize.width * 0.20, y: ScreenSize.height * -0.15)
        
    }
    
    func addNodes() {
        addChild(background)
        addChild(title)
        addChild(playButton)
        addChild(rateButton)
        addChild(shareButton)
    }
    
}
