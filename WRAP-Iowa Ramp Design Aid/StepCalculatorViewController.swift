//
//  StepCalculatorViewController.swift
//  WRAP-Iowa Ramp Design Aid
//
//  Created by Joseph Knight on 2/5/20.
//  Copyright © 2020 Joseph Knight. All rights reserved.
//

import UIKit
import Foundation

// calculate the number of risers needed and the instructions for cuttiomg from a 2x12

//class StepCalculatorViewController: UIViewController, UITextFieldDelegate
class NewStairRiserCalculationView: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var StepHgtWhole: UITextField!
    @IBOutlet weak var StepHgtNumerator: UITextField!
    @IBOutlet weak var TotalNumRisers: UILabel!
    @IBOutlet weak var LowestRiserHgt: UILabel!
    // @IBOutlet weak var lowestLevelRiser: UILabel!
    @IBOutlet weak var RemainingRiserHgt: UILabel!
    @IBOutlet weak var TwoxTenNeeded: UILabel!
    @IBOutlet weak var manualOverrideRisers: UITextField!
    
    //outlet to move text field
    @IBOutlet weak var RiserScrollView: UIScrollView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // initialize variables to help manage optionals
        TotalNumRisers.text = String("")
        LowestRiserHgt.text = String("")
        RemainingRiserHgt.text = String("")
        TwoxTenNeeded.text = String("")
        manualOverrideRisers.text = "0"
    }
    
    //move textfiields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        RiserScrollView.setContentOffset(CGPoint(x: 0, y: 350),animated: true)
    }
    
    //    @IBAction func overrideRiserCalc(_ sender: UIButton) {
    //
    //    }
    
    // perform calculations when pressed
    @IBAction func StairRiserButton(_ sender: UIButton)
    {
        //get keyboard inputs
        //inches are fractions are entered separately. All fractions are 1/16ths
        let stepFirstPart = Double(StepHgtWhole.text!)
        
        var stepSecondPart = Double(StepHgtNumerator.text!)
        if stepSecondPart == nil
        {
            stepSecondPart = 0.0
            
            // the user may wish to use more risers than the minimum number that are caclulated
            let overrideValue = Int(manualOverrideRisers.text!)
            print (manualOverrideRisers.text!)
            print("overrideValue \(overrideValue!)")
        }
        
        //return scrollview to normal position
        self.StepHgtWhole.resignFirstResponder()
        self.StepHgtNumerator.resignFirstResponder()
        
        RiserScrollView.setContentOffset(CGPoint(x: 0, y: 850),animated: true)
        
        //process the inputs
        var secondPartFraction = 1.5
        secondPartFraction = (Double(stepSecondPart!) / 16.0)
        
        // continued variable initializations
        var numerator1 = ""
        var numerator2 = ""
        var fractionTo16ths1 = 0.9
        var fractionTo16ths2 = 0.9
        
        let stairHeight:Double = Double(stepFirstPart!) + Double(secondPartFraction)
        print("StairHeight \(stairHeight)")
        
        //   let totalRisers = Int(((stairHeight)/7.5)+1)
        //    print ("\(ceil(stairHeight))")
        
        var totalRisers = 1
        let newRiserCount = Int("\(manualOverrideRisers.text!)")!
        
        //  logic to accept riser override
        if manualOverrideRisers.text == "0"
        {
            totalRisers = Int((ceil(stairHeight)/7.00001)) + 1
            print("totalRisers \(totalRisers)")
        }
        else
        {
            totalRisers = newRiserCount
            print("totalRisers \(totalRisers)")
        }
        
        TotalNumRisers.text = String(totalRisers)
        print("total risers \(totalRisers)")
        
        let remainingRisers:Double = (stairHeight)/Double(totalRisers)
        print("remaining risers \(remainingRisers)")
        let allRisers = Int(remainingRisers)
        print("all risers \(allRisers)")
        let allRiserTemp = remainingRisers - trunc(remainingRisers)
        print("allRiserTemp \(allRiserTemp)")
        fractionTo16ths1 = (allRiserTemp) * 16
        print("fractionto16ths1 \(fractionTo16ths1)")
        
        // this switch statement is to present the user with a fraction rather than a decimal for the remaining risers
        numerator1 = String("15/16")
        switch  fractionTo16ths1
        {
        case 0:
            numerator1 = ""
        case ..<1.00000000000001:
            numerator1 = "   1/16"
        case ..<2.00000000000001:
            numerator1 = "   1/8"
        case ..<3.00000000000001:
            numerator1 = "   3/16"
        case ..<4.00000000000001:
            numerator1 = "   1/4"
        case ..<5.00000000000001:
            numerator1 = "   5/16"
        case ..<6.00000000000001:
            numerator1 = "   3/8"
        case ..<7.00000000000001:
            numerator1 = "   7/16"
        case ..<8.00000000000001:
            numerator1 = "   1/2"
        case ..<9.00000000000001:
            numerator1 = "   9/16"
        case ..<10.00000000000001:
            numerator1 = "   5/8"
        case ..<11.00000000000001:
            numerator1 = "   11/16"
        case ..<12.00000000000001:
            numerator1 = "   3/4"
        case ..<13.00000000000001:
            numerator1 = "   13/16"
        case ..<14.00000000000001:
            numerator1 = "   7/8"
        case ..<16:
            numerator1 = "   15/16"
        default:
            numerator1 = "   15/16"
        }
        
        RemainingRiserHgt.text = String(allRisers) + String("   ") + String(numerator1)
        print("numerator1 \(numerator1)")
        
        let lowestRiser = remainingRisers - 1.1875
        print("lowest riser \(lowestRiser)")
        let lowRisers = Int(lowestRiser)
        print("lowrisers \(lowRisers)")
        let lowRiserTemp = lowestRiser - trunc(lowestRiser)
        print("lowriser temp \(lowRiserTemp)")
        fractionTo16ths2 = (lowRiserTemp) * 16
        numerator2 = String("15/16")
        print("fractionto16ths2 \(fractionTo16ths2)")
        
        // this switch statement is to present the user with a fraction rather than a decimal for the lowest riser
        switch  fractionTo16ths2
        {
        case 0:
            numerator2 = ""
        case ..<1.00000000000001:
            numerator2 = "   1/16"
        case ..<2.00000000000001:
            numerator2 = "   1/8"
        case ..<3.00000000000001:
            numerator2 = "   3/16"
        case ..<4.00000000000001:
            numerator2 = "   1/4"
        case ..<5.00000000000001:
            numerator2 = "   5/16"
        case ..<6.00000000000001:
            numerator2 = "   3/8"
        case ..<7.00000000000001:
            numerator2 = "   7/16"
        case ..<8.00000000000001:
            numerator2 = "   1/2"
        case ..<9.00000000000001:
            numerator2 = "   9/16"
        case ..<10.00000000000001:
            numerator2 = "   5/8"
        case ..<11.00000000000001:
            numerator2 = "   11/16"
        case ..<12.00000000000001:
            numerator2 = "   3/4"
        case ..<13.00000000000001:
            numerator2 = "   13/16"
        case ..<14.00000000000001:
            numerator2 = "   7/8"
        case ..<16:
            numerator2 = "   15/16"
        default:
            numerator2 = "   15/16"
        }
        
        LowestRiserHgt.text = String(Int(lowRisers))  + String("   ")  + String(numerator2)
        print("numerator2 \(numerator2)")
        
        //computer length of 2x12 needed
        let BoardLength:Double = ((sqrt(pow((stairHeight - lowestRiser),2) + pow((9.1825 + (Double(totalRisers) - 2) * 11),2)))+6)
        
        let thing1 = pow((stairHeight - lowestRiser),2)
        let thing2 = pow((9.1825 + (Double(totalRisers) - 2) * 11),2)
        print(thing1)
        print(thing2)
        print("Board Length \(BoardLength)")
        TwoxTenNeeded.text = String(Int(BoardLength)) + String("  inches per stringer")
        
    }
}

