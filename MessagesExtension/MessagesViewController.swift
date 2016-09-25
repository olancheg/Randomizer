//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Alan Daud on 25/09/16.
//  Copyright © 2016 Alan Daud. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
  // MARK: Variables
  let MessageSize = CGSize.init(width: 300, height: 300)
  @IBOutlet weak var textLabel: UILabel!

  // MARK: Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  // MARK: Actions
  @IBAction func generateNumber(_ sender: AnyObject) {
    let number = Int(arc4random_uniform(100))
    composeMessage(for: number)
  }

  // MARK: Internals
  // Function to generate image for the generated number
  func createImage(from string: String) -> UIImage {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center

    let textFontAttributes: [String: Any] = [
      NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 100)!,
      NSForegroundColorAttributeName: UIColor.red,
      NSParagraphStyleAttributeName: paragraphStyle
    ]

    let renderer = UIGraphicsImageRenderer(size: MessageSize)
    let rectangle = CGRect(
      origin: CGPoint(x: 0, y: MessageSize.height / 3),
      size: MessageSize
    )

    let image = renderer.image { _ctx in
      string.draw(
        with: rectangle,
        options: .usesLineFragmentOrigin,
        attributes: textFontAttributes,
        context: nil
      )
    }

    return image
  }

  // Function to add message
  func composeMessage(for number: Int) {
    let message = MSMessage()
    let layout = MSMessageTemplateLayout()

    layout.image = createImage(from: String(number))
    message.layout = layout

    activeConversation?.insert(message, completionHandler: {_ in })
  }
}
