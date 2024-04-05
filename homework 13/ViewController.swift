//
//  ViewController.swift
//  homework 13
//
//  Created by vako on 05.04.24.
//

//  14 Pro Max-ზე უფრო ახალ ვერსიაზე ვერ ვტესტავ. აღარ აქვს მეტის მხარდაჭერა ჩემს იქსკოდს.  წესით ზომები იგივე უნდა იყოს.

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
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var productDetailsTxt: UITextView!
    @IBOutlet weak var buttonSmall: UIButton!
    @IBOutlet weak var buttonMedium: UIButton!
    @IBOutlet weak var buttonLarge: UIButton!
    @IBOutlet weak var buttonHeart: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buttonBy: UIButton!
    
    var coffee: Coffee! {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBy.layer.cornerRadius = 16
        buttonBy.layer.cornerRadius = 16
        coverImage.layer.masksToBounds = true
        coverImage.layer.cornerRadius = 16
        
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
            coffee.ratingValue = round((coffee.ratingValue + 0.1) * 10) / 10
            coffee.ratingCount += 1
        } else {
            coffee.ratingValue = round((coffee.ratingValue - 0.1) * 10) / 10
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
    
    func updateButtonAppearance(button: UIButton, isSelected: Bool) {
        let selectedBackgroundColor = UIColor(red: 255/255, green: 245/255, blue: 238/255, alpha: 1.0)
        let selectedBorderColor = UIColor(red: 198/255, green: 124/255, blue: 78/255, alpha: 1.0)
        
        let defaultBackgroundColor = UIColor.white
        let defaultBorderColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
        
        let backgroundColor = isSelected ? selectedBackgroundColor : defaultBackgroundColor
        let borderColor = isSelected ? selectedBorderColor : defaultBorderColor
        
        button.backgroundColor = backgroundColor
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = 12
    }
    
    func updateButtonColors(selectedButton: UIButton) {
        updateButtonAppearance(button: selectedButton, isSelected: true)
        selectedButton.isSelected = true
        
        let buttons = [buttonSmall, buttonMedium, buttonLarge].filter { $0 != selectedButton }
        buttons.forEach {
            updateButtonAppearance(button: $0, isSelected: false)
            $0.isSelected = false
        }
    }
    
    
    func updateHeartButtonImage() {
        let heartImageName = coffee.isHeartFilled ? "heart.fill" : "heart"
        let heartImage = UIImage(systemName: heartImageName)
        buttonHeart.setImage(heartImage, for: .normal)
    }
    
    func updateProductDetails(price: Double, coffeeVolume: Int, milkVolume: Int) {
        productPrice.text = "₾\(price)"
        
        let attributedString = NSMutableAttributedString(string: "მოცემული კაპუჩინო არის დაახლოებით \(coffeeVolume) მლ. ის შეიცავს \(coffeeVolume) მლ. ესპრესოს ყავას, \(milkVolume) მლ. ახალთახალი მოწველილი ძროხის რძის რძეს, რომელიც სპეც...მეტი")
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1.0), range: NSRange(location: 0, length: attributedString.length))
        
        if let range = attributedString.string.range(of: "მეტი") {
            let nsRange = NSRange(range, in: attributedString.string)
            
            attributedString.addAttribute(.foregroundColor, value: UIColor(red: 0.78, green: 0.49, blue: 0.31, alpha: 1.0), range: nsRange)
        }
        productDetailsTxt.attributedText = attributedString
    }
    
    func updateRatingLabel() {
        ratingLabel.text = "\(coffee.ratingValue) (\(coffee.ratingCount))"
    }
}
