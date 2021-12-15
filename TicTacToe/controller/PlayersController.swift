//
//  PlayersController.swift
//  TicTacToe
//
//  Created by user202299 on 12/12/21.
//

import UIKit

class PlayersController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var gameBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var xPlayerName = "Guest";
    var allOpponents = [RandomUsers]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameBtn.isHidden = true
        // Do any additional setup after loading the view.
        APIServices.shared.getPlayersFromAPI(handler: {playersResult in
            DispatchQueue.main.async {
                self.allOpponents = playersResult
                self.tableView.reloadData();
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allOpponents.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "players", for: indexPath)
        cell.textLabel?.text = "\(allOpponents[indexPath.row].name.first) \(allOpponents[indexPath.row].name.last)"
        cell.detailTextLabel?.text = allOpponents[indexPath.row].gender
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imgStr = allOpponents[indexPath.row].picture.large;
        let oPlayer = "\(allOpponents[indexPath.row].name.first) \(allOpponents[indexPath.row].name.last)"
        let alert = UIAlertController(title: oPlayer, message: "", preferredStyle: UIAlertController.Style.alert)
        let playAction = UIAlertAction(title: "Play", style: .default, handler: {_ in
                self.gameBtn.sendActions(for: .touchUpInside)
        })
        print("url ", imgStr);
        APIServices.shared.getPlayerImage(url: imgStr, handler: {result in
            switch result{
            case .success(let img):
                DispatchQueue.main.async {
                    
                    alert.addImage(image: img)
                    alert.addAction(playAction);
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameVC"{
            let gameVC = segue.destination as! GameViewController
            gameVC.xPlayerName = self.xPlayerName;
            let selectedIdx = tableView.indexPathForSelectedRow;
            let oPlayer = "\(allOpponents[selectedIdx!.row].name.first) \(allOpponents[selectedIdx!.row].name.last)"
            gameVC.oPlayerName = oPlayer
        }else{
            let scoreBoardVC = segue.destination as! ScoreBoardController
            scoreBoardVC.xPlayerName = xPlayerName;
        }
    }
    

}
