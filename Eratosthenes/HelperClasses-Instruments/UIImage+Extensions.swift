
import UIKit

extension UIImage {
    static let simpleImageCache = NSCache<NSURL, UIImage>()
    
    func circularImage(withSize size: CGSize) -> UIImage {
        let scale = UIScreen.main.scale
        let circleRect = CGRect(x: 0, y: 0, width: size.width * scale, height: size.height * scale)
        
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, scale)
                
        let circlePath = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.width/2.0)
        circlePath.addClip()
        draw(in: circleRect)
        
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        return roundedImage!
    }
    
    class func downloadImage(with url: URL?, completion: @escaping ((_ image: UIImage) -> Void)) {
        guard let url = url else { return }
        
        if let image = simpleImageCache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            let session = URLSession(configuration: .ephemeral)
            DebugSignPostStart(event: .imageDownload, eventObject: url, signPostColor: .purple)
            let task = session.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
                if let data = data, let image = UIImage(data: data) {
                    simpleImageCache.setObject(image, forKey: url as NSURL)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
                DebugSignPostEnd(event: .imageDownload, eventObject: url, signPostColor: .purple)
            })
            
            task.resume()
        }
    }
}
