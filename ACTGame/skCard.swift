//
//  BDButton.swift
//  AdventCalendarTutorial
//
//  Created by TomoyukiKoyanagi on 2020/03/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit

class SKCard: SKNode {
    var card: SKSpriteNode
//    var sheepImage: SKSpriteNode
    private var mask: SKSpriteNode
    private var cropNode:SKCropNode
    private var action: () -> Void
 
    private var isEnabled = true
    private var title: String
    
    private var level : Int
    
    var levelLabel: SKLabelNode?
    var amountLabel: SKLabelNode?
    
    init (imageNamed: String, amountTitle: String? = "", buttonTitle: String? = "", buttonAction: @escaping () -> Void ){
        level = 0
        card = SKSpriteNode(imageNamed: "card.png")
//        sheepImage = SKSpriteNode(imageNamed: imageNamed)
        levelLabel = SKLabelNode(text: "Lv.\(level)")
        amountLabel = SKLabelNode(text: amountTitle)
        title = buttonTitle ?? " "
        mask = SKSpriteNode(color: SKColor.black, size: card.size)
        mask.alpha = 0.0
        cropNode = SKCropNode()
        cropNode.maskNode = card
        cropNode.zPosition = 3
        cropNode.addChild(mask)
        action = buttonAction

        super.init()
        isUserInteractionEnabled = true
        setupNodes()
        addNodes()
    }
    
    lazy var purchaseButton: BDButton = {
        var button = BDButton(imageNamed: "cardbutton.png", title: self.title, buttonAction: {
            self.action()
//            self.addPopup()
            print("pressed purchase button")
        })
        button.position = CGPoint(x:0, y: -90)
        button.scaleTo(screenWithPercentage: 0.4)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNodes() {
        card.zPosition = 0
        if let levelLabel = levelLabel {
            setupLabel(label: levelLabel)
            levelLabel.position = CGPoint(x:-55, y: 118)
            levelLabel.verticalAlignmentMode = .top
            levelLabel.horizontalAlignmentMode = .left
        }
        if let amountLabel = amountLabel {
            setupLabel(label: amountLabel)
            amountLabel.position = CGPoint(x:55, y: 118)
            amountLabel.verticalAlignmentMode = .top
            amountLabel.horizontalAlignmentMode = .right
        }
    }
    
    func setupLabel(label: SKLabelNode){
        label.fontName = "****"
        label.fontSize = CGFloat.universalFont(size: 20)
        label.fontColor = SKColor.white
        label.zPosition = 1
    }
    
    func addNodes() {
        addChild(card)
        if let levelLabel = levelLabel {
            addChild(levelLabel)
        }
        if let amountLabel = amountLabel {
            addChild(amountLabel)
        }
        addChild(purchaseButton)
        addChild(cropNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
//            mask.alpha = 0.5
            run(SKAction.scale(by: 1.25, duration: 0.05))
            run(SKAction.scale(by: 0.8, duration: 0.01))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                if card.contains(location) {
//                    mask.alpha = 0.5
                } else {
//                    mask.alpha = 0.0
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                if card.contains(location) {
                    ACTManager.shared.run(SoundFileName.TapFile.rawValue, onNode: self)
//                    disable()
                    run(SKAction.sequence([SKAction.wait(forDuration:  0.2), SKAction.run({self.enable()
                    })]))
                }
            }
        }
    }
    
    func disable() {
        isEnabled = false
        mask.alpha = 0.0
//        card.alpha = 0.3
        amountLabel?.alpha = 0.3
        purchaseButton.disable()
    }
    
    func enable() {
        isEnabled = true
        mask.alpha = 0.0
        amountLabel?.alpha = 1.0
//        card.alpha = 1.0
        purchaseButton.enable()
    }
    
    func checkPurchacable(sheep: Int){
        if sheep < self.getPrice() {
            self.isEnabled = false
        }
    }
    
    func logAvailableFonts() {
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print ("==\(names)")
            }
            
        }
    }
    
    func scaleTo(screenWithPercentage: CGFloat){
        let aspectRatio = card.size.height / card.size.width
        let screenWidth = ScreenSize.width
        var screenHeight = ScreenSize.height
        if DeviceType.isiPhoneX {
            screenHeight -= 80.0
        }
        card.size.width = screenWidth * screenWithPercentage
        card.size.height = card.size.width * aspectRatio
    }
    
    func changeImage(imageNamed: String){
         card = SKSpriteNode(imageNamed: imageNamed)
    }
    
    
    
    func getPrice() -> Int{
        let price = purchaseButton.titleLabel?.text ?? "0"
        return Int(price) ?? 0
    }
    
    func addPopup() {
        NotificationCenter.default.post(name: .notifyPopup, object: nil)
        
    }
    
    func purchace(){
        let sheep = sheepManager.shared
        sheep.sheeps -= self.getPrice()
        if self.level < 10 {
            self.updateButtonLabel(addLevel: 1)
        }
    }
    
    func updateButtonLabel(addLevel: Int){
        level += addLevel
        levelLabel?.text = "Lv.\(level)"
        amountLabel?.text = "\(coridale.addSPS[level - 1])"
        purchaseButton.setTitle(title: "\(coridale.price[level - 1])")
        if level == 10{
            purchaseButton.setTitle(title: "レベル最大")
        }
    }
}

