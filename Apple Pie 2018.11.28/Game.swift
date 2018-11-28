//
//  game.swift
//  Apple Pie 2018.11.27
//
//  Created by Vdovin Aleksey on 27/11/2018.
//  Copyright © 2018 Vdovin Aleksey. All rights reserved.
//

import Foundation

struct Game {
    
    // загаданное слово
    var word: String
    
    // количество оставшихся попыток
    var incorrectMovesRemaining: Int
    
    // список нажатых букв
    var guessedLetters: [Character]
    
    // отображаемое слово
    var formattedWord: String {
        var guessedWord = ""
        
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        
        return guessedWord
    }
    
    // обработка нажатой буквы
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        
        // проверяем содержится ли буква в слове
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
