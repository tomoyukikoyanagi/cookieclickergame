//
//  Gameplay.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/03/17.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit

class Gameplay : SKScene {
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
    
    var score = 0
    
    lazy var scoreLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "BubbleGum")
        label.fontSize = CGFloat.universalFont(size: 42)
        label.zPosition = 10
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "\(score)"
        return label
    }()

    func startNewBoard() {
        removeAllDonuts()
        addNewDonuts()
    }
    
    override func didMove(to view: SKView) {
        setupNodes()
        addNodes()
        addNewDonuts()
        
    }
    
    func setupNodes() {
        background.position = CGPoint(x: ScreenSize.width * 0.5, y: ScreenSize.height * 0.5)
        scoreLabel.position = CGPoint(x: ScreenSize.width * 0.5, y: ScreenSize.height * 0.9)
    }
    
    func addNodes() {
        addChild(background)
        addChild(scoreLabel)
    }
    
    func addNewDonuts() {
        for i in 0...9 {
            
            var imageName = "donut\(Int(CGFloat.random(in: 1.0 ... 3.0)))"
            let donut = BDButton(imageNamed: imageName) {
                print("donut tapped")
                self.handleWrongDonutTapped()
            }
            donut.name = "donut"
            donut.scaleTo(screenWithPercentage: CGFloat.random(in: 0.48 ... 0.5))
            donut.zPosition = 1
            donut.position = CGPoint(x: ScreenSize.width * CGFloat.random(in: 0.1 ... 0.9), y: ScreenSize.height * CGFloat.random(in: 0.1 ... 0.9))
            addChild(donut)
            print(123)
        }
        let imageName = "donut\(Int(CGFloat.random(in: 1.0 ... 3.0)))"
        let winnerdonut = BDButton(imageNamed: imageName) {
            print("WINNER donut tapped")
            self.handleWinnerDonutTapped()
        }
        winnerdonut.name = "donut"
        winnerdonut.scaleTo(screenWithPercentage: 0.6)
        winnerdonut.zPosition = 2
        winnerdonut.position = CGPoint(x: ScreenSize.width * CGFloat.random(in: 0.1 ... 0.9), y: ScreenSize.height * CGFloat.random(in: 0.1 ... 0.9))
        addChild(winnerdonut)
    }
    
    func removeAllDonuts() {
        enumerateChildNodes(withName: "//*") { (node, stop) in
            if node.name == "donut" {
                node.removeFromParent()
            }
        }
    }
    
    func handleWinnerDonutTapped() {
        score += 1
        updateScoreLabel()
        startNewBoard()
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(score)"
    }
    
    func handleWrongDonutTapped(){
        ACTPlayerStats.shared.setScore(score)
        ACTManager.shared.transition(self, toScene: .GameOver, transition: SKTransition.moveIn(with: .right, duration: 0.5))
    }
}

