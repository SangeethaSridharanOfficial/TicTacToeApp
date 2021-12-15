//
//  ViewController.swift
//  TicTacToe
//
//  Created by user202299 on 12/7/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var playerDB = ScoreBoard();
    }
    
    
    @IBOutlet weak var playerName: UITextField!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playersVC = segue.destination as! PlayersController
        if playerName.text == nil || (playerName.text ?? "").isEmpty {
            let alert = UIAlertController(title: "Error!!", message: "Please enter username to proceed!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }else{
            playersVC.xPlayerName = playerName.text!;
        }
        
    }


}

