[![Swift 5](https://img.shields.io/badge/swift-5-red.svg?style=flat)](https://developer.apple.com/swift)

# Wallet-App

## Author
Dmitrii Sokolov

## Requirements

- iOS 15.2+
- Xcode 13.0+
- Swift 5.0+

## Description
Project purpose is to demonstrate usage of CleanSwift Architecture 
Also usage of IOS FileSystem and CoreData

## Preview
https://user-images.githubusercontent.com/55272093/159800360-8559eebe-cc61-4def-93a0-6c713b4be9e0.mov

## Further Improvments
- Switch from Float to NSDecimalNumber for storing currency 
- Add graph/stackedBar construction animation

## Project Structure

    .
    ├── Main                  # App & Scene Delegate, base controller
    ├── Scenes                # Scenes: HomeScene, Analytcis Scene
    ├── Entity                # Data models
    ├── CoreData              # CoreData service & manager
    ├── Service               # Fake data generation
    └── Utils                 # Extensions + custom objects

### original design: https://dribbble.com/shots/17592495-Wallet-App-UI
