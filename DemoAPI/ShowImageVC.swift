//
//  ShowImageVC.swift
//  DemoAPI
//
//  Created by Hasibur Rahman on 27/4/23.
//

import UIKit

class ShowImageVC: UIViewController {

    @IBOutlet var myImage: UIImageView!
    
    var largeImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let largeImage {
            myImage.image = largeImage
        }
        else {
            print(largeImage)
        }
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
