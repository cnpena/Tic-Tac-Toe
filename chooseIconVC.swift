//
//  chooseIconVC.swift
//  Tic Tac Toe
//
//  Created by Celine Pena on 8/27/17.
//  Copyright © 2017 Celine Pena. All rights reserved.
//

import UIKit

class chooseIconVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var icons: UICollectionView!
    @IBOutlet weak var chooseIconLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    var player1IconChosen = false
  
    let playerIcons = [[#imageLiteral(resourceName: "x"),#imageLiteral(resourceName: "o")],[#imageLiteral(resourceName: "rick"), #imageLiteral(resourceName: "morty"), #imageLiteral(resourceName: "Schmeckles"), #imageLiteral(resourceName: "plumbus"), #imageLiteral(resourceName: "meeseeks"), #imageLiteral(resourceName: "meeseeksBox"), #imageLiteral(resourceName: "megaSeed"), #imageLiteral(resourceName: "pickleRick"), #imageLiteral(resourceName: "snowball")],[#imageLiteral(resourceName: "lindaAndBob"), #imageLiteral(resourceName: "tina"), #imageLiteral(resourceName: "louise"), #imageLiteral(resourceName: "gene"),#imageLiteral(resourceName: "kuchiKopi"),#imageLiteral(resourceName: "burger")]]
    var gameType = Int()
    var player1Icon = UIImage()
    var player2Icon = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.icons.dataSource = self
        self.icons.delegate = self
        
        switch gameType {
        case 1:
            backgroundImage.image = #imageLiteral(resourceName: "rickMortybackground")
        case 2:
            backgroundImage.image = #imageLiteral(resourceName: "bobsBurgersBackground")
        default:
            break
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerIcons[gameType].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! iconCell
        cell.iconImage.image = playerIcons[gameType][indexPath.row]
        return cell
    }
    
    //UI: Collection View function that determines the size of the user cards
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let cellWidth = view.bounds.size.width/4
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! iconCell
        if(!player1IconChosen){
            player1Icon = playerIcons[gameType][indexPath.row]
            cell.iconImage.alpha = 0.3
            chooseIconLabel.text = "Player 2, choose your icon"
            player1IconChosen = true
        }else{
            player2Icon = playerIcons[gameType][indexPath.row]
            if(player2Icon == player1Icon){
                chooseIconLabel.text = "Please choose another icon"
            }else{
                 performSegue(withIdentifier: "toGame", sender: self)
            }
        }
    }
    
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
