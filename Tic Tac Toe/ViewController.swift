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
                        //indices of three markers in a column, row, or diagonal
    var gameIsActive = true //true while game is playing, false when player wins or draws
    
    //Game Design options: Classic(0), Rick and Morty(1), Bob's burgers(2)
    var gameDesign = Int() //Integer value that is set when a user plays a design
    
    //array of images to be used as markers for each player on the board
    let player1Images = [#imageLiteral(resourceName: "x"), #imageLiteral(resourceName: "plumbus"), #imageLiteral(resourceName: "kuchiKopi")]
    let player2Images = [#imageLiteral(resourceName: "o"), #imageLiteral(resourceName: "Schmeckles"), #imageLiteral(resourceName: "burger")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func squareTapped(_ sender: UIButton) {
        
        if(gameState[sender.tag-1] == 0 && gameIsActive){ //if the square tapped is empty, allow the user to place their token
            gameState[sender.tag-1] = activePlayer //set index of the square the user chose as 1 or 2 to indicate who placed it
            
            if(activePlayer == 1){
                sender.setImage(player1Images[gameDesign], for: .normal) //set image inside square based on game design the user chose initially
                activePlayer = 2 //switch active player to player 2
            }else{
                sender.setImage(player2Images[gameDesign], for: .normal) //set image inside square based on game design the user chose initially
                activePlayer = 1 //switch active player to player 1
            }
        }
        
        for board in winningBoards{ //checks current board against winning combinations
            if (gameState[board[0]] != 0 && gameState[board[0]] == gameState[board[1]] && gameState[board[1]] == gameState[board[2]]){
            
                if(gameState[board[0]] == 1){
                    displayWinnerLabel.text = "Player 1 wins!"
                }else{
                    displayWinnerLabel.text = "Player 2 wins!"
                }
                
                //someone has won, so show button to play again, game is no longer active
                playAgainButton.isHidden = false
                gameIsActive = false
                return
            }
        } //end for board in winningBoards()
        
        gameIsActive = false
        
        //checks if theres any empty spaces left in board or we've ended in a tie
        for i in gameState {
            if i == 0 {
                gameIsActive = true
                break
            }
        }
        
        if (!gameIsActive){ //game ended in a tie
            displayWinnerLabel.text = "It was a tie!"
            playAgainButton.isHidden = false
        }
        
        displayturnLabel.text = "Player " + String(activePlayer) + "'s turn!" //display whose turn at the top of the screen
    } //end squareTapped()

    //called when the user taps one of the three options presented at the beginning of a game
    @IBAction func gameTypeTapped(_ sender: UIButton) {
        chooseGameView.isHidden = true //hide view that presents options
        
        switch sender.tag {
        case 10: //classic design
            gameDesign = 0
            backgroundImage.isHidden = true
            displayWinnerLabel.textColor = UIColor.black
        case 11: //rick and morty design
            gameDesign = 1
            backgroundImage.isHidden = false
            backgroundImage.image = #imageLiteral(resourceName: "rickMortybackground")
            displayWinnerLabel.textColor = UIColor.white
        case 12: //bob's burgers design
            gameDesign = 2
            backgroundImage.isHidden = false
            backgroundImage.image = #imageLiteral(resourceName: "bobsBurgersBackground")
            displayWinnerLabel.textColor = UIColor.white
        default:
            break
        }
    }
    
    //clears everything when the user taps the play again button
    @IBAction func playAgainTapped(_ sender: UIButton) {
        chooseGameView.isHidden = false //presented with the option to choose a new design
        gameState = [0,0,0,0,0,0,0,0,0] //resets game board
        activePlayer = randomInt(min: 1, max: 2) //chooses a random int, either 1 or 2 as first player
        sender.isHidden = true //hide play again button
        gameIsActive = true
        displayWinnerLabel.text = ""
        for i in 1...9{ //reset button images on board
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
        }
    } //end playAgainTapped
    
    //picks a random int
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}

