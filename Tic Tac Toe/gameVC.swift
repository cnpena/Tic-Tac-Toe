//
//  gameVC.swift
//  Tic Tac Toe
//
//  Created by Celine Pena on 8/24/17.
//  Copyright © 2017 Celine Pena. All rights reserved.
//
//  View controller that contains the actual game board. Composed of 9 buttons laid out on the storyboard.

import UIKit

class gameVC: UIViewController {

    @IBOutlet weak var playAgainButton: UIButton! //button to play again (with same options)
    @IBOutlet weak var restartButton: UIButton! //button to restart (goes back to chooseGameType screen)
    @IBOutlet weak var displayWinnerLabel: UILabel! //label below board that displays winner
    @IBOutlet weak var backgroundImage: UIImageView! //background on screen
    @IBOutlet weak var displayturnLabel: UILabel! //label above board that displays whose turn it is
    
    var activePlayer = 1 //Alternates between 1 and 2 to determine whose turn it is
    var gameState = [0,0,0,0,0,0,0,0,0] //initial game board is blank
    let winningBoards = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]] //indices of three in a row
    var gameIsActive = true //true while game is playing, false when player wins or draws
    var gameType = Int() //Game Design options: Classic(0), Rick and Morty(1), Bob's burgers(2), passed from chooseGameType()
    var player1Icon = UIImage() //Icon for player 1, passed from chooseIconVC()
    var player2Icon = UIImage() //Icon for player 2, passed from chooseIconVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set look of view based on what game the user chose
        backgroundImage.isHidden = false
        displayWinnerLabel.textColor = UIColor.black
        switch gameType {
        case 0:
            backgroundImage.isHidden = true
        case 1:
            backgroundImage.image = #imageLiteral(resourceName: "rickMortybackground")
            displayWinnerLabel.textColor = UIColor.white
        case 2:
            backgroundImage.image = #imageLiteral(resourceName: "bobsBurgersBackground")
        default:
            break
        }
    }

    //called when a user taps one of the 9 squares on the board
    @IBAction func squareTapped(_ sender: UIButton) {
        if(gameState[sender.tag-1] == 0 && gameIsActive){ //if square tapped is empty, allow the user to place their token
            gameState[sender.tag-1] = activePlayer //set index of the square the user chose as 1 or 2 to indicate who placed it
            switch activePlayer {
            case 1:
                sender.setImage(player1Icon, for: .normal) //set marker as user's chosen icon
                activePlayer = 2 //switch active player to player 2
            case 2:
                sender.setImage(player2Icon, for: .normal) //set marker as user's chosen icon
                activePlayer = 1 //switch active player to player 1
            default:
                break
            }
        }
        
        for board in winningBoards{ //each time a move is move, checks current board against winning combinations
            if (gameState[board[0]] != 0 && gameState[board[0]] == gameState[board[1]] && gameState[board[1]] == gameState[board[2]]){
            
                if(gameState[board[0]] == 1){
                    displayWinnerLabel.text = "Player 1 wins!"
                }else{
                    displayWinnerLabel.text = "Player 2 wins!"
                }
                
                //someone has won, so show button to play again/restart, game is no longer active
                playAgainButton.isHidden = false
                restartButton.isHidden = false
                gameIsActive = false
                return
            }
        } //end for board in winningBoards()
        
        gameIsActive = false
        
        //if there's empty spaces, game isn't finished, if not, its a draw and game is over
        for i in gameState {
            if i == 0 {
                gameIsActive = true
                break
            }
        }
        
        if (!gameIsActive){ //game ended in a tie, present buttons to play again or restart
            displayWinnerLabel.text = "It was a tie!"
            playAgainButton.isHidden = false
            restartButton.isHidden = false
        }
        
        displayturnLabel.text = "Player " + String(activePlayer) + "'s turn!" //display whose turn at the top of the screen
    } //end squareTapped()

    
    //clears everything when the user taps the play again button
    @IBAction func playAgainTapped(_ sender: UIButton) {
        gameState = [0,0,0,0,0,0,0,0,0] //resets game board
        playAgainButton.isHidden = true //hide play again button
        restartButton.isHidden = true //hide restart button
        gameIsActive = true
        displayWinnerLabel.text = ""
        
        for i in 1...9{ //reset button images on board
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
        }
        
        switch sender.tag {
        case 20: //play again pressed
            activePlayer = randomInt(min: 1, max: 2) //chooses a random int, either 1 or 2 as first player
            displayturnLabel.text = "Player " + String(activePlayer) + "'s turn!"
        case 21: //restart pressed
            navigationController!.popToViewController(navigationController!.viewControllers[0], animated: true)
        default:
            break
        }
    } //end playAgainTapped
    
    //picks a random int
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}

