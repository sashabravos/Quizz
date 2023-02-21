//
//  ViewController.swift
//  Quizz
//
//  Created by Александра Кострова on 10.02.2023.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    private lazy var stackView = UIStackView()
    private lazy var questionLabel = UILabel()
    private lazy var progressView = UIProgressView()
    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackground(currentBackground: "backgroundImage")
        addStackView()
        addToStackView()
    }

    private func addBackground(currentBackground: String) {
        let backgroundImage = UIImageView.init(image: UIImage(named: currentBackground) ?? UIImage())
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
    }
    private func addStackView() {
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = Constants.mainStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
    }
    private func addToStackView() {
        questionLabel.text = quizBrain.quizQuestions[quizBrain.currentQuestion].text
        questionLabel.numberOfLines = 0
        questionLabel.textColor = .black
        questionLabel.font = .systemFont(ofSize: Constants.labelFontSize)
        questionLabel.textAlignment = .center
        questionLabel.highlightedTextColor = .systemGray
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(questionLabel)
        createButton(title: "True")
        createButton(title: "False")
        progressView.progressViewStyle = .bar
        progressView.setProgress(0.0, animated: true)
        progressView.progressTintColor = .systemRed
        progressView.trackTintColor = .systemGray
        stackView.addArrangedSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    private func createButton(title: String) {
        let button = UIButton()
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize, weight: .semibold)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.masksToBounds = true
        button.layer.borderWidth = Constants.buttonBorderWidth
        stackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        button.addTarget(self, action: #selector(buttonPressed(currentButton:)), for: .touchUpInside)
    }

    @objc func buttonPressed(currentButton: UIButton) {
        let userAswer = currentButton.currentTitle!
        if quizBrain.currentQuestion < quizBrain.quizQuestions.count {
            if quizBrain.checkAswer(userAswer) {
                currentButton.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                quizBrain.playSound(soundName: "correctAnswer")
            } else {
                currentButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                quizBrain.playSound(soundName: "incorrectAswer")
            }
        } else {
            quizBrain.progress = 0.0
            quizBrain.currentQuestion = 0
            quizBrain.rightAnswer = 0
            quizBrain.playSound(soundName: "correctAnswer")
        }
        UIView.animate(withDuration: 0.2,
                       delay: 0.2,
                       animations: { currentButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)})
        questionLabel.text = quizBrain.updateLabelText()
        progressView.progress = quizBrain.updateProgress()
    }
    private enum Constants {
        static let mainStackViewSpacing: CGFloat = 10.0
        static let labelFontSize: CGFloat = 30.0
        static let buttonHeight: CGFloat = 80.0
        static let buttonFontSize: CGFloat = 35.0
        static let buttonCornerRadius: CGFloat = 15.0
        static let buttonBorderWidth: CGFloat = 2.0
    }
}
