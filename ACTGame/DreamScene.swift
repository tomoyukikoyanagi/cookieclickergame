//
//  DreamScene.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit
import UIKit

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
        self.talkSet = talkList.getTalkList()
        self.character = talkList.getCharacter()
    }
    
    var background: SKSpriteNode = {
           var sprite = SKSpriteNode(imageNamed: "***")
           if DeviceType.isiPad || DeviceType.isiPadPro {
               sprite.scaleTo(screenWidthPercentage: 1.0)
           } else {
               sprite.scaleTo(screenHeightPercentage: 1.0)
           }
           sprite.zPosition = 0
           return sprite
           }()
    
    lazy var backButton: BDButton = {
            var button = BDButton(imageNamed: "", title: "Back", buttonAction: {
                gameSceneManager.shared.transition(self, toScene:.TopMenu, transition: SKTransition.moveIn(with: .right, duration: 0.5))

            })
            button.zPosition = 1
            button.scaleTo(screenWithPercentage: 0.25)
            return button
        }()
    
    var characterNode: SKSpriteNode = {
        var character = SKSpriteNode(imageNamed: "character")
        return character
    }()
   
    lazy var fukidashi: BDButton = {
        var button = BDButton(imageNamed: "buttonback", title: "", buttonAction: {
            self.textLabel.removeAllChildren()
            var labelText = self.talkSet?[self.count]
            self.setText(text: labelText)
            self.count += 1
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.25)
        return button
    }()
    
    var sheepLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "***")
        label.fontSize = CGFloat.universalFont(size: 20)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "羊が0000匹"
        return label
    }()
    
    override func didMove(to view: SKView) {
        print("moved to mainmenu")
        anchorPoint = CGPoint(x: 0.5, y:0.5)
        setupNodes()
        addNodes()
    }
    
    func setText(text: String!){
        let fontSize: CGFloat = 24.0    // フォントサイズ
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
            if chara != "嬲" {      // 嬲 は改行用のキー文字
                // ラベルノードの生成
                var label: SKLabelNode = SKLabelNode(text: "\(chara)")  // "\(chara)"とすることでStringに変換
                // フォントサイズ指定
                label.fontSize = fontSize
                // 文字の位置設定
                label.position = CGPoint(x: -1 * ScreenSize.width / 4  + fontSize * x + fontSize, y: (y * fontSize) - fontSize)
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
                x += 1.0                // 横にずらす距離をプラス
            } else {    // 改行用の処理
                y += 1.0                // 行目をプラス
                x = 0.0                 // 行が変わるので、横にずらす距離を初期化
            }
            strcount += 1.0             // 現在の文字数をプラス
        }
    }
    
    func setupNodes() {
        background.position = CGPoint.zero
        fukidashi.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
        backButton.position = CGPoint(x: ScreenSize.width * -0.35, y :ScreenSize.height * 0.40)
        textLabel.position = CGPoint(x:ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
    }
    
    func addNodes() {
        addChild(background)
        addChild(backButton)
        addChild(fukidashi)
        addChild(textLabel)
    }
    
    
}

