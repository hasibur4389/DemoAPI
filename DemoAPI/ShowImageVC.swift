import UIKit

class ShowImageVC: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet var myImageView: UIImageView!
    
    @IBOutlet var myScrollView: UIScrollView!
    
    // MARK: Gesture Recognizer
//    var imageWidth: CGFloat = 0.0
//    var imageHeight: CGFloat = 0.0
//    var currentScale: CGFloat = 1.0
    
    var largeImage : UIImage?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.delegate = self
        myScrollView.maximumZoomScale = 5.0
        // MARK: ts problematic, pushes the scaled down image to the left corner everytime so to resolve zoom out  we need to impplement centerImage() method and call from viewDidZoom()
        myScrollView.minimumZoomScale = 1.0
        
       
        print("in ShowImageVC")
        if let largeImage = largeImage {
            myImageView.image = largeImage
            centerImage()

            
            // MARK: For GestureRecognizer
//            imageWidth = myImageView.image?.size.width ?? 0.0
//            imageHeight = myImageView.image?.size.height ?? 0.0
//            myImageView.isUserInteractionEnabled = true
//            view.addSubview(myImageView)
          
        }
        else {
            print("found nil")
        }
        
      // MARK: Gesture Recognizer
      // addGesture()
    
    }
    
    
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImageView
    }

    

    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
    
    
    func centerImage() {
        
        // center the zoom view as it becomes smaller than the size of the screen
        let boundsSize = myScrollView.bounds.size
        var frameToCenter = myImageView?.frame ?? CGRect.zero
        
        // center horizontally
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width)/2
        }
        else {
            frameToCenter.origin.x = 0
        }
        
        // center vertically
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height)/2
        }
        else {
            frameToCenter.origin.y = 0
        }
        
        myImageView?.frame = frameToCenter
    }
   
   
  
    
    
    // MARK: used GestureRecognizer to Zoom in and out
    
//    func addGesture(){
//        print("In addGesture")
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch))
//        pinchGesture.cancelsTouchesInView = false
//        myImageView.addGestureRecognizer(pinchGesture)
//    }
//
//    @objc func didPinch(_ gesture: UIPinchGestureRecognizer){
//        print("in didPinch")
//
//        if gesture.state == .began {
//              // Reset the scale factor to the current image view size
//              gesture.scale = currentScale
//            print("In begin Scale is \(gesture.scale)")
//
//          } else if gesture.state == .changed {
//              // Scale the image view based on the current pinch gesture
//              let scale = gesture.scale
//              myImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
//
//              print("After Changing Scale is \(gesture.scale)")
//          } else if gesture.state == .ended {
//              // Store the current scale factor for the next pinch gesture
//
//
//              currentScale = gesture.scale
//              print("In end \(gesture.scale)")
//          }
//    }
    
    
}
