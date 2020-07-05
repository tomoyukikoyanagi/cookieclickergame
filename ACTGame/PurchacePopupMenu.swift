//
//  PurchacePopupMenu.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/04/24.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

let titleFontSize : CGFloat = 20
let titlePostion : CGPoint = CGPoint(x:0, y:100)
let subTitleFontSize : CGFloat = 16
let button1Position : CGPoint = CGPoint(x:-65, y: -110)
//MARK: お金が足りない場合
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
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: titleFontSize)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "羊が足りません"
        return label
    }()
    
    var popupLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
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
        titleLabel.position = titlePostion
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button)
        addChild(popupLabel)
        addChild(titleLabel)
    }
}

//MARK: 羊購入処理
class PurchasePopUpMenu2 : SKNode{
    
    private var action1: () -> Void
    private var action2: () -> Void
    private var cardno: Int
    private var currentAmount : Int
    private var nextAmount : Int
    
    init (cardNo: Int, cancelAction: @escaping () -> Void, purchaseAction: @escaping () -> Void){
        cardno = cardNo
        action1 = cancelAction
        action2 = purchaseAction
        
        let sheep = sheepManager.shared
               let currentLevel = sheep.sheepLevelArray[self.cardno]
               nextAmount = getLevelStruct(type: .sheep, no: cardno).amount?[currentLevel + 1] ?? 0
               currentAmount = getLevelStruct(type: .sheep, no: cardno).amount?[currentLevel] ?? 0
        
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
    
   lazy var button1: BDButton = {
        var button = BDButton(imageNamed: "cancelbutton.png", title: "キャンセル", buttonAction: {
            self.removeFromParent()
            self.action1()
        })
        return button
    }()
    
    lazy var button2: BDButton = {
        var button = BDButton(imageNamed: "okbutton.png", title: "OK", buttonAction: {
            self.removeFromParent()
            self.action2()
        })
        return button
    }()
    
    func setupLable(label: SKLabelNode) {
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.numberOfLines = 3
    }
    
    lazy var checkLabelTitle1: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLable(label: label)
        label.text = "購入前"
        return label
    }()
    
    lazy var checkLabel1: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLable(label: label)
        label.text = "\(currentAmount)"
        return label
    }()
    
    lazy var checkLabelTitle2: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLable(label: label)
        label.text = "購入後"
        return label
    }()
    
    lazy var checkLabel2: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLable(label: label)
        label.text = "\(nextAmount)"
        return label
    }()
    
    var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: titleFontSize)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "羊を強化しますか？"
        return label
    }()
    
    func setupNodes() {
        button1.position = CGPoint(x:-65, y: -110)
        button2.position = CGPoint(x:65, y: -110)
        titleLabel.position = titlePostion
        checkLabel1.position = CGPoint(x:-50, y:0)
        checkLabelTitle1.position = CGPoint(x:-50, y:30)
        checkLabel2.position = CGPoint(x:50, y:0)
        checkLabelTitle2.position = CGPoint(x:50, y:30)
        logo.position = CGPoint(x: -50, y:0)
        checkLabel1.addChild(logo)
        
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button1)
        addChild(button2)
        addChild(titleLabel)
        addChild(checkLabel1)
        addChild(checkLabelTitle1)
        addChild(checkLabel2)
        addChild(checkLabelTitle2)
    }
}

//MARK: 背景変更ボタン
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
        var button = BDButton(imageNamed: "popupbutton_cannnotpurchase.png", title: "背景を変更しますか？", buttonAction: {
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
    
    func setupLabel(label: SKLabelNode){
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
    }
    
    lazy var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: titleFontSize)
        setupLabel(label: label)
        label.text = "背景を変更する"
        return label
    }()
    
    lazy var popupLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLabel(label: label)
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

//MARK: 背景購入
class PurchaseBackgroundMenu : SKNode{
    
    private var action1: () -> Void
    private var action2: () -> Void
    private var action3: () -> Void
    private var cardno: Int
    private var currentAmount: Int
    private var nextAmount : Int
    
    init (cardNo: Int, cancelAction: @escaping () -> Void, purchaseAction: @escaping () -> Void, changeBackground: @escaping () -> Void){
        action1 = cancelAction
        action2 = purchaseAction
        action3 = changeBackground
        cardno = cardNo
        
        let sheep = sheepManager.shared
        let currentLevel = sheep.sheepLevelArray[self.cardno]
        nextAmount = getLevelStruct(type: .area, no: cardno).amount?[currentLevel + 1] ?? 0
        currentAmount = getLevelStruct(type: .area, no: cardno).amount?[currentLevel] ?? 0
        
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
    
    lazy var button1: BDButton = {
        var button = BDButton(imageNamed: "cancelbutton.png", title: "キャンセル", buttonAction: {
            self.removeAllChildren()
            self.removeFromParent()
            self.action1()
        })
        return button
    }()
    
    lazy var button2: BDButton = {
        var button = BDButton(imageNamed: "okbutton.png", title: "購入する", buttonAction: {
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
    
    var logo: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: gameSceneManager.ImageName.spsLogo.rawValue)
        return sprite
    }()
    
    func setupLabel(label: SKLabelNode) {
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.numberOfLines = 3
    }
    
    lazy var checkLabelTitle1: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLabel(label: label)
        label.text = "購入前"
        return label
       }()
    
    lazy var checkLabel1: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLabel(label: label)
        label.text = "\(currentAmount)"
        return label
    }()
    
    lazy var checkLabelTitle2: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLabel(label: label)
       label.text = "購入後"
        return label
    }()
    
    lazy var checkLabel2: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLabel(label: label)
        label.text = "\(nextAmount)"
        return label
    }()
    var popupCard: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "popupwindow.png")
        return sprite
    }()
    
    var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: titleFontSize)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "背景を強化しますか？"
        return label
    }()
    
    func setupNodes() {
        button1.position = CGPoint(x:-65, y: -110)
        button2.position = CGPoint(x:65, y: -110)
        button3.position = CGPoint(x:0, y: -60)
        logo.position = CGPoint(x: -50, y:0)
        checkLabel1.position = CGPoint(x:-50, y:0)
        checkLabelTitle1.position = CGPoint(x:-50, y:30)
        checkLabel2.position = CGPoint(x:50, y:0)
        checkLabelTitle2.position = CGPoint(x:50, y:30)
        titleLabel.position = CGPoint(x:0, y:100)
        checkLabel1.addChild(logo)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(titleLabel)
        addChild(button1)
        addChild(button2)
        addChild(button3)
        addChild(checkLabel1)
        addChild(checkLabelTitle1)
        addChild(checkLabel2)
        addChild(checkLabelTitle2)
    }
}

//MARK:夢に入る確認ポップアップ
class DreamCheckPopUp : SKNode{
    
    private var action1: () -> Void
    private var action2: () -> Void
    
    init (cancelAction: @escaping () -> Void, OKAction: @escaping () -> Void){
        action1 = cancelAction
        action2 = OKAction
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
    
    var logo: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: gameSceneManager.ImageName.dreamFragmentLogo.rawValue)
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
        var button = BDButton(imageNamed: "purchasebutton2.png", title: "夢をみる", buttonAction: {
            self.removeFromParent()
            self.action2()
        })
        return button
    }()
    
    var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 25)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "夢を見ますか？"
        return label
    }()
    
    var title2Label: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 16)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "夢を見ると羊の数が０に戻ります"
        return label
    }()
    
    var title3Label: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 16)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "獲得できるアイテム"
        return label
    }()
    
    var dreamLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 20)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        let sheep = sheepManager.shared
        let earnedDreamDrop = sheep.exchangeSheepToFragment(sheeps: sheep.sheeps)
        label.text = " \(earnedDreamDrop)"
        return label
    } ()
    
    func setupNodes() {
        button1.position = CGPoint(x:-65, y: -110)
        button2.position = CGPoint(x:65, y: -110)
        titleLabel.position = CGPoint(x:0, y:100)
        title2Label.position = CGPoint(x:0, y:80)
        title3Label.position = CGPoint(x:0, y:30)
        dreamLabel.position = CGPoint(x:0, y:0)
        dreamLabel.addChild(logo)
        logo.position = CGPoint(x: -30, y:0)
        
    }
    
    func addNodes(){
        addChild(background)
        addChild(dreamLabel)
        addChild(popupCard)
        addChild(button1)
        addChild(button2)
        addChild(titleLabel)
        addChild(title2Label)
        addChild(title3Label)
    }
}

//MARK: ドリンク使用処理
class DrinkPopUpMenu : SKNode{
    
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
    
    var logo: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: " ")
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
    
    func setupLabel(lable: SKLabelNode){
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
    }
    
    lazy var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: titleFontSize)
        label.text = "ドリンクを使用しますか？"
        setupLabel(lable: label)
        return label
    }()
    
    lazy var label: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        label.text = "1分間タップ値が\n２倍になります"
        setupLabel(lable: label)
        return label
    }()
    
    lazy var checkLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        setupLabel(lable: label)
        return label
    } ()

    func setupNodes() {
        button1.position = CGPoint(x:-65, y: -110)
        button2.position = CGPoint(x:65, y: -110)
        titleLabel.position = CGPoint(x:0, y:100)
        checkLabel.position = CGPoint(x:0, y:0)
        logo.position = CGPoint(x: -50, y:0)
        checkLabel.addChild(logo)
        label.position = CGPoint(x:0, y:30)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button1)
        addChild(button2)
        addChild(titleLabel)
        addChild(checkLabel)
        addChild(label)
    }
}
//MARK: ドリンク購入処理
class PurchaseDrinkPopUpMenu : SKNode{
    
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
    
    var logo: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "drinklogo.png")
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
    
   lazy var button1: BDButton = {
    var button = BDButton(imageNamed: gameSceneManager.ImageName.popupCancel.rawValue, title: "キャンセル", buttonAction: {
            self.removeFromParent()
            self.action1()
        })
        return button
    }()
    
    lazy var button2: BDButton = {
        var button = BDButton(imageNamed: gameSceneManager.ImageName.popupOK.rawValue, title: "OK", buttonAction: {
            self.removeFromParent()
            self.action2()
        })
        return button
    }()
    
    var titleLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: titleFontSize)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "ドリンクを購入しますか？"
        return label
    }()
    
    var label: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: subTitleFontSize)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "使用すると1分間タップ値が２倍になります"
        return label
    }()
    
    lazy var checkLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: titleFontSize)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        let sheep = sheepManager.shared
        label.text = " +１"
        return label
    } ()

    func setupNodes() {
        button1.position = CGPoint(x:-65, y: -110)
        button2.position = CGPoint(x:65, y: -110)
        titleLabel.position = CGPoint(x:0, y:100)
        checkLabel.position = CGPoint(x:0, y:0)
        logo.position = CGPoint(x: -50, y:0)
        checkLabel.addChild(logo)
        label.position = CGPoint(x:0, y:30)
    }
    
    func addNodes(){
        addChild(background)
        addChild(popupCard)
        addChild(button1)
        addChild(button2)
        addChild(titleLabel)
        addChild(checkLabel)
        addChild(label)
    }
}

//MARK: 夢のかけらが足りない場合
class DrinkCannotPurchasePopUpMenu : SKNode{
    
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
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 30)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "栄養ドリンク"
        return label
    }()
    
    var popupLabel: SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 20)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "夢のかけらが足りません"
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
