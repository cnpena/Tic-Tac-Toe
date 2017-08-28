//
//  chooseIconVC.swift
//  Tic Tac Toe
//
//  Created by Celine Pena on 8/27/17.
//  Copyright © 2017 Celine Pena. All rights reserved.
//
//  Second view controller presented to the user. Allows both players to pick icons to play with.

import UIKit

class chooseIconVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var icons: UICollectionView! //collection view that displays icons
    @IBOutlet weak var chooseIconLabel: UILabel! //label prompting the user to choose an icon
    @IBOutlet weak var backgroundImage: UIImageView! //background image
    
    let playerIcons = [[#imageLiteral(resourceName: "x"),#imageLiteral(resourceName: "o")],[#imageLiteral(resourceName: "rick"), #imageLiteral(resourceName: "morty"), #imageLiteral(resourceName: "Schmeckles"), #imageLiteral(resourceName: "plumbus"), #imageLiteral(resourceName: "meeseeks"), #imageLiteral(resourceName: "meeseeksBox"), #imageLiteral(resourceName: "megaSeed"), #imageLiteral(resourceName: "pickleRick"), #imageLiteral(resourceName: "snowball")],[#imageLiteral(resourceName: "lindaAndBob"), #imageLiteral(resourceName: "tina"), #imageLiteral(resourceName: "louise"), #imageLiteral(resourceName: "gene"),#imageLiteral(resourceName: "kuchiKopi"),#imageLiteral(resourceName: "burger")]]
    var gameType = Int() //game type picked by user, passed from chooseIconVC
    var player1Icon = UIImage() //Icon chosen by player 1, passed to gameVC
    var player2Icon = UIImage() //Icon chosen by player 2, passed to gameVC
    var player1IconChosen = false //boolean to determine which user is picking
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.icons.dataSource = self
        self.icons.delegate = self
        
        //set background based on game type the user chose
        switch gameType {
        case 1:
            backgroundImage.image = #imageLiteral(resourceName: "rickMortybackground")
        case 2:
            backgroundImage.image = #imageLiteral(resourceName: "bobsBurgersBackground")
        default:
            break
        }
    }
    
    //Number of icons shown
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerIcons[gameType].count
    }
    
    //set image for each icon shown
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! iconCell
        cell.iconImage.image = playerIcons[gameType][indexPath.row]
        return cell
    }
    
    //set size for the icons shown
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let cellWidth = view.bounds.size.width/4
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    //handles when the user picks an icon
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! iconCell
        
        if(!player1IconChosen){ //player 1 is choosing
            player1Icon = playerIcons[gameType][indexPath.row] //assign var player1Icon to chosen icon
            cell.iconImage.alpha = 0.3 //make this icon transparent
            chooseIconLabel.text = "Player 2, choose your icon" //now prompt player 2 to chose icon
            player1IconChosen = true
        }else{ //player 2 is choosing
            player2Icon = playerIcons[gameType][indexPath.row] //assign var player2Icon to chosen icon
            if(player2Icon == player1Icon){ //check if player 2 chooses the same icon as player 1
                chooseIconLabel.text = "Please choose another icon" //prompt user to pick another
            }else{
                 performSegue(withIdentifier: "toGame", sender: self) //otherwise, move onto game
            }
        }
    }
    
    //pass the game type, and player icons to gameVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            if let toViewController = segue.destination as? gameVC {
                toViewController.player1Icon = player1Icon
                toViewController.player2Icon = player2Icon
                toViewController.gameType = gameType
            }
        }
    }
}
