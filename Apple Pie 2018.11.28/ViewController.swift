//
//  ViewController.swift
//  Apple Pie 2018.11.27
//
//  Created by Vdovin Aleksey on 27/11/2018.
//  Copyright © 2018 Vdovin Aleksey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // список слов для угадывания
    var listOfWords = [
        "арбуз",
        "банан",
        "вертолет",
        "гномик",
        "домик",
        "стол",
        "телефон",
        "подоконник",
         "половник"
    ]
    
    // количество неверных попыток
    let incorrectMovesAllowed = 7

    // количество выигрышей и проигрышей
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    // текущая игра
    var currentGame: Game!
    
    @IBOutlet weak var pieImageView: UIImageView!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // запуск нового раунда игры
        newRound()
    }
    
    // запуск нового раунда игры
    
    var gameFinished: Bool?
    
    func newRound() {
        if !listOfWords.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(listOfWords.count)))
            let newWord = listOfWords.remove(at: randomIndex)
            
            currentGame = Game(
                word: newWord.lowercased(),
                incorrectMovesRemaining: incorrectMovesAllowed,
                guessedLetters: []
            )
            
            enableLetterButtons(true)
        } else {
           enableLetterButtons(false)
            gameFinished = true
        }
        
                updateUI()
    }
    
    // разрешить/запретить кнопки
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // обновление интерфейса
    
    func updateUI() {
        // обновляем картинку
        let imageName = "ApplePie \(currentGame.incorrectMovesRemaining)"
        let image = UIImage(named: imageName)
        pieImageView.image = image
        
        // обновляем угадываемое слово
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpaces = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpaces
        
        // обновление счета
        scoreLabel.text = "Выигрыши: \(totalWins), Проигрыши: \(totalLosses)"
        
        // завершение игры
        if gameFinished == true {
            correctWordLabel.text = "Игра кончилась, нет слов"
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    // проверяем на окончание игры
    func updateGameState() {
        if currentGame.incorrectMovesRemaining < 1 {
            // проиграли раунд
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            // выиграли раунд
            totalWins += 1
        } else {
        updateUI()
        }
    }
}

