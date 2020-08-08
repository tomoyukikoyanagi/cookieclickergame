//
//  ItemCard.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

class ItemCard : SKNode {
        var title : String
        var imageNamed: String
        var levelStruct: LevelStruct
        var id : Int
        
        init(id:Int, levelStruct: LevelStruct){
            self.id = id
            self.title = itemNameArrayJp[id]
            self.imageNamed = itemCardName[id]
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

    func update(){
        updateButton()
        updateLabel()
    }
    
        func updateLabel() {
            let sm = sheepManager.shared
            if self.isUnlocked(gameLevel: sm.getStoryLevel()){
                card.disable()
                buttonLabel.text = String(levelStruct.lockLevel)
                buttonLogo.texture = SKTexture(imageNamed: levelLogo)
            } else {
                buttonLabel.text = String(getPrice())
                buttonLogo.texture = SKTexture(imageNamed: sheepLogo)
                setCardLabel()
            }
        }
    
    func updateButton() {
        let sm = sheepManager.shared
        if sm.getDreamFragment() >= getPrice(){
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
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    //    MARK:購入処理
        func purchase() {
            let sm = sheepManager.shared
            
            if self.isUnlocked(gameLevel: sm.getStoryLevel()){
    //解放レベルに至っていない
    //            popup1
            } else if sm.isPurchasable(price: self.getPrice()){
    //変えるだけ金があること
    //            ?popupdouble
            } else {
    //            popupdouble
            }
            
            if sm.getLevel(type: .item, id: id) == 0{
    //購入処理（初回）
            }else{
    //            購入処理
            }
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
            let price = sm.getDreamFragment()
            return price
        }
    
    func scaleTo(scaleWithPercentage: CGFloat){
        card.scaleTo(screenWithPercentage: scaleWithPercentage)
        purchaseButton.scaleTo(screenWithPercentage: scaleWithPercentage - 0.05)
    }
    
    func setPosition(){
        purchaseButton.position = CGPoint(x:0, y: -100)
        buttonLabel.position = CGPoint(x: 30, y: -5)
        buttonLogo.position = CGPoint(x: 0, y: 0)
    }
    
    func getMode() -> countMode{
        let sm = sheepManager.shared
        let mode = sm.countMode
        return mode
    }
    
    func setCardLabel(){
        var label = ""
        switch self.levelStruct.name {
        case "drink":
            label = "ドリンク数  \(getDrinks())"
        case "dog":
            if getMode() == .normal{
                label = "購入可能"
            }else if getMode() == .dog{
                label = "購入済み"
            }else if getMode() == .wolf{
                label = "購入できません"
            }
        case "wolf":
            if getMode() == .normal{
                label = "購入可能"
            }else if getMode() == .dog{
                label = "購入できません"
            }else if getMode() == .wolf{
                label = "購入済み"
            }
        default:
            label = ""
        }
        self.card.levelLabel?.text = label
    }
    
    func getDrinks() -> Int{
        let sm = sheepManager.shared
        let amount = sm.getDrinkPossessed()
        return amount
    }
        
}

let drinkCard : ItemCard = ItemCard(id: 0, levelStruct: drink)
let dogCard : ItemCard = ItemCard(id: 1, levelStruct: dog)
let wolfCard : ItemCard = ItemCard(id: 2, levelStruct: wolf)
let itemCardList : [ItemCard] = [drinkCard,dogCard,wolfCard]

func updateItemCardList(){
    for i in 0...itemCardList.count-1{
        itemCardList[i].update()
    }
}
