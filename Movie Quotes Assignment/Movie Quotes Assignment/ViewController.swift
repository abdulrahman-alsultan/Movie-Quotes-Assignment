//
//  ViewController.swift
//  Movie Quotes Assignment
//
//  Created by admin on 19/12/2021.
//

import UIKit

struct Movie{
    var name: String
    var image: UIImage
    var quotes: String
}




class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedMovies: [Movie] = []
    
    // Star-Wars
    
    let movies: [Movie] = [
        Movie(name: "Gone With the Wind", image: UIImage(named: "The-Godfather")!, quotes: "Frankly, my dear, I don't give a damn."),
        Movie(name: "Star Wars", image: UIImage(named: "Star-Wars")!, quotes: "May the Force be with you."),
        Movie(name: "The Wizard of Oz", image: UIImage(named: "he-Wizard-of-Oz")!, quotes: "There's no place like home."),
        Movie(name: "Titanic", image: UIImage(named: "he-Wizard-of-Oz")!, quotes: "I'm the king of the world!"),
        Movie(name: "Dead Poets Society", image: UIImage(named: "Dead-Poets-Society")!, quotes: "Carpe diem. Seize the day, boys. Make your lives extraordinary."),
        Movie(name: "The Terminator", image: UIImage(named: "The-Terminator")!, quotes: "I'll be back."),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 180)
        
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture: )))
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
    }
    
    
    @objc func swipeFunc(gesture: UISwipeGestureRecognizer){
        if selectedMovies.isEmpty == false{
            performSegue(withIdentifier: "MoveToQuiz", sender: self)
        }
        else{
            let alert = UIAlertController(title: "You must choose at lest one movie", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! QuizViewController
        
        for m in selectedMovies{
            destination.moviesList.append(m)
        }
    }
    
}


extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        
        if cell?.layer.borderWidth == 0{
            cell?.layer.borderColor = UIColor.blue.cgColor
            cell?.layer.borderWidth = 3
            cell?.isSelected = true
            selectedMovies.append(movies[indexPath.row])
        }
        else{
            for i in 0..<selectedMovies.count{
                if selectedMovies[i].name == movies[indexPath.row].name && selectedMovies[i].image == movies[indexPath.row].image{
                    selectedMovies.remove(at: i)
                    cell?.layer.borderWidth = 0
                    cell?.isSelected = false
                }
            }
        }
        
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        cell.configure(image: movies[indexPath.row].image, name: movies[indexPath.row].name)
//        cell.isSelected = false
        
        return cell
    }
    
    
    
    
}


extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}
