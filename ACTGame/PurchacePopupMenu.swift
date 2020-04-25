//
//  PurchacePopupMenu.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/04/24.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

class PurchasePopUpMenu : SKNode{
    
    private var action: () -> Void
    
    init (buttonAction: @escaping () -> Void){
        action = buttonAction
        super.init()
        setupNodes()
        addNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(color: .black, size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        sprite.alpha = 0.5
        return sprite
    }()
    
    var popupCard: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "popupwindow.png")
        return sprite
    }()
    
   lazy var button: BDButton = {
        var button = BDButton(imageNamed: "popupbutton_cannnotpurchase.png", title: "OK", buttonAction: {
            self.removeFromParent()
            self.action()
        })
        return button
    }()
    
    func setupNodes() {
        button.position = CGPoint(x:0, y: -110)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button)
    }
}
