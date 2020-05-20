//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

// MARK: - Protocol Section

protocol CoinManagerDelegate: class {
    
    func didUpdateBTC(rate: String, currency: String)
    
    func didFailWithError(_ error: Error)
    
}

struct CoinManager {
    
    // MARK: - Properties
    weak var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]
    let apiKey = Constant.apiKey!
    
    func getCoinPrice(for currency: String) {
        
        let urlString = baseURL
            + currency
            + "?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let rate = self.parseJSON(safeData) {
                        let rateString = String(format: "%.2f", rate)
                        
                        self.delegate?.didUpdateBTC(rate: rateString, currency: currency)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(_ coinData: Data) -> Double? {

        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate

            return rate
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }

    }
    
}
