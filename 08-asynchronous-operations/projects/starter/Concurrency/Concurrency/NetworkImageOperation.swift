/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

typealias ImageOperationCompletion = ((Data?, URLResponse?, Error?) -> Void)?

final class NetworkImageOperation: AsyncOperation {
  
  var image: UIImage?
  
  private let url: URL
  private let completion: ImageOperationCompletion
  private let tiltShift: Bool
  
  private var queue: OperationQueue?
  
  init(
    url: URL,
    tiltShift: Bool = true,
    completion: ImageOperationCompletion = nil) {
      
      self.url = url
      self.tiltShift = tiltShift
      self.completion = completion
      
      super.init()
    }
  
  convenience init?(
    string: String,
    completion: ImageOperationCompletion = nil) {
      guard let url = URL(string: string) else { return nil }
      self.init(url: url, completion: completion)
    }
  
  override func main() {
    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      
      guard let self = self else { return }
      
      if let completion = self.completion {
        defer { self.state = .finished }
        completion(data, response, error)
        return
      }
      
      guard error == nil, let data = data else { return }
      
      let image = UIImage(data: data)
      
      guard let image = image,
            self.tiltShift else {
              defer { self.state = .finished }
              self.image = image
              return
            }
      
      self.applyTiltShift(with: image)
      
    }.resume()
    
  }
  
  private func applyTiltShift(with image: UIImage) {
    
    queue = OperationQueue()
    queue?.qualityOfService = .utility
    
    let operation = TiltShiftOperation(image: image)
    operation.completionBlock = { [weak self] in
      guard let self = self else { return }
      
      defer { self.state = .finished }
      
      guard let image = operation.outputImage else {
        self.image = image
        return
      }
      
      self.image = image
    }
    
    queue?.addOperation(operation)
  }
  
}
