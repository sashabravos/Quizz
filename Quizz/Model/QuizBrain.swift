//
//  QuizBrain.swift
//  Quizz
//
//  Created by Александра Кострова on 15.02.2023.
//

import AVFoundation
import Foundation

struct QuizBrain {
    var player: AVAudioPlayer?
    var currentQuestion = 0
    var rightAnswer = 0
    var progress: Float = 0.0
    let fullProgress: Float = 1.0
    let quizQuestions = [
        Question(text: "The atomic number for lithium is 17", answer: "False"), // "- it's 3"
        Question(text: "A cross between a horse and a zebra is called a 'Hobra'", answer: "False"),
        // - A male zebra and a female horse is called a 'zorse',
        // and a female zebra and a male horse is called a 'zonkey
        Question(text: "Alliumphobia is a fear of garlic", answer: "True"),
        Question(text: "M&M stands for Mars and Moordale", answer: "False"),// "- M&M stands for Mars and Murrie"
        Question(text: "The unicorn is the national animal of Scotland", answer: "True"),
        Question(text: "There are two parts of the body that can't heal themselves", answer: "False"),
        // "- there's only one: the teeth."
        Question(text: "Your 'radius' bone is in your leg", answer: "False"),
        // - it's one of the biggest bones in your forearm
        Question(text: "Hillary Clinton and Celine Dion are related", answer: "False"),
        Question(text: "Cardi B's real name is Cardigan Backyardigan", answer: "False"),
        // - that was a meme. Her real name is Belcalis Marlenis Almánzar.
        Question(text: "Fish cannot blink", answer: "True")
    ]
    mutating func checkAswer(_ userAswer: String) -> Bool {
        if userAswer == quizQuestions[ currentQuestion ].answer {
            rightAnswer += 1
            return true
        } else { return false }
    }
    mutating func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try? AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    mutating func updateProgress() -> Float {
        progress += fullProgress / Float(quizQuestions.count)
        return progress
    }
    mutating func updateLabelText() -> String {
        currentQuestion += 1
        if currentQuestion < quizQuestions.count {
            return quizQuestions[currentQuestion].text
        } else {
            return """
            It's all!
            \(rightAnswer)/\(quizQuestions.count)
            """ }
    }
}
