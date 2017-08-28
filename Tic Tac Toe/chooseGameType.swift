//
//  chooseGameType.swift
//  Tic Tac Toe
//
//  Created by Celine Pena on 8/27/17.
//  Copyright © 2017 Celine Pena. All rights reserved.
//

import UIKit

class chooseGameType: UIViewController {

    var gameType = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        performSegue(withIdentifier: "toChooseIcon", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toChooseIcon" {
            if let toViewController = segue.destination as? chooseIconVC {
                toViewController.gameType = gameType
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
