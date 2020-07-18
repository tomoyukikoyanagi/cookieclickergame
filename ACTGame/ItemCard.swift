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
            addChild(card)
            addChild(purchaseButton)
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
            button.position = CGPoint(x:0, y: -90)
            button.scaleTo(screenWithPercentage: 0.4)
            return button
        }()

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
                logo.texture = SKTexture(imageNamed: dreamFragmentLogo)
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
    //            ?popupdouble
            } else {
    //            popupdouble
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

let drinkCard : ItemCard = ItemCard(id: 0, levelStruct: drink)
let dogCard : ItemCard = ItemCard(id: 1, levelStruct: dog)
let wolfCard : ItemCard = ItemCard(id: 2, levelStruct: wolf)
let itemCardList : [ItemCard] = [drinkCard,dogCard,wolfCard]

