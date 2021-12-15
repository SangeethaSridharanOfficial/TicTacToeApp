//
//  GameViewController.swift
//  TicTacToe
//
//  Created by user202299 on 12/12/21.
//

import UIKit

class GameViewController: UIViewController {
    var clickedIdentifiers: [String: String] = [:]
    var diagonalCoords: Set = [["00", "11", "22"], ["02", "11", "20"]]
    var isDiagonal: Set = ["00", "11", "22", "02", "20"]
    var currentPlayer = "X";
    var isGameOver = false;
    var xPlayerName: String = "";
    var oPlayerName: String = "";
    var clickedBoardCount = 0;
    
    @IBOutlet weak var oponentOPlayer: UILabel!
    @IBOutlet weak var curXPlayer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        print("val ", oPlayerName);
        oponentOPlayer.text = oPlayerName;
        curXPlayer.text = xPlayerName;
    }
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn8: UIButton!
    
    func refreshView(){
        btn1.setTitle("", for: .normal)
        btn2.setTitle("", for: .normal)
        btn3.setTitle("", for: .normal)
        btn4.setTitle("", for: .normal)
        btn5.setTitle("", for: .normal)
        btn6.setTitle("", for: .normal)
        btn7.setTitle("", for: .normal)
        btn8.setTitle("", for: .normal)
        btn9.setTitle("", for: .normal)
        clickedIdentifiers = [:]
        currentPlayer = "X"
        isGameOver = false
        clickedBoardCount = 0;
        
    }
    
    @IBAction func boardBtnClicked(_ sender: UIButton) {
        
        if sender.accessibilityIdentifier != nil && isGameOver == false {
            let identifier = sender.accessibilityIdentifier!;
            sender.setTitle(currentPlayer, for: .normal)
            if (clickedIdentifiers[identifier] == nil){
                clickedBoardCount = clickedBoardCount + 1;
                clickedIdentifiers[identifier] = currentPlayer;
                if clickedIdentifiers.count >= 5{
                    var count = 0;
                    if isDiagonal.contains(identifier){
                        for diagonal in diagonalCoords{
                            
                            diagonal.forEach{val in
                                if clickedIdentifiers[val] == currentPlayer{
                                    count = count + 1;
                                }
                            }
                            if count == 3{
                                isGameOver = true;
                                print(currentPlayer + " Wins the game");
                                var winner = "You"
                                if currentPlayer != "X" {
                                    winner = oPlayerName
                                }
                                insertPlayersInDB(winner: winner)
                                showAlert(title: "Game Over!!!" , message: winner + " Won the game")
                                count = 0;
                                break;
                            }
                            count = 0
                        }
                    }
                    if(count != 3){
                        var clickedVal = identifier.first
                        count = 0;
                        for row in (0...2) {
                            let horCoords = "\(clickedVal!)\(row)"
                            if clickedIdentifiers[horCoords] == currentPlayer {
                                count = count + 1
                            }
                        }
                        if count == 3 {
                            print(currentPlayer + " Wins the game")
                            var winner = "You"
                            if currentPlayer != "X" {
                                winner = oPlayerName
                            }
                            insertPlayersInDB(winner: winner)
                            isGameOver = true;
                            showAlert(title: "Game Over!!!" , message: winner + " Won the game")
                        }else{
                            count = 0;
                            clickedVal = identifier.last
                            for column in (0...2) {
                                let verCoords = "\(column)\(clickedVal!)"
                                if clickedIdentifiers[verCoords] == currentPlayer {
                                    count = count + 1
                                }
                            }
                            
                            if count == 3 {
                                print(currentPlayer + " Wins the game")
                                var winner = "You"
                                if currentPlayer != "X" {
                                    winner = oPlayerName
                                }
                                insertPlayersInDB(winner: winner)
                                isGameOver = true;
                                showAlert(title: "Game Over!!!" , message: winner + " Won the game")
                                
                            }
                        }
                    }
                    if clickedBoardCount == 9 && isGameOver == false {
                        isGameOver = true;
                        showAlert(title: "Game Over!!!" , message: "Match is draw")
                        
                    }
                }
                if currentPlayer == "O"{
                    currentPlayer = "X"
                }else{
                    currentPlayer = "O"
                }
            }else{
                //todo
                print("Already Clicked");
            }
        }
        
    }
    
    func insertPlayersInDB(winner: String){
        let playerName = xPlayerName;
        let opponentName = oPlayerName;
        ScoreBoardServices.shared.insertScoreData(playerName: playerName, opponentName: opponentName, winnerName: winner, date: Date().description);
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Replay", style: UIAlertAction.Style.default, handler: {_ in
            self.refreshView();
        }))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
