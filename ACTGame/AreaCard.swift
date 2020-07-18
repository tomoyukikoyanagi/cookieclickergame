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
    
    init(id:Int, levelStruct: LevelStruct){
        self.id = id
        self.title = areaNameArrayJp[id]
        self.imageNamed = areaCardName[id]
        self.levelStruct = levelStruct
        
        super.init()
        addChild(card)
        addChild(purchaseButton)
        addChild(changeBackgroundButton)
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
//            changeBackground(id: self.id)
        })
        button.position = CGPoint(x:55, y: -90)
        button.scaleTo(screenWithPercentage: 0.15)
        return button
    }()
//    背景を変えるボタンを設定する
    
    func setButtonLabel(){
        let sm = sheepManager.shared
        let node = SKNode()
        let label = SKLabelNode()
        let logo = SKSpriteNode()
        if self.card.isUnlocked(gameLevel: sm.getStoryLevel()){
            card.disable()
            label.text = String(levelStruct.lockLevel)
            logo.texture = SKTexture(imageNamed: levelLogo)
        } else {
            label.text = String(getPrice())
            logo.texture = SKTexture(imageNamed: sheepLogo)
        }
        node.addChild(label)
        node.addChild(logo)
        purchaseButton.addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        
    //    MARK:購入処理
        func purchase() {
            let sm = sheepManager.shared
            
            if self.card.isUnlocked(gameLevel: sm.getStoryLevel()){
    //解放レベルに至っていない
    //            popup1
            } else if sm.isPurchasable(price: self.getPrice()){
    //変えるだけ金があること
    //            購入処理
            } else {
    //            ボタンを無効化する
            }
            
            if sm.getLevel(type: .sheep, id: id) == 0{
    //購入処理（初回）
            }else{
    //            購入処理
            }
        }
        
        func getPrice() -> Int{
            let sm = sheepManager.shared
            let price = self.levelStruct.price[sm.getLevel(type: .sheep, id: id)]
            return price
        }
    
    func scaleTo(scaleWithPercentage: CGFloat){
        card.card.scaleTo(screenWidthPercentage: scaleWithPercentage)
        purchaseButton.scaleTo(screenWithPercentage: scaleWithPercentage - 0.05)
    }
}

let farmCard : AreaCard = AreaCard(id:0, levelStruct: farm)
let mountainCard : AreaCard = AreaCard(id:1, levelStruct: mountain)
let cityCard : AreaCard = AreaCard(id: 2, levelStruct: city)
let moonCard : AreaCard = AreaCard(id: 3, levelStruct: moon)
let galaxyCard : AreaCard = AreaCard(id: 4, levelStruct: galaxy)
let areaCardList : [AreaCard] = [farmCard, mountainCard, cityCard, moonCard, galaxyCard]
