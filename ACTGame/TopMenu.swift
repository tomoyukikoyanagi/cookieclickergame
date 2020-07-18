//
//  TopMenu.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/04/10.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

import SwiftySKScrollView


let sheepCardLabelName : [String] = []

class TopMenu: SKScene{
    var scrollView : SwiftySKScrollView?
    let moveableNode = SKNode()
    let animationNode  = SKNode()
//    var sheepCardList : [SKCard] = []
//    var areaCardList : [SKCard] = []
//    var itemCardList : [SKCard] = []
    
    private var sheepWalkingFrames: [SKTexture] = []
    private var currentSheepNumber = 0
    private let MaxSheepNumber = 100
    
    let moveableNode_position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -1)
    let popMenuBackground_position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -1.0)
    let popMenuCancelButton_position = CGPoint(x: ScreenSize.width * -0.4, y: ScreenSize.height * -1.0)
    let menuChangeButton_position = CGPoint(x: ScreenSize.width * -0.2, y: ScreenSize.height * -1.0)
    
//    MARK: TimerUpdate
    override init(size: CGSize) {
        super.init(size: size)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSPS(notification:)), name: .notifyName, object: nil)
        let sheep = sheepManager.shared
        sheep.updateSPT()
        updateLabels()
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    var areaImage : SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "area1.png")
        sprite.zPosition = topmenuLayer.area
        return sprite
        }()
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "topmenu_background.png")
        if DeviceType.isiPad || DeviceType.isiPadPro {
            sprite.scaleTo(screenWidthPercentage: 1.0)
        } else {
//            sprite.scaleTo(screenHeightPercentage: 1.0)
            sprite.scale(to: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        }
        sprite.zPosition = topmenuLayer.background
        return sprite
        }()
    
//    MARK:羊が何匹か表示するラベル
    var sheepLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = topmenuLayer.label
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "羊が0000匹"
        return label
    }()
    
    func updateSheepLabel() {
        let sheep = sheepManager.shared
        sheepLabel.text = "羊が\(sheep.sheeps)匹"
    }
    
//    MARK: 夢のかけら表示ラベル
    var dfLabel : SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 15)
        label.zPosition = topmenuLayer.label
        label.color = SKColor.white
        label.horizontalAlignmentMode = .right
        label.verticalAlignmentMode = .center
        label.text = "0"
        return label
    }()
    
    var dfnode : SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "ddnode.png")
        sprite.zPosition = topmenuLayer.node
        return sprite
    }()
    
//    MARK:SPS SPTを表示するラベル
    var spsLabel : SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 15)
        label.zPosition = topmenuLayer.label
        label.color = SKColor.white
        label.horizontalAlignmentMode = .right
        label.verticalAlignmentMode = .center
        label.text = "0"
        return label
    }()
    
    var spsnode : SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "spsnode.png")
        sprite.zPosition = topmenuLayer.node
        return sprite
    }()
    
    var sptLabel : SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 15)
        label.zPosition = topmenuLayer.label
        label.color = SKColor.white
        label.horizontalAlignmentMode = .right
        label.verticalAlignmentMode = .center
        label.text = "1"
        return label
    }()
    
    var sptnode : SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "sptnode.png")
        sprite.zPosition = topmenuLayer.node
        return sprite
    }()
    
    @objc func updateSPS(notification: NSNotification?) {
        let sheep = sheepManager.shared
        sheep.addSPS()
        updateSheepLabel()
        print("notification recieved!")
    }
    
    func updateLabels(){
        let sharedInfo = sheepManager.shared
        dfLabel.text = "\(sharedInfo.getDreamFragment())"
        sptLabel.text = "\(sharedInfo.sheepsPerTap)"
        spsLabel.text = "\(sharedInfo.sheepsPerSecond)"
    }
    
//    MARK: 羊を数えるボタン＋押した時のアニメーション
    
    lazy var sheepButton: BDButton = {
        var button = BDButton(imageNamed:gameSceneManager.ImageName.sheepbutton.rawValue, buttonAction: {
            self.handleSheepButtonTapped()
        })
        button.scaleTo(screenWithPercentage: 0.8)
        button.zPosition = topmenuLayer.button
        return button
    } ()
    
    func handleSheepButtonTapped() { run(SKAction.sequence([SKAction.run(addSheep),SKAction.wait(forDuration: 1.0)]))
        let sheep = sheepManager.shared
        sheep.addSPT()
        updateSheepLabel()
    }
    
    func addSheep() {
        let sheep = buildSheep()
        currentSheepNumber += 1
        let actualY = CGFloat.random(in: 0 ... ScreenSize.height * 5 / 16 - sheep.size.height)
        sheep.position = CGPoint(x: ScreenSize.width / 2, y: actualY)

      addChild(sheep)
        let actualDuration = CGFloat.random(in: CGFloat(2.0) ... CGFloat(4.0))
        let actionMove = SKAction.move(to: CGPoint(x: -1 * ScreenSize.width / 2, y:actualY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        sheep.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
//    今後name内の値は引数に変更
    func buildSheep() -> SKSpriteNode{
        var sheep = SKSpriteNode()
        let sheepAnimatedAtlas = SKTextureAtlas(named: "sheep")
        var walkFrames: [SKTexture] = []
        
        let numImages = sheepAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let sheepTextureName = "sheep\(i)"
            walkFrames.append(sheepAnimatedAtlas.textureNamed(sheepTextureName))
        }
        sheepWalkingFrames = walkFrames
        
        let firstFrameTexture = sheepWalkingFrames[0]
        sheep = SKSpriteNode(texture: firstFrameTexture)
        sheep.position = CGPoint(x: frame.midX, y: frame.midY)
        sheep.scaleTo(screenWidthPercentage: 0.2)
        sheep.run(SKAction.repeatForever(
        SKAction.animate(with: sheepWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)))
        return sheep
    }
    
    //    MARK:ドリンクボタン
    lazy var useDrinkButton: DrinkButton = {
        var button = DrinkButton(buttonAction: {
            let popup = DrinkPopUpMenu(cancelAction:{},purchaseAction:{
                let sharedInstance = sheepManager.shared
                sharedInstance.startDrinkMode()
                sharedInstance.updateSPT()
                sharedInstance.useDrink()
                self.updateLabels()
                
                self.addChild(drinkModeAnimationNode())
                DispatchQueue.main.asyncAfter(deadline: .now() + drinkModeTime, execute: {
                    sharedInstance.endDrinkMode()
                    sharedInstance.updateSPT()
                })
            })
            popup.zPosition = topmenuLayer.popupmenu
            self.addChild(popup)
            })
        button.scaleTo(screenWithPercentage: 0.2)
        button.zPosition = topmenuLayer.button
        return button
    }()

//    MARK:ゆめにっきボタン
    lazy var diaryButton: BDButton = {
        var button = BDButton(imageNamed: "diarybutton.png", buttonTitle: buttonNameArrayJP[3], buttonAction:{
            gameSceneManager.shared.transition(self, toScene: .Diary, transition: SKTransition.reveal(with: .up, duration: 0.3))
        })
        button.scaleTo(screenWithPercentage: 0.16)
        button.zPosition = topmenuLayer.button
        return button
    }()
    
//    MARK:設定ボタン
    lazy var settingsButton: BDButton = {
        var button = BDButton(imageNamed: "settingbutton.png", buttonTitle: buttonNameArrayJP[4], buttonAction:{
            gameSceneManager.shared.transition(self, toScene: .Settings, transition: SKTransition.reveal(with: .up, duration: 0.3))
        })
        button.scaleTo(screenWithPercentage: 0.16)
        button.zPosition = topmenuLayer.button
        return button
    }()
    
//    MARK:眠るボタン
    lazy var sleepButton: BDButton = {
        var button = BDButton(imageNamed: gameSceneManager.ImageName.sleepButton.rawValue, buttonAction:{
            let popup = DreamCheckPopUp(cancelAction: {}, OKAction: {
                self.addChild(fadeAnimationNode())
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0, execute: {
                   gameSceneManager.shared.transition(self, toScene: .DreamScene, transition: SKTransition.fade(withDuration: 8.0)
                    )
                })
//                self.fadeAnimation()
            })
            popup.zPosition = topmenuLayer.popupmenu
            self.addChild(popup)
        })
        button.scaleTo(screenWithPercentage: 0.45)
        button.zPosition = topmenuLayer.button
        return button
    }()
    
//    MARK: 強化ボタン
    lazy var powerupsButton: BDButton = {
          var button = BDButton(imageNamed: "powerupButton", buttonAction:{
            self.moveScrollView()
            print("pubutton")
          })
          button.scaleTo(screenWithPercentage: 0.18)
        button.zPosition = topmenuLayer.button
          return button
      }()


//    @objc func startGameplayNotification(_info: Notification) {
//        startGameplay()
//    }
    
//    func startGameplay() {
//        ACTManager.shared.transition(self, toScene: .Gameplay, transition: SKTransition.moveIn(with: .right, duration:0.5))
//    }
    
    override func didMove(to view: SKView) {
        print("moved to mainmenu")
        anchorPoint = CGPoint(x: 0.5, y:0.5)
//        displayPoPMenu()
        addMovableNode()
        setupNodes()
        addNodes()
    }
    
//    MARK:setupNodes
    func setupNodes() {
        let labelOffset = ScreenSize.width * 0.1
        areaImage.position = CGPoint.zero
        background.position = CGPoint.zero
        sheepButton.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * -0.1)
        sheepLabel.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.36)
        dfLabel.position = CGPoint(x: ScreenSize.width * -0.3 + labelOffset, y: ScreenSize.height * 0.42)
        dfnode.position = CGPoint(x: ScreenSize.width * -0.3, y: ScreenSize.height * 0.42)
        sptnode.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.height * 0.42)
        sptLabel.position = CGPoint(x: ScreenSize.width * 0.0 + labelOffset, y: ScreenSize.height * 0.42)
        spsnode.position = CGPoint(x: ScreenSize.width * 0.3, y: ScreenSize.height * 0.42)
        spsLabel.position = CGPoint(x: ScreenSize.width * 0.3 + labelOffset, y: ScreenSize.height * 0.42)
        sleepButton.position = CGPoint(x:ScreenSize.width * -0.2, y: ScreenSize.height * -0.30)
        powerupsButton.position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -0.4)
        useDrinkButton.position = CGPoint(x: ScreenSize.width * -0.35, y:ScreenSize.height * -0.4)
        diaryButton.position = CGPoint(x: ScreenSize.width * 0.18, y:ScreenSize.height * -0.38)
        settingsButton.position = CGPoint(x: ScreenSize.width * 0.35, y:ScreenSize.height * -0.38)
        
        moveableNode.position = moveableNode_position
        popMenuBackground.position = popMenuBackground_position
        popMenuCancelButton.position = popMenuCancelButton_position
        menuChangeButton.position = menuChangeButton_position
        
    }
    
    func addNodes() {
        addChild(areaImage)
        addChild(background)
        addChild(sheepLabel)
        addChild(sheepButton)
        addChild(dfnode)
        addChild(dfLabel)
        addChild(sptLabel)
        addChild(sptnode)
        addChild(spsnode)
        addChild(spsLabel)
        addChild(sleepButton)
        addChild(useDrinkButton)
        addChild(powerupsButton)
        addChild(diaryButton)
        addChild(settingsButton)
        addChild(moveableNode)
        addChild(popMenuBackground)
        addChild(popMenuCancelButton)
        addChild(menuChangeButton)
        addChild(animationNode)
    }

    //    MARK: 強化アイテムメニュー
        lazy var popMenuBackground : SKSpriteNode = {
            let sprite = SKSpriteNode(imageNamed: gameSceneManager.ImageName.popmenuBackground1.rawValue)
            sprite.scaleTo(screenWidthPercentage: 1.1)
            
            sprite.zPosition = topmenuLayer.popmenufront
            return sprite
        }()
        
        func moveScrollView(){
            let actionMove = SKAction.move(to: CGPoint(x:0, y: ScreenSize.height * 0.5), duration: TimeInterval(0.2))
            let actionMove2 = SKAction.move(to: CGPoint(x:0, y: ScreenSize.height * -0.25), duration: TimeInterval(0.2))
            let actionMove3 = SKAction.move(to: CGPoint(x: ScreenSize.width * -0.4, y :-1 * ScreenSize.height / 20), duration: TimeInterval(0.2))
            let actionMove4 = SKAction.move(to: CGPoint(x: ScreenSize.width * 0, y : ScreenSize.height * -0.05), duration: TimeInterval(0.2))
            
            moveableNode.run(SKAction.sequence([actionMove]))
            popMenuBackground.run(SKAction.sequence([actionMove2]))
            popMenuCancelButton.run(SKAction.sequence([actionMove3]))
            menuChangeButton.run(SKAction.sequence([actionMove4]))
            scrollView?.isDisabled = false
        }
    
        func hideScrollView(){
    //        moveableNode.position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -1)
            let actionMove = SKAction.move(to: moveableNode_position, duration: TimeInterval(0.2))
            let actionMove2 = SKAction.move(to: popMenuBackground_position, duration: TimeInterval(0.2))
            let actionMove3 = SKAction.move(to: popMenuCancelButton_position, duration: TimeInterval(0.2))
            let actionMove4 = SKAction.move(to: menuChangeButton_position, duration: TimeInterval(0.2))
            moveableNode.run(SKAction.sequence([actionMove]))
            popMenuBackground.run(SKAction.sequence([actionMove2]))
            popMenuCancelButton.run(SKAction.sequence([actionMove3]))
            menuChangeButton.run(SKAction.sequence([actionMove4]))
            scrollView?.isDisabled = true
        }
        
        lazy var popMenuCancelButton : BDButton = {
            var button = BDButton(imageNamed: gameSceneManager.ImageName.popmenuCancelButton.rawValue, buttonAction:{
              self.hideScrollView()
            })
            button.scaleTo(screenWithPercentage: 0.25)
            button.zPosition = topmenuLayer.popmenuCancelButton
            return button
        }()
        
        lazy var menuChangeButton : SKSpriteNode = {
            let sprite = SKSpriteNode()
            let imageNameArray : [String] = [gameSceneManager.ImageName.popmenuBackground1.rawValue, gameSceneManager.ImageName.popmenuBackground2.rawValue, gameSceneManager.ImageName.popmenuBackground3.rawValue]
            var x_position = -37
            let y_position = 0
            
            for i in 0...2 {
                var button = BDButton(imageNamed: "buttonarea.png" , buttonAction:{
                    for j in 0...self.scrollViewArray.count - 1 {
                        if i == j {
                            self.scrollViewArray[j].zPosition = topmenuLayer.popmenufront
                        } else {
                            self.scrollViewArray[j].zPosition = topmenuLayer.popmenuback
                        }
                    }
                    self.popMenuBackground.texture = SKTexture(imageNamed: imageNameArray[i])
                    if i == 0 {
                        self.scrollView?.contentSize = CGSize(width: self.scrollView!.frame.width * 4, height: self.scrollView!.frame.height / 4)
                    } else if i == 1 {
                        self.scrollView?.contentSize = CGSize(width: self.scrollView!.frame.width * 3, height: self.scrollView!.frame.height / 4)
                    } else {
                        self.scrollView?.contentSize = CGSize(width: self.scrollView!.frame.width * 2, height: self.scrollView!.frame.height / 4)
                    }
                })
                button.position = CGPoint(x: x_position, y: y_position)
                button.scaleTo(screenWithPercentage: 0.20)
                button.alpha = 0.01
                button.zPosition = topmenuLayer.popmenufront
                sprite.addChild(button)
                x_position += 80
            }
            return sprite
        }()
        
        func addMovableNode() {
//            MARK:これをチェック
            moveableNode.zPosition = topmenuLayer.popmenufront
            scrollView = SwiftySKScrollView(frame: CGRect(x:0, y:  ScreenSize.height * 5 / 8, width: ScreenSize.width, height: ScreenSize.height / 4), moveableNode: moveableNode, direction: .horizontal)
            scrollView?.contentSize = CGSize(width: scrollView!.frame.width * 4, height: scrollView!.frame.height / 4)
//            scrollView?.setContentOffset(CGPoint(x: scrollView!.frame.width * 4, y: 0), animated: true)
            view?.addSubview(scrollView!)
            scrollView?.isDisabled = true
            guard let scrollView = scrollView else { return } // unwrap  optional
            addScrollView(scrollView: scrollView, zposition: topmenuLayer.popmenufront, num: 0)
            addScrollView(scrollView: scrollView, zposition: topmenuLayer.popmenuback, num: 1)
            addScrollView(scrollView: scrollView, zposition: topmenuLayer.popmenuback, num: 2)
        }
        
    var scrollViewArray : [SKSpriteNode] = []
        
    func addScrollView(scrollView: SwiftySKScrollView, zposition : CGFloat, num: Int) {
            let page1ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height / 2))
            page1ScrollView.position = CGPoint(x: frame.midX - (scrollView.frame.width * 3), y: 0 * frame.midY - 3 * (scrollView.frame.height))
            moveableNode.addChild(page1ScrollView)
            page1ScrollView.zPosition = zposition
        switch num {
            case 0:
                setSheepCard(scrollView: page1ScrollView)
            case 1:
                setAreaCard(scrollView: page1ScrollView)
            print("3")
            case 2:
                setItemCard(scrollView: page1ScrollView)
            print("3")
            default:
                print("3")
            }
            scrollViewArray.append(page1ScrollView)
        }
    
    func setSheepCard(scrollView: SKSpriteNode){
        var x_pos = 1200
        let y_pos = -30
        
        for i in 0...6{
            sheepCardList[i].position = CGPoint(x: x_pos, y: y_pos)
            sheepCardList[i].scaleTo(scaleWithPercentage: 0.45)
            x_pos -= 200
            scrollView.addChild(sheepCardList[i])
        }
    }
    
    func setAreaCard(scrollView: SKSpriteNode){
        var x_pos = 1200
        let y_pos = -30
        for i in 0...4{
            areaCardList[i].position = CGPoint(x: x_pos, y: y_pos)
//            areaCardList[i].scaleTo(screenWithPercentage: 0.45)
            x_pos -= 200
            scrollView.addChild(areaCardList[i])
        }
    }
    
    func setItemCard(scrollView: SKSpriteNode){
        var x_pos = 1200
        let y_pos = -30
        for i in 0...2{
            itemCardList[i].position = CGPoint(x: x_pos, y: y_pos)
            itemCardList[i].scaleTo(scaleWithPercentage: 0.45)
            x_pos -= 200
            scrollView.addChild(itemCardList[i])
        }
    }
    
//    func setSheepCard(scrollView: SKSpriteNode){
//        var x_position = 1200
//        let y_position = -30
//        for i in 0 ... 6 {
//            let sheepStruct = getLevelStruct(type: .sheep, no: i)
//            let card = SKCard(name: sheepNameArrayJp[i], imageNamed: sheepCardName[i], amountTitle: "\(sheepStruct.amount?[0] ?? 0)" , buttonTitle: "\(sheepStruct.price[1])", buttonAction: {
//                self.addPopup(cardNo: i, type: purchaseType.sheep, cardList: self.sheepCardList)
//            }, levelStruct: sheepStruct)
//            if i == 0{
//                card.enable()
//                card.updateButtonLabel(addLevel: 1)
//            } else {
//                card.disable()
//            }
//            card.position = CGPoint(x: x_position, y: y_position)
//            card.scaleTo(screenWithPercentage: 0.45)
//            scrollView.addChild(card)
//            x_position -= 200
//            self.sheepCardList.append(card)
//        }
//    }
    
//    func setAreaCard(scrollView: SKSpriteNode){
//        var x_position = 1200
//        let y_position = -30
//        for i in 0 ... 4 {
//            let areaStruct = getLevelStruct(type: .area, no: i)
//            let card = SKCard(name: areaNameArrayJp[i], imageNamed: areaCardName[i], amountTitle: "\(areaStruct.amount?[0] ?? 0)" , buttonTitle: "\(areaStruct.price[1])", buttonAction: {
//                self.addPopup(cardNo: i, type: purchaseType.area, cardList: self.areaCardList)
//            }, levelStruct: areaStruct)
//            if i == 0{
//                card.enable()
//                card.updateButtonLabel(addLevel: 1)
//            } else {
//                card.disable()
//            }
//            card.position = CGPoint(x: x_position, y: y_position)
//            card.scaleTo(screenWithPercentage: 0.45)
//            scrollView.addChild(card)
//            x_position -= 200
//            self.areaCardList.append(card)
//        }
//    }
//
//    func setItemCard(scrollView: SKSpriteNode){
//        var x_position = 1200
//        let y_position = -30
//        for i in 0 ... 2 {
//            let itemStruct = getLevelStruct(type: .item, no: i)
//            let card = SKCard(name: itemNameArrayJp[i], imageNamed: itemCardName[i], amountTitle: " " , buttonTitle: "\(itemStruct.price[0])", buttonAction: {
//                self.addPopup(cardNo: i, type: purchaseType.item, cardList: self.itemCardList)
//            },levelStruct: itemStruct)
//            if i == 0{
//                card.enable()
//            } else {
//                card.disable()
//            }
//            card.position = CGPoint(x: x_position, y: y_position)
//            card.scaleTo(screenWithPercentage: 0.45)
//            scrollView.addChild(card)
//            x_position -= 200
//            self.itemCardList.append(card)
//        }
//    }
    
//    MARK: ポップアップメニューの処理
//
//    func addPopup(cardNo: Int, type: purchaseType, cardList: [SKCard]){
//        let sheep = sheepManager.shared
//        scrollView?.isDisabled = true
//        switch type {
//        case .sheep:
//            if sheep.sheeps < cardList[cardNo].getPrice(){
//                let popup = PurchasePopUpMenu1(buttonAction: {
//                    self.scrollView?.isDisabled = false
//                })
//                popup.zPosition = topmenuLayer.popupmenu
//                addChild(popup)
//            } else {
//            let popup = PurchasePopUpMenu2(cardNo: cardNo, cancelAction: {
//                        self.scrollView?.isDisabled = false
//                           }, purchaseAction: {
//                               self.scrollView?.isDisabled = false
//                            self.updateCard(cardNo: cardNo, type: type)
//                           })
//            popup.zPosition = topmenuLayer.popupmenu
//            addChild(popup)
//            }
//
//        case .area:
//            if sheep.sheeps < cardList[cardNo].getPrice(){
//                let popup = ChangeBackgroundMenu(changeBackground: {
//                    guard let imgName = cardList[cardNo].getLevelStruct().imageName else {return}
//                    self.areaImage.texture = SKTexture(imageNamed: imgName)
//                    sheep.changeCurrentArea(areaNo: cardNo)
//                    self.scrollView?.isDisabled = false
//                }, cancelAction: {
//                    self.scrollView?.isDisabled = false
//                })
//                popup.zPosition = topmenuLayer.popupmenu
//                addChild(popup)
//            } else {
//                let popup = PurchaseBackgroundMenu(cardNo: cardNo, cancelAction: {
//                        self.scrollView?.isDisabled = false
//                           }, purchaseAction: {
//                                self.scrollView?.isDisabled = false
//                                self.updateCard(cardNo: cardNo, type: type)
//                                sheep.changeCurrentArea(areaNo: cardNo)
//            }, changeBackground: {
//                self.scrollView?.isDisabled = false
//                guard let imgName = cardList[cardNo].getLevelStruct().imageName else {return}
//                print("Imagename \(imgName)")
//                self.areaImage.texture = SKTexture(imageNamed: imgName)
//            })
//            popup.zPosition = topmenuLayer.popupmenu
//            addChild(popup)
//            }
//
//        case .item:
//            if sheep.getDreamFragment() >= cardList[cardNo].getPrice(){
//                let popup = PurchaseDrinkPopUpMenu(cancelAction: {
//                    self.scrollView?.isDisabled = false
//                        },purchaseAction: {
//                        self.scrollView?.isDisabled = false
//                        self.updateCard(cardNo: cardNo, type: type)
//                })
//                popup.zPosition = topmenuLayer.popupmenu
//                addChild(popup)
//            } else {
//                let popup = DrinkCannotPurchasePopUpMenu(buttonAction: {
//                    self.scrollView?.isDisabled = false
//                })
//                popup.zPosition = topmenuLayer.popupmenu
//                addChild(popup)
//            }
//        }
//    }
//
//    func updateCard(cardNo: Int, type: purchaseType){
//        let sheep = sheepManager.shared
//        if type == purchaseType.sheep{
////            購入処理
//        sheep.sheeps -= sheepCardList[cardNo].getPrice()
////            レベル処理
//            if cardNo < self.sheepCardList.count{
//                self.sheepCardList[cardNo + 1].enable()
//                self.sheepCardList[cardNo].updateButtonLabel(addLevel: 1)
//            }
////            カード表示処理
//            sheep.sheepLevelArray[cardNo] += 1
//        } else if type == purchaseType.area{
//            //            購入処理
//            sheep.sheeps -= areaCardList[cardNo].getPrice()
//            //            レベル処理
//            if cardNo < self.areaCardList.count{
//                    self.areaCardList[cardNo + 1].enable()
//                    self.areaCardList[cardNo].updateButtonLabel(addLevel: 1)
//            }
//            //            カード表示処理
//            sheep.areaLevelArray[cardNo] += 1
//
//        } else if type == purchaseType.item{
//            sheep.substractDreamFragment(int: itemCardList[cardNo].getPrice())
//            sheep.addDrink()
////            if cardNo < self.areaCardList.count{
//////                    self.areaCardList[cardNo + 1].enable()
////            }
//
//        }
//        var array1 : [Int] = []
//        var array2 : [Int] = []
//        for i in 0 ... sheepCardList.count - 1 {
//            array1.append(sheepCardList[i].getLevel())
//        }
//        for j in 0 ... areaCardList.count - 1 {
//            array2.append(areaCardList[j].getLevel())
//        }
//        sheep.updateSPT()
//        sheep.updateSPS()
//        useDrinkButton.updateDrinkLabel()
//        self.updateLabels()
//        print("sheepLevel \(sheep.sheepLevelArray)")
//        print("areaLevel \(sheep.areaLevelArray)")
//    }
}

struct topmenuLayer {
    static let area : CGFloat = 0
    static let background : CGFloat = 1
    static let node : CGFloat = 2
    static let label : CGFloat = 3
    static let button : CGFloat = 4
    static let popmenuCancelButton : CGFloat = 6
    static let popmenuback : CGFloat = -1
    static let popmenufront : CGFloat = 6
    static let popupmenu : CGFloat = 20
    static let animation : CGFloat = 10
    static let title : CGFloat = 20
}
