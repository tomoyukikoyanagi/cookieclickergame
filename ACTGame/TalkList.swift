//
//  TalkList.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation




struct talkListStruct {
    private var storyLevel : Int
    private var sheep : Int
    private var drinkUsed : Int
    private var sheepLevel : [Int]
    private var areaLevel : [Int]
    private var talkList : [String]
    private var id : Int
    private var character : String
    
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
    
    func getTalkList() -> [String] {
        return talkList
    }
    
    func getCharacter() -> String {
        return character
    }
}

func getTalkListID(sheep: sheepManager) -> Int{
    
    switch sheep.countMode {
    case .normal:
        return getID(storyLevel: sheep.getStoryLevel(), sheep: sheep.sheeps, drinkUsed: sheep.drinkUsed, areaNo: sheep.getCurrentAreaNumber(), sheepLevels: sheep.sheepLevelArray)
    case .dog:
        return getDogID(sheep: sheep.sheeps, areaNo: sheep.getCurrentAreaNumber())
    case.wolf:
        return getWolfID(sheep: sheep.sheeps, areaNo: sheep.getCurrentAreaNumber())
    default:
            return 90000
        }
    }
    
    func getID(storyLevel: Int, sheep: Int, drinkUsed: Int, areaNo: Int, sheepLevels: [Int]) -> Int {
        
        let i5 = 1 * 10000
        let i4 = storyLevel * 1000
        var i3 = 0
        var i2 = 0
        var i1 = 0
        if i4 != 0 {
            i3 = getSheepAmount(sheep: sheep) * 100
        
            var d = drinkUsed
            if drinkUsed > 9 { d = 9}
            i2 = d * 10

            i1 = areaNo
        }
        return i1 + i2 + i3 + i4 + i5
    }
    
    func getDogID(sheep: Int, areaNo:Int) -> Int {
        let i5 = 3 * 10000
        
        var i3 = 0
        if sheep <= THRESHOLD1 { i3 = 1 }
        else if sheep <= THRESHOLD2 { i3 = 2 }
        else if sheep <= THRESHOLD3 { i3 = 3 }
        else if sheep <= THRESHOLD4 { i3 = 4 }
        
        var i1 = 0
        if areaNo <= 2 {
            i1 = 0
        } else if areaNo == 3 {
            i1 = 1
        } else if areaNo >= 4 {
            i1 = 2
        }
        
        return i5 + i3 + i1
    }
    
    func getWolfID(sheep: Int, areaNo:Int) -> Int {
        let i5 = 5 * 10000
        
        var i3 = 0
        if sheep <= -1 * THRESHOLD4 { i3 = 1 }
        else if sheep <= -1 * THRESHOLD3 { i3 = 2 }
        else if sheep <= -1 * THRESHOLD2 { i3 = 3 }
        else if sheep <= -1 * THRESHOLD1 { i3 = 4 }
        else if sheep <= THRESHOLD1 { i3 = 5 }
        else if sheep <= THRESHOLD2 { i3 = 6 }
        else if sheep <= THRESHOLD3 { i3 = 7 }
        else if sheep <= THRESHOLD4 { i3 = 8 }
        
        return i5 + i3
    }
    
    func getSheepAmount(sheep: Int) -> Int {
        var i = 0
        if sheep <= THRESHOLD2 {i = 0}
        else if sheep <= THRESHOLD3 {i = 1}
        else if sheep <= THRESHOLD4 {i = 2}
        else if sheep <= THRESHOLD5 {i = 3}
        else if sheep <= THRESHOLD6 {i = 4}
        return i
    }
    
    func maxSheepLevels(sheepLevels: [Int]) -> Int {
        var num = 0
        var j = 1
        for i in 0...sheepLevels.count{
            if sheepLevels[i] == 9{
                num = 1 * j
            } else {
                num = 0 * j
            }
            j *= 10
        }
        return num
    }
    
//    func getTalkList() -> [String]{
//        return talkList
//    }
    
    

let sheepMan0 : talkListStruct  = talkListStruct(id: 0, character: "sheepman", storyLevel: 0, sheep: 0, drinkUsed: 0, sheepLevel: [0,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["はじめまして",
                                                                                                                                         "この夢を見たということは君は",
                                                                                                                                         "どんな夢でも叶えることができる夢の話を聞いたのだな",
                                                                                                                                         "で、私が夢を叶えてくれるのかって？",
                                                                                                                                          "私はただの羊男だよ。人違いだな。",
                                                                                                                                         "いや、この場合は羊違いと言ったところか？まあ気にするな",
                                                                                                                                         "どんな夢も叶える夢を見るためにはまずは",
                                                                                                                                         "七匹の黄金の羊を捕まえなくてはならない",
                                                                                                                                         "黄金の羊は君の夢の中に解き放たれている",
                                                                                                                                         "不思議な力を持った羊たちだ",
                                                                                                                                         "黄金の羊を探し出したければそれ相応にたくさんの夢を見なければならない",
                                                                                                                                         "たくさんの夢を見るためには数えた羊の数だけじゃなく",
                                                                                                                                         "どうやって羊たちを数えたかも重要になってくる",
                                                                                                                                         "迷ったらゆめ日記を読みなさい。ヒントはそこにある。",
                                                                                                                                         "あと広告もまじってる。が、それは許してくれ。",
                                                                                                                                         "この夢はほんのはじまりにすぎない",
                                                                                                                                         "黄金の羊を探す長い夢の旅はこれから始まるんだ"]
)

let sheepMan1 : talkListStruct = talkListStruct(id: 1, character: "sheepman", storyLevel: 100, sheep: 1, drinkUsed: 0, sheepLevel: [1,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["...",
                                                                                                                                                       "お前羊数える気ないだろ？",
                                                                                                                                                       "あるいは本当に疲れてるのか？",
                                                                                                                                                       "もし疲れているのなら栄養ドリンクを使うことをお勧めしよう",
                                                                                                                                                       "栄養ドリンクは強化メニューから買うことができるぞ",
                                                                                                                                                       "ただし、栄養ドリンクを使うには夢のかけらが必要だ",
                                                                                                                                                       "あるいは広告を見てもらうこともできる"
                                                                                                                                                ])
let sheepMan2 : talkListStruct = talkListStruct(id: 1, character: "sheepman", storyLevel: 1, sheep: 10000, drinkUsed: 0, sheepLevel: [1,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["やあ。また会ったな。",
"羊を数えるのは大変か？",
"それも慣れてくれば数える効率も上がってくるぞ",
"強化メニューは使っているか？",
"羊をレベルアップすれば数えられる羊の数が増えるんだ",
"それにもしからしたら羊のレベルが見る夢に影響を与えるかもしれない",
"たくさんの羊を数えるには必須だと思うぞ"
])


let sheepMan3 : talkListStruct = talkListStruct(id: 2, character: "sheepman", storyLevel: 1, sheep: 100, drinkUsed: 1, sheepLevel: [1,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["お前本気か？",
"ドリンクを飲んだみたいだな",
"夢のかけらを使って買えるものは他にもあるらしい",
"だが今は買えないかもしれない",
"匹数えた程度で満足してらないないな"])


let sheepMan4 : talkListStruct = talkListStruct(id: 3, character: "sheepman", storyLevel: 1, sheep: 10000, drinkUsed: 0, sheepLevel: [2,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["羊に数え慣れてくると",
"羊のレベルが上がるのはもうわかっているな？",
"よりたくさんの羊を数えたければ、羊のレベル上げは大切だ",
"だが、羊の数だけで見る夢が決まるはずもまないよな",
"どのように羊を数えたかも夢に作用する",
"あと目覚めてからがっかりされても困るから先に言っとくと",
"寝ると羊のレベルはリセットされるから"])

let defaultTalkList : talkListStruct = talkListStruct(id: 90000, character: "sheepman", storyLevel: 1, sheep: 1000, drinkUsed: 0, sheepLevel: [2,0,0,0,0,0,0], areaLevel: [0,0,0,0,0], talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])


let talkListDictionary : [Int : talkListStruct] = [90000 : defaultTalkList,
                                                   
                                                   10000 : sheepMan0,
                                                   
                                                   11001 : sheepMan1,
                                                   11001 : sheepMan2,
                                                   
                                                   11111 : sheepMan3,
                                                   11121 : sheepMan3,
                                                   11131 : sheepMan3,
                                                   11141 : sheepMan3,
                                                   11151 : sheepMan3,
                                                   11161 : sheepMan3,
                                                   11171 : sheepMan3,
                                                   11181 : sheepMan3,
                                                   11191 : sheepMan3,
                                                   11211 : sheepMan3,
                                                   11221 : sheepMan3,
                                                   11231 : sheepMan3,
                                                   11241 : sheepMan3,
                                                   11251 : sheepMan3,
                                                   11261 : sheepMan3,
                                                   11271 : sheepMan3,
                                                   11281 : sheepMan3,
                                                   11291 : sheepMan3,
                                                   
                                                   11201 : sheepMan4,
                                                   11301 : sheepMan4,
                                                   11401 : sheepMan4
                                                   
                                                   ]

