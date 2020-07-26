//
//  AreaCard.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit


class AreaCard: SKNode{
    var title : String
    var imageNamed: String
    var levelStruct: LevelStruct
    var id : Int
    var currentArea : Bool = false
    
    init(id:Int, levelStruct: LevelStruct){
        self.id = id
        self.title = areaNameArrayJp[id]
        self.imageNamed = areaCardName[id]
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
        var button = BDButton(imageNamed: areaCardButtonImage, title: "", buttonAction: {
            
            self.purchase()
        })
        button.position = CGPoint(x:-20, y: -90)
        button.scaleTo(screenWithPercentage: 0.3)
        return button
    }()
    
    lazy var changeBackgroundButton: BDButton = {
        var button = BDButton(imageNamed: changeBackgroundButtonImage, title: "", buttonAction: {
            var shared = sheepManager.shared
            shared.changeCurrentArea(areaNo: self.id)
            
        })
        button.position = CGPoint(x:55, y: -90)
        button.scaleTo(screenWithPercentage: 0.15)
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
//    背景を変えるボタンを設定する
    
    func update(){
        updateButton()
        updateLabel()
        let sm = sheepManager.shared
        if sm.isLevelMax(type: levelStruct.type, id: id) {
             levelMax()
         }
    }
    
    func updateLabel(){
        let sm = sheepManager.shared
        if self.isUnlocked(gameLevel: sm.getStoryLevel()){
            unlockedMode()
        } else {
            buttonLabel.text = String(getPrice())
            buttonLogo.texture = SKTexture(imageNamed: sheepLogo)
            if sm.getStoryLevel() > 0 {
                changeBackgroundButton.enable()
            } else {
                changeBackgroundButton.disable()
            }
            if sm.getLevel(type: self.levelStruct.type, id: self.id) == 0{
                self.card.levelLabel?.text = ""
                self.card.amountLabel?.text = ""
            } else {
            self.card.levelLabel?.text = "Lv.\(getLevel())"
            self.card.amountLabel?.text = "\(getAmount()) SPS"
            }
            
        }
    }
    
    func unlockedMode(){
        card.disable()
        buttonLabel.text = String(levelStruct.lockLevel)
        buttonLogo.texture = SKTexture(imageNamed: levelLogo)
        self.card.levelLabel?.text = ""
        self.card.amountLabel?.text = ""
        changeBackgroundButton.disable()
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
        addChild(changeBackgroundButton)
        purchaseButton.addChild(buttonLabel)
        purchaseButton.addChild(buttonLogo)
    }
    
    func setPosition(){
        purchaseButton.position = CGPoint(x:-20, y: -100)
        changeBackgroundButton.position = CGPoint(x:55, y: -100)
        buttonLabel.position = CGPoint(x: 30, y: -5)
        buttonLogo.position = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        
    //    MARK:購入処理
        func purchase() {
            let sm = sheepManager.shared
            if self.isUnlocked(gameLevel: sm.getStoryLevel()){
    //解放レベルに至っていない
                self.parent?.parent?.parent?.addChild(notEnoughLevel)
            } else if sm.isPurchasable(price: self.getPrice()){
                sm.sheeps -= self.getPrice()
                sm.levelUp(type: self.levelStruct.type, id: self.id)
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
    
    func isCurrentArea(){
        
    }
        
    func getPrice() -> Int{
        let sm = sheepManager.shared
        let price = self.levelStruct.price[sm.getLevel(type: .area, id: id)]
        return price
    }
    
    func getLevel() -> Int{
        let sm = sheepManager.shared
        let level = sm.getLevel(type: .area, id: id)
        return level
    }
    
    func getAmount() -> Int{
        let sm = sheepManager.shared
        let amount = self.levelStruct.amount?[sm.getLevel(type: .area, id: id)] ?? 0
        return amount
    }
    
    func scaleTo(scaleWithPercentage: CGFloat){
        card.scaleTo(screenWithPercentage: scaleWithPercentage)
        purchaseButton.scaleTo(screenWithPercentage: scaleWithPercentage - 0.15)
        changeBackgroundButton.scaleTo(screenWithPercentage: scaleWithPercentage / 2 - 0.1)
    }
    
    
}

let farmCard : AreaCard = AreaCard(id:0, levelStruct: farm)
let mountainCard : AreaCard = AreaCard(id:1, levelStruct: mountain)
let cityCard : AreaCard = AreaCard(id: 2, levelStruct: city)
let moonCard : AreaCard = AreaCard(id: 3, levelStruct: moon)
let galaxyCard : AreaCard = AreaCard(id: 4, levelStruct: galaxy)
let areaCardList : [AreaCard] = [farmCard, mountainCard, cityCard, moonCard, galaxyCard]

func updateAreaCardList(){
    for i in 0...areaCardList.count-1{
        areaCardList[i].update()
    }
}
