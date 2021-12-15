//
//  ScoreBoardController.swift
//  TicTacToe
//
//  Created by user202299 on 12/13/21.
//

import UIKit
import CoreData

class ScoreBoardController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var xPlayerName: String = "";
    @IBOutlet weak var xPlayerLabel: UILabel!
    
    @IBOutlet weak var scoreTableView: UITableView!
    var allScores = [ScoreBoard]();
    override func viewDidLoad() {
        super.viewDidLoad()
        allScores = ScoreBoardServices.shared.getAllScores(playerName: xPlayerName);
        xPlayerLabel.text = xPlayerName;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteAllEntries(_ sender: UIBarButtonItem) {
        ScoreBoardServices.shared.deleteScoreData(playerName: xPlayerName, handler: {result in
            switch result{
            case .success(_):
                self.scoreTableView.dataSource = nil
                self.scoreTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
        self.scoreTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "score", for: indexPath)
        cell.textLabel?.text = allScores[indexPath.row].opponentName
        cell.detailTextLabel?.text = allScores[indexPath.row].winnerName
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        }
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
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
