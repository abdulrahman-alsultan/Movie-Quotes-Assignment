//
//  QuizViewController.swift
//  Movie Quotes Assignment
//
//  Created by admin on 19/12/2021.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var guessMovieTF: UITextField!
    @IBOutlet weak var answerBtn: UIButton!
    @IBOutlet weak var quotesTV: UILabel!
    @IBOutlet weak var scoreTV: UILabel!
    
    var moviesList: [Movie] = []
    var score = 0
    var random = -1
    var correctAnswer = ""
    var totalScore = -1
    
    var currentQuote: Movie? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalScore = moviesList.count
        setQuiz()
    }
    
    func setQuiz(){
        if moviesList.count > 0 {
            random = Int.random(in: 0..<moviesList.count)
            currentQuote = moviesList[random]
            quotesTV.text = currentQuote?.quotes
            correctAnswer = currentQuote!.name
            moviesList.remove(at: random)
        }
        else{
            quotesTV.text = ""
            answerBtn.isHidden = true
            guessMovieTF.isHidden = true
        }
        scoreTV.text = "Score: \(score) out of \(totalScore)"
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        if let answer = guessMovieTF.text, answer.isEmpty == false{
            if answer == correctAnswer{
                score += 1
            }
            setQuiz()
            guessMovieTF.text = ""
        }
        else{
            let alert = UIAlertController(title: "Empty field", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
