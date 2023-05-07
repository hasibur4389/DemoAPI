import UIKit

class ShowImageVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet var myImageView: UIImageView!
   
    @IBOutlet var myScrollView: UIScrollView!
        var imageWidth: CGFloat = 0.0
    var imageHeight: CGFloat = 0.0
    
    var largeImage : UIImage?
    var currentScale: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
       
        print("in ShowImageVC")
        if let largeImage = largeImage {
            myImageView.image = largeImage
//            myScrollView.contentSize = myImageView.bounds.size
          //  myScrollView.delegate = self
          
            imageWidth = myImageView.image?.size.width ?? 0.0
            imageHeight = myImageView.image?.size.height ?? 0.0
            myImageView.isUserInteractionEnabled = true
            view.addSubview(myImageView)
           // myScrollView.addSubview(myImageView)
           // myImageView.center = myScrollView.center
            
//                    myScrollView.contentSize = myImageView.bounds.size
//
//
//                    myScrollView.showsVerticalScrollIndicator = true
//                    myScrollView.showsHorizontalScrollIndicator = true

        }
        else {
            print("found nil")
        }
      //  setupScrollView()
      // addGesture()
    
    }
    
    
    
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        // Adjust the content offset of the scroll view when zooming
//        centerImage()
//    }

    
  
   
  
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImageView
    }
    
  
    func addGesture(){
        print("In addGesture")
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch))
        pinchGesture.cancelsTouchesInView = false
        myImageView.addGestureRecognizer(pinchGesture)
    }

    @objc func didPinch(_ gesture: UIPinchGestureRecognizer){
        print("in didPinch")

        if gesture.state == .began {
              // Reset the scale factor to the current image view size
              gesture.scale = currentScale
            print("In begin Scale is \(gesture.scale)")

          } else if gesture.state == .changed {
              // Scale the image view based on the current pinch gesture
              let scale = gesture.scale
              myImageView.transform = CGAffineTransform(scaleX: scale, y: scale)

              print("After Changing Scale is \(gesture.scale)")
          } else if gesture.state == .ended {
              // Store the current scale factor for the next pinch gesture


              currentScale = gesture.scale
              print("In end \(gesture.scale)")
          }
    }
    
    
}
