//
//  TalkList.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation

struct talkListStruct {
    var storyLevel : Int
    var sheep : Int
    var drinkUsed : Int
    var sheepLevel : [Int]
    var areaLevel : [Int]
    var talkList : [String]
    var id : Int
    var character : String
    
    init (id: Int, character : String, storyLevel: Int, sheep: Int, drinkUsed: Int, sheepLevel: [Int], areaLevel: [Int], talkList: [String]){
        self.character = character
        self.id = id
        self.storyLevel = storyLevel
        self.sheep = sheep
        self.drinkUsed = drinkUsed
        self.sheepLevel = sheepLevel
        self.areaLevel = areaLevel
        self.talkList = talkList
    }
    
    func getBool(storyLevel: Int, sheep: Int, drinkUsed: Int, sheepLevel: [Int], areaLevel: [Int]) -> Bool {
        var i = 0
        if self.storyLevel <= storyLevel{
            i += 1
        }
        if self.sheep <= sheep{
            i += 1
        }
        if self.sheepLevel.everyElementIsLager(as: sheepLevel){
            i += 1
        }
        if self.areaLevel.everyElementIsLager(as: areaLevel){
            i += 1
        }
        if i == 4 {
            return true
        } else {
            return false
        }
    }
    
    func getTalkList() -> [String]{
        return talkList
    }
    
    func getCharacter() -> String{
        return character
    }
    
}

let sheepMan1 : talkListStruct  = talkListStruct(id: 0, character: "sheepman", storyLevel: 0, sheep: 0, drinkUsed: 0, sheepLevel: [0,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["はじめまして",
                                                                                                                                         "この夢を見たということは君は",
                                                                                                                                         "どんな夢でも叶えることができる夢の話を聞いたのだな",
                                                                                                                                         "で、私が夢を叶えてくれるのかって？",
                                                                                                                                         "私がそんなことできそうに見えるか？",
                                                                                                                                          "私はただの羊男だよ。それ以上でもそれ以下でもない。",
                                                                                                                                         "どんなことも実現できる夢がそう簡単に見れるわけがないだろう",
                                                                                                                                         "その夢を見る条件だって？",
                                                                                                                                         "夢の中で７匹の黄金の羊を見つけること",
                                                                                                                                         "そう君の夢はこれから始まる",
                                                                                                                                         "この夢はほんのはじまりにすぎない"]
)

let sheepMan2 : talkListStruct = talkListStruct(id: 1, character: "sheepman", storyLevel: 1, sheep: 0, drinkUsed: 0, sheepLevel: [1,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["...",
                                                                                                                                                       "お前疲れてんの？",
                                                                                                                                                       "羊１匹も数えずに寝るって",
                                                                                                                                                       "本気か？"])

let sheepMan3 : talkListStruct = talkListStruct(id: 2, character: "sheepman", storyLevel: 1, sheep: 100, drinkUsed: 0, sheepLevel: [1,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["また会ったな",
"大抵の人間は羊を100匹も数えないうちに寝てしまうらしい。",
"大体みんな100匹数えないうちに飽きるらしいからな",
"だが本当に黄金の羊を見つけたいなら",
"100匹数えた程度で満足してらないないな"])


let sheepMan4 : talkListStruct = talkListStruct(id: 2, character: "sheepman", storyLevel: 1, sheep: 0, drinkUsed: 0, sheepLevel: [2,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["羊に数え慣れてくると",
"羊のレベルが上がるのはもうわかっているな？",
"よりたくさんの羊を数えたければ、羊のレベル上げは大切だ",
"だが、羊の数だけで見る夢が決まるはずもまないよな",
"どのように羊を数えたかも夢に作用する",
"あと目覚めてからがっかりされても困るから先に言っとくと",
"寝ると羊のレベルはリセットされるから"])


let talkListArray : [talkListStruct] = [sheepMan1,sheepMan2]
