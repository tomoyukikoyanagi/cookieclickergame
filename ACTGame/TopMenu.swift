//
//  TopMenu.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/04/10.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit



class TopMenu: SKScene, SKPopMenuDelegate {
    
    var pop: SKPopMenu!
    
//    var scrollView: SwiftySKScrollView?
//    let movableNode = SKNode()
    
    private var sheepWalkingFrames: [SKTexture] = []
    private var currentSheepNumber = 0
    private let MaxSheepNumber = 100
    
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
            //self.pop.slideUp(0.2)
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
        setupNodes()
        addNodes()
    }
    
    func setupNodes() {
        background.position = CGPoint.zero
        sheepButton.position = CGPoint.zero
        sheepLabel.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
        sptLabel.position = CGPoint(x: ScreenSize.width * -0.2, y: ScreenSize.height * 0.4)
        spsLabel.position = CGPoint(x: ScreenSize.width * 0.2, y: ScreenSize.height * 0.4)
        sleepButton.position = CGPoint(x:ScreenSize.width * -0.2, y: ScreenSize.height * -0.30)
        powerupsButton.position = CGPoint(x: ScreenSize.width * 0, y: ScreenSize.height * -0.4)
    }
    
    func addNodes() {
        addChild(background)
        addChild(sheepLabel)
        addChild(sheepButton)
        addChild(sptLabel)
        addChild(spsLabel)
        addChild(sleepButton)
        addChild(powerupsButton)
        //displayPoPMenu()
    }
    
    func displayPoPMenu() {
        pop = SKPopMenu(numberOfSections:5, sceneFrame: self.frame)
        pop.setSectionColor(1, color: SKColor.red)
        pop.setSectionColor(2, color: SKColor.magenta)
        pop.setSectionColor(3, color: SKColor.purple)
        pop.setSectionColor(4, color: SKColor.blue)
        pop.setSectionColor(5, color: SKColor.darkGray)
        pop.popMenuDelegate = self
        self.addChild(pop)
    }
    
    override func update(_ currentTime: TimeInterval) {
       /* Called before each frame is rendered */
     }
     
     // Delegate
     func sectionTapped(_ index:Int, name:String) {
       print("tapped: index " + "\(index)" + " " + name)
       if pop.sections[index].name == "email" {
         // email button tapped
       }
     }
}

