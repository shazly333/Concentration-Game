//
//  ViewController.swift
//  Concenteration
//
//  Created by El-Shazly on 6/12/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import UIKit

class ConcentrationController: UIViewController {


   
    @IBOutlet private weak var NumberOfFlips: UILabel!{
        didSet{
            flipsCount = 0
        }
    }
    lazy private var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (cardsButton.count + 1) / 2
    }
    @IBOutlet private var cardsButton: [UIButton]!
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    private var emoji = [Card: String]()
    
    private(set) var flipsCount = 0 {
        didSet {
            let attributes: [NSAttributedStringKey: Any] = [
                .strokeWidth: 5.0,
                .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            ]
            let attributedString = NSAttributedString(string: "Flips: \(flipsCount)", attributes: attributes)
            NumberOfFlips.attributedText = attributedString
        }
    }
    @IBAction func NewGame(_ sender: Any) {
            let newGame = Concentration(numberOfPairsOfCards: (cardsButton.count+1)/2)
            game = newGame
            NumberOfFlips.text = "Flips: 0"
            flipsCount = 0
            emoji.removeAll()
            for button in cardsButton.indices{
            cardsButton[button].setTitle("", for: UIControlState.normal)
            cardsButton[button].backgroundColor =  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

        }
         Card.identifierFactory = 0
          emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"

        

    }
    @IBAction func touchCard(_ sender: UIButton) {
       flipsCount += 1
        if  let cardNumber = cardsButton.index(of: sender) {
            game.choosenCard(at: cardNumber)
            updateView()
        }
        else {
            print("choosen card was not in cardButtons")
        }

    }
   private func updateView(){
        for index in cardsButton.indices {
            let button = cardsButton[index]
            let card = game.cards[index]
            if card.isFaced {
                button.setTitle(getEmoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    private func getEmoji(for card:Card)->String{
        if emoji[card] == nil, emojiChoices.count > 0{
            let indexOfEmoji = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emoji[card] = String(emojiChoices.remove(at: indexOfEmoji))
        }
        
        
        return emoji[card] ?? "?"
    }
    

}
extension Int {
        var arc4Random: Int {
            switch self {
            case 1...Int.max:
                return Int(arc4random_uniform(UInt32(self)))
            case -Int.max..<0:
                return -Int(arc4random_uniform(UInt32(-self)))
            default:
                return 0
            }
            
        }
    }


