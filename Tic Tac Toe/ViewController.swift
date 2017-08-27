//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Celine Pena on 8/24/17.
//  Copyright © 2017 Celine Pena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var displayWinnerLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var chooseGameView: UIView!
    @IBOutlet weak var displayturnLabel: UILabel!
    
    var activePlayer = 1 //player 1 = x, player 2 = o (initially x)
    var gameState = [0,0,0,
                     0,0,0,
                     0,0,0] //initial game board is blank
    let winningBoards = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
                        //indices of three markers in a column, row, or diagnol
    var gameIsActive = true //true while game is playing, false when player wins or draws
    //Game Design options: Classic(0), Rick and Morty(1), Bob's burgers(2)
    var gameDesign = Int() //Integer value that is set when a user plays a design
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func squareTapped(_ sender: UIButton) {
        
        if(gameState[sender.tag-1] == 0 && gameIsActive){ //if the square tapped is empty, allow the user to place their token
            gameState[sender.tag-1] = activePlayer
            
            if(activePlayer == 1){
                if(gameDesign == 0){
                    sender.setImage(#imageLiteral(resourceName: "x"), for: .normal)
                }else if(gameDesign == 1){
                    sender.setImage(#imageLiteral(resourceName: "plumbus"), for: .normal)
                }else{
                    sender.setImage(#imageLiteral(resourceName: "kuchiKopi"), for: .normal)
                }
                activePlayer = 2
            }else{
                if(gameDesign == 0){
                    sender.setImage(#imageLiteral(resourceName: "o"), for: .normal)
                }else if(gameDesign == 1){
                    sender.setImage(#imageLiteral(resourceName: "Schmeckles"), for: .normal)
                }else{
                    sender.setImage(#imageLiteral(resourceName: "burger"), for: .normal)
                }
                activePlayer = 1
            }
        }
        
        for board in winningBoards{
            if (gameState[board[0]] != 0 && gameState[board[0]] == gameState[board[1]] && gameState[board[1]] == gameState[board[2]]){
            
                if(gameState[board[0]] == 1){
                    displayWinnerLabel.text = "Player 1 wins!"
                }else{
                    displayWinnerLabel.text = "Player 2 wins!"
                }
                playAgainButton.isHidden = false
                gameIsActive = false
                return
            }
        } //end for board in winningBoards()
        
        gameIsActive = false
        for i in gameState{
            if i == 0{
                gameIsActive = true
                break
            }
        }
        
        if (!gameIsActive){
            displayWinnerLabel.text = "It was a tie!"
            playAgainButton.isHidden = false
        }
        
        displayturnLabel.text = "Player " + String(activePlayer) + "'s turn!"
    } //end squareTapped()

    @IBAction func gameTypeTapped(_ sender: UIButton) {
        chooseGameView.isHidden = true
        if(sender.tag == 10){
            gameDesign = 0
            backgroundImage.isHidden = true
            displayWinnerLabel.textColor = UIColor.black
        }else if(sender.tag == 11){
            gameDesign = 1
            backgroundImage.isHidden = false
            backgroundImage.image = #imageLiteral(resourceName: "rickMortybackground")
            displayWinnerLabel.textColor = UIColor.white
        }else if(sender.tag == 12){
            gameDesign = 2
            backgroundImage.isHidden = false
            backgroundImage.image = #imageLiteral(resourceName: "bobsBurgersBackground")
            displayWinnerLabel.textColor = UIColor.white
        }
    }
    
    @IBAction func playAgainTapped(_ sender: UIButton) {
        chooseGameView.isHidden = false
        gameState = [0,0,0,0,0,0,0,0,0]
        activePlayer = randomInt(min: 1, max: 2)
        sender.isHidden = true
        gameIsActive = true
        displayWinnerLabel.text = ""
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
        }
    } //end playAgainTapped
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}

