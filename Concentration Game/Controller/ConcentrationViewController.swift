//
//  ConcentrationViewController.swift
//  Concentration Game
//
//  Created by Henrik Anthony Odden Sandberg on 11.04.2018.
//  Copyright © 2018 Henrik Anthony Odden Sandberg. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var playAgainbtn: UIButton!
    
    @IBOutlet private weak var flipLbl: UILabel!{
        didSet{
            updateFlipCountLbl()
        }
    }
    @IBOutlet private var btnArray: [UIButton]!
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int{
        return (btnArray.count+1)/2
    }
    
    private(set) var flips = 0 { didSet{updateFlipCountLbl()} }
    
    private func updateFlipCountLbl() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : strokeArray[theme ?? emojiArray.count.arc4Randum]
        ]
        
        let attributedString = NSAttributedString(string: "Flips:\(flips)", attributes: attributes)
        flipLbl.attributedText = attributedString
    }
    
    private let strokeArray = [#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton){
        flips += 1
        if let cardNumber = btnArray.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in button array")
        }
    }
    
    var theme: Int?{
        didSet{
            emojiChoices = emojiArray[theme ?? emojiArray.count.arc4Randum]
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private let emojiArray = [
        "⚽️🏀⚾️🏈🎾🏐🏉🎱🏓🏸🥅🏒🏑🏏⛳️🏹🎣🥊🥋🎽⛸🥌🛷🎿",
        "🍏🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥥🥝🍅🍆🥑🥦🥒🌶🌽🥕🥔🥐🥖🥨🧀🍳🥞🥓🥩🍗🍖🌭🍔🍟🍕🥪🌮🌯🥗🥘🥫🍣🍱🥟🍤🍙🍚🍘🥠🍡🍧🍦🥧🍰🎂🍮🍭🍬🍫🍿🍩🍪",
        "🐶🐱🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵🦄",
        "😁😂😊😇😍😋🤪🧐🤩😤🤬🤯😳😱😰🤗🤔🤭🤥🙄😬🤤😪🤢🤮🤐🤧😷🤒🤕🤑🤠😈🤡",
        "🏳️‍🌈🇦🇫🇦🇱🇩🇿🇦🇸🇦🇩🇦🇴🇦🇮🇦🇶🇦🇬🇦🇷🇦🇲🇦🇼🇦🇿🇦🇺🇧🇸🇧🇭🇧🇩🇧🇧🇧🇪🇧🇿🇧🇯🇧🇲🇧🇹🇧🇴🇧🇦🇧🇼🇧🇷🇧🇳🇧🇬🇧🇫🇧🇮🇨🇦🇰🇾🇨🇱🇨🇽🇨🇴🇨🇰🇨🇷🇨🇺🇨🇼🇩🇰🇻🇮🇻🇬🇦🇪🇹🇫🇩🇴🇨🇫🇮🇴🇵🇸🇩🇯🇩🇲🇪🇨🇪🇬🇬🇶🇸🇻🇨🇮🇪🇷🇪🇪🇪🇹🇪🇺🇫🇰🇫🇯🇵🇭🇫🇮🇫🇷🇬🇫🇵🇫🇫🇴🇬🇦🇬🇲🇬🇪🇬🇭🇬🇮🇬🇩🇬🇱🇬🇵🇬🇺🇬🇹🇬🇬🇬🇳🇬🇼🇬🇾🇭🇹🇬🇷🇭🇳🇭🇰🇧🇾🇮🇳🇮🇶🇮🇷🇮🇪🇮🇸🇮🇱🇮🇹🇯🇲🇯🇵🇾🇪🇯🇪🇯🇴🇰🇭🇮🇨🇨🇻🇧🇶🇰🇿🇰🇪🇨🇳🇰🇬🇰🇮🇨🇨🇰🇲🇨🇬🇨🇩🇽🇰🇭🇷🇰🇼🇨🇾🇱🇦🇱🇻🇱🇸🇱🇧🇱🇷🇱🇾🇱🇮🇱🇹🇱🇺🇲🇴🇲🇬🇲🇰🇲🇼🇲🇾🇲🇻🇲🇱🇲🇹🇮🇲🇲🇦🇲🇭🇲🇶🇲🇷🇲🇺🇾🇹🇲🇽🇫🇲🇲🇩🇲🇨🇲🇸🇲🇿🇲🇲🇳🇦🇳🇷🇳🇱🇳🇵🇳🇿🇳🇪🇳🇬🇳🇺🇰🇵🇳🇫🇳🇴🇳🇨🇴🇲🇵🇰🇵🇼🇵🇦🇵🇬🇵🇾🇵🇪🇵🇳🇵🇱🇵🇹🇵🇷🇶🇦🇷🇪🇷🇴🇷🇺🇰🇳🇧🇱🇸🇧🇼🇸🇸🇲🇸🇹🇸🇦🇸🇳🇷🇸🇸🇨🇸🇱🇸🇬🇸🇽🇸🇰🇸🇮🇸🇴🇪🇸🇱🇰🇸🇭🇱🇨🇵🇲🇻🇨🇬🇧🏴󠁧󠁢󠁥󠁮󠁧󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁷󠁬󠁳󠁿🇸🇩🇸🇷🇨🇭🇸🇪🇸🇿🇸🇾🇿🇦🇬🇸🇰🇷🇸🇸🇹🇯🇹🇼🇹🇿🇹🇭🇹🇬🇹🇰🇹🇴🇹🇹🇹🇩🇨🇿🇹🇳🇹🇲🇹🇨🇹🇻🇹🇷🇩🇪🇺🇬🇺🇦🇭🇺🇺🇾🇺🇸🇺🇿🇻🇺🇻🇦🇪🇭🇻🇳🇼🇫🇿🇲🇿🇼🇹🇱🇦🇹🇦🇽"
    ]
    
    private func setNewGame(){
        flips = 0
        updateFlipCountLbl()
        
        emojiChoices = emojiArray[theme ?? emojiArray.count.arc4Randum]
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    @IBAction func playAgainBtnPressed(_ sender: UIButton) {
        setNewGame()
        
        UIView.animate(withDuration: 0.5) {            
            for button in self.btnArray{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = self.strokeArray[self.theme ?? self.strokeArray.count.arc4Randum-1]
            }
        }
    }
    
    private func updateViewFromModel(){
        if btnArray != nil {
            updateFlipCountLbl()
            for index in btnArray.indices {
                let button = btnArray[index]
                let card = game.cards[index]
                
                if card.isFaceUp{
                    button.setTitle(emojiForCard(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0) : strokeArray[theme ?? strokeArray.count.arc4Randum]
                }
                playAgainbtn.isHidden = !isGameOver()
            }
        }
    }
    
    private func isGameOver() -> Bool{
        if game.isGameOver{
            for button in btnArray{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0)
                
                let index = btnArray.index(of: button)
                UIView.animate(withDuration: 0.5) {
                    button.setTitle(self.emojiForCard(for: self.game.cards[index!]), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
            }
        }
        return game.isGameOver
    }
    
    func resetFromOtherVC(){
        if game.isGameOver {
            setNewGame()
        }
    }
    
    //Mark:- Emoji related
    private var emojiChoices: String?
    
    private var emoji = [Card : String]()
    
    private func emojiForCard(for card: Card) -> String{
        if emojiChoices != nil{
            if emoji[card] == nil, emojiChoices!.count > 0{
                let randumStringIndex = emojiChoices!.index(emojiChoices!.startIndex, offsetBy: emojiChoices!.count.arc4Randum)
                emoji[card] = String(emojiChoices!.remove(at: randumStringIndex))
            }
        }
        return emoji[card] ?? "?"
    }
}



extension Int{
    var arc4Randum: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
