//
//  PopupSingle.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/18.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit



let button1Position : CGPoint = CGPoint(x:-65, y: -110)

class PopupSingle : SKNode{
    
    private var action: () -> Void
    private var title : String
    private var subTitle : String
    private var buttonTitle : String
    
    init (title: String, subTitle : String, buttonTitle : String, buttonAction: @escaping () -> Void){
        action = buttonAction
        self.buttonTitle = buttonTitle
        self.title = title
        self.subTitle = subTitle
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
    var button = BDButton(imageNamed: popupButtonImage1, title: self.buttonTitle, buttonAction: {
            self.removeFromParent()
            self.action()
        })
        return button
    }()
    
    lazy var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: fontSize.titleFontSize)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = self.title
        return label
    }()
    
    lazy var subLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: fontSize.subTitleFontSize)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = self.subTitle
        return label
    } ()
    
    func setupNodes() {
        self.zPosition = topmenuLayer.popupmenu
        button.position = CGPoint(x:0, y: -110)
        subLabel.position = CGPoint(x:0, y:0)
        titleLabel.position = CGPoint(x:0, y:100)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button)
        addChild(subLabel)
        addChild(titleLabel)
    }
}

let notEnoughLevel : PopupSingle = PopupSingle(title: "黄金の羊が足りません", subTitle: "この羊を解放するには黄金の羊がn匹必要です", buttonTitle: "閉じる", buttonAction: {})


