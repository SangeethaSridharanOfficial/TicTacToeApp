//
//  alertImage.swift
//  TicTacToe
//
//  Created by user202299 on 12/15/21.
//

import Foundation

import UIKit

extension UIAlertController{
    
    func addImage(image: UIImage) {
        let maxSize = CGSize(width: 200, height: 245)
        let imgSize = image.size
        var ratio: CGFloat!
        if(imgSize.width > imgSize.height){
            ratio = maxSize.width / imgSize.width
        }else{
            ratio = maxSize.height / imgSize.height
        }
        let scaledSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        let resizedImage = image.imageResize(scaledSize)
        
        
        
        let imageAction = UIAlertAction(title: "", style: .default, handler: nil)
        imageAction.isEnabled = false;
        imageAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imageAction)
    }
}

extension UIImage {
    func imageResize(_ size:CGSize) -> UIImage {
        var scled = CGRect.zero
        let aWid:CGFloat = size.width / self.size.width
        let aHei:CGFloat = size.height / self.size.height
        let ar:CGFloat = min(aWid, aHei)
        
        scled.size.width = self.size.width * ar
        scled.size.height = self.size.height * ar
        scled.origin.x = (size.width - scled.size.width) / 2.0
        scled.origin.y = (size.height - scled.size.height) / 2.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: scled)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
}
