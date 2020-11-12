//
//  EventCompileViewController.swift
//  LiveSongRequest
//
//

import UIKit

class EventCompileViewController: UIViewController {
    
    @IBOutlet var textFields: [UITextField]!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add logo
        let logo = UIImage(named: "logo2")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        //adds a fake button to center logo better
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "    ", style: .plain, target: self, action: nil)
        
        //double tab for submission
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
    }
    
    @objc
    func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        makeEvent(sender)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        for x: UITextField in textFields {
            x.resignFirstResponder()
        }
    }
    
    @IBAction func makeEvent(_ sender: Any) {
        var b = true
        for x: UITextField in textFields {
            if (x.text?.count)! == 0 {
                let message = "Try to put something in all the boxes."
                let alertController = UIAlertController(title: "You Forgot Something", message: message, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                b = false
            }
        }
        if b {
            event = Event(eventName: textFields[0].text!, adminCode: textFields[1].text!, eventCode: textFields[2].text!, songs: [])
            eventList.append(event!)
            performSegue(withIdentifier: "toEventAdminList", sender: self)
        }
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        moveTextField(textField: sender, moveDistance: -120, up: true)
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        moveTextField(textField: sender, moveDistance: -120, up: false)
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: CGFloat(0), dy: CGFloat(movement))
        UIView.commitAnimations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toEventAdminList" {
            if let viewControllerEventAdmin = segue.destination as? ViewControllerEventAdmin {
                //get the index of this event
                if let found = eventList.index(where: { $0.eventName == event?.eventName }) {
                        viewControllerEventAdmin.event = eventList[found]
                    }
                }
            }
        }
    }


