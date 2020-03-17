//
//  MainMenu.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/03/17.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit


class MainMenu: SKScene {
    
    lazy var playButton: BDButton = {
        var button = BDButton(imageNamed: "ButtonPlay", buttonAction: {
            
            let chance = CGFloat.random(in: 1 ... 10)
            if chance <= 5 {
//                self.showAds()
            } else {
                self.startGameplay()
            }
            
        })
        button.zPosition = 1
        return button
    } ()
    
    @objc func startGameplayNotification(_info: Notification) {
        startGameplay()
    }
    
    func startGameplay() {
        ACTManager.shared.transition(self, toScene: .Gameplay, transition: SKTransition.moveIn(with: .right, duration:0.5))
    }
    
    override func didMove(to view: SKView) {
        setupNodes()
        addNodes()
    }
    
    func setupNodes() {
        
    }
    
    func addNodes() {
        
    }
    
}
