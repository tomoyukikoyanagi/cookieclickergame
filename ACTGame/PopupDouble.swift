//
//  PopupDouble.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/18.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

class PopupDouble : SKNode{
    
    private var actionGo: () -> Void
    private var actionCancel: () -> Void
    private var title : String
    private var subTitle : String
    private var buttonTitle : String
    private var cancelTitle : String
    
    init (title:String, subTitle: String, buttonTitle:String, cancelTitle: String, okAction : @escaping () -> Void, cancelAction: @escaping () -> Void){
        actionGo = okAction
        actionCancel = cancelAction
        self.title = title
        self.subTitle = subTitle
        self.buttonTitle = buttonTitle
        self.cancelTitle = cancelTitle
        super.init()
        setupNodes()
        addNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var logo: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: gameSceneManager.ImageName.sptLogo.rawValue)
        return sprite
    }()
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(color: .black, size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        sprite.alpha = 0.5
        return sprite
    }()
    
    var popupCard: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "popupwindow.png")
        return sprite
    }()
    
   lazy var buttonGo: BDButton = {
    var button = BDButton(imageNamed: popupButtonImage1, title: self.buttonTitle, buttonAction: {
            self.removeFromParent()
            self.actionGo()
        })
        return button
    }()
    
    lazy var buttonCancel: BDButton = {
        var button = BDButton(imageNamed: popupButtonImage2, title: self.cancelTitle, buttonAction: {
            self.removeFromParent()
            self.actionCancel()
        })
        
        return button
    }()
    
    func setupLabel(label: SKLabelNode) {
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.numberOfLines = 3
    }
    
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
    
    func updateSubLabel(){
        
    }
    
    func setupNodes() {
        self.zPosition = topmenuLayer.popupmenu
        buttonGo.position = CGPoint(x:0, y: -50)
        buttonCancel.position = CGPoint(x:0, y: -100)
        titleLabel.position = CGPoint(x:0, y:100)
        subLabel.position = CGPoint(x:0, y:0)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(buttonGo)
        addChild(buttonCancel)
        addChild(titleLabel)
        addChild(subLabel)
    }
}

//let watchDream : PopupDouble = PopupDouble(title: "もう寝ますか？", subTitle: "手に入る夢のかけら＊＊＊", buttonTitle: "おやすみ", cancelTitle: "まだいい", okAction: {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0, execute: {
//                       gameSceneManager.shared.transition(self, toScene: .DreamScene, transition: SKTransition.fade(withDuration: 8.0)
//                        )
//                    })
//                    self.fadeAnimation()
//                },
//                                           cancelAction: {})


