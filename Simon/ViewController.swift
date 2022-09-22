//
//  ViewController.swift
//  Simon
//
//  Created by William Dedominico on 9/22/22.
//

import UIKit

class ViewController: UIViewController {

  enum Input {
    case Green
    case Blue
    case Red
    case Yellow
  }

    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    
  var timer:Timer = Timer();
  var speed = 1.0, patternLen = 1, userInputCount = 0;
  var takingInput = false;
  var userInput:Input! = nil, currPattern:Input! = nil;
  
  override func viewDidLoad () {
    super.viewDidLoad();

      AddButtonBorder(button: greenButton);
      AddButtonBorder(button: blueButton);
      AddButtonBorder(button: redButton);
      AddButtonBorder(button: yellowButton);
    
    timer = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(Update), userInfo: nil, repeats: true);
  }
    
    func AddButtonBorder(button:UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    func SetColorWhite(button:UIButton){
        button.alpha = 0.1;
    }

  @objc func Update() {
      
      greenButton.alpha = 1;
      blueButton.alpha = 1;
      redButton.alpha = 1;
      yellowButton.alpha = 1;
      
      if !takingInput {
          if (userInput == currPattern) {
            userInputCount += 1;
            userInput = nil;
            if (userInputCount >= patternLen) {
              userInputCount = 0;
              patternLen += 1;
              // TODO: dispatch queue and play sound for win
              
            } else {
              UpdatePattern();
            }
            takingInput = true;
          } else {
              userInput = nil;
              userInput = currPattern;
            userInputCount = 0;
            patternLen = 1;
              SetColorWhite(button: greenButton);
              SetColorWhite(button: blueButton);
              SetColorWhite(button: redButton);
              SetColorWhite(button: yellowButton);
            //TODO: dispatch queue and play lose sound
          }
      }
  }

  func UpdatePattern() {
      switch Int.random(in: 1...4) {
      
      case 1:
        currPattern = Input.Green;
          SetColorWhite(button: greenButton);
      break;
      case 2:
        currPattern = Input.Blue;
          SetColorWhite(button: blueButton);
      break;
      case 3:
        currPattern = Input.Red;
          SetColorWhite(button: redButton);
      break;
      case 4:
          SetColorWhite(button: yellowButton);
        currPattern = Input.Yellow;
      break;
      default: break;
      }
      
      takingInput = true;

    // TODO: dispatch queue and play sound and display color
    
  }

    @IBAction func StartButtonPressed(_ sender: Any) {
        UpdatePattern();
    }
    
    @IBAction func GreenPressed(_ sender: Any) {
        if takingInput {
          userInput = Input.Green;
          takingInput = false;
          // TODO: dispatch queue and play sound
        }
    }
    
    @IBAction func BluePressed(_ sender: Any) {
        if takingInput {
            userInput = Input.Blue;
          takingInput = false;
          // TODO: dispatch queue and play sound
        }
    }
    
    @IBAction func RedPressed(_ sender: Any) {
        if takingInput {
            userInput = Input.Red;
          takingInput = false;
          // TODO: dispatch queue and play sound
        }
    }
    
    @IBAction func YellowPressed(_ sender: Any) {
        if takingInput {
            userInput = Input.Yellow;
          takingInput = false;
          // TODO: dispatch queue and play sound
        }
    }
  
}
