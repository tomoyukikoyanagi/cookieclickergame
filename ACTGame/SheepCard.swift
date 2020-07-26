//
//  SheepCard.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit



class SheepCard: SKNode{
    var title : String
    var imageNamed: String
    var levelStruct: LevelStruct
    var id : Int
    
    init(id:Int, levelStruct: LevelStruct){
        self.id = id
        self.title = sheepNameArrayJp[id]
        self.imageNamed = sheepCardName[id]
        self.levelStruct = levelStruct
        super.init()
        addNodes()
        setPosition()
        update()
    }
    
    lazy var card: PowerUpCard = {
        var card = PowerUpCard(title: title, imageNamed: imageNamed, buttonAction: {
            self.purchase()
        }, levelStruct: levelStruct)
        return card
    }()
    
    lazy var purchaseButton: BDButton = {
        var button = BDButton(imageNamed: cardButtonImage, title: "", buttonAction: {
            self.purchase()
        })
        button.scaleTo(screenWithPercentage: 0.4)
        
        return button
    }()
    
    lazy var buttonLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: fontSize.cardFontSize)
        return label
    }()
    
    lazy var buttonLogo: SKSpriteNode = {
        let buttonLogo = SKSpriteNode()
        return buttonLogo
    }()
    
    func update() {
        updateLabel()
        updateButton()
        let sm = sheepManager.shared
        if sm.isLevelMax(type: levelStruct.type, id: id) {
             levelMax()
         }
    }
    
    func updateLabel() {
        let sm = sheepManager.shared
        if self.isUnlocked(gameLevel: sm.getStoryLevel()){
            card.disable()
            buttonLabel.text = String(levelStruct.lockLevel)
            buttonLogo.texture = SKTexture(imageNamed: levelLogo)
            self.card.levelLabel?.text = ""
            self.card.amountLabel?.text = ""
        } else {
            buttonLabel.text = String(getPrice())
            buttonLogo.texture = SKTexture(imageNamed: sheepLogo)
            if sm.getLevel(type: self.levelStruct.type, id: self.id) == 0{
                self.card.levelLabel?.text = ""
                self.card.amountLabel?.text = ""
            } else {
            self.card.levelLabel?.text = "Lv.\(getLevel())"
            self.card.amountLabel?.text = "\(getAmount()) SPS"
            }
        }
    }
    
    func updateButton() {
        let sm = sheepManager.shared
        if sm.sheeps >= getPrice(){
            purchaseButton.enable()
        } else {
            purchaseButton.disable()
        }
    }
    
    func addNodes(){
        addChild(card)
        addChild(purchaseButton)
        purchaseButton.addChild(buttonLabel)
        purchaseButton.addChild(buttonLogo)
    }

    func setPosition(){
        purchaseButton.position = CGPoint(x:0, y: -100)
        buttonLabel.position = CGPoint(x: 30, y: -5)
        buttonLogo.position = CGPoint(x: 0, y: -5)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scaleTo(scaleWithPercentage: CGFloat){
        card.scaleTo(screenWithPercentage: scaleWithPercentage)
        purchaseButton.scaleTo(screenWithPercentage: scaleWithPercentage - 0.05)
    }
    
//    MARK:購入処理
    func purchase() {
        let sm = sheepManager.shared
        if self.isUnlocked(gameLevel: sm.getStoryLevel()){
//解放レベルに至っていない
            self.parent?.parent?.parent?.addChild(notEnoughLevel)
        } else if sm.isPurchasable(price: self.getPrice()){
//変えるだけ金がなければボタンは押せない(updateButton)
            sm.sheeps -= self.getPrice()
            sm.levelUp(type: levelStruct.type, id: id)

        }
        update()
    }
    
    func levelMax(){
        purchaseButton.disable()
        buttonLabel.text = "レベル最大"
        buttonLabel.position = CGPoint(x: 30, y: -5)
    }
    
    func isUnlocked(gameLevel : Int) -> Bool{
        if gameLevel >= levelStruct.lockLevel{
            return false
        } else {
            return true
        }
    }
    
    func getPrice() -> Int{
        let sm = sheepManager.shared
        let price = self.levelStruct.price[sm.getLevel(type: .sheep, id: id)]
        return price
    }
    
    func getLevel() -> Int{
        let sm = sheepManager.shared
        let level = sm.getLevel(type: .sheep, id: id)
        return level
    }
    
    func getAmount() -> Int{
        let sm = sheepManager.shared
        let amount = self.levelStruct.amount?[sm.getLevel(type: .sheep, id: id)] ?? 0
        return amount
    }
    
}


let corriedaleCard : SheepCard = SheepCard(id: 0, levelStruct: corriedale)
let suffolkCard : SheepCard = SheepCard(id: 1, levelStruct: suffolk)
let merinoCard : SheepCard = SheepCard(id: 2, levelStruct: merino)
let lincolnCard : SheepCard = SheepCard(id: 3, levelStruct: lincoln)
let vbnCard : SheepCard = SheepCard(id: 4, levelStruct: valleyblacknose)
let karaculCard : SheepCard = SheepCard(id: 5, levelStruct: karacul)
let jacobCard : SheepCard = SheepCard(id: 6, levelStruct: jacob)
let sheepCardList : [SheepCard] = [corriedaleCard, suffolkCard, merinoCard, lincolnCard, vbnCard, karaculCard, jacobCard]

func updateSheepCardList(){
    for i in 0...sheepCardList.count-1{
        sheepCardList[i].update()
    }
}
