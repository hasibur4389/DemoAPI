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
    var loader: UIAlertController?
    var calls = 0
    
    let per_page = 5
    var page = 1

    @IBOutlet var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for _ in 1...10{
//            let img = UIImage(named: "demo.png") ?? UIImage()
//            myImages.append(img)
//        }
//
        // Fetch Data from API
        fetchAPIData(pageNo: page)
            
        
         
        
      
        // Do any additional setup after loading the view.
    }
    
    func fetchAPIData(pageNo: Int){
        
        print("Page no \(pageNo)")
        var url = "https://api.unsplash.com/photos/?client_id=sWB7EZzrIDG--PoBd4j-BxAGdT6Jr5mTQ3zoFkSF8Go"
        url = url + "&page=\(pageNo)" + "&per_page=\(per_page)"
       // print(url)
        print("In fetchAPIData")
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            
            print("IN REQUEST \(response.result)")
            
            self.calls += 1
            
            print("Called the the API \(self.calls) times")
            switch response.result{
                
                
            case .success(let data):
                do{
                    print("In success")
                     
                    //let jsonData = try JSONDecoder().decode([UnsplashItem].self , from: data!)

                // Catch anything then convert to my unsplashitem
                    
                    
                   // var jsonData = [UnsplashItem]()
                    let currentCount = self.unsplashItems.count

                    
                    if let data {
                         
                       let json = try? JSONSerialization.jsonObject(with: data, options: [])
                      //  print("data is \(json)")
                        
                        
                      
                        // Rate Limit Exceeded Handling
                       
                        guard let json else{
                            self.alertMessage(title: "This is an error", message: "Rate Limit Exceeded")
                            print("Rate Limit Exceeded (50req/hr)")
                            return
                        }
                        
                        
                        
                        if let json = json as? Dictionary<String, Any> {
                            //check api error
                            let errors = json["errors"]
                            print("the error is \(errors!)")
                            self.alertMessage(title: "This is an error", message: errors as! String)
                            
                        }else{
                            print("not error")
                        }
                        
                        if let json = json as? [[String: Any]] {
                            //unsplash create
                            print("Creating UnspalshItem")
                            for j in json{
                                if let id = j["id"] as? String, let urls = j["urls"] as? [String: String] {
                                    var item = UnsplashItem(id: id, description: "", alt_description: "", urls: urls)
                                    
                                    if let desc = j["description"] as? String {
                                        item.description = desc
                                    }else {item.description = "No description found"}
                
                                    if let alt_desc = j["alt_description"] as? String {
                                        item.alt_description = alt_desc
                                    }else{item.alt_description = "No alt_description founf"}
                                    
                                    self.unsplashItems.append(item)
                                }
                            }
                        }else{
                            self.alertMessage(title: "This is an error", message: "No Data found")
                            print("not Data")
                        }
                            
                    }
                    else{
                        self.alertMessage(title: "This is an error", message: "Failed decoding API data")
                        print("failed decoding api data")
                    }
                 
//
                 
                    
                    // parsing Data
                    
                 //   self.unsplashItems.append(contentsOf: jsonData)
                    print("Calling reloadData()")
                    
                    //insert cells
                    var indexpathArray = [IndexPath]()
                    
                    
                    for i in currentCount...self.unsplashItems.count-1{
                        indexpathArray.append( IndexPath(item: i, section: 0))
                    }
                    
                   // self.myCollectionView.reloadData()
                    
                    self.myCollectionView.insertItems(at: indexpathArray)
                 
                }
                catch{
                    self.alertMessage(title: "This is an error", message: error.localizedDescription)
                    print(error.localizedDescription)
                }
            case .failure(let error):
                self.alertMessage(title: "This is an error", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
   
    
   
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == unsplashItems.count - 2{
            // load another 15 images
            page += 1
            fetchAPIData(pageNo: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageVC//
        let item = unsplashItems[indexPath.row]
        
        //vc.largeImage = unsplashItems[indexPath.item]
        
        // starting loader View
        
        loader = self.loader()

        DispatchQueue.global().async { [self] in
            downloadImage(item: item, vc: vc)
        }
        
     //   navigationController?.pushViewController(vc, animated: true)
         
       
      }
    
    func downloadImage(item: UnsplashItem, vc: ShowImageVC){
        
        print("in setImage")
       //download
        let catPictureURL = URL(string: item.urls["raw"]!)!

            // Creating a session object with the default configuration.
            
            let session = URLSession(configuration: .default)

            // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                // The download has finished.
                if let e = error {
                    print("Error downloading cat picture: \(e)")
                } else {
                    // No errors found.
                    // It would be weird if we didn't have a response, so check for that too.
                    print("after setImage")
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded cat picture with response code \(res.statusCode)")
                        if let imageData = data {
                            // Finally convert that Data into an image and do what you wish with it.
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)
                                vc.largeImage = image
                             //   vc.loaderView = self.loader
//                                print("in setImage \(vc.largeImage!)")
                                
                                // used escape sequence
                                self.stopLoader(loader: self.loader!) {
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
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
    
    //MARK: - Collectionview
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
        cell.myLabel.numberOfLines = 0
        cell.myLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.myLabel.text = item.description
        cell.myImageView.layer.cornerRadius = 15
      //  print("returnin cell \(indexPath)")
        
        return cell
    }
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height/5 - 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

}

