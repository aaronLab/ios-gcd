import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        
        UIGraphicsBeginImageContext(rotatedSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

func timeCheck(_ block: () -> ()) -> TimeInterval {
  let start = Date()
  block()
  return Date().timeIntervalSince(start)
}

class RotateImageOperation: Operation {
    
    var inputImage: UIImage?
    var outputImage: UIImage?
    
    override func main() {
        sleep(1)
        outputImage = inputImage?.rotate(radians: .pi)
    }
    
}

let op = RotateImageOperation()

let inputImage = UIImage(named: "desert.jpg")
op.inputImage = inputImage

timeCheck {
    op.start()
}

op.outputImage

PlaygroundPage.current.finishExecution()
