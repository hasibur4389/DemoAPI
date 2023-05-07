//
//  Extensions.swift
//  DemoAPI
//
//  Created by Hasibur Rahman on 2/5/23.
//

import UIKit

extension  UIViewController {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait ", preferredStyle: .alert)
         let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
       
        return alert
    }
    
    
    func stopLoader(loader: UIAlertController, completion: @escaping () -> Void){
//        DispatchQueue.main.async {
        loader.dismiss(animated: true) {
            completion()
        }
//        }
    }




    
    func alertMessage(title: String, message: String) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        present(alertController, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alertController.dismiss(animated: true, completion: nil)
            }
        })
      
        
     

    }
}


