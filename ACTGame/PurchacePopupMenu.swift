//
//  PurchacePopupMenu.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/04/24.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

class PurchasePopUpMenu1 : SKNode{
    
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

class PurchasePopUpMenu2 : SKNode{
    
    private var action1: () -> Void
    private var action2: () -> Void
    
    init (cancelAction: @escaping () -> Void, purchaseAction: @escaping () -> Void){
        action1 = cancelAction
        action2 = purchaseAction
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
    
   lazy var button1: BDButton = {
        var button = BDButton(imageNamed: "purchasebutton1.png", title: " ", buttonAction: {
            self.removeFromParent()
            self.action1()
        })
        return button
    }()
    
    lazy var button2: BDButton = {
        var button = BDButton(imageNamed: "purchasebutton2.png", title: " ", buttonAction: {
            self.removeFromParent()
            self.action2()
        })
        return button
    }()
    
    func setupNodes() {
        button1.position = CGPoint(x:-65, y: -110)
        button2.position = CGPoint(x:65, y: -110)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button1)
        addChild(button2)
    }
}
