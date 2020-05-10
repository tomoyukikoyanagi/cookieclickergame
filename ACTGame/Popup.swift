//
//  Popup.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/09.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

class PopUp : SKNode{
    
    private var action1: () -> Void
    private var action2: () -> Void
    private var action3: () -> Void?
    
    var titleLabel: SKLabelNode
    
    init (title: String, cancelAction: @escaping () -> Void, purchaseAction: @escaping () -> Void, changeBackground: @escaping () -> Void){
        titleLabel = SKLabelNode(text: title)
        action1 = cancelAction
        action2 = purchaseAction
        action3 = changeBackground
        super.init()
        setupNodes()
        addNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(color: .black, size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        sprite.alpha = 0.7
        return sprite
    }()
    
    var popupCard: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "popupwindow.png")
        return sprite
    }()
    
   lazy var button1: BDButton = {
        var button = BDButton(imageNamed: "popupbutton_cannnotpurchase.png", title: "キャンセル", buttonAction: {
            self.removeFromParent()
            self.action1()
        })
        return button
    }()
    
    lazy var button2: BDButton = {
        var button = BDButton(imageNamed: "popupbutton_cannnotpurchase.png", title: "強化する", buttonAction: {
            self.removeFromParent()
            self.action2()
        })
        return button
    }()
    
    lazy var button3: BDButton = {
        var button = BDButton(imageNamed: "popupbutton_cannnotpurchase.png", title:"背景を変える", buttonAction: {
            self.removeFromParent()
            self.action3()
        })
        return button
    }()
    
    func setupLabel(label: SKLabelNode){
        label.fontName = "GenEi LateMin v2"
        label.fontSize = CGFloat.universalFont(size: 16)
        label.fontColor = SKColor.white
        label.zPosition = 1
    }
    
    func setupNodes() {
        button1.position = CGPoint(x:0, y: -160)
        button2.position = CGPoint(x:0, y: -110)
        button3.position = CGPoint(x:0, y: -60)
        titleLabel.position = CGPoint(x:0, y:100)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(titleLabel)
        addChild(button1)
        addChild(button2)
        addChild(button3)
    }
}
