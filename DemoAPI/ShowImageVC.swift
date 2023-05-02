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
    var loaderView : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        print("in ShowImageVC")
        if let largeImage {
            myImage.image = largeImage
            //self.stopLoader()
        }
        else {
            print("found nil")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if let loaderView {
//                   self.stopLoader(loader: loaderView, completion: nil)
//               }
//               else {
//                   print("no loaderView!")
//        }
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
