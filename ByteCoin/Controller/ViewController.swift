//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // Properties
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Marking class as delegate
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        // Show default BTC price in USD
        coinManager.getCoinPrice(for: "USD")
    }
    
}

// MARK: - UIPickerViewDataSource Section

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return coinManager.currencyArray.count
        
    }
    
}

// MARK: - UIPickerViewDelegate Section

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.currencyArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currency = coinManager.currencyArray[row]
        
        // Fetch coin price
        coinManager.getCoinPrice(for: currency)
    }
    
}

extension ViewController: CoinManagerDelegate {
    
    func didUpdateBTC(rate: String, currency: String) {
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = rate
            self.currencyLabel.text = currency
        }
        
    }
    
    func didFailWithError(_ error: Error) {
        
        print(error)
        
    }
    
}
