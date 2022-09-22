//
//  ViewController.swift
//  Simon
//
//  Created by William Dedominico on 9/22/22.
//

import UIKit
import AVFoundation

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
    var userInput:Input! = nil;
  var colorArray: [Input] = []
    var player:AVAudioPlayer = AVAudioPlayer();
    var showingArr = false;
    var showArrIndex = 0;
  
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
    
    func playSound(soundColor: String){
        let sound = Bundle.main.path(forResource: soundColor, ofType: "wav")
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound ?? ""))
        }catch {
            print(error)
        }
        player.play()
    }

  @objc func Update() {
      
      greenButton.alpha = 1;
      blueButton.alpha = 1;
      redButton.alpha = 1;
      yellowButton.alpha = 1;
      
      if !showingArr{
          if !takingInput && colorArray.count != 0 {
              if (userInput == colorArray[userInputCount]) {
                userInputCount += 1;
                userInput = nil;
                  if (userInputCount >= colorArray.count) {
                      userInputCount = 0;
                      patternLen += 1;
                      // TODO: dispatch queue and play sound for win
                      playSound(soundColor: "hiscore")
                      UpdatePattern()
                } else {
                  //UpdatePattern();
                }
                takingInput = true;
              } else {
                  userInput = nil;
                  userInputCount = 0;
                  patternLen = 1;
                  colorArray = [];
                  SetColorWhite(button: greenButton);
                  SetColorWhite(button: blueButton);
                  SetColorWhite(button: redButton);
                  SetColorWhite(button: yellowButton);
                //TODO: dispatch queue and play lose sound
                  playSound(soundColor: "lose")
              }
          }
      }
      else {
          if !(showArrIndex >= colorArray.count) {
              
              switch colorArray[showArrIndex] {
              case Input.Green:
                  SetColorWhite(button: greenButton);
                  playSound(soundColor: "green")
              break;
              case Input.Blue:
                  SetColorWhite(button: blueButton);
                  playSound(soundColor: "blue")
              break;
              case Input.Red:
                  SetColorWhite(button: redButton);
                  playSound(soundColor: "red")
              break;
              case Input.Yellow:
                  SetColorWhite(button: yellowButton);
                  playSound(soundColor: "yellow")
              break;
              }
              
              showArrIndex += 1;
          }else{
              showingArr = false;
              showArrIndex = 0;
          }
      }
      
      print(colorArray)
  }

  func UpdatePattern() {
      switch Int.random(in: 1...4) {
      
      case 1:
          colorArray.append(Input.Green)
      break;
      case 2:
          colorArray.append(Input.Blue)
      break;
      case 3:
          colorArray.append(Input.Red)
      break;
      case 4:
          colorArray.append(Input.Yellow)
      break;
      default: break;
      }
      
      takingInput = true;
      showingArr = true;
      
      
    // TODO: dispatch queue and play sound and display color
    
  }

    @IBAction func StartButtonPressed(_ sender: Any) {
        colorArray = [];
        UpdatePattern();
        playSound(soundColor: "start")
    }
    
    @IBAction func GreenPressed(_ sender: Any) {
        if takingInput {
          userInput = Input.Green;
          takingInput = false;
          // TODO: dispatch queue and play sound
            playSound(soundColor: "green")
        }
    }
    
    @IBAction func BluePressed(_ sender: Any) {
        if takingInput {
            userInput = Input.Blue;
          takingInput = false;
          // TODO: dispatch queue and play sound
            playSound(soundColor: "blue")
        }
    }
    
    @IBAction func RedPressed(_ sender: Any) {
        if takingInput {
            userInput = Input.Red;
          takingInput = false;
          // TODO: dispatch queue and play sound
            playSound(soundColor: "red")
        }
    }
    
    @IBAction func YellowPressed(_ sender: Any) {
        if takingInput {
            userInput = Input.Yellow;
          takingInput = false;
          // TODO: dispatch queue and play sound
            playSound(soundColor: "yellow")
        }
    }
  
}
