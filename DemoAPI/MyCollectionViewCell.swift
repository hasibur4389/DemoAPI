//
//  MyCollectionViewCell.swift
//  DemoAPI
//
//  Created by Hasibur Rahman on 26/4/23.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var myImageView: UIImageView!
    
    var urlString: String? {
        didSet {
            
            //Download
            DispatchQueue.global().async { [self] in
                
                //download
                let catPictureURL = URL(string: urlString!)!

                // Creating a session object with the default configuration.
                
                let session = URLSession(configuration: .default)

                // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
                let downloadPicTask = session.dataTask(with: catPictureURL) { [self] (data, response, error) in
                    // The download has finished.
                    if let e = error {
                        print("Error downloading cat picture: \(e)")
                    } else {
                        // No errors found.
                        // It would be weird if we didn't have a response, so check for that too.
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded cat picture with response code \(res.statusCode)")
                            if let imageData = data {
                                // Finally convert that Data into an image and do what you wish with it.
                                DispatchQueue.main.async { [self] in
                                    let image = UIImage(data: imageData)
                                    myImageView.image = image
                                }
                               // print("in CollectionViewCell")
                               
                                
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                    }
                }
             
               
                
                downloadPicTask.resume()
            }
            
            
        }
    }
}
