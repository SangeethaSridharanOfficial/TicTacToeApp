//
//  ScoreBoardServices.swift
//  TicTacToe
//
//  Created by user202299 on 12/13/21.
//

import Foundation
import CoreData
class ScoreBoardServices{
    static var shared : ScoreBoardServices = ScoreBoardServices()
    func getAllScores(playerName: String) -> [ScoreBoard]{
        var result = [ScoreBoard]()
        
        let fetch: NSFetchRequest = ScoreBoard.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: true)]
        let predicate : NSPredicate = NSPredicate(format: "playerName == %@", playerName)
        fetch.predicate = predicate
        do{
            result = try persistentContainer.viewContext.fetch(fetch)
        }catch {
            print(error)
        }
        return result;
        
    }
    
    func insertScoreData(playerName: String, opponentName: String, winnerName: String, date: String){
        
        let newScore = ScoreBoard(context: persistentContainer.viewContext);
        newScore.opponentName = opponentName
        newScore.playerName = playerName
        newScore.winnerName = winnerName
        newScore.date = date
        saveContext()
    }
    
    func deleteScoreData(playerName: String, handler: @escaping (Result<String, Error>) -> Void){
        let fetchre: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ScoreBoard")
        let predicate : NSPredicate = NSPredicate(format: "playerName == %@", playerName)
        fetchre.predicate = predicate
        let delere = NSBatchDeleteRequest(fetchRequest: fetchre)
        do{
            try persistentContainer.viewContext.execute(delere)
            handler(.success("Success"))
        }catch{
            handler(.failure(error))
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TicTacToe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
