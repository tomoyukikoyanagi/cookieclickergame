//
//  DreamScene.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit
import UIKit
import SKTextureGradient

class DreamScene: SKScene {
    
    var character : String?
    var talkSet : [String]?
    var count = 0
    var max = 0
    var textLabel = SKSpriteNode()
    
    override init(size: CGSize) {
        //        ここはセリフ管理クラスで作成
        super.init(size: size)
        let sheep = sheepManager.shared
        self.getTalkSet(talkList: sheep.getTalkList())
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    func getTalkSet(talkList: talkListStruct){
        
        self.count = 0
        self.talkSet = talkList.getTalkList()
        self.character = talkList.getCharacter()
        self.max = talkList.getTalkList().count
    }
    
    var background: SKSpriteNode = {
        let texture = SKTexture(size: CGSize(width: ScreenSize.width, height: ScreenSize.height), color1: CIColor.gray, color2: CIColor.black, direction: GradientDirection.up)
        var sprite = SKSpriteNode(texture: texture)
           if DeviceType.isiPad || DeviceType.isiPadPro {
//               sprite.scaleTo(screenWidthPercentage: 1.0)
           } else {
//               sprite.scaleTo(screenHeightPercentage: 1.0)
           }
           sprite.zPosition = 0
           return sprite
        }()
    
    
    var characterNode: SKSpriteNode = {
        var character = SKSpriteNode()
        character.zPosition = Layers.character
        let characterNode = animationNode(atlasName: AtlasName.sheepMan)
        character.addChild(characterNode)
        return character
    }()
   
    lazy var fukidashi: BDButton = {
        var button = BDButton(imageNamed: "pop.png", title: "", buttonAction: {
            if self.count >= self.max - 1 {
                gameSceneManager.shared.transition(self, toScene:.TopMenu, transition: SKTransition.fade(withDuration: 3.0))
            } else {
                self.textLabel.removeAllChildren()
                var labelText = self.talkSet?[self.count]
                self.setText(text: labelText)
                self.count += 1
            }
        })
        button.zPosition = Layers.fukidashi
        button.scaleTo(screenWithPercentage: 1.0)
        button.alpha = 0.0
        return button
    }()
    
    lazy var emitter: SKEmitterNode = {
        let emitter = SKEmitterNode(fileNamed: "SnowParticle.sks")!
        emitter.zPosition = Layers.emitter
        
    return emitter
    }()
    
    override func didMove(to view: SKView) {
        print("moved to mainmenu")
        anchorPoint = CGPoint(x: 0.5, y:0.5)
        setupNodes()
        addNodes()
    }
    
    func setText(text: String!){
        let fontSize: CGFloat = 17.0    // フォントサイズ
        // テキストを文字送りするのに必要そうな変数
        var text: String = text         // 引数で貰ったテキストを格納
        let count = text.count // テキストの文字数取得
        var strcount: CGFloat = 0.0     // 現在何文字目表示したか
        if count == 0 { return }        // 取得した文字列が空なら処理を抜ける
        let delayTime: CGFloat = 0.1    // 説明は後述
        // 文字の位置決定用変数(後で変換するのが面倒なのでCGCloatで作成)
        var x: CGFloat = 0              // 横に何文字目か
        var y: CGFloat = 0              // 何行目か
        
        // テキストの文字数文回す
        for n in 1 ... count {
//            if !loadingFlag { return }    // 表示途中で文字を消して、といった処理が来た時用のフラグと処理
            let chara:Character = text[text.startIndex] // 一文字目を取得 Character型で返ってくる
            text.remove(at: text.startIndex)         // 一文字目をテキストから削除
//            if chara != "嬲" {      // 嬲 は改行用のキー文字
            if n % 20 != 0{
                } else {    // 改行用の処理
                    y -= 1.0                // 行目をプラス
                    x = 0.0                 // 行が変わるので、横にずらす距離を初期化
                }
                // ラベルノードの生成
                var label: SKLabelNode = SKLabelNode(text: "\(chara)")  // "\(chara)"とすることでStringに変換
                // フォントサイズ指定
                label.fontName = UniversalFontName
                label.fontSize = fontSize
                label.fontColor = .black
                label.zPosition = Layers.text
                // 文字の位置設定
                label.position = CGPoint(x: -1 * ScreenSize.width / 2  + fontSize * x + fontSize, y: (y * fontSize) - fontSize)
                // 透明度の設定(初期は透明なので0.0)
                label.alpha = 0.0
                // ラベルの取り付け
                textLabel.addChild(label)
                print("adding: \(label)")
                // 表示する時間をずらすためのアクションの設定
                let delay = SKAction.wait(forDuration: TimeInterval(delayTime * strcount))  // 基本の送らせる時間に文字数を掛けることでずれを大きくする
                let fadein = SKAction.fadeAlpha(by: 1.0, duration: 0.1)   // 不透明にするアクションの生成
                let seq = SKAction.sequence([delay, fadein])            // 上記2つのアクションを連結
                label.run(seq)    // 実行
                x += 1.0
                
            
            strcount += 1.0 // 横にずらす距離をプラス
                        // 現在の文字数をプラス
        }
    }
    
    func setupNodes() {
        background.position = CGPoint.zero
        fukidashi.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
//        backButton.position = CGPoint(x: ScreenSize.width * -0.35, y :ScreenSize.height * 0.40)
        textLabel.position = CGPoint(x:ScreenSize.width * 0.1, y: ScreenSize.height * 0.3)
        emitter.position = CGPoint(x:ScreenSize.width * 0.0 , y:ScreenSize.height * 0.5)
        
    }
    
    func addNodes() {
        addChild(background)
        addChild(characterNode)
        addChild(fukidashi)
        addChild(textLabel)
        addChild(emitter)
        let delay = SKAction.wait(forDuration: TimeInterval(1.0))
        let fadein = SKAction.fadeAlpha(by: 1.0, duration: 1.0)
        let seq = SKAction.sequence([delay, fadein])
        fukidashi.run(seq)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            var labelText = self.talkSet?[self.count]
            self.setText(text: labelText)
            self.count += 1
        })
    }
}

struct Layers {
    static let background : CGFloat = 0
    static let emitter : CGFloat = 1
    static let fukidashi : CGFloat = 2
    static let text : CGFloat = 3
    static let character : CGFloat = 4
}
