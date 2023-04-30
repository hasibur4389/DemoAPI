//
//  ViewController.swift
//  DemoAPI
//
//  Created by Hasibur Rahman on 26/4/23.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
   
    
    var unsplashItems = [UnsplashItem]()

    @IBOutlet var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for _ in 1...10{
//            let img = UIImage(named: "demo.png") ?? UIImage()
//            myImages.append(img)
//        }
//
        // Fetch Data from API
        fetchAPIData()
            
        
         
        
      
        // Do any additional setup after loading the view.
    }
    
    func fetchAPIData(){
        
        let url = "https://api.unsplash.com/photos/?client_id=s4zDoLC4blWmZ9WWvz75UHtB_luHbCVNa0YZ-eN2iNI"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result{
            case .success(let data):
                do{
//                    print(response.result)
                    
                    let jsonData = try JSONDecoder().decode([UnsplashItem].self , from: data!)
                    // parsing Data
                    self.unsplashItems = jsonData
                    print("Calling reloadData()")
                    self.myCollectionView.reloadData()
                 
                }
                catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
   
    
   
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageVC//
        let item = unsplashItems[indexPath.row]
        
        //vc.largeImage = unsplashItems[indexPath.item]
        //DispatchQueue.global().async { [self] in
            setImage(item: item, vc: vc)
       // }
        
        navigationController?.pushViewController(vc, animated: true)
         
       
      }
    
    func setImage(item: UnsplashItem, vc: ShowImageVC){
        
        print("in setImage")
       //download
        let catPictureURL = URL(string: item.urls["raw"]!)!

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
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)
                                vc.largeImage = image
                             
                                print("in setImage \(vc.largeImage)")
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        unsplashItems.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("returnin cell \(indexPath)")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyCollectionViewCell
        else{
            return UICollectionViewCell()
        }
       // cell.myImageView.layer.cornerRadius = 15
        //print("returnin cell \(indexPath)")
        //cell.myImageView.image = myImages[indexPath.row]
//        cell.myImageView.layer.cornerRadius = 15
        
        let item = unsplashItems[indexPath.row]
        cell.urlString = item.urls["thumb"]
        cell.myImageView.layer.cornerRadius = 15
      //  print("returnin cell \(indexPath)")
        
        return cell
    }
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width/3 - 3, height: collectionView.frame.size.height/5 - 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }

}

