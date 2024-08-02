
import Foundation

//func toDebugString<T>(# x: T) -> String {
//    return "overload"
//}
//
//toDebugString(x: "t") // Prints "overload"
//toDebugString("t") // Prints "t"

func abc(on day: Int) -> Int {
  return day
}

abc(on: 12)

func abc(day: Int) -> Int {
  return day
}

abc(day: 112)

