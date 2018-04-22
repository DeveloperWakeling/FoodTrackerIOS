//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Michael Wakeling on 4/22/18.
//  Copyright © 2018 Michael Wakeling. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Actions
    @objc func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        //Calculate the rating of the button
        let selectedRating = index + 1
        
        if(selectedRating == rating){
            //If the selected star represents the current rating, reset the rating to 0
            rating = 0
        }
        else {
            //Set the rating to the selected star
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButtons(){
        //Clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load Buttons Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        //Weird for loop to create 5 buttons and add them to the stack
        for index in 0..<starCount {
            let button = UIButton()
            
            //Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            //Disable the button's auto generated constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            //Constraints
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Accessibility
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            //Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add the button to the stack
            addArrangedSubview(button)
            
            //Add buttons to the ratingButtons Array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
        
    }
    
    private func updateButtonSelectionStates() {
        for(index, button) in ratingButtons.enumerated() {
            //If the index of the button is less than the rating the button should be selected
            button.isSelected = index < rating
            
            //Set tooltip (Accessibility)
            let hintString: String?
            if(rating == index + 1){
                hintString = "Tap to reset the rating to 0"
            }
            else {
                hintString = nil
            }
            
            //Calculate the Value String
            let valueString: String
            switch(rating){
            case 0:
                valueString = "No Rating Yet"
            case 1:
                valueString = "1 Star Set"
            default:
                valueString = "\(rating) Stars Set"
            }
            //Assign the hintString and the valueString
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
}
