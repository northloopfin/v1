import Foundation
import UIKit



struct AppFonts{
    static let mainTitleCalibriBold25 = Font(.installed(.CalibriBold), size: .standard(.h25)).instance
    static let textBoxCalibri16 = Font(.installed(.Calibri), size: .standard(.h16)).instance
    static let btnTitleCalibri18 = Font(.installed(.Calibri), size: .standard(.h18)).instance
    static let calibri15 = Font(.installed(.Calibri), size: .standard(.h15)).instance
    static let calibri17 = Font(.installed(.Calibri), size: .standard(.h17)).instance
    static let calibri14 = Font(.installed(.Calibri), size: .standard(.h14)).instance
    static let calibri16 = Font(.installed(.Calibri), size: .standard(.h16)).instance
    static let calibriBold15 = Font(.installed(.CalibriBold), size: .standard(.h15)).instance
    static let calibriBold16 = Font(.installed(.CalibriBold), size: .standard(.h16)).instance
    static let calibriBold17 = Font(.installed(.CalibriBold), size: .standard(.h17)).instance
    static let calibriBold18 = Font(.installed(.CalibriBold), size: .standard(.h18)).instance
    
}

struct Font {
    

    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        case systemItatic
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }
    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    enum FontName: String {
        case Calibri                = "Calibri"
        case CalibriItalic          = "Calibri-Italic"
        case CalibriBoldItalic      = "Calibri-BoldItalic"
        case CalibriBold            = "Calibri-Bold"
        
    }
    enum StandardSize: Double {
        case h25 = 25.0
        case h18 = 18.0
        case h15 = 15.0
        case h16 = 16.0
        case h17 = 17.0
        case h14 = 14.0
        case h12 = 12.0
        case h10 = 10.0
    }

    
    var type: FontType
    var size: FontSize
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension Font {
    
    var instance: UIFont {
        
        var instanceFont: UIFont!
        switch type {
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
                fatalError("\(fontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .installed(let fontName):
            guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        case .systemWeighted(let weight):
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value),
                                             weight: UIFont.Weight(rawValue: CGFloat(weight)))
        case .monoSpacedDigit(let size, let weight):
            instanceFont = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size),
                                                            weight: UIFont.Weight(rawValue: CGFloat(weight)))
        }
        return instanceFont
    }
}

class Utility {
	/// Logs all available fonts from iOS SDK and installed custom font
	class func logAllAvailableFonts() {
		for family in UIFont.familyNames {
			print("\(family)")
			for name in UIFont.fontNames(forFamilyName: family) {
				print("   \(name)")
			}
		}
	}
}
