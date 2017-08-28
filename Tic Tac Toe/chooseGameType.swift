//
//  chooseGameType.swift
//  Tic Tac Toe
//
//  Created by Celine Pena on 8/27/17.
//  Copyright © 2017 Celine Pena. All rights reserved.
//
//  First view controller presented to the user. Gives them a choice between three game choices:
//  classic(0), Rick and Morty(1) or Bob's Burgers(2). Once the user has chosen an option, presented with the next
//  screen to pick icons to play with.

import UIKit

class chooseGameType: UIViewController {

    var gameType = Int() //game type picked by user, passed onto chooseIconVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(true, animated: false) //hide navigation bar on all screens
    }
    
    //called when the user picks one of the 3 options
    @IBAction func gameTypeTapped(_ sender: UIButton) {
        switch sender.tag {
        case 10: //classic design
            gameType = 0
        case 11: //rick and morty design
            gameType = 1
        case 12: //bob's burgers design
            gameType = 2
        default:
            break
        }
        performSegue(withIdentifier: "toChooseIcon", sender: self) //move to next screen to choose icons
    }

    //pass game type to next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChooseIcon" {
            if let toViewController = segue.destination as? chooseIconVC {
                toViewController.gameType = gameType
            }
        }
    }
}
