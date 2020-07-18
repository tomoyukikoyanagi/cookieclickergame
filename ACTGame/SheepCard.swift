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
        addChild(card)
    }
    
    lazy var card: PowerUpCard = {
        var card = PowerUpCard(title: title, imageNamed: imageNamed, buttonAction: {
            self.purchase()
        }, levelStruct: levelStruct)
        return card
    }()
    
//    lazy var purchaseButton: BDButton = {
//        var button = BDButton(imageNamed: "cardbutton.png", title: "", buttonAction: {
//            self.action()
//            print("pressed purchase button")
//        })
//        button.position = CGPoint(x:0, y: -90)
//        button.scaleTo(screenWithPercentage: 0.4)
//        return button
//    }()
//    
//    
    func setButtonLabel(){
        let sm = sheepManager.shared
        let node = SKNode()
        let label = SKLabelNode()
        let logo = SKSpriteNode()
        if self.card.isUnlocked(gameLevel: sm.getStoryLevel()){
            label.text = String(levelStruct.lockLevel)
            logo.texture = SKTexture(imageNamed: levelLogo)
        } else {
            label.text = String(getPrice())
            logo.texture = SKTexture(imageNamed: sheepLogo)
        }
        node.addChild(label)
        node.addChild(logo)
        card.setButtonLabel(label: node)
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
    
    
    
}

let corriedaleCard : SheepCard = SheepCard(id: 0, levelStruct: corriedale)
let suffolkCard : SheepCard = SheepCard(id: 1, levelStruct: suffolk)
let merinoCard : SheepCard = SheepCard(id: 2, levelStruct: merino)
let lincolnCard : SheepCard = SheepCard(id: 3, levelStruct: lincoln)
let vbnCard : SheepCard = SheepCard(id: 4, levelStruct: valleyblacknose)
let karaculCard : SheepCard = SheepCard(id: 5, levelStruct: karacul)
let jacobCard : SheepCard = SheepCard(id: 6, levelStruct: jacob)
let sheepCardList : [SheepCard] = [corriedaleCard, suffolkCard, merinoCard, lincolnCard, vbnCard, karaculCard, jacobCard]
