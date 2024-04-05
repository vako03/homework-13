//
//  ViewController.swift
//  homework 13
//
//  Created by vako on 05.04.24.
//

import UIKit

struct Coffee {
    let productName: String
    var smallPrice: Double
    var mediumPrice: Double
    var largePrice: Double
    let details: String
    var ratingValue: Double
    var ratingCount: Int
    var isHeartFilled: Bool

    init(productName: String, smallPrice: Double, mediumPrice: Double, largePrice: Double, details: String, ratingValue: Double, ratingCount: Int, isHeartFilled: Bool) {
        self.productName = productName
        self.smallPrice = smallPrice
        self.mediumPrice = mediumPrice
        self.largePrice = largePrice
        self.details = details
        self.ratingValue = ratingValue
        self.ratingCount = ratingCount
        self.isHeartFilled = isHeartFilled
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var productDetailsTxt: UITextView!
    @IBOutlet weak var buttonSmall: UIButton!
    @IBOutlet weak var buttonMedium: UIButton!
    @IBOutlet weak var buttonLarge: UIButton!
    @IBOutlet weak var buttonHeart: UIButton!
    @IBOutlet weak var productPrice: UILabel!

    var coffee: Coffee! {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        coffee = Coffee(productName: "Coffee", smallPrice: 3.95, mediumPrice: 4.53, largePrice: 6.89, details: "მოცემული კაპუჩინო არის დაახლოებით 150 მლ. ის შეიცავს 25 მლ. ესპრესოს ყავას, 85 მლ. ახალთახალი მოწველილი ძროხის რძის რძეს, რომელიც სპეც... მეტი", ratingValue: 4.8, ratingCount: 230, isHeartFilled: false)
        
        sizeButtonPressed(buttonMedium)
        
    }

    @IBAction func sizeButtonPressed(_ sender: UIButton) {
         var coffeeVolume = 0
         var milkVolume = 0
         
         switch sender {
         case buttonSmall:
             coffeeVolume = 145
             milkVolume = 20
         case buttonMedium:
             coffeeVolume = 150
             milkVolume = 25
         case buttonLarge:
             coffeeVolume = 170
             milkVolume = 30
         default:
             break
         }
         
         updateProductDetails(price: sender == buttonSmall ? coffee.smallPrice : sender == buttonMedium ? coffee.mediumPrice : coffee.largePrice, coffeeVolume: coffeeVolume, milkVolume: milkVolume)
         
         updateButtonColors(selectedButton: sender)
         }

    @IBAction func heartButtonPressed(_ sender: UIButton) {
        coffee.isHeartFilled.toggle()
        if coffee.isHeartFilled {
            coffee.ratingValue = round((coffee.ratingValue + 0.1) * 10) / 10 // Round to 1 decimal place
            coffee.ratingCount += 1
        } else {
            coffee.ratingValue = round((coffee.ratingValue - 0.1) * 10) / 10 // Round to 1 decimal place
            coffee.ratingCount -= 1
        }
        updateHeartButtonImage()
        updateRatingLabel()
    }

    func updateUI() {
        let defaultCoffeeVolume = 150
        let defaultMilkVolume = 25
        
        updateProductDetails(price: coffee.smallPrice, coffeeVolume: defaultCoffeeVolume, milkVolume: defaultMilkVolume)
        updateHeartButtonImage()
        updateRatingLabel()
    }


    func updateButtonColors(selectedButton: UIButton) {
        let selectedBackgroundColor = UIColor(red: 1.0, green: 0.96, blue: 0.93, alpha: 1.0) // #FFF5EE
        let selectedTextColor = UIColor(red: 0.78, green: 0.49, blue: 0.31, alpha: 1.0) // #C67C4E
          
        buttonSmall.backgroundColor = .white
        buttonSmall.setTitleColor(.black, for: .normal)
        buttonMedium.backgroundColor = .white
        buttonMedium.setTitleColor(.black, for: .normal)
        buttonLarge.backgroundColor = .white
        buttonLarge.setTitleColor(.black, for: .normal)
            
        selectedButton.backgroundColor = selectedBackgroundColor
        selectedButton.setTitleColor(selectedTextColor, for: .normal)
    }

    func updateHeartButtonImage() {
        let heartImageName = coffee.isHeartFilled ? "heart.fill" : "heart"
        let heartImage = UIImage(systemName: heartImageName)
        buttonHeart.setImage(heartImage, for: .normal)
    }

    func updateProductDetails(price: Double, coffeeVolume: Int, milkVolume: Int) {
        productPrice.text = "₾\(price)"
        productDetailsTxt.text = "მოცემული კაპუჩინო არის დაახლოებით \(coffeeVolume) მლ. ის შეიცავს \(coffeeVolume) მლ. ესპრესოს ყავას, \(milkVolume) მლ. ახალთახალი მოწველილი ძროხის რძის რძეს, რომელიც სპეც... მეტი"
    }
    
    func updateRatingLabel() {
        ratingLabel.text = "\(coffee.ratingValue) (\(coffee.ratingCount))"
    }
}
