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

let sheepCardName : [String] = ["card1.png","card2.png","card0.png","card0.png","card0.png","card0.png"]
let sheepCardLabelName : [String] = []

class TopMenu: SKScene{
    var scrollView : SwiftySKScrollView?
    let moveableNode = SKNode()
    var sheepCardList : [BDButton] = []
    
    private var sheepWalkingFrames: [SKTexture] = []
    private var currentSheepNumber = 0
    private let MaxSheepNumber = 100
    
    let moveableNode_position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -1)
    let popMenuBackground_position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -1.0)
    let popMenuCancelButton_position = CGPoint(x: ScreenSize.width * -0.4, y: ScreenSize.height * -1.0)
    let menuChangeButton_position = CGPoint(x: ScreenSize.width * -0.2, y: ScreenSize.height * -1.0)
    
    override init(size: CGSize) {
        super.init(size: size)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSPS(notification:)), name: .notifyName, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "background.png")
        if DeviceType.isiPad || DeviceType.isiPadPro {
            sprite.scaleTo(screenWidthPercentage: 1.0)
        } else {
            sprite.scaleTo(screenHeightPercentage: 1.0)
        }
        sprite.zPosition = 0
        return sprite
        }()
    
//    MARK:羊が何匹か表示するラベル
    var sheepLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = 2
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
    
//    MARK:SPS SPTを表示するラベル
    
    var spsLabel : SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 15)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "0 SPS"
        return label
    }()
    
    var sptLabel : SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 15)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "0 SPT"
        return label
    }()
    
    @objc func updateSPS(notification: NSNotification?) {
        let sheep = sheepManager.shared
        sheep.addSPS()
        updateSheepLabel()
        print("notification recieved!")
    }
    
    func updateLabels(){
        let sharedInfo = sheepManager.shared
        sptLabel.text = "\(sharedInfo.sheepsPerTap) SPT"
        spsLabel.text = "\(sharedInfo.sheepsPerSecond) SPS"
    }
    
//    MARK: 羊を数えるボタン＋押した時のアニメーション
    
    lazy var sheepButton: BDButton = {
        var button = BDButton(imageNamed:gameSceneManager.ImageName.sheepbutton.rawValue, buttonAction: {
            self.handleSheepButtonTapped()
//           add action
        })
        button.scaleTo(screenWithPercentage: 0.8)
        button.zPosition = 1
        return button
    } ()
    
    func handleSheepButtonTapped() {
        run(SKAction.sequence([SKAction.run(addSheep),SKAction.wait(forDuration: 1.0)]))
        let sheep = sheepManager.shared
        sheep.addSPT()
        updateSheepLabel()
    }
    
    func addSheep() {
        let sheep = buildSheep()
        currentSheepNumber += 1
        let actualY = CGFloat.random(in: 0 ... ScreenSize.height/2 - sheep.size.height)
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
    
    lazy var settingsButton: BDButton = {
        var button = BDButton(imageNamed: "****", buttonAction:{})
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 1
        return button
    }()
    
    lazy var diaryButton: BDButton = {
        var button = BDButton(imageNamed: "****n", buttonAction:{})
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 1
        return button
    }()
    
//    MARK:眠るボタン
//    このボタンは現在仮で値のリセットに使っています
    lazy var sleepButton: BDButton = {
        var button = BDButton(imageNamed: gameSceneManager.ImageName.sleepButton.rawValue, buttonAction:{
            let sheep = sheepManager.shared
            sheep.increaseSPS(amount: 1)
            self.updateStatusLabel()
        })
        button.scaleTo(screenWithPercentage: 0.45)
        button.zPosition = 1
        return button
    }()
    
//    MARK: 強化ボタン
    lazy var powerupsButton: BDButton = {
          var button = BDButton(imageNamed: "powerupButton", buttonAction:{
            self.moveScrollView()
            print("pubutton")
          })
          button.scaleTo(screenWithPercentage: 0.18)
          button.zPosition = 1
          return button
      }()
    
    func updateStatusLabel() {
        let sheep = sheepManager.shared
        spsLabel.text = "\(sheep.sheepsPerSecond) SPS"
        sptLabel.text = "\(sheep.sheepsPerTap) SPT"
    }

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
        background.position = CGPoint.zero
        sheepButton.position = CGPoint.zero
        sheepLabel.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
        sptLabel.position = CGPoint(x: ScreenSize.width * -0.2, y: ScreenSize.height * 0.4)
        spsLabel.position = CGPoint(x: ScreenSize.width * 0.2, y: ScreenSize.height * 0.4)
        sleepButton.position = CGPoint(x:ScreenSize.width * -0.2, y: ScreenSize.height * -0.30)
        powerupsButton.position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -0.4)
        
        moveableNode.position = moveableNode_position
        popMenuBackground.position = popMenuBackground_position
        popMenuCancelButton.position = popMenuCancelButton_position
        menuChangeButton.position = menuChangeButton_position
        
    }
    
    func addNodes() {
        addChild(background)
        addChild(sheepLabel)
        addChild(sheepButton)
        addChild(sptLabel)
        addChild(spsLabel)
        addChild(sleepButton)
        addChild(powerupsButton)
        addChild(moveableNode)
        addChild(popMenuBackground)
        addChild(popMenuCancelButton)
        addChild(menuChangeButton)
    }

    
    //    MARK: 強化アイテムメニュー
        lazy var popMenuBackground : SKSpriteNode =  {
            let sprite = SKSpriteNode(imageNamed: gameSceneManager.ImageName.popmenuBackground1.rawValue)
            sprite.scaleTo(screenWidthPercentage: 1.1)
            sprite.zPosition = 2
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
            button.zPosition = 3
            return button
        }()
        
        lazy var menuChangeButton : SKSpriteNode = {
            let sprite = SKSpriteNode()
            let imageNameArray : [String] = [gameSceneManager.ImageName.popmenuBackground1.rawValue, gameSceneManager.ImageName.popmenuBackground2.rawValue, gameSceneManager.ImageName.popmenuBackground3.rawValue]
            var x_position = 0
            let y_position = 0
            for i in 0...2 {
                var button = BDButton(imageNamed: "buttonplay.png" , buttonAction:{
                    for j in 0...self.scrollViewArray.count - 1 {
                        if i == j {
                            self.scrollViewArray[j].zPosition = 3
                        } else {
                            self.scrollViewArray[j].zPosition = -1
                        }
                    }
                    self.popMenuBackground.texture = SKTexture(imageNamed: imageNameArray[i])
                })
                button.position = CGPoint(x: x_position, y: y_position)
                button.scaleTo(screenWithPercentage: 0.20)
                button.zPosition = 3
                sprite.addChild(button)
                x_position += 50
            }
            return sprite
        }()
        
        func addMovableNode() {
            moveableNode.zPosition = 2
            scrollView = SwiftySKScrollView(frame: CGRect(x:0, y:  ScreenSize.height * 5 / 8, width: ScreenSize.width, height: ScreenSize.height / 4), moveableNode: moveableNode, direction: .horizontal)
            scrollView?.contentSize = CGSize(width: scrollView!.frame.width * 3, height: scrollView!.frame.height / 4)
            scrollView?.setContentOffset(CGPoint(x: 0 + scrollView!.frame.width * 3, y: 0), animated: true)
            view?.addSubview(scrollView!)
            scrollView?.isDisabled = true
            guard let scrollView = scrollView else { return } // unwrap  optional
            addScrollView(scrollView: scrollView, zposition: 3, num: 0)
            addScrollView(scrollView: scrollView, zposition: -1, num: 1)
            addScrollView(scrollView: scrollView, zposition: -1, num: 2)
        }
        
        var scrollViewArray : [SKSpriteNode] = []
        
    func addScrollView(scrollView: SwiftySKScrollView, zposition : CGFloat, num: Int) {
            let page1ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height / 2))
            page1ScrollView.position = CGPoint(x: frame.midX - (scrollView.frame.width * 2), y: 0 * frame.midY - 3 * (scrollView.frame.height))
            moveableNode.addChild(page1ScrollView)
            page1ScrollView.zPosition = zposition
        switch num {
        case 0:
            setCard1(scrollView: page1ScrollView)
        case 1:
            print("123")
        case 2:
            print("23")
        default:
            print("3")
        }
            scrollViewArray.append(page1ScrollView)
        }
        
        func setCard1(scrollView: SKSpriteNode){
            var x_position = -50
            let y_position = -30
            
            for i in 0 ... 4 {
                var card = BDButton(imageNamed: sheepCardName[i], buttonAction:{
                    self.updateCard(cardNo: i)
                })
                if i == 0{
                    card.enable()
                } else {
                    card.disable()
                }
                var label1 = "Lv.0"
                card.position = CGPoint(x: x_position, y: y_position)
//                card.zPosition = 3
                card.scaleTo(screenWithPercentage: 0.45)
                scrollView.addChild(card)
                x_position += 200
                self.sheepCardList.append(card)
            }
        }
        
        func updateCard(cardNo: Int){
            if cardNo < self.sheepCardList.count{
                self.sheepCardList[cardNo + 1].enable()
            }
            let sheep = sheepManager.shared
            sheep.sheepLevel[cardNo] += 1
            sheep.updateSPT()
            self.updateLabels()
            print("cardPressed")
        }
}

