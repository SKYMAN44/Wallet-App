//
//  DBService.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

// func to store fake data for later usage with actual storage 
final class DBService {
    static let shared = DBService()
    
    public func getCards() -> [Cards] {
        return [
            Cards(type: "VISA", balance: 1234, cardNumber: "5454 6969 6969 6919", history: self.getExpenses()),
            Cards(type: "MASTERCARD", balance: 124, cardNumber: "5494 6969 6969 6979", history: self.getExpenses()),
            Cards(type: "MIR", balance: 1245, cardNumber: "5474 6969 6969 6959", history: self.getExpenses()),
            Cards(type: "VISA", balance: 23654, cardNumber: "5444 6969 6969 7089", history: self.getExpenses())
        ]
    }
    
    public func getContacts() -> [Contacts] {
        return [
            Contacts(id: 1, imageURL: "testPerson.jpeg"),
            Contacts(id: 2, imageURL: "testPerson2.jpeg"),
            Contacts(id: 3, imageURL: "testPerson3.jpeg"),
            Contacts(id: 4, imageURL: "purpleGradient.jpg"),
            Contacts(id: 5, imageURL: "testPerson3.jpeg"),
            Contacts(id: 6, imageURL: "purpleGradient.jpg"),
        ]
    }
    
    public func getExpenses() -> [Expenses] {
        let month = Int.random(in: 1...3)
        let day = Int.random(in: 1...20)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let stringDate = "2022-\(month)-\(day)"
        let date = dateFormatter.date(from: stringDate)
        let monthStringDate = "2022-3-3"
        let thisMonthDate = dateFormatter.date(from: monthStringDate)
        
        func generateAmount() -> NSDecimalNumber {
            let integer = Int.random(in: 800...50000)
            let decimal = Int.random(in: 0...99)
            let val = integer + decimal
            return NSDecimalNumber(mantissa: UInt64(val), exponent: -2, isNegative: false)
        }
        
        func generating() -> Float {
            var num = Float.random(in: 8...500)
            // round up to 2 decimal
            num = round(100 * num) / 100
            
            return num
        }
        
        return [
            Expenses(recieverName: "Mvideo", date: Date(), amount: generating(), sector: .tech),
            Expenses(recieverName: "Azbuka Vkusa", date: Date(), amount: generating(), sector:  .grocery),
            Expenses(recieverName: "Apple Store", date: Date(), amount: generating(), sector: .tech),
            Expenses(recieverName: "Creative Cloud", date: date!, amount: generating(), sector: .intelcom),
            Expenses(recieverName: "Spar", date: date!, amount: generating(), sector: .grocery),
            Expenses(recieverName: "McDonalds", date: date!, amount: generating(), sector: .restaurants),
            Expenses(recieverName: "MTS", date: date!, amount: generating(), sector: .intelcom),
            Expenses(recieverName: "Metro", date: date!, amount: generating(), sector: .transport),
            Expenses(recieverName: "Yandex.Taxi", date: thisMonthDate!, amount: generating(), sector: .transport),
            Expenses(recieverName: "Uber", date: thisMonthDate!, amount: generating(), sector: .transport),
            Expenses(recieverName: "MGTS", date: date!, amount: generating(), sector: .intelcom)
        ]
    }
}
