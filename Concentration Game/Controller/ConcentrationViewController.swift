//
//  ConcentrationViewController.swift
//  Concentration Game
//
//  Created by Henrik Anthony Odden Sandberg on 11.04.2018.
//  Copyright © 2018 Henrik Anthony Odden Sandberg. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    //MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewGame()
    }
    
    //MARK: Outlets
    @IBOutlet private weak var playAgainButton: UIButton!
    
    @IBOutlet private weak var flipLbl: UILabel!{
        didSet{
            updateFlipCountLbl()
        }
    }
    @IBOutlet private var arrayOfCardButtons: [UIButton]!
    
    
    //MARK:- Actions
    @IBAction func touchCard(_ sender: UIButton){
        flips += 1
        if let cardNumber = arrayOfCardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in button array")
        }
    }
    
    @IBAction func playAgainBtnPressed(_ sender: UIButton) {
        setNewGame()
        
        UIView.animate(withDuration: 0.5) {            
            for button in self.arrayOfCardButtons{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = self.strokeArray[self.theme!]
            }
        }
    }
    
    //MARK:- Variables
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int{return (arrayOfCardButtons.count+1)/2}
    
    private(set) var flips = 0 { didSet{updateFlipCountLbl()} }
    
    private let strokeArray = [#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)]
    private var strokeColor = 0
    
    
    //MARK: - Private Functions
    private func setNewGame(){
        emojiChoices = emojiArray[theme ?? {() -> Int in
            self.theme = self.emojiArray.count.arc4Randum
            return self.theme!
            }()]
        
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
        flips = 0
    }
    
    private func isGameOver() -> Bool{
        if game.isGameOver{
            for button in arrayOfCardButtons{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0)
                
                let index = arrayOfCardButtons.index(of: button)
                UIView.animate(withDuration: 0.5) {
                    button.setTitle(self.emojiForCard(for: self.game.cards[index!]), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
            }
            playAgainButton.setTitleColor(strokeArray[strokeColor], for: .normal)
        }
        return game.isGameOver
    }
    
    //MARK:- Update UI elemnts
    private func updateViewFromModel(){
        if arrayOfCardButtons != nil {
            for index in arrayOfCardButtons.indices {
                let button = arrayOfCardButtons[index]
                let card = game.cards[index]
                
                if card.isFaceUp{
                    button.setTitle(emojiForCard(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0) : strokeArray[strokeColor]
                }
                playAgainButton.isHidden = !isGameOver()
            }
            updateFlipCountLbl()
        }
    }
    
    private func updateFlipCountLbl() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : strokeArray[strokeColor]
        ]
        
        let attributedString = NSAttributedString(string: "Flips:\(flips)", attributes: attributes)
        flipLbl.attributedText = attributedString
    }
    
    //MARK:- Public API
    var theme: Int?{
        didSet{
            if theme == 5 {theme = emojiArray.count.arc4Randum}
            
            emojiChoices = emojiArray[theme ?? emojiArray.count.arc4Randum]
            emoji = [:]
            
            strokeColor = strokeArray.count.arc4Randum
            
            updateViewFromModel()
        }
    }
    
    func resetFromOtherVC(){
        if game.isGameOver {
            setNewGame()
        }
    }
    
    //MARK:- Emoji related
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
    
    private let emojiArray = [
        "⚽️🏀⚾️🏈🎾🏐🏉🎱🏓🏸🥅🏒🏑🏏⛳️🏹🎣🥊🥋🎽⛸🥌🛷🎿",
        "🍏🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥥🥝🍅🍆🥑🥦🥒🌶🌽🥕🥔🥐🥖🥨🧀🍳🥞🥓🥩🍗🍖🌭🍔🍟🍕🥪🌮🌯🥗🥘🥫🍣🍱🥟🍤🍙🍚🍘🥠🍡🍧🍦🥧🍰🎂🍮🍭🍬🍫🍿🍩🍪",
        "🐶🐱🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵🦄",
        "😁😂😊😇😍😋🤪🧐🤩😤🤬🤯😳😱😰🤗🤔🤭🤥🙄😬🤤😪🤢🤮🤐🤧😷🤒🤕🤑🤠😈🤡",
        "🏳️‍🌈🇦🇫🇦🇱🇩🇿🇦🇸🇦🇩🇦🇴🇦🇮🇦🇶🇦🇬🇦🇷🇦🇲🇦🇼🇦🇿🇦🇺🇧🇸🇧🇭🇧🇩🇧🇧🇧🇪🇧🇿🇧🇯🇧🇲🇧🇹🇧🇴🇧🇦🇧🇼🇧🇷🇧🇳🇧🇬🇧🇫🇧🇮🇨🇦🇰🇾🇨🇱🇨🇽🇨🇴🇨🇰🇨🇷🇨🇺🇨🇼🇩🇰🇻🇮🇻🇬🇦🇪🇹🇫🇩🇴🇨🇫🇮🇴🇵🇸🇩🇯🇩🇲🇪🇨🇪🇬🇬🇶🇸🇻🇨🇮🇪🇷🇪🇪🇪🇹🇪🇺🇫🇰🇫🇯🇵🇭🇫🇮🇫🇷🇬🇫🇵🇫🇫🇴🇬🇦🇬🇲🇬🇪🇬🇭🇬🇮🇬🇩🇬🇱🇬🇵🇬🇺🇬🇹🇬🇬🇬🇳🇬🇼🇬🇾🇭🇹🇬🇷🇭🇳🇭🇰🇧🇾🇮🇳🇮🇶🇮🇷🇮🇪🇮🇸🇮🇱🇮🇹🇯🇲🇯🇵🇾🇪🇯🇪🇯🇴🇰🇭🇮🇨🇨🇻🇧🇶🇰🇿🇰🇪🇨🇳🇰🇬🇰🇮🇨🇨🇰🇲🇨🇬🇨🇩🇽🇰🇭🇷🇰🇼🇨🇾🇱🇦🇱🇻🇱🇸🇱🇧🇱🇷🇱🇾🇱🇮🇱🇹🇱🇺🇲🇴🇲🇬🇲🇰🇲🇼🇲🇾🇲🇻🇲🇱🇲🇹🇮🇲🇲🇦🇲🇭🇲🇶🇲🇷🇲🇺🇾🇹🇲🇽🇫🇲🇲🇩🇲🇨🇲🇸🇲🇿🇲🇲🇳🇦🇳🇷🇳🇱🇳🇵🇳🇿🇳🇪🇳🇬🇳🇺🇰🇵🇳🇫🇳🇴🇳🇨🇴🇲🇵🇰🇵🇼🇵🇦🇵🇬🇵🇾🇵🇪🇵🇳🇵🇱🇵🇹🇵🇷🇶🇦🇷🇪🇷🇴🇷🇺🇰🇳🇧🇱🇸🇧🇼🇸🇸🇲🇸🇹🇸🇦🇸🇳🇷🇸🇸🇨🇸🇱🇸🇬🇸🇽🇸🇰🇸🇮🇸🇴🇪🇸🇱🇰🇸🇭🇱🇨🇵🇲🇻🇨🇬🇧🏴󠁧󠁢󠁥󠁮󠁧󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁷󠁬󠁳󠁿🇸🇩🇸🇷🇨🇭🇸🇪🇸🇿🇸🇾🇿🇦🇬🇸🇰🇷🇸🇸🇹🇯🇹🇼🇹🇿🇹🇭🇹🇬🇹🇰🇹🇴🇹🇹🇹🇩🇨🇿🇹🇳🇹🇲🇹🇨🇹🇻🇹🇷🇩🇪🇺🇬🇺🇦🇭🇺🇺🇾🇺🇸🇺🇿🇻🇺🇻🇦🇪🇭🇻🇳🇼🇫🇿🇲🇿🇼🇹🇱🇦🇹🇦🇽"
    ]
}
