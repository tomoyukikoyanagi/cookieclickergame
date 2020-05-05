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
    
    var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 30)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "羊が足りません"
        return label
    }()
    
    var popupLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 20)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "羊の数が不足しています"
        return label
    } ()
    
    func setupNodes() {
        button.position = CGPoint(x:0, y: -110)
        popupLabel.position = CGPoint(x:0, y:0)
        titleLabel.position = CGPoint(x:0, y:100)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button)
        addChild(popupLabel)
        addChild(titleLabel)
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

class ChangeBackgroundMenu : SKNode{
    
    private var action1: () -> Void
    private var action2: () -> Void
        
    init (changeBackground: @escaping () -> Void, cancelAction: @escaping () -> Void){
        action1 = changeBackground
        action2 = cancelAction
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
        var button = BDButton(imageNamed: "popupbutton_cannnotpurchase.png", title: "背景を変える", buttonAction: {
            self.removeFromParent()
            self.action1()
        })
        return button
    }()
    
    lazy var button2: BDButton = {
        var button = BDButton(imageNamed: "popupbutton_cannnotpurchase.png", title: "キャンセル", buttonAction: {
            self.removeFromParent()
            self.action2()
        })
        return button
    }()
    
    var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 30)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = ""
        return label
    }()
    
    var popupLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 20)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "背景を変更しますか？"
        return label
    } ()
    
    func setupNodes() {
        button1.position = CGPoint(x:0, y: -60)
        button2.position = CGPoint(x:0, y: -110)
        popupLabel.position = CGPoint(x:0, y:0)
        titleLabel.position = CGPoint(x:0, y:100)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button1)
        addChild(button2)
        addChild(popupLabel)
        addChild(titleLabel)
    }
}

class PurchaseBackgroundMenu : SKNode{
    
    private var action1: () -> Void
    private var action2: () -> Void
    private var action3: () -> Void
    
    init (cancelAction: @escaping () -> Void, purchaseAction: @escaping () -> Void, changeBackground: @escaping () -> Void){
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
    
    func setupNodes() {
        button1.position = CGPoint(x:0, y: -160)
        button2.position = CGPoint(x:0, y: -110)
        button3.position = CGPoint(x:0, y: -60)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button1)
        addChild(button2)
        addChild(button3)
    }
}
