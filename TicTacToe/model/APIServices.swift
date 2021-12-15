//
//  APIServices.swift
//  TicTacToe
//
//  Created by user202299 on 12/14/21.
//

import Foundation
import UIKit

class APIServices{
    static var shared = APIServices()
    
    func getPlayersFromAPI(handler: @escaping ([RandomUsers]) -> Void){
        let urlStr = "https://randomuser.me/api/?results=10";
        guard let urlObj = URL(string: urlStr) else { return };
        let task = URLSession.shared.dataTask(with: urlObj){(data, response, error) in
            guard let data = data else {
                return handler([RandomUsers]())
            }
            do{
                let result = try? JSONDecoder().decode(RandomUser.self, from: data);
                handler(result!.results)
            }catch{
                print("Error in api response ",error);
            }
        }
        task.resume();
    }
    
    func getPlayerImage(url: String, handler: @escaping (Result<UIImage, Error>) -> Void){
        
        guard let urlObj = URL(string: url) else { return };
        let task = URLSession.shared.dataTask(with: urlObj){(data, response, error) in
            guard let data = data else {
                return  handler(.failure(error!))
            }
            do{
                let img = UIImage(data: data)
                handler(.success(img!))
            }catch{
                handler(.failure(error))
            }
        }
        task.resume();
        
    }
    
}

